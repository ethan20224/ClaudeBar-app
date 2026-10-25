import XCTest
import AppKit
@testable import ClaudeBar

@MainActor
final class MascotControllerTests: XCTestCase {
    private func usage(util: Double) -> UsageData {
        UsageData(
            fiveHour: UsagePeriod(utilization: util, resetsAt: Date().addingTimeInterval(9000), periodSeconds: 5 * 3600),
            sevenDay: UsagePeriod(utilization: 0, resetsAt: Date().addingTimeInterval(7 * 24 * 3600), periodSeconds: 7 * 24 * 3600),
            fetchedAt: Date()
        )
    }
    private func make() -> MascotController {
        MascotController(defaults: UserDefaults(suiteName: "ctrl-\(UUID().uuidString)")!)
    }

    func testUpdateEmitsNonTemplateImage() {
        let c = make()
        var image: NSImage?
        c.onImage = { image = $0 }
        c.update(usage: usage(util: 50))
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.isTemplate, false)
        XCTAssertEqual(image?.size, NSSize(width: 32, height: 22), "16 columns x 11 rows at 2pt per cell")
        c.stop()
    }

    func testNilUsageStillEmitsIdleClawd() {
        let c = make()
        var image: NSImage?
        c.onImage = { image = $0 }
        c.update(usage: nil)
        XCTAssertNotNil(image)
        XCTAssertEqual(c.model.plan.mood, .idle)
        c.stop()
    }

    func testModelReflectsUsageMood() {
        let c = make()
        c.update(usage: usage(util: 80))
        XCTAssertEqual(c.model.plan.mood, .strained)
        c.update(usage: usage(util: 100))
        XCTAssertEqual(c.model.plan.mood, .locked)
        c.stop()
    }

    func testMoodsGetUnlockedWhenSeen() {
        let c = make()
        c.update(usage: usage(util: 80))
        XCTAssertTrue(c.model.unlocked.contains("mood-strained"))
        XCTAssertFalse(c.model.unlocked.contains("mood-maxed"))
        c.stop()
    }

    func testPettingShowsHappyPlanAndUnlocksMood() {
        let c = make()
        c.update(usage: usage(util: 10))
        c.petClawd()
        XCTAssertTrue(c.model.plan.pet)
        XCTAssertTrue(c.model.unlocked.contains("mood-pet"))
        c.stop()
    }

    func testEyeLookClampedAndAppliedToPlan() {
        let c = make()
        c.update(usage: usage(util: 10))
        c.setEyeLook(5)
        XCTAssertEqual(c.model.plan.eyeLook, 1)
        c.setEyeLook(-9)
        XCTAssertEqual(c.model.plan.eyeLook, -1)
        c.stop()
    }

    func testReduceMotionGivesSingleFramePlan() {
        let c = make()
        c.setReduceMotion(true)
        c.update(usage: usage(util: 10))
        XCTAssertEqual(c.model.timeline?.frames.count, 1)
        c.stop()
    }

    func testPauseHoldsStillAndMarksModel() {
        let c = make()
        c.update(usage: usage(util: 10))
        c.setReduceMotion(false) // forced refresh clears any first-load one-shot, so pause applies now
        c.toggleAnimations()
        XCTAssertFalse(c.motionAllowed)
        XCTAssertTrue(c.model.animationsPaused)
        XCTAssertTrue(c.model.plan.reduceMotion)
        XCTAssertEqual(c.model.timeline?.frames.count, 1)
        c.stop()
    }

    func testResumeOverridesSystemReduceMotion() {
        let c = make()
        c.setReduceMotion(true)
        XCTAssertFalse(c.motionAllowed)
        c.toggleAnimations()
        XCTAssertTrue(c.motionAllowed, "explicit resume wins over the system setting")
        XCTAssertFalse(c.model.animationsPaused)
        XCTAssertFalse(c.model.plan.reduceMotion)
        c.stop()
    }

    func testPauseChoicePersistsAcrossControllers() {
        let suite = "ctrl-\(UUID().uuidString)"
        let first = MascotController(defaults: UserDefaults(suiteName: suite)!)
        first.toggleAnimations()
        first.stop()
        let second = MascotController(defaults: UserDefaults(suiteName: suite)!)
        XCTAssertFalse(second.motionAllowed)
        second.stop()
    }

    func testSchedulerStartIsIdempotentAndFiresPick() {
        let s = MascotMicroScheduler(interval: 3600, jitter: 0, pick: { .yawn })
        var fired: MicroMoment?
        s.onTrigger = { fired = $0 }
        s.start(); s.start()
        XCTAssertTrue(s.isRunning)
        s.fireNow()
        XCTAssertEqual(fired, .yawn)
        s.stop()
        XCTAssertFalse(s.isRunning)
    }
}
