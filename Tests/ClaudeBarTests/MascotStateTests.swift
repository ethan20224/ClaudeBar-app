import XCTest
@testable import ClaudeBar

final class MascotStateTests: XCTestCase {
    func testPriorityOrdering() {
        XCTAssertGreaterThan(MascotState.reset.priority, MascotState.locked.priority)
        XCTAssertGreaterThan(MascotState.locked.priority, MascotState.maxed.priority)
        XCTAssertGreaterThan(MascotState.maxed.priority, MascotState.strained.priority)
        XCTAssertGreaterThan(MascotState.strained.priority, MascotState.working.priority)
        XCTAssertGreaterThan(MascotState.working.priority, MascotState.sleepy.priority)
        XCTAssertGreaterThan(MascotState.sleepy.priority, MascotState.idle.priority)
    }

    func testAllCasesPresent() {
        XCTAssertEqual(MascotState.allCases.count, 7)
    }
}
