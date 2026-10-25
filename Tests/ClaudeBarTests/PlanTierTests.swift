import XCTest
@testable import ClaudeBar

private final class PlanFakeStore: SessionKeyStore {
    var key: String? = "sk-ant-sid01-existing-key-123456"
    func save(sessionKey: String) throws { key = sessionKey }
    func load() throws -> String {
        guard let key else { throw AppError.keychainError("none") }
        return key
    }
    func hasKey() -> Bool { key != nil }
    func delete() { key = nil }
}

private final class PlanFakeUsage: UsageFetching, @unchecked Sendable {
    var tier: PlanTier?
    var fail = false
    func fetch(forceRefresh: Bool) async throws -> UsageData { throw AppError.networkError("offline") }
    func fetchPlanTier() async throws -> PlanTier? {
        if fail { throw AppError.networkError("offline") }
        return tier
    }
}

final class PlanTierTests: XCTestCase {
    func testTierStringsMapToBadges() {
        XCTAssertEqual(PlanTier(rateLimitTier: "default_claude_max_20x", capabilities: nil)?.badge, "MAX 20X")
        XCTAssertEqual(PlanTier(rateLimitTier: "default_claude_max_5x", capabilities: ["chat"])?.badge, "MAX 5X")
        XCTAssertEqual(PlanTier(rateLimitTier: nil, capabilities: ["chat", "claude_max"])?.badge, "MAX")
        XCTAssertEqual(PlanTier(rateLimitTier: nil, capabilities: ["chat", "claude_pro"])?.badge, "PRO")
        XCTAssertEqual(PlanTier(rateLimitTier: "default_claude_ai", capabilities: ["chat", "claude_pro"])?.badge, "PRO")
    }

    func testUnknownOrMissingDataGivesNoBadge() {
        XCTAssertNil(PlanTier(rateLimitTier: nil, capabilities: nil))
        XCTAssertNil(PlanTier(rateLimitTier: "something_new", capabilities: ["chat"]))
        XCTAssertNil(PlanTier(rateLimitTier: "", capabilities: []))
    }

    func testSurprisingPlanFieldShapesNeverBreakOrganizationDecoding() throws {
        let json = #"[{"uuid":"org-1","name":"x","rate_limit_tier":5,"capabilities":{"a":1}}]"#
        let decoded = try JSONDecoder().decode(OrganizationsResponse.self, from: Data(json.utf8))
        XCTAssertEqual(decoded.firstUUID, "org-1")
        XCTAssertNil(decoded.organizations.first?.rateLimitTier)
        XCTAssertNil(decoded.organizations.first?.capabilities)
    }

    func testPlanFieldsDecodeWhenWellFormed() throws {
        let json = #"[{"uuid":"org-1","rate_limit_tier":"default_claude_max_5x","capabilities":["chat","claude_max"]}]"#
        let item = try JSONDecoder().decode(OrganizationsResponse.self, from: Data(json.utf8)).organizations[0]
        XCTAssertEqual(PlanTier(rateLimitTier: item.rateLimitTier, capabilities: item.capabilities), .max5x)
    }

    func testMaxWinsWhenBothCapabilitiesAreListed() {
        XCTAssertEqual(PlanTier(rateLimitTier: nil, capabilities: ["claude_pro", "claude_max"]), .max)
    }
}

@MainActor
final class PlanRefreshTests: XCTestCase {
    private var suite = ""
    private var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        suite = "PlanRefreshTests-\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suite)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suite)
        super.tearDown()
    }

    private func makeModel(_ usage: PlanFakeUsage) -> AppModel {
        AppModel(store: PlanFakeStore(), cookieExtractor: { nil }, defaults: defaults,
                 makeUsageService: { _ in usage })
    }

    func testUpgradeFromProToMaxShowsAfterTheNextRefresh() async {
        let usage = PlanFakeUsage()
        usage.tier = .pro
        let model = makeModel(usage)
        await model.start()
        XCTAssertEqual(model.planTier, .pro)
        usage.tier = .max5x
        await model.refreshPlan()
        XCTAssertEqual(model.planTier, .max5x)
        model.disconnect()
    }

    func testFailedLookupKeepsTheLastKnownPlan() async {
        let usage = PlanFakeUsage()
        usage.tier = .max20x
        let model = makeModel(usage)
        await model.start()
        usage.fail = true
        await model.refreshPlan()
        XCTAssertEqual(model.planTier, .max20x)
        model.disconnect()
    }

    func testUnrecognizedPlanClearsTheBadgeInsteadOfShowingAWrongOne() async {
        let usage = PlanFakeUsage()
        usage.tier = .pro
        let model = makeModel(usage)
        await model.start()
        usage.tier = nil
        await model.refreshPlan()
        XCTAssertNil(model.planTier)
        model.disconnect()
    }
}
