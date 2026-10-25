import Foundation
import AppKit
import Observation

enum MenuBarMode: String {
    case percentage
    case countdown
    case both
}

@MainActor
@Observable
final class AppModel {
    var usage: UsageData?
    var error: AppError?
    var isLoading = false
    var isSetup = false
    var isInitializing = true
    var pendingKey = ""

    var isReconnecting = false
    var onStatusUpdate: ((String) -> Void)?

    /// True only after the user pressed Connect. Every read of another app's cookies is gated on it.
    static let consentKey = "browserReadConsent"

    private let store: SessionKeyStore
    private let cookieExtractor: @Sendable () -> String?
    private let defaults: UserDefaults
    private let makeUsageService: (String) -> UsageFetching
    let loginItem: LoginItemModel
    private var usageService: UsageFetching?

    /// The user's plan for the popover badge. `nil` hides the badge.
    var planTier: PlanTier?
    /// True once, after the first successful connect, to offer "open at login".
    var shouldOfferLoginItem = false
    private static let loginOfferKey = "loginOfferShown"
    private var refreshTask: Task<Void, Never>?
    private var cookieRefreshTask: Task<Void, Never>?
    private var isRecoveringFromAuth = false
    private var authFailureCount = 0

    init(store: SessionKeyStore = KeychainRepository(),
         cookieExtractor: @escaping @Sendable () -> String? = { BrowserCookieService.extractSessionKey() },
         defaults: UserDefaults = .standard,
         makeUsageService: @escaping (String) -> UsageFetching = { UsageService(network: NetworkService(sessionKey: $0)) },
         loginItem: LoginItemControlling = SystemLoginItem()) {
        self.store = store
        self.cookieExtractor = cookieExtractor
        self.defaults = defaults
        self.makeUsageService = makeUsageService
        self.loginItem = LoginItemModel(controller: loginItem)
    }

    func dismissLoginOffer() {
        defaults.set(true, forKey: Self.loginOfferKey)
        shouldOfferLoginItem = false
    }

    func acceptLoginOffer() {
        loginItem.set(true)
        dismissLoginOffer()
    }

    /// Looks the plan up again, so an upgrade from Pro to Max shows without reconnecting.
    /// A failed lookup keeps the last known plan; an unrecognized plan clears it.
    func refreshPlan() async {
        guard let service = usageService else { return }
        do {
            planTier = try await service.fetchPlanTier()
        } catch {
            log("plan lookup failed: \(error)")
        }
    }

    var hasBrowserReadConsent: Bool { defaults.bool(forKey: Self.consentKey) }

    private func log(_ msg: String) {
        AppLog.debug(msg)
    }

    var statusBarTitle: String {
        guard let usage else { return " –" }
        let mode = MenuBarMode(rawValue: UserDefaults.standard.string(forKey: "menuBarMode") ?? "both") ?? .both

        switch mode {
        case .percentage:
            let pct = Int(usage.fiveHour.utilization)
            return " \(pct)%"
        case .countdown:
            guard let interval = usage.fiveHour.timeUntilReset else { return " –" }
            let hours = Int(interval) / 3600
            let minutes = (Int(interval) % 3600) / 60
            return " \(hours)h\(String(format: "%02d", minutes))m"
        case .both:
            let pct = Int(usage.fiveHour.utilization)
            guard let interval = usage.fiveHour.timeUntilReset else { return " \(pct)%" }
            let hours = Int(interval) / 3600
            let minutes = (Int(interval) % 3600) / 60
            return " \(pct)% · \(hours)h\(String(format: "%02d", minutes))m"
        }
    }

    var lastUpdatedText: String {
        guard let usage else { return "" }
        let ago = Int(-usage.fetchedAt.timeIntervalSinceNow)
        if ago < 60 { return "Updated \(ago)s ago" }
        return "Updated \(ago / 60)m ago"
    }

    func start() async {
        log("START begin - isSetup=\(isSetup) isInitializing=\(isInitializing)")
        migrateMenuBarMode()
        isSetup = store.hasKey()
        log("START hasKey=\(isSetup)")
        if isSetup {
            setupServices()
            await refresh()
            await refreshPlan()
            startPolling()
            startCookieRefresh()
        }
        if !isSetup {
            updateStatusBar()
        }
        isInitializing = false
        log("START end - isSetup=\(isSetup) isInitializing=\(isInitializing)")
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didWakeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { await self?.refresh() }
        }
    }

    func saveKey() async {
        let key = pendingKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard key.hasPrefix("sk-ant-"), key.count > 10 else {
            error = .invalidSessionKey
            return
        }
        do {
            try store.save(sessionKey: key)
            pendingKey = ""
            await completeConnection()
        } catch let e as AppError {
            error = e
        } catch {
            self.error = .keychainError(error.localizedDescription)
        }
    }

    /// The Connect button. Pressing it is the user's consent to read their browser's claude.ai login,
    /// now and when the session needs refreshing later. Nothing reads a browser before this.
    func connectAutomatically() async {
        defaults.set(true, forKey: Self.consentKey)
        isLoading = true
        error = nil
        let key = await extractKeyOffMainThread()
        isLoading = false
        guard let key, Self.looksLikeSessionKey(key) else {
            error = .noBrowserLogin
            return
        }
        do {
            try store.save(sessionKey: key)
            await completeConnection()
        } catch let e as AppError {
            error = e
        } catch {
            self.error = .keychainError(error.localizedDescription)
        }
    }

    /// Re-reads the login from the browser to recover from an expired session or to keep it fresh.
    /// Does nothing, and never touches a browser, unless the user already pressed Connect.
    func refreshKeyFromBrowser() async -> Bool {
        guard hasBrowserReadConsent else { return false }
        guard let key = await extractKeyOffMainThread(), Self.looksLikeSessionKey(key) else { return false }
        do {
            try store.save(sessionKey: key)
            setupServices()
            return true
        } catch {
            log("browser key save failed: \(error)")
            return false
        }
    }

    private func completeConnection() async {
        error = nil
        isSetup = true
        if !defaults.bool(forKey: Self.loginOfferKey) && !loginItem.isOn {
            shouldOfferLoginItem = true
        }
        setupServices()
        await refresh()
        await refreshPlan()
        startPolling()
        startCookieRefresh()
    }

    private func extractKeyOffMainThread() async -> String? {
        let extract = cookieExtractor
        return await Task.detached(priority: .userInitiated) { extract() }.value
    }

    private static func looksLikeSessionKey(_ key: String) -> Bool {
        key.hasPrefix("sk-ant-") && key.count > 10
    }

    func disconnect() {
        store.delete()
        defaults.removeObject(forKey: Self.consentKey)
        UserDefaults.standard.removeObject(forKey: "cachedOrgUUID")
        isSetup = false
        usage = nil
        planTier = nil
        error = nil
        stopPolling()
        updateStatusBar()
    }

    func refresh(forceRefresh: Bool = false) async {
        guard let usageService else {
            log("refresh: no usageService, skipping")
            return
        }
        isLoading = true
        do {
            usage = try await usageService.fetch(forceRefresh: forceRefresh)
            log("refresh: fetch OK")
            error = nil
            let historyRepo = UsageHistoryRepository()
            let snapshot = UsageSnapshot(
                timestamp: Date(),
                fiveHourPercent: usage!.fiveHour.utilization,
                sevenDayPercent: usage!.sevenDay.utilization
            )
            historyRepo.append(snapshot: snapshot)
            let notificationService = NotificationService()
            await notificationService.checkAndNotify(usage: usage!)
            updateStatusBar()
        } catch let e as AppError {
            log("refresh: error \(e)")
            error = e
            if case .authenticationFailed = e {
                await handleAuthFailure()
            }
        } catch {
            log("refresh: unknown error \(error)")
            self.error = .networkError(error.localizedDescription)
        }
        isLoading = false
    }

    private func handleAuthFailure() async {
        log("handleAuthFailure called - isRecovering=\(isRecoveringFromAuth) failCount=\(authFailureCount)")
        guard !isRecoveringFromAuth else {
            log("handleAuthFailure: already recovering, skipping")
            return
        }
        isRecoveringFromAuth = true
        authFailureCount += 1

        if await refreshKeyFromBrowser() {
            log("handleAuthFailure: recovered a fresh key from the browser")
            isLoading = false
            isRecoveringFromAuth = false
            authFailureCount = 0
            isReconnecting = false
            await refresh()
            return
        }

        if authFailureCount < 3 {
            isReconnecting = true
            isRecoveringFromAuth = false
            log("handleAuthFailure: will retry (attempt \(authFailureCount)/3)")
            let delay = pow(2.0, Double(authFailureCount)) * 30.0
            try? await Task.sleep(for: .seconds(delay))
            await refresh()
        } else {
            log("handleAuthFailure: exhausted retries, showing setup")
            isReconnecting = false
            isRecoveringFromAuth = false
            isSetup = false
            authFailureCount = 0
            stopPolling()
        }
    }

    private func migrateMenuBarMode() {
        if !UserDefaults.standard.bool(forKey: "menuBarModeConfigured") {
            UserDefaults.standard.set("both", forKey: "menuBarMode")
            UserDefaults.standard.set(true, forKey: "menuBarModeConfigured")
        }
    }

    private func setupServices() {
        guard let key = try? store.load() else {
            log("setupServices: keychain.load failed")
            return
        }
        log("setupServices: key loaded, creating usage service")
        usageService = makeUsageService(key)
    }

    private func startPolling() {
        stopPolling()
        refreshTask = Task { [weak self] in
            while !Task.isCancelled {
                let interval = TimeInterval(UserDefaults.standard.integer(forKey: "refreshInterval") == 0 ? 60 : UserDefaults.standard.integer(forKey: "refreshInterval"))
                try? await Task.sleep(for: .seconds(interval))
                guard !Task.isCancelled else { break }
                await self?.refresh()
            }
        }
    }

    private func startCookieRefresh() {
        cookieRefreshTask?.cancel()
        cookieRefreshTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(6 * 3600))
                guard !Task.isCancelled, let self else { break }
                await self.proactiveCookieRefresh()
                await self.refreshPlan()
            }
        }
    }

    private func proactiveCookieRefresh() async {
        if await refreshKeyFromBrowser() {
            log("cookieRefresh: updated session key")
        } else {
            log("cookieRefresh: nothing to update")
        }
    }

    private func stopPolling() {
        refreshTask?.cancel()
        refreshTask = nil
        cookieRefreshTask?.cancel()
        cookieRefreshTask = nil
    }

    private func updateStatusBar() {
        onStatusUpdate?(statusBarTitle)
    }
}
