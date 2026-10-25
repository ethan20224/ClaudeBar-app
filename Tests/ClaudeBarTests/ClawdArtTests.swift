import XCTest
@testable import ClaudeBar

final class ClawdArtTests: XCTestCase {
    func testBodyMatchesReferenceSilhouette() {
        let c = ClawdArt.body(ClawdArt.Pose())
        // Body-grid origin is canvas (2, 3).
        for x in 4...11 { XCTAssertEqual(c[x, 3], "B", "head top row, x=\(x)") }
        XCTAssertEqual(c[3, 3], ".")
        XCTAssertEqual(c[12, 3], ".")
        // Side nubs: 2x2 at body-grid rows 2-3.
        XCTAssertEqual(c[2, 5], "B"); XCTAssertEqual(c[3, 6], "B")
        XCTAssertEqual(c[12, 5], "B"); XCTAssertEqual(c[13, 6], "B")
        XCTAssertEqual(c[2, 4], ".")
        // Four legs, two rows tall, with gaps between.
        for x in [4, 6, 9, 11] { XCTAssertEqual(c[x, 9], "B"); XCTAssertEqual(c[x, 10], "B") }
        for x in [5, 7, 8, 10] { XCTAssertEqual(c[x, 9], ".", "gap at x=\(x)") }
        // Two square eyes.
        XCTAssertEqual(c[5, 4], "k"); XCTAssertEqual(c[10, 4], "k")
    }

    func testEyeLookShiftsEyesOneCell() {
        let left = ClawdArt.body(ClawdArt.Pose(eyes: .open(look: -1)))
        XCTAssertEqual(left[4, 4], "k"); XCTAssertEqual(left[9, 4], "k")
        let right = ClawdArt.body(ClawdArt.Pose(eyes: .open(look: 1)))
        XCTAssertEqual(right[6, 4], "k"); XCTAssertEqual(right[11, 4], "k")
    }

    func testBlinkRemovesEyes() {
        let c = ClawdArt.body(ClawdArt.Pose(eyes: .none))
        XCTAssertEqual(c[5, 4], "B"); XCTAssertEqual(c[10, 4], "B")
    }

    func testStampClipsOffCanvas() {
        var c = PixelCanvas()
        c.stamp(["kkk"], x: 14, y: 0)
        XCTAssertEqual(c[14, 0], "k"); XCTAssertEqual(c[15, 0], "k")
        c.stamp(["k"], x: -1, y: -1)
        XCTAssertEqual(c[0, 0], ".")
    }
}
