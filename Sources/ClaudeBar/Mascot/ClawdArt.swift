import Foundation

/// Clawd's body and face, drawn procedurally on a 16x12 canvas.
/// The body is the reference silhouette: 8-wide head/body, a 2x2 nub on each
/// side, four legs, two square eyes. Body-grid origin sits at canvas (2, 3).
enum ClawdArt {
    static let bodyX = 2
    static let bodyY = 3

    enum Legs { case stand, liftA, liftB, tuck, ghostA, ghostB }
    enum Arms { case down, up, pumpA, pumpB }
    enum Eyes: Equatable { case open(look: Int), none, happy, dash, wide, squint }

    struct Pose: Equatable {
        var dx = 0
        var dy = 0
        var legs: Legs = .stand
        var arms: Arms = .down
        var eyes: Eyes = .open(look: 0)
        var yawn = false
    }

    private static let legCols = [2, 4, 7, 9]

    static func body(_ pose: Pose) -> PixelCanvas {
        var c = PixelCanvas()
        let ox = bodyX + pose.dx
        let oy = bodyY + pose.dy

        c.rect(ox + 2, oy, 8, 6, "B")

        let (leftY, rightY): (Int, Int)
        switch pose.arms {
        case .down:  (leftY, rightY) = (2, 2)
        case .up:    (leftY, rightY) = (0, 0)
        case .pumpA: (leftY, rightY) = (1, 3)
        case .pumpB: (leftY, rightY) = (3, 1)
        }
        c.rect(ox, oy + leftY, 2, 2, "B")
        c.rect(ox + 10, oy + rightY, 2, 2, "B")
        // The arm nubs only read as "attached" when they touch the body.
        if leftY != 2 || rightY != 2 {
            c.rect(ox + 2, oy + 2, 8, 2, "B")
        }

        switch pose.legs {
        case .stand:
            for col in legCols { c.rect(ox + col, oy + 6, 1, 2, "B") }
        case .liftA:
            for (i, col) in legCols.enumerated() { c.rect(ox + col, oy + 6, 1, i % 2 == 0 ? 1 : 2, "B") }
        case .liftB:
            for (i, col) in legCols.enumerated() { c.rect(ox + col, oy + 6, 1, i % 2 == 0 ? 2 : 1, "B") }
        case .tuck:
            for col in legCols { c.rect(ox + col, oy + 6, 1, 1, "B") }
        case .ghostA:
            c.stamp(["..BBBBBBBB..", "..BB.BB.BB.."], x: ox, y: oy + 6)
        case .ghostB:
            c.stamp(["..BBBBBBBB..", "..BBB..BBB.."], x: ox, y: oy + 6)
        }

        drawEyes(&c, pose.eyes, ox: ox, oy: oy)
        if pose.yawn { c.rect(ox + 5, oy + 3, 2, 2, "k") }
        return c
    }

    private static func drawEyes(_ c: inout PixelCanvas, _ eyes: Eyes, ox: Int, oy: Int) {
        let l = 3, r = 8
        func px(_ x: Int, _ y: Int) { c[ox + x, oy + y] = "k" }
        switch eyes {
        case .none:
            break
        case .open(let look):
            px(l + look, 1); px(r + look, 1)
        case .wide:
            px(l, 1); px(l, 2); px(r, 1); px(r, 2)
        case .happy:
            px(l, 0); px(l - 1, 1); px(l + 1, 1)
            px(r, 0); px(r - 1, 1); px(r + 1, 1)
        case .dash:
            px(l, 1); px(l + 1, 1); px(r - 1, 1); px(r, 1)
        case .squint:
            px(l - 1, 0); px(l, 1); px(l - 1, 2)
            px(r + 1, 0); px(r, 1); px(r + 1, 2)
        }
    }

    // MARK: Decorations (mood effects, drawn in canvas coordinates)

    /// Claude's spark flickering above the head while working.
    static func spark(phase: Int) -> [Stamp] {
        switch phase % 3 {
        case 0: return [Stamp([".g.", "ggg", ".g."], x: 6, y: 0)]
        case 1: return [Stamp(["g...g", ".ggg.", "g...g"], x: 5, y: 0)]
        default: return [Stamp(["...", ".g.", "..."], x: 6, y: 1)]
        }
    }

    /// A pixel "z" that grows as it rises, right of the head.
    static func zzz(phase: Int) -> [Stamp] {
        switch phase % 3 {
        case 0: return [Stamp(["l"], x: 13, y: 4)]
        case 1: return [Stamp(["l"], x: 12, y: 4), Stamp(["ll", ".l", "ll"], x: 13, y: 1)]
        default: return [Stamp(["l"], x: 12, y: 4), Stamp(["lll", "..l", ".l.", "l..", "lll"], x: 13, y: 0)]
        }
    }

    static func sweat(phase: Int) -> [Stamp] {
        [Stamp(["c", "c"], x: 13, y: 3 + (phase % 3))]
    }

    static func steam(phase: Int) -> [Stamp] {
        let a = phase % 2 == 0
        return [Stamp(["l"], x: 5, y: a ? 1 : 0), Stamp(["l"], x: 9, y: a ? 0 : 1), Stamp(["l"], x: 7, y: a ? 1 : 2)]
    }

    static func heart(phase: Int) -> [Stamp] {
        phase % 2 == 0
            ? [Stamp([".h.h.", "hhhhh", ".hhh."], x: 5, y: 0)]
            : [Stamp(["h.h", "hhh", ".h."], x: 6, y: 0)]
    }

    static func confetti(phase: Int) -> [Stamp] {
        let spots: [(Int, Int, Character)] = [(1, 0, "r"), (14, 1, "c"), (3, 2, "g"), (12, 0, "h"), (0, 4, "g"), (15, 5, "r")]
        return spots.enumerated().map { i, s in
            Stamp([String(s.2)], x: s.0, y: (s.1 + phase * 2 + i) % 9)
        }
    }

    /// Checkered finish flag held up on a pole at the head's right edge.
    static func flag(phase: Int) -> [Stamp] {
        let top = phase % 2 == 0 ? "kwkw" : "wkwk"
        let bottom = phase % 2 == 0 ? "wkwk" : "kwkw"
        return [Stamp(["k", "k", "k"], x: 11, y: 0), Stamp([top, bottom], x: 7, y: 0)]
    }

    /// Working prop: a little pickaxe swung by the left hand.
    static func tool(phase: Int) -> [Stamp] {
        phase % 2 == 0
            ? [Stamp(["yyy", ".n.", ".n."], x: 0, y: 3), Stamp(["n"], x: 1, y: 6)]
            : [Stamp(["y..", "ynn", "..n"], x: 0, y: 4), Stamp(["n"], x: 2, y: 7)]
    }

    static func sparkleAura(phase: Int) -> [Stamp] {
        let spots: [(Int, Int)] = [(1, 1), (14, 2), (13, 8), (0, 7)]
        return spots.enumerated().compactMap { i, s in
            (phase + i) % 3 == 0 ? Stamp(["g"], x: s.0, y: s.1) : nil
        }
    }
}

struct Stamp: Equatable {
    var rows: [String]
    var x: Int
    var y: Int
    init(_ rows: [String], x: Int, y: Int) { self.rows = rows; self.x = x; self.y = y }
}
