import XCTest
@testable import ClaudeBar

final class ClawdEditionTests: XCTestCase {
    private let legend = Set("BkdwroegcuxphnyIlX. ")

    func testIDsAreUniqueAndPrefixedKebabCase() {
        let ids = ClawdEditions.all.map(\.id)
        XCTAssertEqual(ids.count, Set(ids).count, "duplicate edition ids")
        for id in ids {
            XCTAssertNotNil(id.range(of: "^[a-z0-9]+(-[a-z0-9]+)*$", options: .regularExpression), "bad id \(id)")
        }
    }

    func testCopyHasNoEmDashesOrEmojiAndIsNotEmpty() {
        for e in ClawdEditions.all {
            XCTAssertFalse(e.name.isEmpty, e.id)
            XCTAssertFalse(e.blurb.isEmpty, e.id)
            XCTAssertFalse((e.name + e.blurb).contains("\u{2014}"), "em dash in \(e.id)")
            XCTAssertTrue((e.name + e.blurb).unicodeScalars.allSatisfy { $0.value < 0x2190 || $0.value > 0x1FFFF }, "emoji in \(e.id)")
            XCTAssertLessThanOrEqual(e.name.split(separator: " ").count, 4, "long name \(e.id)")
        }
    }

    func testStampsUseOnlyLegendLettersAndStayOnCanvas() {
        for e in ClawdEditions.all {
            XCTAssertFalse(e.parts.isEmpty, e.id)
            for part in e.parts {
                for phase in 0..<6 {
                    for s in part.stamps(phase) {
                        for ch in s.rows.joined() { XCTAssertTrue(legend.contains(ch), "\(e.id): unknown '\(ch)'") }
                        let w = s.rows.map(\.count).max() ?? 0
                        XCTAssertFalse(s.x + w <= 0 || s.x >= 16 || s.y + s.rows.count <= 0 || s.y >= 12, "\(e.id): off canvas")
                    }
                }
            }
        }
    }

    func testEveryEditionRendersInEveryMoodWithoutHidingTheBody() {
        let moods: [MascotState] = [.idle, .working, .sleepy, .strained, .maxed, .locked, .reset]
        for e in ClawdEditions.all {
            for mood in moods {
                var plan = ClawdPlan(); plan.mood = mood; plan.edition = e.id
                let tl = ClawdComposer.timeline(for: plan)
                XCTAssertFalse(tl.frames.isEmpty, "\(e.id) \(mood)")
                var bodyCells = 0
                for y in 0..<12 { for x in 0..<16 where tl.frames[0].canvas[x, y] == "B" { bodyCells += 1 } }
                // Costumes may hide a lot of the body, but never all of it.
                XCTAssertGreaterThan(bodyCells, 12, "\(e.id) \(mood) hides Clawd")
            }
        }
    }

    func testStatusColorStillWinsOverEditionColor() {
        guard let recolored = ClawdEditions.all.first(where: { $0.bodyColor != nil }) else { return }
        var plan = ClawdPlan(); plan.edition = recolored.id; plan.mood = .maxed
        XCTAssertEqual(ClawdComposer.theme(for: plan).body, ClawdTheme.rgb(0xE5484D))
        plan.mood = .idle
        XCTAssertEqual(ClawdComposer.theme(for: plan).body, ClawdTheme.rgb(recolored.bodyColor!))
    }

    func testFaceAndHandPartsYieldToMoods() {
        // Strained claims .face: a face-only difference must disappear.
        for e in ClawdEditions.all {
            let faceParts = e.parts.filter { $0.slot == .face }
            guard !faceParts.isEmpty, e.parts.count == faceParts.count else { continue }
            var plan = ClawdPlan(); plan.mood = .strained
            let bare = ClawdComposer.preview(for: plan).canvas
            plan.edition = e.id
            XCTAssertEqual(ClawdComposer.preview(for: plan).canvas, bare, "\(e.id)")
        }
    }

    func testCollectionsAreAllPopulatedOnceBatchesLand() {
        // Every collection exists in the sidebar and has editions.
        XCTAssertEqual(ClawdCollection.allCases.count, 26)
        for col in ClawdCollection.allCases {
            XCTAssertFalse(ClawdEditions.editions(in: col).isEmpty, "empty collection \(col)")
        }
        XCTAssertGreaterThanOrEqual(ClawdEditions.all.count, 16)
    }

    func testProgressStoresWornEditionFavoritesAndSeen() {
        let p = ClawdProgress(defaults: UserDefaults(suiteName: "ed-\(UUID().uuidString)")!)
        XCTAssertNil(p.edition)
        p.edition = "fox"
        XCTAssertEqual(p.edition, "fox")
        p.edition = "no-such-edition"
        XCTAssertNil(p.edition, "unknown ids must not stick")
        p.toggleFavorite("fox"); p.toggleFavorite("cat")
        XCTAssertEqual(p.favorites, ["fox", "cat"])
        p.toggleFavorite("fox")
        XCTAssertEqual(p.favorites, ["cat"])
        p.markSeen(["fox"]); p.markSeen(["cat"])
        XCTAssertEqual(p.seenEditions, ["fox", "cat"])
    }

    @MainActor
    func testWearingAnEditionShowsItInThePlanAndHidesOutfits() {
        let c = MascotController(defaults: UserDefaults(suiteName: "wear-\(UUID().uuidString)")!)
        c.update(usage: nil)
        c.model.onWearEdition?("fox")
        XCTAssertEqual(c.model.plan.edition, "fox")
        XCTAssertTrue(c.model.plan.outfits.isEmpty)
        c.model.onWearEdition?(nil)
        XCTAssertNil(c.model.plan.edition)
        c.stop()
    }

    @MainActor
    func testDisplayNameTellsYouWhichClawdIsWorn() {
        let c = MascotController(defaults: UserDefaults(suiteName: "name-\(UUID().uuidString)")!)
        c.update(usage: nil)
        // With no edition the name is the worn outfit (seasonal ones count) or plain "Clawd".
        let expected = c.model.plan.outfits.first.flatMap { ClawdCatalog.item($0)?.name } ?? "Clawd"
        XCTAssertEqual(c.model.displayName, expected)
        XCTAssertEqual(c.model.displaySubtitle, "Idle")
        c.model.onWearEdition?("fox")
        XCTAssertEqual(c.model.displayName, "Fox")
        XCTAssertEqual(c.model.displaySubtitle, "Animals")
        c.stop()
    }

    func testTrademarkedEditionsAreFlaggedForEasyRemoval() {
        let franchise = ClawdEditions.all.filter { $0.collection == .franchise }
        XCTAssertFalse(franchise.isEmpty)
        XCTAssertTrue(franchise.allSatisfy(\.trademarked), "every franchise edition must carry the trademarked flag")
    }

    @MainActor
    func testPickedSceneAppliesWhenCalmButNeverOverWarnings() {
        let c = MascotController(defaults: UserDefaults(suiteName: "scene-\(UUID().uuidString)")!)
        c.update(usage: nil)
        c.model.onPickScene?("wizard")
        XCTAssertEqual(c.model.plan.scene, .wizard)
        c.model.onPickScene?(nil)
        XCTAssertNil(c.model.plan.scene)
        c.stop()
    }

    @MainActor
    func testMoodPreviewShowsThatMoodButNeverChangesRealResolution() {
        let c = MascotController(defaults: UserDefaults(suiteName: "preview-\(UUID().uuidString)")!)
        c.update(usage: nil)
        c.model.onPreviewMood?(.maxed)
        XCTAssertEqual(c.model.plan.mood, .maxed)
        c.stop()
    }

    @MainActor
    func testMicroMomentsCanBeSwitchedOffAndPlayedOnDemand() {
        let c = MascotController(defaults: UserDefaults(suiteName: "micro-\(UUID().uuidString)")!)
        c.update(usage: nil)
        c.model.onSetMicroEnabled?(.sneeze, false)
        XCTAssertTrue(c.model.disabledMicros.contains("sneeze"))
        c.model.onSetMicroEnabled?(.sneeze, true)
        XCTAssertFalse(c.model.disabledMicros.contains("sneeze"))
        c.model.onPlayMicro?(.dance)
        XCTAssertEqual(c.model.plan.micro, .dance)
        c.stop()
    }

    func testPickableShinyColorsRecolorTheBody() {
        for (i, hex) in ClawdCatalog.shinyColors.enumerated() {
            var plan = ClawdPlan(); plan.skin = "shiny\(i)"
            XCTAssertEqual(ClawdComposer.theme(for: plan).body, ClawdTheme.rgb(hex))
        }
        XCTAssertEqual(ClawdCatalog.skins.count, 1 + ClawdCatalog.shinyColors.count)
    }
}
