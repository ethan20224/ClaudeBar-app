import XCTest
import AppKit
@testable import ClaudeBar

/// Renders the real sprites and a manifest for the landing page.
/// Skipped unless CLAWD_EXPORT_DIR is set:  CLAWD_EXPORT_DIR=site/assets/export swift test --filter SiteExportTests
@MainActor
final class SiteExportTests: XCTestCase {
    private let pxPerCell = 10

    private func writePNG(_ canvas: PixelCanvas, theme: ClawdTheme, to url: URL) throws {
        let cg = try XCTUnwrap(MascotRenderer.cgImage(canvas, theme: theme, pxPerCell: pxPerCell))
        let png = try XCTUnwrap(NSBitmapImageRep(cgImage: cg).representation(using: .png, properties: [:]))
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try png.write(to: url)
    }

    /// All of a costume's idle frames side by side (left to right), for the site's animated featured tile.
    private func writeStrip(_ timeline: ClawdTimeline, to url: URL) throws {
        let w = PixelCanvas.width * pxPerCell, h = PixelCanvas.height * pxPerCell
        let space = try XCTUnwrap(CGColorSpace(name: CGColorSpace.sRGB))
        let ctx = try XCTUnwrap(CGContext(data: nil, width: w * timeline.frames.count, height: h, bitsPerComponent: 8,
                                          bytesPerRow: 0, space: space,
                                          bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        ctx.interpolationQuality = .none
        for (i, frame) in timeline.frames.enumerated() {
            let cg = try XCTUnwrap(MascotRenderer.cgImage(frame.canvas, theme: timeline.theme, pxPerCell: pxPerCell))
            ctx.draw(cg, in: CGRect(x: i * w, y: 0, width: w, height: h))
        }
        let image = try XCTUnwrap(ctx.makeImage())
        let png = try XCTUnwrap(NSBitmapImageRep(cgImage: image).representation(using: .png, properties: [:]))
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try png.write(to: url)
    }

    func testExportSpritesAndManifest() throws {
        guard let path = ProcessInfo.processInfo.environment["CLAWD_EXPORT_DIR"], !path.isEmpty else {
            throw XCTSkip("set CLAWD_EXPORT_DIR to export the site sprites")
        }
        let root = URL(fileURLWithPath: path, isDirectory: true)
        try? FileManager.default.removeItem(at: root)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)

        let moodInfo = Dictionary(uniqueKeysWithValues: ClawdCatalog.moods.map { ($0.id, $0) })
        var moods: [[String: Any]] = []
        for mood in MascotState.allCases {
            let info = try XCTUnwrap(moodInfo[mood.catalogID], "no catalog entry for \(mood)")
            var themes: [String: Any] = [:]
            for dark in [true, false] {
                var plan = ClawdPlan()
                plan.mood = mood
                plan.darkBackdrop = dark
                let timeline = ClawdComposer.timeline(for: plan)
                XCTAssertGreaterThan(timeline.frames.count, 0)
                var frames: [[String: Any]] = []
                for (i, frame) in timeline.frames.enumerated() {
                    let rel = "moods/\(dark ? "dark" : "light")/\(mood.catalogID)-\(i).png"
                    try writePNG(frame.canvas, theme: timeline.theme, to: root.appendingPathComponent(rel))
                    frames.append(["file": rel, "duration": frame.duration])
                }
                themes[dark ? "dark" : "light"] = ["frames": frames, "oneShot": timeline.isOneShot]
            }
            moods.append(["id": mood.catalogID, "name": info.name, "hint": info.hint, "themes": themes])
        }

        var editions: [[String: Any]] = []
        for e in ClawdEditions.all {
            var durations: [Double] = []
            for dark in [true, false] {
                let tl = ClawdPreviewCache.timeline(edition: e.id, mood: .idle, dark: dark)
                try writePNG(tl.frames[0].canvas, theme: tl.theme,
                             to: root.appendingPathComponent("editions/\(dark ? "dark" : "light")/\(e.id).png"))
                try writeStrip(tl, to: root.appendingPathComponent("editions-anim/\(dark ? "dark" : "light")/\(e.id).png"))
                if dark { durations = tl.frames.map(\.duration) }
            }
            editions.append([
                "id": e.id, "name": e.name, "collection": e.collection.rawValue,
                "collectionTitle": e.collection.title, "blurb": e.blurb, "trademarked": e.trademarked,
                "frames": durations,
            ])
        }

        let manifest: [String: Any] = [
            "counts": ["editions": editions.count, "collections": ClawdCollection.allCases.count, "moods": moods.count],
            "pxPerCell": pxPerCell,
            "moods": moods,
            "editions": editions,
        ]
        let data = try JSONSerialization.data(withJSONObject: manifest, options: [.prettyPrinted, .sortedKeys])
        try data.write(to: root.appendingPathComponent("manifest.json"))

        // Verify what we wrote.
        let parsed = try XCTUnwrap(try JSONSerialization.jsonObject(with: data) as? [String: Any])
        let counts = try XCTUnwrap(parsed["counts"] as? [String: Int])
        XCTAssertEqual(counts["editions"], ClawdEditions.all.count)
        XCTAssertEqual(counts["moods"], 7)
        for e in ClawdEditions.all {
            for theme in ["dark", "light"] {
                XCTAssertTrue(FileManager.default.fileExists(atPath: root.appendingPathComponent("editions/\(theme)/\(e.id).png").path), e.id)
                XCTAssertTrue(FileManager.default.fileExists(atPath: root.appendingPathComponent("editions-anim/\(theme)/\(e.id).png").path), "strip \(e.id)")
            }
        }
        let listed = try XCTUnwrap(parsed["editions"] as? [[String: Any]])
        for entry in listed {
            let frames = try XCTUnwrap(entry["frames"] as? [Double])
            XCTAssertGreaterThanOrEqual(frames.count, 2, "\(entry["id"] ?? "?") has no animation frames")
            XCTAssertTrue(frames.allSatisfy { $0 > 0 })
        }
    }
}
