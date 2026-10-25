import XCTest
import AppKit
@testable import ClaudeBar

final class ClawdWardrobeTests: XCTestCase {
    private var cal: Calendar {
        var c = Calendar(identifier: .gregorian)
        c.timeZone = TimeZone(identifier: "UTC")!
        return c
    }
    private func progress() -> ClawdProgress { ClawdProgress(defaults: UserDefaults(suiteName: "w-\(UUID().uuidString)")!) }
    private func ctx(_ m: Int, _ d: Int, hour: Int = 12) -> ClawdContext {
        let date = cal.date(from: DateComponents(year: 2026, month: m, day: d, hour: hour))!
        return ClawdContext(now: date, calendar: cal, installDate: date, regionCode: "US")
    }

    func testLockedItemsAreNeverWorn() {
        let p = progress()
        XCTAssertTrue(ClawdWardrobe.resolve(ctx: ctx(10, 16), progress: p).outfits.isEmpty)
    }

    func testSeasonalHatWornOnceUnlockedInSeason() {
        let p = progress()
        let c = ctx(10, 16)
        p.evaluate(c)
        XCTAssertEqual(ClawdWardrobe.resolve(ctx: c, progress: p).outfits, ["witch"])
        // Out of season it stays unlocked but is not worn.
        XCTAssertTrue(ClawdWardrobe.resolve(ctx: ctx(11, 20), progress: p).outfits.isEmpty)
    }

    func testPriorityNewYearBeatsSantaInSameSlot() {
        let p = progress()
        let c = ctx(12, 31)
        p.evaluate(c)
        XCTAssertEqual(ClawdWardrobe.resolve(ctx: c, progress: p).outfits, ["newyear"])
    }

    func testPinOverridesAutomaticPickEvenIfNotEarned() {
        let p = progress()
        let c = ctx(10, 16)
        p.evaluate(c)
        p.pin(ClawdCatalog.crown)
        XCTAssertEqual(ClawdWardrobe.resolve(ctx: c, progress: p).outfits, ["crown"])
    }

    func testDifferentSlotsStack() {
        let p = progress()
        let c = ctx(10, 16, hour: 8)
        p.evaluate(c)
        XCTAssertEqual(Set(ClawdWardrobe.resolve(ctx: c, progress: p).outfits), ["witch", "mug"])
    }
}

final class ClawdComposerTests: XCTestCase {
    private func plans() -> [ClawdPlan] {
        var out: [ClawdPlan] = MascotState.allCases.map { var p = ClawdPlan(); p.mood = $0; return p }
        out += MicroMoment.allCases.map { var p = ClawdPlan(); p.micro = $0; return p }
        out += ClawdCatalog.outfits.map { var p = ClawdPlan(); p.outfits = [$0.id]; return p }
        for s in [ClawdScene.treadmillJog, .treadmillSprint, .wizard] { var p = ClawdPlan(); p.mood = .working; p.scene = s; out.append(p) }
        var pet = ClawdPlan(); pet.pet = true; out.append(pet)
        return out
    }

    func testEveryPlanComposesNonEmptyFramesOnTheCanvas() {
        for plan in plans() {
            let tl = ClawdComposer.timeline(for: plan)
            XCTAssertFalse(tl.frames.isEmpty)
            for f in tl.frames {
                XCTAssertEqual(f.canvas.w, PixelCanvas.width)
                XCTAssertEqual(f.canvas.h, PixelCanvas.height)
                XCTAssertGreaterThan(f.duration, 0)
                var painted = 0
                for y in 0..<f.canvas.h { for x in 0..<f.canvas.w where f.canvas[x, y] != "." { painted += 1 } }
                XCTAssertGreaterThan(painted, 30, "\(plan) frame looks empty")
            }
        }
    }

    func testEveryLegendCharacterUsedHasAColor() {
        let theme = ClawdTheme(body: ClawdTheme.rgb(0xD07A5C))
        for plan in plans() {
            for f in ClawdComposer.timeline(for: plan).frames {
                for y in 0..<f.canvas.h { for x in 0..<f.canvas.w where f.canvas[x, y] != "." {
                    XCTAssertNotNil(theme.color(for: f.canvas[x, y]), "no color for '\(f.canvas[x, y])' in \(plan)")
                } }
            }
        }
    }

    func testReduceMotionCollapsesToOneStaticFrame() {
        var p = ClawdPlan(); p.mood = .working; p.reduceMotion = true
        let tl = ClawdComposer.timeline(for: p)
        XCTAssertEqual(tl.frames.count, 1)
        XCTAssertFalse(tl.isOneShot)
    }

    func testOneShotFlags() {
        var reset = ClawdPlan(); reset.mood = .reset
        XCTAssertTrue(ClawdComposer.timeline(for: reset).isOneShot)
        var idle = ClawdPlan(); idle.mood = .idle
        XCTAssertFalse(ClawdComposer.timeline(for: idle).isOneShot)
        var micro = ClawdPlan(); micro.micro = .sneeze
        XCTAssertTrue(ClawdComposer.timeline(for: micro).isOneShot)
    }

    func testEveryMicroMomentAnimates() {
        for m in MicroMoment.allCases {
            var p = ClawdPlan(); p.micro = m
            XCTAssertGreaterThanOrEqual(ClawdComposer.timeline(for: p).frames.count, 3, "\(m)")
        }
    }

    func testIdleBlinksInsteadOfConstantlyFlickering() {
        let tl = ClawdComposer.timeline(for: ClawdPlan())
        let open = tl.frames.filter { $0.duration >= 0.9 }
        let blink = tl.frames.filter { $0.duration < 0.2 }
        XCTAssertFalse(open.isEmpty); XCTAssertFalse(blink.isEmpty)
        XCTAssertGreaterThan(open.reduce(0) { $0 + $1.duration }, 10 * blink.reduce(0) { $0 + $1.duration })
    }

    func testStatusColorBeatsCosmeticSkin() {
        var p = ClawdPlan(); p.skin = "golden"
        XCTAssertEqual(ClawdComposer.theme(for: p).body, ClawdTheme.rgb(0xF2C14E))
        p.mood = .maxed
        XCTAssertEqual(ClawdComposer.theme(for: p).body, ClawdTheme.rgb(0xE5484D))
        p.mood = .strained
        XCTAssertEqual(ClawdComposer.theme(for: p).body, ClawdTheme.rgb(0xDD6A3E))
    }

    func testMoodClaimsSlotsSoWarningFacesStayVisible() {
        var p = ClawdPlan(); p.mood = .strained; p.outfits = ["shades"]
        let withShades = ClawdComposer.preview(for: p).canvas
        p.outfits = []
        let without = ClawdComposer.preview(for: p).canvas
        XCTAssertEqual(withShades, without, "face props must yield to the strained face")
    }

    func testResetFlagReplacesHat() {
        var p = ClawdPlan(); p.mood = .reset; p.outfits = ["crown"]
        let a = ClawdComposer.preview(for: p).canvas
        p.outfits = []
        XCTAssertEqual(a, ClawdComposer.preview(for: p).canvas)
    }

    func testTimelineFrameLookupLoopsAndOneShotHolds() {
        let tl = ClawdComposer.timeline(for: ClawdPlan())
        XCTAssertEqual(tl.frame(at: 0), tl.frame(at: tl.totalDuration))
        var micro = ClawdPlan(); micro.micro = .hiccup
        let one = ClawdComposer.timeline(for: micro)
        XCTAssertEqual(one.frame(at: 999), one.frames.last!.canvas)
    }
}

final class MascotRendererTests: XCTestCase {
    func testRenderedSizeAndColorAreExact() {
        let tl = ClawdComposer.timeline(for: ClawdPlan())
        let image = MascotRenderer.render(tl.frames[0].canvas, theme: tl.theme)
        XCTAssertEqual(image.size.width, 32); XCTAssertEqual(image.size.height, 24, "full canvas; the animator trims it to 11 rows")
        XCTAssertFalse(image.isTemplate)

        let cg = MascotRenderer.cgImage(tl.frames[0].canvas, theme: tl.theme, pxPerCell: 3)!
        XCTAssertEqual(cg.width, 48); XCTAssertEqual(cg.height, 36)
        let rep = NSBitmapImageRep(cgImage: cg)
        // Cell (6, 3) is the head's top row; (0,0) is transparent.
        let body = rep.colorAt(x: 6 * 3 + 1, y: 3 * 3 + 1)!
        XCTAssertEqual(body.redComponent, 0xD0 / 255.0, accuracy: 0.01)
        XCTAssertEqual(body.greenComponent, 0x7A / 255.0, accuracy: 0.01)
        XCTAssertEqual(body.blueComponent, 0x5C / 255.0, accuracy: 0.01)
        XCTAssertEqual(rep.colorAt(x: 0, y: 0)!.alphaComponent, 0, accuracy: 0.001)
        let eye = rep.colorAt(x: 5 * 3 + 1, y: 4 * 3 + 1)!
        XCTAssertLessThan(eye.redComponent, 0.15)
    }

    func testSilhouetteHidesColors() {
        var theme = ClawdTheme(body: ClawdTheme.rgb(0xD07A5C)); theme.silhouette = true
        XCTAssertEqual(theme.color(for: "B"), theme.color(for: "k"))
        XCTAssertNil(theme.color(for: "."))
    }

    func testDarkBackdropLightensDarkProps() {
        var theme = ClawdTheme(body: ClawdTheme.rgb(0xD07A5C))
        let light = theme.color(for: "d")!
        theme.darkBackdrop = true
        XCTAssertGreaterThan(theme.color(for: "d")!.brightnessComponent, light.brightnessComponent)
    }
}
