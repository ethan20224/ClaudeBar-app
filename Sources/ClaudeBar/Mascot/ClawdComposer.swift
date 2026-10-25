import AppKit

enum ClawdScene: Equatable {
    case treadmillJog, treadmillSprint, wizard
}

/// A complete description of what Clawd looks like right now.
struct ClawdPlan: Equatable {
    var mood: MascotState = .idle
    var scene: ClawdScene?
    var micro: MicroMoment?
    var pet = false
    /// Outfit ids worn (already resolved: one per slot, mood-claimed slots removed).
    var outfits: [String] = []
    var skin: String?
    var shinyColor: UInt32?
    /// A full-character edition worn instead of outfits (see `ClawdEdition`).
    var edition: String?
    var eyeLook = 0
    var darkBackdrop = false
    var reduceMotion = false

    var isOneShot: Bool { micro != nil || pet || (mood == .reset && scene == nil) }
}

struct ClawdFrame {
    let canvas: PixelCanvas
    let duration: TimeInterval
}

struct ClawdTimeline {
    let frames: [ClawdFrame]
    let theme: ClawdTheme
    let isOneShot: Bool

    var totalDuration: TimeInterval { frames.reduce(0) { $0 + $1.duration } }

    /// The frame showing `t` seconds in (loops unless one-shot).
    func frame(at t: TimeInterval) -> PixelCanvas { frames[index(at: t)].canvas }

    func index(at t: TimeInterval) -> Int {
        guard frames.count > 1 else { return 0 }
        let total = totalDuration
        var cursor = isOneShot ? min(t, total - 0.0001) : t.truncatingRemainder(dividingBy: total)
        for (i, f) in frames.enumerated() {
            if cursor < f.duration { return i }
            cursor -= f.duration
        }
        return frames.count - 1
    }
}

enum ClawdComposer {
    private struct Spec {
        var pose: ClawdArt.Pose
        var duration: TimeInterval
        var phase: Int = 0
        var extra: [Stamp] = []
        var overlays: [Stamp] = []
    }

    static func theme(for plan: ClawdPlan) -> ClawdTheme {
        var body = ClawdTheme.rgb(0xD07A5C)
        var alpha: CGFloat = 1
        if let color = plan.edition.flatMap(ClawdEditions.edition)?.bodyColor { body = ClawdTheme.rgb(color) }
        switch plan.skin {
        case "golden": body = ClawdTheme.rgb(0xF2C14E)
        case "shiny": body = ClawdTheme.rgb(plan.shinyColor ?? 0x2FB5A8)
        case let id? where id.hasPrefix("shiny"):
            if let i = Int(id.dropFirst(5)), ClawdCatalog.shinyColors.indices.contains(i) { body = ClawdTheme.rgb(ClawdCatalog.shinyColors[i]) }
        default: break
        }
        // Status colors always win over cosmetics so danger is never hidden.
        switch plan.mood {
        case .strained: body = ClawdTheme.rgb(0xDD6A3E)
        case .maxed:    body = ClawdTheme.rgb(0xE5484D)
        case .locked:   body = ClawdTheme.rgb(0xCFD8E6); alpha = 0.8
        default: break
        }
        return ClawdTheme(body: body, bodyAlpha: alpha, darkBackdrop: plan.darkBackdrop)
    }

    /// Slots a mood or scene takes over, so props never fight the main action.
    static func claimedSlots(for plan: ClawdPlan) -> Set<ClawdSlot> {
        if plan.scene != nil { return [.head, .face, .hand, .back] }
        if plan.pet { return [.face] }
        switch plan.mood {
        case .working:                          return [.hand]
        case .reset:                            return [.head, .hand]
        case .sleepy, .strained, .maxed, .locked: return [.face]
        case .idle:                             return []
        }
    }

    static func timeline(for plan: ClawdPlan) -> ClawdTimeline {
        let specs = specs(for: plan)
        let items = plan.outfits.compactMap(ClawdCatalog.item)
        let frames = specs.map { spec in
            ClawdFrame(canvas: compose(spec, plan: plan, items: items), duration: spec.duration)
        }
        let shown = plan.reduceMotion ? Array(frames.prefix(1)) : frames
        return ClawdTimeline(frames: shown, theme: theme(for: plan), isOneShot: plan.isOneShot && !plan.reduceMotion)
    }

    /// First frame only — cheap, for Clawdex tiles.
    static func preview(for plan: ClawdPlan) -> (canvas: PixelCanvas, theme: ClawdTheme) {
        let items = plan.outfits.compactMap(ClawdCatalog.item)
        guard let first = specs(for: plan).first else { return (PixelCanvas(), theme(for: plan)) }
        return (compose(first, plan: plan, items: items), theme(for: plan))
    }

    private static func compose(_ spec: Spec, plan: ClawdPlan, items: [ClawdItem]) -> PixelCanvas {
        var c = PixelCanvas()
        let skinItem = plan.skin.flatMap(ClawdCatalog.item)
        let claimed = claimedSlots(for: plan)

        // Auras and scenery sit behind the body.
        for item in items where !item.followsBody { for s in item.stamps(spec.phase) { c.stamp(s.rows, x: s.x, y: s.y) } }
        if let skinItem, plan.mood != .strained, plan.mood != .maxed, plan.mood != .locked {
            for s in skinItem.stamps(spec.phase) { c.stamp(s.rows, x: s.x, y: s.y) }
        }
        c.overlay(ClawdArt.body(spec.pose), x: 0, y: 0)
        for s in spec.extra { c.stamp(s.rows, x: s.x, y: s.y) }

        for item in items where item.followsBody {
            if let slot = item.slot, claimed.contains(slot) { continue }
            for s in item.stamps(spec.phase) { c.stamp(s.rows, x: s.x + spec.pose.dx, y: s.y + spec.pose.dy) }
        }
        if let edition = plan.edition.flatMap(ClawdEditions.edition) {
            for part in edition.parts where !claimed.contains(part.slot) {
                let (dx, dy) = part.followsBody ? (spec.pose.dx, spec.pose.dy) : (0, 0)
                for s in part.stamps(spec.phase) { c.stamp(s.rows, x: s.x + dx, y: s.y + dy) }
            }
        }
        for s in spec.overlays { c.stamp(s.rows, x: s.x, y: s.y) }
        return c
    }

    private static func shift(_ stamps: [Stamp], _ dx: Int, _ dy: Int) -> [Stamp] {
        stamps.map { Stamp($0.rows, x: $0.x + dx, y: $0.y + dy) }
    }

    // MARK: Timelines

    private static func specs(for plan: ClawdPlan) -> [Spec] {
        if let micro = plan.micro { return microSpecs(micro, look: plan.eyeLook) }
        if plan.pet { return petSpecs() }
        if let scene = plan.scene { return sceneSpecs(scene) }
        return moodSpecs(plan.mood, look: plan.eyeLook)
    }

    private static func moodSpecs(_ mood: MascotState, look: Int) -> [Spec] {
        typealias P = ClawdArt.Pose
        switch mood {
        case .idle:
            let open = P(eyes: .open(look: look)), blink = P(eyes: .none)
            return [Spec(pose: open, duration: 2.8), Spec(pose: blink, duration: 0.14),
                    Spec(pose: open, duration: 4.2), Spec(pose: blink, duration: 0.14),
                    Spec(pose: open, duration: 0.9), Spec(pose: blink, duration: 0.12)]
        case .working:
            return (0..<4).map { i in
                Spec(pose: P(legs: i % 2 == 0 ? .liftA : .liftB, eyes: .open(look: 0)), duration: 0.24, phase: i,
                     extra: ClawdArt.tool(phase: i) + ClawdArt.spark(phase: i))
            }
        case .sleepy:
            return (0..<3).map { i in
                Spec(pose: P(dy: 1, legs: .tuck, eyes: .dash), duration: 0.9, phase: i, extra: ClawdArt.zzz(phase: i))
            }
        case .strained:
            return (0..<3).map { i in
                Spec(pose: P(legs: i % 2 == 0 ? .liftA : .liftB, eyes: .wide), duration: 0.16, phase: i,
                     extra: ClawdArt.sweat(phase: i))
            }
        case .maxed:
            return (0..<4).map { i in
                Spec(pose: P(dy: i % 2, legs: i % 2 == 0 ? .liftA : .liftB, eyes: .squint), duration: 0.2, phase: i,
                     extra: ClawdArt.steam(phase: i) + ClawdArt.sweat(phase: i))
            }
        case .locked:
            return [0, 1, 2, 3].map { i in
                Spec(pose: P(dy: i < 2 ? 0 : -1, legs: i % 2 == 0 ? .ghostA : .ghostB, eyes: .open(look: look)),
                     duration: 0.5, phase: i)
            }
        case .reset:
            let seq = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1]
            return seq.enumerated().map { i, dy in
                Spec(pose: P(dy: dy, arms: dy == 0 ? .up : .down, eyes: .happy), duration: 0.2, phase: i,
                     extra: shift(ClawdArt.flag(phase: i), 0, dy) + ClawdArt.confetti(phase: i))
            }
        }
    }

    private static func petSpecs() -> [Spec] {
        (0..<6).map { i in
            let dy = i % 2 == 0 ? 1 : 0
            return Spec(pose: ClawdArt.Pose(dy: dy, arms: dy == 0 ? .up : .down, eyes: .happy),
                        duration: 0.22, phase: i, extra: ClawdArt.heart(phase: i))
        }
    }

    private static func sceneSpecs(_ scene: ClawdScene) -> [Spec] {
        typealias P = ClawdArt.Pose
        switch scene {
        case .treadmillJog, .treadmillSprint:
            let fast = scene == .treadmillSprint
            return (0..<4).map { i in
                let up = i % 2 == 0
                var extra = treadmill(phase: i)
                if fast { extra += sweatAndSpeed(phase: i) }
                return Spec(pose: P(dy: up ? -1 : -2, legs: up ? .liftA : .liftB, arms: up ? .pumpA : .pumpB,
                                    eyes: fast ? .wide : .open(look: 0)),
                            duration: fast ? 0.11 : 0.26, phase: i, extra: extra)
            }
        case .wizard:
            return (0..<4).map { i in
                Spec(pose: P(arms: i >= 2 ? .up : .down, eyes: .open(look: 0)), duration: 0.35, phase: i,
                     extra: wizardGear(phase: i))
            }
        }
    }

    private static func treadmill(phase: Int) -> [Stamp] {
        var belt = Array(repeating: Character("d"), count: 14)
        for i in stride(from: (phase * 2) % 4, to: 14, by: 4) { belt[i] = "y" }
        return [Stamp([String(belt), String(repeating: "d", count: 14)], x: 1, y: 10),
                Stamp(["y", "y", "y", "y", "y", "y", "y"], x: 15, y: 3),
                Stamp(["dd", "de"], x: 14, y: 1)]
    }

    private static func sweatAndSpeed(phase: Int) -> [Stamp] {
        [Stamp(["c", "c"], x: 13, y: 2 + phase % 3),
         Stamp(["ll"], x: 0, y: 4 + phase % 2), Stamp(["l"], x: 1, y: 7 - phase % 2)]
    }

    private static func wizardGear(phase: Int) -> [Stamp] {
        let glow: Character = phase % 2 == 0 ? "c" : "w"
        var s: [Stamp] = [
            // hat
            Stamp(["xx"], x: 7, y: 0), Stamp(["xgxx"], x: 6, y: 1), Stamp(["uuuuuuuuuu"], x: 3, y: 2),
            // robe and beard
            Stamp(["xxxxxxxx"], x: 4, y: 7), Stamp(["xxxxxxxx"], x: 4, y: 8),
            Stamp(["wwwwww"], x: 5, y: 5), Stamp(["wwwwww"], x: 5, y: 6),
            Stamp(["wwww"], x: 6, y: 7), Stamp([".ww."], x: 6, y: 8),
            // staff with a pulsing orb
            Stamp(["n", "n", "n", "n", "n", "n", "n", "n"], x: 1, y: 3),
            Stamp(["cc", "c\(glow)"], x: 0, y: 1),
        ]
        let sparks: [(Int, Int)] = [(3, 1), (14, 0), (13, 9), (0, 10)]
        for (i, p) in sparks.enumerated() where (phase + i) % 2 == 0 { s.append(Stamp(["w"], x: p.0, y: p.1)) }
        return s
    }

    private static func microSpecs(_ micro: MicroMoment, look: Int) -> [Spec] {
        typealias P = ClawdArt.Pose
        switch micro {
        case .sneeze:
            let spray = [Stamp(["l.l"], x: 0, y: 5), Stamp(["l..l"], x: 12, y: 5), Stamp(["l", "l"], x: 15, y: 7)]
            return [Spec(pose: P(eyes: .open(look: 0)), duration: 0.5),
                    Spec(pose: P(dy: 1, eyes: .dash), duration: 0.3),
                    Spec(pose: P(dy: 1, eyes: .dash), duration: 0.3),
                    Spec(pose: P(dx: -1, eyes: .squint), duration: 0.14, extra: spray),
                    Spec(pose: P(dx: -1, eyes: .squint), duration: 0.2, extra: shift(spray, 0, 1)),
                    Spec(pose: P(eyes: .open(look: 0)), duration: 0.5)]
        case .stretch:
            return [Spec(pose: P(eyes: .open(look: 0)), duration: 0.4),
                    Spec(pose: P(arms: .up, eyes: .dash), duration: 0.8),
                    Spec(pose: P(dy: 0, legs: .tuck, arms: .up, eyes: .dash), duration: 0.8),
                    Spec(pose: P(eyes: .open(look: 0)), duration: 0.4)]
        case .bugChase:
            let xs = [13, 10, 7, 4, 1]
            let looks = [1, 1, 0, -1, -1]
            return xs.enumerated().map { i, x in
                Spec(pose: P(legs: i % 2 == 0 ? .liftA : .liftB, eyes: .open(look: looks[i])), duration: 0.38,
                     extra: [Stamp(["kk"], x: x, y: 11)])
            } + [Spec(pose: P(eyes: .open(look: 0)), duration: 0.4)]
        case .yawn:
            return [Spec(pose: P(eyes: .open(look: 0)), duration: 0.3),
                    Spec(pose: P(eyes: .dash, yawn: true), duration: 0.7),
                    Spec(pose: P(dy: 1, legs: .tuck, eyes: .dash, yawn: true), duration: 0.7),
                    Spec(pose: P(eyes: .open(look: 0)), duration: 0.3)]
        case .dance:
            let beats: [(Int, ClawdArt.Arms)] = [(-1, .pumpA), (1, .pumpB), (-1, .pumpA), (1, .pumpB), (0, .up)]
            return beats.map { dx, arms in
                Spec(pose: P(dx: dx, legs: dx == 0 ? .stand : (dx < 0 ? .liftA : .liftB), arms: arms, eyes: .happy), duration: 0.2)
            } + [Spec(pose: P(eyes: .open(look: 0)), duration: 0.4)]
        case .hiccup:
            return [Spec(pose: P(eyes: .open(look: 0)), duration: 0.5),
                    Spec(pose: P(dy: 1, eyes: .wide), duration: 0.12),
                    Spec(pose: P(eyes: .open(look: 0)), duration: 0.5),
                    Spec(pose: P(dy: 1, eyes: .wide), duration: 0.12),
                    Spec(pose: P(eyes: .open(look: 0)), duration: 0.5)]
        }
    }
}
