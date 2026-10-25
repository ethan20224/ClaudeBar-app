import XCTest
@testable import ClaudeBar

final class MascotStateResolverTests: XCTestCase {
    private func usage(util: Double, untilReset: TimeInterval) -> UsageData {
        UsageData(
            fiveHour: UsagePeriod(utilization: util, resetsAt: Date().addingTimeInterval(untilReset), periodSeconds: 5 * 3600),
            sevenDay: UsagePeriod(utilization: 0, resetsAt: Date().addingTimeInterval(7 * 24 * 3600), periodSeconds: 7 * 24 * 3600),
            fetchedAt: Date()
        )
    }

    func testNoUsageIsIdle() {
        let r = MascotStateResolver(now: Date())
        XCTAssertEqual(r.resolve(usage: nil, isClaudeProcessLive: false, now: Date()),
                       MascotResolution(state: .idle, didCrossReset: false))
    }

    func testDeltaUpIsWorking() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 40, untilReset: 9000), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 42, untilReset: 8900), isClaudeProcessLive: false, now: t0.addingTimeInterval(60))
        XCTAssertEqual(res.state, .working)
    }

    func testProcessLiveIsWorking() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        let res = r.resolve(usage: usage(util: 40, untilReset: 9000), isClaudeProcessLive: true, now: t0)
        XCTAssertEqual(res.state, .working)
    }

    func testIdleWhenFlatAndRecent() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 40, untilReset: 9000), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 40, untilReset: 8940), isClaudeProcessLive: false, now: t0.addingTimeInterval(60))
        XCTAssertEqual(res.state, .idle)
    }

    func testSleepyAfterThreshold() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 40, untilReset: 9000), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 40, untilReset: 7000), isClaudeProcessLive: false, now: t0.addingTimeInterval(2000))
        XCTAssertEqual(res.state, .sleepy)
    }

    func testStrainedAt75() {
        let r = MascotStateResolver(now: Date())
        let res = r.resolve(usage: usage(util: 80, untilReset: 5000), isClaudeProcessLive: false, now: Date())
        XCTAssertEqual(res.state, .strained)
    }

    func testMaxedAt90() {
        let r = MascotStateResolver(now: Date())
        let res = r.resolve(usage: usage(util: 95, untilReset: 5000), isClaudeProcessLive: false, now: Date())
        XCTAssertEqual(res.state, .maxed)
    }

    func testMaxedBeatsWorking() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 88, untilReset: 5000), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 95, untilReset: 4900), isClaudeProcessLive: true, now: t0.addingTimeInterval(60))
        XCTAssertEqual(res.state, .maxed)
    }

    func testResetOneShot() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 95, untilReset: 120), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 3, untilReset: 17000), isClaudeProcessLive: false, now: t0.addingTimeInterval(120))
        XCTAssertEqual(res.state, .reset)
        XCTAssertTrue(res.didCrossReset)
        // Next poll should NOT re-trigger reset.
        let after = r.resolve(usage: usage(util: 4, untilReset: 16900), isClaudeProcessLive: false, now: t0.addingTimeInterval(180))
        XCTAssertFalse(after.didCrossReset)
    }

    func testLockedAt100BeatsMaxed() {
        let r = MascotStateResolver(now: Date())
        let res = r.resolve(usage: usage(util: 100, untilReset: 5000), isClaudeProcessLive: false, now: Date())
        XCTAssertEqual(res.state, .locked)
    }

    func testBurnRateFromRecentSamples() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 10, untilReset: 9000), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 20, untilReset: 8400), isClaudeProcessLive: false, now: t0.addingTimeInterval(1200))
        XCTAssertEqual(res.burnPerHour, 30, accuracy: 0.5) // +10 over 20 minutes
    }

    func testBurnRateUnknownWithTooLittleHistory() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 10, untilReset: 9000), isClaudeProcessLive: false, now: t0)
        let res = r.resolve(usage: usage(util: 20, untilReset: 8940), isClaudeProcessLive: false, now: t0.addingTimeInterval(60))
        XCTAssertEqual(res.burnPerHour, 0)
    }

    func testLiveMinutesTracksContinuousProcess() {
        let t0 = Date()
        let r = MascotStateResolver(now: t0)
        _ = r.resolve(usage: usage(util: 10, untilReset: 9000), isClaudeProcessLive: true, now: t0)
        let mid = r.resolve(usage: usage(util: 10, untilReset: 8000), isClaudeProcessLive: true, now: t0.addingTimeInterval(50 * 60))
        XCTAssertEqual(mid.liveMinutes, 50, accuracy: 0.1)
        let off = r.resolve(usage: usage(util: 10, untilReset: 7000), isClaudeProcessLive: false, now: t0.addingTimeInterval(55 * 60))
        XCTAssertEqual(off.liveMinutes, 0)
    }
}
