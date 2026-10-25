import XCTest
import SwiftUI
import AppKit
@testable import ClaudeBar

@MainActor
final class UsageBarTests: XCTestCase {
    private func render(_ fraction: Double, _ color: Color) -> NSBitmapImageRep? {
        let r = ImageRenderer(content: UsageBar(fraction: fraction, color: color).frame(width: 300, height: 11))
        r.scale = 1
        guard let cg = r.cgImage else { return nil }
        return NSBitmapImageRep(cgImage: cg)
    }

    func testBarIsColoredNotGreyAndFillMatchesFraction() throws {
        let rep = try XCTUnwrap(render(0.4, .green))
        let filled = try XCTUnwrap(rep.colorAt(x: 60, y: 5)?.usingColorSpace(.sRGB))
        XCTAssertGreaterThan(filled.greenComponent, filled.redComponent + 0.2, "filled part must be green")
        XCTAssertGreaterThan(filled.greenComponent, filled.blueComponent + 0.2)
        let empty = try XCTUnwrap(rep.colorAt(x: 250, y: 5)?.usingColorSpace(.sRGB))
        XCTAssertLessThan(empty.alphaComponent, 0.4, "unfilled track is a faint tint, not a color")
    }

    func testFullRedBarIsRedAcrossTheWidth() throws {
        let rep = try XCTUnwrap(render(1.0, .red))
        for x in [20, 150, 280] {
            let c = try XCTUnwrap(rep.colorAt(x: x, y: 5)?.usingColorSpace(.sRGB))
            XCTAssertGreaterThan(c.redComponent, c.greenComponent + 0.3, "x=\(x)")
        }
    }
}
