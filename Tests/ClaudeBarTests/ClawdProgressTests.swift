import XCTest
@testable import ClaudeBar

final class ClawdProgressTests: XCTestCase {
    private func makeProgress() -> ClawdProgress {
        ClawdProgress(defaults: UserDefaults(suiteName: "clawd-\(UUID().uuidString)")!)
    }
    private var cal: Calendar {
        var c = Calendar(identifier: .gregorian)
        c.timeZone = TimeZone(identifier: "UTC")!
        return c
    }
    private func day(_ d: Int) -> Date { cal.date(from: DateComponents(year: 2026, month: 3, day: d, hour: 12))! }

    func testIdleKnownFromStartAndUnlockIsPermanent() {
        let p = makeProgress()
        XCTAssertTrue(p.isUnlocked("mood-idle"))
        XCTAssertTrue(p.unlock("crown"))
        XCTAssertFalse(p.unlock("crown"))
        XCTAssertTrue(p.isUnlocked("crown"))
    }

    func testEvaluateUnlocksEarnedAndReportsNewOnly() {
        let p = makeProgress()
        var ctx = ClawdContext(now: day(3), calendar: cal, streak: 7, installDate: day(3), regionCode: "US")
        let first = p.evaluate(ctx)
        XCTAssertTrue(first.contains("shades"))
        XCTAssertFalse(p.evaluate(ctx).contains("shades"))
        ctx.liveMinutes = 50
        XCTAssertTrue(p.evaluate(ctx).contains("wizard"))
    }

    func testAnyItemCanBePinnedAndUnpinClears() {
        let p = makeProgress()
        p.pin(ClawdCatalog.crown)
        XCTAssertEqual(p.pins[.head], "crown", "everything can be picked from day one")
        p.unpin(slot: .head)
        p.pin(ClawdCatalog.crown)
        XCTAssertEqual(p.pins[.head], "crown")
        p.unpin(slot: .head)
        XCTAssertNil(p.pins[.head])
        p.pin(ClawdCatalog.crown)
        p.clearPins()
        XCTAssertTrue(p.pins.isEmpty)
    }

    func testCalmDaysCountConsecutiveLowPeakDays() {
        let p = makeProgress()
        for d in 1...5 { p.recordPoll(utilization: 30, now: day(d), calendar: cal) }
        XCTAssertEqual(p.calmDays(now: day(5), calendar: cal), 5)
        p.recordPoll(utilization: 80, now: day(5), calendar: cal)
        XCTAssertEqual(p.calmDays(now: day(5), calendar: cal), 0, "a busy day breaks the run")
    }

    func testCalmDaysGapBreaksStreak() {
        let p = makeProgress()
        for d in [1, 2, 4, 5] { p.recordPoll(utilization: 10, now: day(d), calendar: cal) }
        XCTAssertEqual(p.calmDays(now: day(5), calendar: cal), 2)
    }

    func testZeroUsageDaysAreNotRecorded() {
        let p = makeProgress()
        p.recordPoll(utilization: 0, now: day(1), calendar: cal)
        XCTAssertEqual(p.calmDays(now: day(1), calendar: cal), 0)
    }

    func testShinyIsDeterministicPerDayAndRoughlyOneInForty() {
        var hits = 0
        for d in 0..<4000 {
            let date = Date(timeIntervalSinceReferenceDate: Double(d) * 86_400 + 43_200)
            let a = ClawdProgress.shinyColor(on: date, calendar: cal)
            XCTAssertEqual(a, ClawdProgress.shinyColor(on: date, calendar: cal))
            if a != nil { hits += 1 }
        }
        // Expect ~100 of 4000; allow a wide band so the test is not flaky by construction (it is deterministic).
        XCTAssertTrue((50...170).contains(hits), "shiny hits: \(hits)")
    }

    func testCardFinishSavedPerEditionAndMatteClears() {
        let p = makeProgress()
        XCTAssertEqual(p.cardFinish(for: "wise-sage"), .matte)
        p.setCardFinish(.gold, for: "wise-sage")
        p.setCardFinish(.prismatic, for: "rogue-robot")
        XCTAssertEqual(p.cardFinish(for: "wise-sage"), .gold)
        XCTAssertEqual(p.cardFinish(for: "rogue-robot"), .prismatic)
        p.setCardFinish(.matte, for: "wise-sage")
        XCTAssertEqual(p.cardFinish(for: "wise-sage"), .matte)
        XCTAssertNil(p.cardFinishes["wise-sage"])
    }
}
