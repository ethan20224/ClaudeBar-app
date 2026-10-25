import Foundation

struct MascotResolution: Equatable {
    let state: MascotState
    let didCrossReset: Bool
    /// Usage points gained per hour over the recent window (0 when unknown).
    var burnPerHour: Double = 0
    /// Minutes the local `claude` process has been continuously live.
    var liveMinutes: Double = 0
}

final class MascotStateResolver {
    private static let sleepySeconds: TimeInterval = 1800
    private static let resetJumpSeconds: TimeInterval = 3600
    private static let burnWindow: TimeInterval = 30 * 60
    private static let burnMinSpan: TimeInterval = 5 * 60

    private var previousUtilization: Double?
    private var previousTimeUntilReset: TimeInterval?
    private var lastActivityDate: Date
    private var samples: [(date: Date, util: Double)] = []
    private var liveSince: Date?

    init(now: Date) {
        self.lastActivityDate = now
    }

    func resolve(usage: UsageData?, isClaudeProcessLive: Bool, now: Date) -> MascotResolution {
        if isClaudeProcessLive {
            if liveSince == nil { liveSince = now }
        } else {
            liveSince = nil
        }
        let liveMinutes = liveSince.map { now.timeIntervalSince($0) / 60 } ?? 0

        guard let usage else {
            return MascotResolution(state: .idle, didCrossReset: false, liveMinutes: liveMinutes)
        }

        let util = usage.fiveHour.utilization
        let untilReset = usage.fiveHour.timeUntilReset

        // Reset detection (one-shot): window flipped + utilization dropped.
        var didCrossReset = false
        if let prevUntil = previousTimeUntilReset, let nowUntil = untilReset,
           let prevUtil = previousUtilization,
           (nowUntil - prevUntil) >= Self.resetJumpSeconds, util < prevUtil {
            didCrossReset = true
            samples.removeAll()
        }

        // Burn rate from recent samples (only when a new sample arrives with a new value).
        if let last = samples.last, now.timeIntervalSince(last.date) < 1 {
            // same poll re-resolved; do not double count
        } else {
            samples.append((now, util))
        }
        samples.removeAll { now.timeIntervalSince($0.date) > Self.burnWindow }
        var burn = 0.0
        if let first = samples.first, let last = samples.last {
            let span = last.date.timeIntervalSince(first.date)
            if span >= Self.burnMinSpan { burn = max(0, (last.util - first.util) / (span / 3600)) }
        }

        // Activity → working, and refresh lastActivityDate.
        let deltaUp = (previousUtilization.map { util > $0 }) ?? false
        let working = isClaudeProcessLive || deltaUp
        if working { lastActivityDate = now }

        // Choose state by priority.
        let state: MascotState
        if didCrossReset {
            state = .reset
        } else if util >= 100 {
            state = .locked
        } else if util >= 90 {
            state = .maxed
        } else if util >= 75 {
            state = .strained
        } else if working {
            state = .working
        } else if now.timeIntervalSince(lastActivityDate) > Self.sleepySeconds {
            state = .sleepy
        } else {
            state = .idle
        }

        previousUtilization = util
        previousTimeUntilReset = untilReset
        return MascotResolution(state: state, didCrossReset: didCrossReset, burnPerHour: burn, liveMinutes: liveMinutes)
    }
}
