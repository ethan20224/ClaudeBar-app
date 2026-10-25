import XCTest
@testable import ClaudeBar

private final class FakeStore: SessionKeyStore {
    var key: String?
    func save(sessionKey: String) throws { key = sessionKey }
    func load() throws -> String {
        guard let key else { throw AppError.keychainError("none") }
        return key
    }
    func hasKey() -> Bool { key != nil }
    func delete() { key = nil }
}

private final class CallCounter: @unchecked Sendable {
    private let lock = NSLock()
    private var value = 0
    var count: Int { lock.lock(); defer { lock.unlock() }; return value }
    func hit() { lock.lock(); value += 1; lock.unlock() }
}

private struct OfflineUsage: UsageFetching {
    func fetch(forceRefresh: Bool) async throws -> UsageData { throw AppError.networkError("offline") }
}

@MainActor
final class ConsentGateTests: XCTestCase {
    private var suiteName = ""
    private var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        suiteName = "ConsentGateTests-\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        super.tearDown()
    }

    private func makeModel(store: FakeStore = FakeStore(),
                           counter: CallCounter = CallCounter(),
                           found key: String? = nil) -> (AppModel, FakeStore, CallCounter) {
        let model = AppModel(
            store: store,
            cookieExtractor: { counter.hit(); return key },
            defaults: defaults,
            makeUsageService: { _ in OfflineUsage() }
        )
        return (model, store, counter)
    }

    func testStartWithoutConsentNeverCallsExtractor() async {
        let (model, _, counter) = makeModel(found: "sk-ant-sid01-browser-key-123456")
        await model.start()
        XCTAssertEqual(counter.count, 0)
        XCTAssertFalse(model.isSetup)
        XCTAssertFalse(model.hasBrowserReadConsent)
    }

    func testStartWithExistingKeyStaysConnectedAndDoesNotExtract() async {
        let store = FakeStore()
        store.key = "sk-ant-sid01-existing-key-123456"
        let (model, _, counter) = makeModel(store: store)
        await model.start()
        XCTAssertTrue(model.isSetup)
        XCTAssertEqual(counter.count, 0)
        model.disconnect()
    }

    func testConnectAutomaticallySetsConsentAndSavesKey() async {
        let (model, store, counter) = makeModel(found: "sk-ant-sid01-browser-key-123456")
        await model.connectAutomatically()
        XCTAssertEqual(counter.count, 1)
        XCTAssertEqual(store.key, "sk-ant-sid01-browser-key-123456")
        XCTAssertTrue(model.isSetup)
        XCTAssertTrue(model.hasBrowserReadConsent)
        model.disconnect()
    }

    func testConnectAutomaticallyWithNoLoginShowsErrorAndStaysOnSetup() async {
        let (model, store, _) = makeModel(found: nil)
        await model.connectAutomatically()
        XCTAssertEqual(model.error, .noBrowserLogin)
        XCTAssertFalse(model.isSetup)
        XCTAssertNil(store.key)
        XCTAssertFalse(model.isLoading)
    }

    func testConnectAutomaticallyRejectsAKeyThatIsNotASessionKey() async {
        let (model, store, _) = makeModel(found: "not-a-session-key")
        await model.connectAutomatically()
        XCTAssertEqual(model.error, .noBrowserLogin)
        XCTAssertNil(store.key)
        XCTAssertFalse(model.isSetup)
    }

    func testDisconnectClearsKeyAndConsent() async {
        let (model, store, _) = makeModel(found: "sk-ant-sid01-browser-key-123456")
        await model.connectAutomatically()
        model.disconnect()
        XCTAssertNil(store.key)
        XCTAssertFalse(model.hasBrowserReadConsent)
        XCTAssertFalse(model.isSetup)
    }

    func testBrowserRecoveryWithoutConsentDoesNotExtract() async {
        let store = FakeStore()
        store.key = "sk-ant-sid01-pasted-key-123456"
        let (model, _, counter) = makeModel(store: store, found: "sk-ant-sid01-browser-key-123456")
        let recovered = await model.refreshKeyFromBrowser()
        XCTAssertFalse(recovered)
        XCTAssertEqual(counter.count, 0)
        XCTAssertEqual(store.key, "sk-ant-sid01-pasted-key-123456")
    }

    func testBrowserRecoveryWithConsentSavesTheFreshKey() async {
        let store = FakeStore()
        store.key = "sk-ant-sid01-old-key-123456"
        defaults.set(true, forKey: AppModel.consentKey)
        let (model, _, counter) = makeModel(store: store, found: "sk-ant-sid01-fresh-key-123456")
        let recovered = await model.refreshKeyFromBrowser()
        XCTAssertTrue(recovered)
        XCTAssertEqual(counter.count, 1)
        XCTAssertEqual(store.key, "sk-ant-sid01-fresh-key-123456")
    }
}
