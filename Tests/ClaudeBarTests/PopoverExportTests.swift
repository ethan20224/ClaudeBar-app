import XCTest
import SwiftUI
import AppKit
@testable import ClaudeBar

private final class ExportStore: SessionKeyStore {
    func save(sessionKey: String) throws {}
    func load() throws -> String { throw AppError.keychainError("none") }
    func hasKey() -> Bool { true }
    func delete() {}
}

private struct ExportUsage: UsageFetching {
    func fetch(forceRefresh: Bool) async throws -> UsageData { throw AppError.networkError("export") }
}

private struct ExportLogin: LoginItemControlling {
    var isEnabled: Bool { false }
    var requiresApproval: Bool { false }
    func setEnabled(_ on: Bool) throws {}
}

/// Renders the real popover, from the app's own views, at chosen usage levels. For marketing images.
/// Skipped unless CLAWD_POPOVER_DIR is set.
///   CLAWD_POPOVER_DIR=out CLAWD_POPOVER_ALL=1 CLAWD_POPOVER_SCHEME=dark CLAWD_POPOVER_EDITION=wizard-school swift test --filter PopoverExportTests
@MainActor
final class PopoverExportTests: XCTestCase {
    private func render(usage u: Int, dark: Bool, edition: String?, afterReset: Bool = false, scale: CGFloat = 3) throws -> Data {
        let suite = "popover-export-\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suite))
        defer { defaults.removePersistentDomain(forName: suite) }
        if let edition { defaults.set(edition, forKey: "clawd.edition") }

        let mascot = MascotController(defaults: defaults)
        mascot.setReduceMotion(true)
        mascot.setDarkBackdrop(dark)

        let model = AppModel(store: ExportStore(), cookieExtractor: { nil }, defaults: defaults,
                             makeUsageService: { _ in ExportUsage() }, loginItem: ExportLogin())
        model.isSetup = true
        model.isInitializing = false
        model.planTier = .pro
        let now = Date()
        let usage = UsageData(
            fiveHour: UsagePeriod(utilization: Double(u), resetsAt: now.addingTimeInterval(3 * 3600 + 11 * 60), periodSeconds: 5 * 3600),
            sevenDay: UsagePeriod(utilization: 24, resetsAt: now.addingTimeInterval(2 * 86_400 + 23 * 3600), periodSeconds: 7 * 86_400),
            fetchedAt: now)
        model.usage = usage
        if afterReset {
            // Seen at 100% a minute before the reset, so the next poll crosses the reset and Clawd reaches the finish line.
            let before = UsageData(
                fiveHour: UsagePeriod(utilization: 100, resetsAt: now.addingTimeInterval(60), periodSeconds: 5 * 3600),
                sevenDay: usage.sevenDay, fetchedAt: now)
            mascot.update(usage: before)
        }
        mascot.update(usage: usage)

        let presentation = PopoverPresentation()
        presentation.revealed = true
        let scheme: ColorScheme = dark ? .dark : .light
        let view = PopoverView(model: model, clawd: mascot.model, presentation: presentation)
            .environment(\.colorScheme, scheme)
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        let image = try XCTUnwrap(renderer.nsImage)
        let tiff = try XCTUnwrap(image.tiffRepresentation)
        return try XCTUnwrap(NSBitmapImageRep(data: tiff)?.representation(using: .png, properties: [:]))
    }

    func testExportPopoverImages() throws {
        guard let path = ProcessInfo.processInfo.environment["CLAWD_POPOVER_DIR"], !path.isEmpty else {
            throw XCTSkip("set CLAWD_POPOVER_DIR to export popover images")
        }
        let env = ProcessInfo.processInfo.environment
        let dark = env["CLAWD_POPOVER_SCHEME"] != "light"
        let edition = env["CLAWD_POPOVER_EDITION"].flatMap { $0.isEmpty ? nil : $0 }
        let scale = env["CLAWD_POPOVER_SCALE"].flatMap { Double($0) }.map { CGFloat($0) } ?? 3
        let levels = env["CLAWD_POPOVER_ALL"] == "1" ? Array(4...100) : [4, 38, 78, 92, 100]
        let dir = URL(fileURLWithPath: path, isDirectory: true)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        for u in levels {
            let data = try render(usage: u, dark: dark, edition: edition, scale: scale)
            XCTAssertEqual(Array(data.prefix(4)), [0x89, 0x50, 0x4E, 0x47])
            try data.write(to: dir.appendingPathComponent("popover-\(dark ? "dark" : "light")-\(u).png"))
        }
        if env["CLAWD_POPOVER_RESET"] == "1" {
            let data = try render(usage: 4, dark: dark, edition: edition, afterReset: true)
            try data.write(to: dir.appendingPathComponent("popover-\(dark ? "dark" : "light")-reset.png"))
        }
        XCTAssertEqual(try FileManager.default.contentsOfDirectory(atPath: dir.path).filter { $0.hasSuffix(".png") }.count >= levels.count, true)
    }
}
