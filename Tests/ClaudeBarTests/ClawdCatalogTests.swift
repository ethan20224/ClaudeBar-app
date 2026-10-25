import XCTest
@testable import ClaudeBar

final class ClawdCatalogTests: XCTestCase {
    private var cal: Calendar {
        var c = Calendar(identifier: .gregorian)
        c.timeZone = TimeZone(identifier: "UTC")!
        return c
    }

    private func ctx(_ y: Int, _ m: Int, _ d: Int, hour: Int = 12, region: String? = "US",
                     streak: Int = 0, installed: Date? = nil) -> ClawdContext {
        let date = cal.date(from: DateComponents(year: y, month: m, day: d, hour: hour))!
        return ClawdContext(now: date, calendar: cal, streak: streak,
                            installDate: installed ?? date, regionCode: region)
    }

    func testIsWithinWrapsNewYear() {
        XCTAssertTrue(ctx(2026, 12, 31).isWithin((12, 31), (1, 2)))
        XCTAssertTrue(ctx(2027, 1, 2).isWithin((12, 31), (1, 2)))
        XCTAssertFalse(ctx(2027, 1, 3).isWithin((12, 31), (1, 2)))
        XCTAssertFalse(ctx(2026, 12, 30).isWithin((12, 31), (1, 2)))
    }

    func testWitchHatIsOctoberOnly() {
        XCTAssertTrue(ClawdCatalog.witch.wear(ctx(2026, 10, 16)))
        XCTAssertFalse(ClawdCatalog.witch.wear(ctx(2026, 11, 1)))
    }

    func testPatriotNeedsUSRegionAndJulyWindow() {
        XCTAssertTrue(ClawdCatalog.patriot.wear(ctx(2026, 7, 4)))
        XCTAssertTrue(ClawdCatalog.patriot.wear(ctx(2026, 7, 4, region: nil)))
        XCTAssertFalse(ClawdCatalog.patriot.wear(ctx(2026, 7, 4, region: "IL")))
        XCTAssertFalse(ClawdCatalog.patriot.wear(ctx(2026, 7, 8)))
    }

    func testTimeOfDayItems() {
        XCTAssertTrue(ClawdCatalog.headphones.wear(ctx(2026, 3, 3, hour: 23)))
        XCTAssertTrue(ClawdCatalog.headphones.wear(ctx(2026, 3, 3, hour: 2)))
        XCTAssertFalse(ClawdCatalog.headphones.wear(ctx(2026, 3, 3, hour: 5)))
        XCTAssertTrue(ClawdCatalog.mug.wear(ctx(2026, 3, 3, hour: 8)))
        XCTAssertFalse(ClawdCatalog.mug.wear(ctx(2026, 3, 3, hour: 11)))
    }

    func testPartyHatOnInstallAnniversaryNotFirstYear() {
        let installed = cal.date(from: DateComponents(year: 2025, month: 10, day: 16))!
        XCTAssertTrue(ClawdCatalog.party.earn(ctx(2026, 10, 16, installed: installed)))
        XCTAssertFalse(ClawdCatalog.party.earn(ctx(2025, 10, 16, installed: installed)))
        XCTAssertFalse(ClawdCatalog.party.earn(ctx(2026, 10, 17, installed: installed)))
    }

    func testStreakItemsUnlockAtThresholds() {
        XCTAssertFalse(ClawdCatalog.shades.earn(ctx(2026, 3, 3, streak: 6)))
        XCTAssertTrue(ClawdCatalog.shades.earn(ctx(2026, 3, 3, streak: 7)))
        XCTAssertFalse(ClawdCatalog.crown.earn(ctx(2026, 3, 3, streak: 29)))
        XCTAssertTrue(ClawdCatalog.crown.earn(ctx(2026, 3, 3, streak: 30)))
        XCTAssertTrue(ClawdCatalog.golden.earn(ctx(2026, 3, 3, streak: 100)))
    }

    func testShadesOnlyWornWhenUsageLow() {
        var c = ctx(2026, 3, 3, streak: 10)
        c.utilization = 5
        XCTAssertTrue(ClawdCatalog.shades.wear(c))
        c.utilization = 40
        XCTAssertFalse(ClawdCatalog.shades.wear(c))
    }

    func testIDsAreUniqueAndEverySlotItemHasAnArt() {
        let ids = ClawdCatalog.all.map(\.id)
        XCTAssertEqual(ids.count, Set(ids).count)
        for item in ClawdCatalog.outfits + ClawdCatalog.skins {
            XCTAssertFalse(item.stamps(0).isEmpty || (item.id == "shiny" && false), "\(item.id) has no art")
            XCTAssertNotNil(item.slot)
        }
    }
}
