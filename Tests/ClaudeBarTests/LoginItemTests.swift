import XCTest
@testable import ClaudeBar

private final class FakeLogin: LoginItemControlling {
    var enabled = false
    var throwOnEnable = false
    var approval = false
    var isEnabled: Bool { enabled }
    var requiresApproval: Bool { approval }
    func setEnabled(_ on: Bool) throws {
        if on && throwOnEnable {
            throw NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Operation not permitted"])
        }
        enabled = on
    }
}

private final class LoginFakeStore: SessionKeyStore {
    var key: String?
    func save(sessionKey: String) throws { key = sessionKey }
    func load() throws -> String {
        guard let key else { throw AppError.keychainError("none") }
        return key
    }
    func hasKey() -> Bool { key != nil }
    func delete() { key = nil }
}

private struct LoginOfflineUsage: UsageFetching {
    func fetch(forceRefresh: Bool) async throws -> UsageData { throw AppError.networkError("offline") }
}

@MainActor
final class LoginItemTests: XCTestCase {
    private var suite = ""
    private var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        suite = "LoginItemTests-\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suite)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suite)
        super.tearDown()
    }

    func testEnablingReflectsTheRealState() {
        let fake = FakeLogin()
        let model = LoginItemModel(controller: fake)
        model.set(true)
        XCTAssertTrue(model.isOn)
        XCTAssertNil(model.message)
        model.set(false)
        XCTAssertFalse(model.isOn)
    }

    func testToggleReflectsRealStateWhenRegisterThrows() {
        let fake = FakeLogin()
        fake.throwOnEnable = true
        let model = LoginItemModel(controller: fake)
        model.set(true)
        XCTAssertFalse(model.isOn)
        XCTAssertEqual(model.message, "Operation not permitted")
    }

    func testRequiresApprovalShowsAHint() {
        let fake = FakeLogin()
        fake.approval = true
        let model = LoginItemModel(controller: fake)
        XCTAssertNotNil(model.message)
        XCTAssertTrue(model.message?.contains("Login Items") ?? false)
    }

    func testVersionFallsBackToDevOutsideABundle() {
        XCTAssertEqual(AppVersion.display(info: nil), "dev")
        XCTAssertEqual(AppVersion.display(info: [:]), "dev")
    }

    func testVersionShowsShortVersionAndBuild() {
        XCTAssertEqual(AppVersion.display(info: ["CFBundleShortVersionString": "1.0.0", "CFBundleVersion": "7"]),
                       "1.0.0 (7)")
        XCTAssertEqual(AppVersion.display(info: ["CFBundleShortVersionString": "1.0.0"]), "1.0.0")
    }

    func testOfferAppearsOnlyOnceAfterTheFirstConnect() async {
        let model = AppModel(store: LoginFakeStore(),
                             cookieExtractor: { "sk-ant-sid01-browser-key-123456" },
                             defaults: defaults,
                             makeUsageService: { _ in LoginOfflineUsage() },
                             loginItem: FakeLogin())
        await model.connectAutomatically()
        XCTAssertTrue(model.shouldOfferLoginItem)
        model.dismissLoginOffer()
        XCTAssertFalse(model.shouldOfferLoginItem)
        model.disconnect()
        await model.connectAutomatically()
        XCTAssertFalse(model.shouldOfferLoginItem)
        model.disconnect()
    }

    func testNoOfferWhenAlreadyEnabled() async {
        let fake = FakeLogin()
        fake.enabled = true
        let model = AppModel(store: LoginFakeStore(),
                             cookieExtractor: { "sk-ant-sid01-browser-key-123456" },
                             defaults: defaults,
                             makeUsageService: { _ in LoginOfflineUsage() },
                             loginItem: fake)
        await model.connectAutomatically()
        XCTAssertFalse(model.shouldOfferLoginItem)
        model.disconnect()
    }
}
