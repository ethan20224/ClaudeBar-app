import XCTest
import AppKit
@testable import ClaudeBar

@MainActor
final class ClawdShareCardTests: XCTestCase {
    private var edition: ClawdEdition { ClawdEditions.all[0] }

    private func bitmap(_ image: NSImage) throws -> NSBitmapImageRep {
        let tiff = try XCTUnwrap(image.tiffRepresentation)
        return try XCTUnwrap(NSBitmapImageRep(data: tiff))
    }

    func testCardIsPortraitAtTwiceTheLayoutSize() throws {
        let image = try XCTUnwrap(ClawdShareCard.image(edition: edition, finish: .clay, dark: true))
        let rep = try bitmap(image)
        XCTAssertEqual(rep.pixelsWide, Int(ClawdShareCard.size.width) * 2)
        XCTAssertEqual(rep.pixelsHigh, Int(ClawdShareCard.size.height) * 2)
    }

    func testPNGDataHasThePNGSignature() throws {
        let image = try XCTUnwrap(ClawdShareCard.image(edition: edition, finish: .matte, dark: false))
        let data = try XCTUnwrap(ClawdShareCard.pngData(image))
        XCTAssertEqual(Array(data.prefix(8)), [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])
    }

    func testCardIsNotBlankInDarkOrLight() throws {
        for dark in [true, false] {
            let image = try XCTUnwrap(ClawdShareCard.image(edition: edition, finish: .gold, dark: dark))
            let rep = try bitmap(image)
            var colors = Set<UInt32>()
            for y in stride(from: 0, to: rep.pixelsHigh, by: 17) {
                for x in stride(from: 0, to: rep.pixelsWide, by: 17) {
                    guard let c = rep.colorAt(x: x, y: y)?.usingColorSpace(.sRGB) else { continue }
                    colors.insert(UInt32(c.redComponent * 255) << 16 | UInt32(c.greenComponent * 255) << 8 | UInt32(c.blueComponent * 255))
                }
            }
            XCTAssertGreaterThan(colors.count, 12, "share card looks blank (dark: \(dark))")
        }
    }

    func testEveryFinishRenders() throws {
        for finish in ClawdCardFinish.allCases {
            XCTAssertNotNil(ClawdShareCard.image(edition: edition, finish: finish, dark: true), "\(finish)")
        }
    }

    func testSuggestedFileNameIsSafe() {
        XCTAssertEqual(ClawdShareCard.fileName(for: "Wizard School"), "ClaudeBar-Clawd-Wizard-School.png")
        XCTAssertEqual(ClawdShareCard.fileName(for: "R&D / Lab #1"), "ClaudeBar-Clawd-R-D-Lab-1.png")
    }
}
