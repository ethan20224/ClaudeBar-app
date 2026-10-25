import XCTest
@testable import ClaudeBar

final class StreakTrackerTests: XCTestCase {
    private func makeDefaults() -> UserDefaults {
        let d = UserDefaults(suiteName: "streak-test-\(UUID().uuidString)")!
        return d
    }
    private let cal = Calendar(identifier: .gregorian)
    private func day(_ y: Int, _ m: Int, _ d: Int) -> Date {
        cal.date(from: DateComponents(year: y, month: m, day: d, hour: 12))!
    }

    func testFirstActivityIsStreakOne() {
        let t = StreakTracker(defaults: makeDefaults(), calendar: cal)
        t.recordActivity(active: true, on: day(2026, 6, 29))
        XCTAssertEqual(t.currentStreak, 1)
    }

    func testSameDayIsIdempotent() {
        let t = StreakTracker(defaults: makeDefaults(), calendar: cal)
        t.recordActivity(active: true, on: day(2026, 6, 29))
        t.recordActivity(active: true, on: cal.date(byAdding: .hour, value: 3, to: day(2026, 6, 29))!)
        XCTAssertEqual(t.currentStreak, 1)
    }

    func testConsecutiveDaysIncrement() {
        let t = StreakTracker(defaults: makeDefaults(), calendar: cal)
        t.recordActivity(active: true, on: day(2026, 6, 29))
        t.recordActivity(active: true, on: day(2026, 6, 30))
        t.recordActivity(active: true, on: day(2026, 7, 1))
        XCTAssertEqual(t.currentStreak, 3)
    }

    func testGapResets() {
        let t = StreakTracker(defaults: makeDefaults(), calendar: cal)
        t.recordActivity(active: true, on: day(2026, 6, 29))
        t.recordActivity(active: true, on: day(2026, 6, 30))
        t.recordActivity(active: true, on: day(2026, 7, 3)) // gap
        XCTAssertEqual(t.currentStreak, 1)
    }

    func testInactiveDoesNothing() {
        let t = StreakTracker(defaults: makeDefaults(), calendar: cal)
        t.recordActivity(active: false, on: day(2026, 6, 29))
        XCTAssertEqual(t.currentStreak, 0)
    }
}
