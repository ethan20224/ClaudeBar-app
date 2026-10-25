import Foundation

/// Where the claude.ai session key is kept. The Keychain in the app, a fake in tests.
protocol SessionKeyStore {
    func save(sessionKey: String) throws
    func load() throws -> String
    func hasKey() -> Bool
    func delete()
}

extension KeychainRepository: SessionKeyStore {}

/// Anything that can fetch usage. `UsageService` in the app, a fake in tests.
protocol UsageFetching {
    func fetch(forceRefresh: Bool) async throws -> UsageData
    /// `nil` means the plan is not recognized; a throw means the lookup itself failed.
    func fetchPlanTier() async throws -> PlanTier?
}

extension UsageFetching {
    func fetchPlanTier() async throws -> PlanTier? { nil }
}

extension UsageService: UsageFetching {}
