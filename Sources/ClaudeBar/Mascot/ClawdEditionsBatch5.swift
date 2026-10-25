import Foundation

extension ClawdEditions {
    /// Batch 5: holidays and seasons; see ClawdEditionsCore.swift for the format.
    static let batch5: [ClawdEdition] = [

        ClawdEdition(
            id: "b5-snowman", name: "Snowman", collection: .holidays,
            blurb: "Top hat, carrot nose, and a very cool head on its shoulders.",
            bodyColor: 0xDADCE0,
            parts: [
                .init(.head) { _ in [Stamp(["dddd", "rrrr"], x: 6, y: 0), Stamp(["dddddd"], x: 5, y: 2)] },
                .init(.face) { _ in [Stamp(["ooo"], x: 7, y: 5), Stamp(["k....k", ".kkkk."], x: 5, y: 6)] },
                .init(.back) { _ in [Stamp(["xcxcxcxc"], x: 4, y: 8), Stamp(["x", "c"], x: 12, y: 8),
                                     Stamp(["n", "nn"], x: 0, y: 4), Stamp(["n", "nn"], x: 15, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: p % 12), Stamp(["w"], x: 14, y: (p + 4) % 12),
                                                         Stamp(["w"], x: 0, y: (p + 8) % 12), Stamp(["w"], x: 15, y: (p + 2) % 12),
                                                         Stamp(["w"], x: 12, y: (p + 9) % 3)] },
            ]),

        ClawdEdition(
            id: "b5-gingerbread", name: "Gingerbread", collection: .holidays,
            blurb: "Baked golden, iced with care, and absolutely not running from you.",
            bodyColor: 0xB5753A,
            parts: [
                .init(.face) { _ in [Stamp(["w..w", ".ww."], x: 6, y: 6)] },
                .init(.back) { _ in [Stamp(["w", "w"], x: 2, y: 5), Stamp(["w", "w"], x: 13, y: 5),
                                     Stamp(["rrgrr"], x: 5, y: 8),
                                     Stamp(["w"], x: 4, y: 10), Stamp(["w"], x: 6, y: 10),
                                     Stamp(["w"], x: 9, y: 10), Stamp(["w"], x: 11, y: 10)] },
                .init(.head) { p in [Stamp(["w.w.w.w.w"], x: 3, y: 2), Stamp([p % 2 == 0 ? "r" : "e"], x: 7, y: 1)] },
                .init(.aura, followsBody: false) { p in [Stamp(["n"], x: 1 + p % 3, y: 11), Stamp(["n"], x: 13 - p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b5-christmas-tree", name: "Christmas Tree", collection: .holidays,
            blurb: "Lit up, loaded with ornaments, and guarding a pile of presents.",
            bodyColor: 0x2E8B4A,
            parts: [
                .init(.head) { p in [Stamp([p % 2 == 0 ? "gg" : "ww"], x: 7, y: 0),
                                     Stamp(["BB"], x: 7, y: 1), Stamp(["BBBB"], x: 6, y: 2)] },
                .init(.back) { p in
                    let c = ["r", "g", "c", "h"]
                    return [Stamp([c[p % 4]], x: 5, y: 6), Stamp([c[(p + 1) % 4]], x: 10, y: 5),
                            Stamp([c[(p + 2) % 4]], x: 7, y: 7), Stamp([c[(p + 3) % 4]], x: 9, y: 8),
                            Stamp([c[(p + 1) % 4]], x: 4, y: 8),
                            Stamp(["n", "n"], x: 4, y: 9), Stamp(["n", "n"], x: 6, y: 9),
                            Stamp(["n", "n"], x: 9, y: 9), Stamp(["n", "n"], x: 11, y: 9)]
                },
                .init(.aura, followsBody: false) { _ in [Stamp(["rg", "rg"], x: 0, y: 10), Stamp(["cg", "cg"], x: 14, y: 10)] },
            ]),

        ClawdEdition(
            id: "b5-santa-claus", name: "Santa Claus", collection: .holidays,
            blurb: "Big white beard, bigger sack, one very long list.",
            bodyColor: 0xC8352D,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrw"], x: 6, y: 0), Stamp(["rrrrrr"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["hh"], x: 7, y: 5), Stamp(["wwwwww"], x: 5, y: 6),
                                     Stamp(["wwwwwwww"], x: 4, y: 7), Stamp(["wwwwww"], x: 5, y: 8)] },
                .init(.back) { _ in [Stamp([".g.", "nnn", "nnn", "nnn"], x: 13, y: 7),
                                     Stamp(["d", "d"], x: 4, y: 9), Stamp(["d", "d"], x: 6, y: 9),
                                     Stamp(["d", "d"], x: 9, y: 9), Stamp(["d", "d"], x: 11, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 0, y: (p * 2) % 12), Stamp(["w"], x: 1, y: (p * 2 + 6) % 12)] },
            ]),

        ClawdEdition(
            id: "b5-menorah", name: "Festival of Lights", collection: .holidays,
            blurb: "A glowing menorah on top and a dreidel mid-spin.",
            bodyColor: 0x3F6FCF,
            parts: [
                .init(.head) { p in
                    let f = p % 2 == 0
                    let flame = f ? "o.g.o.oo.g.o.g" : "g.o.g.oo.o.g.o"
                    return [Stamp([flame], x: 1, y: 0),
                            Stamp(["w.w.w.ww.w.w.w"], x: 1, y: 1),
                            Stamp(["gggggggggggggg"], x: 1, y: 2)]
                },
                .init(.back) { p in [Stamp([".g.", "www", "wxw", ".w."], x: 13, y: 7 + (p % 2))] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 0, y: 3 + p % 3), Stamp(["w"], x: 15, y: 4 + (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b5-kinara", name: "Kinara Night", collection: .holidays,
            blurb: "Seven candles, kente stripes, and a table set for community.",
            parts: [
                .init(.head) { p in
                    let f = p % 2 == 0
                    return [Stamp([f ? "o.g.o.g.o.g.o" : "g.o.g.o.g.o.g"], x: 2, y: 0),
                            Stamp(["r.r.r.d.e.e.e"], x: 2, y: 1),
                            Stamp(["nnnnnnnnnnnnn"], x: 2, y: 2)]
                },
                .init(.back) { _ in [Stamp(["rgegrgeg"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([b5cyc("rgeg", 12, p)], x: 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b5-easter-bunny", name: "Easter Bunny", collection: .holidays,
            blurb: "Floppy ears, twitchy nose, and a basket of very suspicious eggs.",
            bodyColor: 0xE6D9D9,
            parts: [
                .init(.head) { p in
                    let twitch = p % 4 >= 2
                    return [Stamp(twitch ? ["Bh", "Bh", "Bh"] : ["Bh", "Bh", "Bh"], x: 5, y: 0),
                            Stamp(twitch ? [".B", "hB", "hB"] : ["hB", "hB", "hB"], x: twitch ? 10 : 9, y: twitch ? 0 : 0)]
                },
                .init(.face) { _ in [Stamp(["hh"], x: 7, y: 5), Stamp(["ww"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "hcgh" : "chhg"], x: 12, y: 8),
                                     Stamp(["nnnn", "nnnn"], x: 12, y: 9), Stamp(["ww"], x: 2, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e.e.e.e"], x: 0, y: 11), Stamp(["e"], x: 1 + p % 2, y: 10)] },
            ]),

        ClawdEdition(
            id: "b5-easter-egg", name: "Hatching Egg", collection: .holidays,
            blurb: "Painted, polka-dotted, and cracking under the pressure of spring.",
            bodyColor: 0xF0A8C5,
            parts: [
                .init(.head) { p in [Stamp(["kggk"], x: 6, y: 0), Stamp(["gggg"], x: 6, y: 1),
                                     Stamp(["oo"], x: 7, y: 2), Stamp(["g"], x: p % 2 == 0 ? 5 : 10, y: 1),
                                     Stamp(["w.w.w.w."], x: 4, y: 3)] },
                .init(.back) { _ in [Stamp(["c.c.c.c.", ".c.c.c.c"], x: 4, y: 7),
                                     Stamp(["g"], x: 4, y: 5), Stamp(["g"], x: 7, y: 5), Stamp(["g"], x: 11, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp([b5cyc("eee.", 16, p / 2)], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b5-jack-o-lantern", name: "Jack-o-Lantern", collection: .holidays,
            blurb: "Carved grin, candle glow, and a stem that has seen things.",
            bodyColor: 0xE8821E,
            parts: [
                .init(.head) { _ in [Stamp(["ee", "e"], x: 7, y: 1), Stamp(["e"], x: 8, y: 0)] },
                .init(.face) { p in
                    let g = p % 2 == 0 ? "g" : "o"
                    return [Stamp([".k.", "kkk"], x: 4, y: 4), Stamp([".k.", "kkk"], x: 9, y: 4),
                            Stamp(["kkkkkk", "k\(g)kk\(g)k"], x: 5, y: 6)]
                },
                .init(.aura, followsBody: false) { p in
                    p % 2 == 0 ? [Stamp(["d.d", ".d."], x: 0, y: 1), Stamp(["d.d", ".d."], x: 13, y: 0)]
                               : [Stamp(["ddd"], x: 0, y: 1), Stamp(["ddd"], x: 13, y: 1)]
                },
            ]),

        ClawdEdition(
            id: "b5-ghost", name: "Bedsheet Ghost", collection: .holidays,
            blurb: "Two eyeholes, one sheet, zero actual haunting experience.",
            bodyColor: 0xE6E8EC,
            parts: [
                .init(.head) { _ in [Stamp(["ww"], x: 7, y: 2)] },
                .init(.face) { _ in [Stamp(["k", "k"], x: 5, y: 4), Stamp(["k", "k"], x: 10, y: 4), Stamp(["kk", "kk"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["wwwwwwwwww"], x: 3, y: 9),
                                     Stamp([p % 2 == 0 ? "ww.ww.ww.w" : "w.ww.ww.ww"], x: 3, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 2 + p % 2), Stamp(["g"], x: 14, y: 5 - p % 2),
                                                         Stamp(["w"], x: 0, y: 8)] },
            ]),

        ClawdEdition(
            id: "b5-midnight-cat", name: "Midnight Cat", collection: .holidays,
            blurb: "Moonlit fur, gold eyes, and a bell that does not fool anyone.",
            bodyColor: 0x6B5A82,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1),
                                     Stamp(["h"], x: 5, y: 2), Stamp(["h"], x: 10, y: 2)] },
                .init(.face) { _ in [Stamp(["g"], x: 5, y: 4), Stamp(["g"], x: 10, y: 4), Stamp(["hh"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["rrrr"], x: 6, y: 8), Stamp(["g"], x: 7, y: 8),
                                     Stamp(["B", "B", "B", "B", "B", "B"], x: 14, y: 3),
                                     Stamp(["B"], x: p % 2 == 0 ? 15 : 14, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gg", "g.", "gg"], x: 0, y: 0),
                                                         Stamp(["w"], x: 3, y: 1 + p % 2), Stamp(["w"], x: 11, y: 0)] },
            ]),

        ClawdEdition(
            id: "b5-cupid", name: "Cupid", collection: .holidays,
            blurb: "Tiny wings, golden halo, and unnervingly good aim.",
            bodyColor: 0xF4C7B5,
            parts: [
                .init(.head) { _ in [Stamp([".gggg.", "g....g"], x: 5, y: 1)] },
                .init(.back) { p in
                    let up = p % 2 == 0
                    return [Stamp(up ? ["ww..", "www.", "wwww", ".www"] : ["....", "ww..", "www.", "wwww"], x: 0, y: up ? 2 : 3),
                            Stamp(up ? ["..ww", ".www", "wwww", "www."] : ["....", "..ww", ".www", "wwww"], x: 12, y: up ? 2 : 3)]
                },
                .init(.hand) { _ in [Stamp([".n", "n.", "n.", "n.", ".n"], x: 14, y: 3), Stamp(["l", "l", "l"], x: 15, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r"], x: 7, y: 2 - p % 3), Stamp(["h"], x: 1, y: 9 - p % 4)] },
            ]),

        ClawdEdition(
            id: "b5-turkey", name: "Turkey Day", collection: .holidays,
            blurb: "A full fan of autumn feathers and no idea what day it is.",
            bodyColor: 0x8B5A2B,
            parts: [
                .init(.head) { p in [Stamp([b5cyc("rogn", 6, p % 2)], x: 5, y: 0),
                                     Stamp([b5cyc("rogn", 10, p % 2 + 1)], x: 3, y: 1),
                                     Stamp([b5cyc("rogn", 12, p % 2)], x: 2, y: 2)] },
                .init(.face) { _ in [Stamp(["oo"], x: 7, y: 5), Stamp(["r"], x: 8, y: 6)] },
                .init(.back) { _ in [Stamp(["o"], x: 4, y: 10), Stamp(["o"], x: 6, y: 10),
                                     Stamp(["o"], x: 9, y: 10), Stamp(["o"], x: 11, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 0 + p % 2, y: (p * 2) % 12), Stamp(["r"], x: 15, y: (p * 2 + 5) % 12)] },
            ]),

        ClawdEdition(
            id: "b5-earth-day", name: "Earth Day", collection: .holidays,
            blurb: "Blue marble, green continents, and a brave little sprout on top.",
            bodyColor: 0x3A7BD5,
            parts: [
                .init(.head) { p in [Stamp(["ee..ee"], x: 5, y: p % 2 == 0 ? 0 : 1),
                                     Stamp([".eeee."], x: 5, y: p % 2 == 0 ? 1 : 1), Stamp(["..ee.."], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["eee", "ee."], x: 4, y: 6), Stamp([".ee", "eee"], x: 9, y: 5),
                                     Stamp(["w.w"], x: 6, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: (p * 2) % 12), Stamp(["c"], x: 14, y: (p * 2 + 5) % 12)] },
            ]),

        ClawdEdition(
            id: "b5-birthday-cake", name: "Birthday Cake", collection: .holidays,
            blurb: "Four candles, thick frosting, and a wish you are not supposed to share.",
            bodyColor: 0xE8C48C,
            parts: [
                .init(.head) { p in
                    let f = p % 2 == 0
                    return [Stamp([f ? "o" : "g"], x: 4, y: 0), Stamp([f ? "g" : "o"], x: 6, y: 0),
                            Stamp([f ? "o" : "g"], x: 9, y: 0), Stamp([f ? "g" : "o"], x: 11, y: 0),
                            Stamp(["h"], x: 4, y: 1), Stamp(["c"], x: 6, y: 1), Stamp(["g"], x: 9, y: 1), Stamp(["r"], x: 11, y: 1),
                            Stamp(["h"], x: 4, y: 2), Stamp(["c"], x: 6, y: 2), Stamp(["g"], x: 9, y: 2), Stamp(["r"], x: 11, y: 2)]
                },
                .init(.back) { _ in [Stamp(["wwwwwwww", "w.wwww.w"], x: 4, y: 3),
                                     Stamp(["r"], x: 6, y: 7), Stamp(["c"], x: 9, y: 6), Stamp(["g"], x: 5, y: 8),
                                     Stamp(["h"], x: 10, y: 8), Stamp(["e"], x: 7, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["llllllllllll"], x: 2, y: 11),
                                                         Stamp([["r", "g", "c", "h"][p % 4]], x: 1, y: 1 + p % 3),
                                                         Stamp([["c", "h", "r", "g"][p % 4]], x: 14, y: 2 + p % 4)] },
            ]),

        ClawdEdition(
            id: "b5-beach-day", name: "Beach Day", collection: .holidays,
            blurb: "Straw hat, shades, a surfboard, and a strict no-deploy policy.",
            parts: [
                .init(.head) { _ in [Stamp(["gggg", "rrrr"], x: 6, y: 0), Stamp(["gggggggggggg"], x: 2, y: 2)] },
                .init(.face) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 4)] },
                .init(.back) { _ in [Stamp([".h", "hh", "hw", "hh", "hw", "hh", "hh", ".h"], x: 0, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "gg" : "g.", "gg"], x: 14, y: 0),
                                                         Stamp([b5cyc("cc.c", 16, p)], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b5-hot-cocoa", name: "Cozy Cocoa", collection: .holidays,
            blurb: "Knit beanie, wool scarf, and a mug with marshmallows on top.",
            parts: [
                .init(.head) { _ in [Stamp(["ww"], x: 7, y: 0), Stamp(["xcxcxc"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["ogogogog"], x: 4, y: 8), Stamp(["o", "g"], x: 12, y: 8),
                                     Stamp(["wnw", "xxx", "xxx", "xx."], x: 13, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 14, y: 6 - p % 3), Stamp(["l"], x: 15, y: 5 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b5-spring-crown", name: "Spring Bloom", collection: .holidays,
            blurb: "A flower crown, a passing butterfly, and grass that finally turned green.",
            parts: [
                .init(.head) { p in [Stamp(["h.g.w.p."], x: 4, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "g" : "h"], x: 7, y: 1)] },
                .init(.back) { _ in [Stamp(["e"], x: 2, y: 8), Stamp(["e"], x: 13, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(p % 2 == 0 ? ["h.p"] : [".h."], x: 12, y: 0 + p % 3),
                                                         Stamp(["e.e.eh.e.e.e.eg"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b5-rainy-day", name: "Rainy Day", collection: .holidays,
            blurb: "Yellow raincoat, red umbrella, and a deep respect for puddles.",
            bodyColor: 0xF2C230,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrr"], x: 5, y: 0), Stamp(["rrrrrrrrrr"], x: 3, y: 1),
                                     Stamp(["r.rr.rr.r."], x: 3, y: 2).self, Stamp(["d"], x: 7, y: 2)] },
                .init(.back) { _ in [Stamp(["n", "n"], x: 7, y: 7),
                                     Stamp(["e"], x: 4, y: 10), Stamp(["e"], x: 6, y: 10),
                                     Stamp(["e"], x: 9, y: 10), Stamp(["e"], x: 11, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 0, y: (p * 2) % 12), Stamp(["c"], x: 1, y: (p * 2 + 7) % 12),
                                                         Stamp(["c"], x: 14, y: (p * 2 + 3) % 12), Stamp(["c"], x: 15, y: (p * 2 + 9) % 12),
                                                         Stamp([p % 2 == 0 ? "cccc" : ".cc."], x: 6, y: 11)] },
            ]),

        ClawdEdition(
            id: "b5-fireworks", name: "Fireworks Night", collection: .holidays,
            blurb: "Midnight sky, a sparkler in hand, and the whole town going boom.",
            bodyColor: 0x2B3A6B,
            parts: [
                .init(.face) { _ in [Stamp(["w"], x: 5, y: 4), Stamp(["w"], x: 10, y: 4)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "w" : "g"], x: 4, y: 7), Stamp([p % 2 == 0 ? "g" : "w"], x: 8, y: 6),
                                     Stamp([p % 3 == 0 ? "w" : "."], x: 10, y: 8), Stamp(["g"], x: 6, y: 8)] },
                .init(.hand) { p in [Stamp(["y", "y", "y"], x: 14, y: 6),
                                     Stamp([p % 2 == 0 ? "w.g" : "g.w"], x: 13, y: 5), Stamp([p % 3 == 0 ? "g" : "o"], x: 14, y: 4)] },
                .init(.aura, followsBody: false) { p in
                    let a = b5burst(p, cx: 2, cy: 2, c: ["r", "o"])
                    let b = b5burst(p + 2, cx: 13, cy: 2, c: ["c", "h"])
                    return a + b
                },
            ]),
    ]
}

/// Repeats a pattern to a fixed length, starting `off` characters in.
private func b5cyc(_ pattern: String, _ n: Int, _ off: Int) -> String {
    let chars = Array(pattern)
    return String((0..<n).map { chars[($0 + off) % chars.count] })
}

/// One firework burst, 4 animation steps: spark, cross, ring, falling embers.
private func b5burst(_ phase: Int, cx: Int, cy: Int, c: [String]) -> [Stamp] {
    switch phase % 4 {
    case 0: return [Stamp([c[0]], x: cx, y: cy)]
    case 1: return [Stamp([c[0]], x: cx, y: cy - 1), Stamp([c[0]], x: cx - 1, y: cy), Stamp([c[1]], x: cx, y: cy),
                    Stamp([c[0]], x: cx + 1, y: cy), Stamp([c[0]], x: cx, y: cy + 1)]
    case 2: return [Stamp([c[1]], x: cx, y: cy - 2), Stamp([c[1]], x: cx - 2, y: cy), Stamp([c[1]], x: cx + 2, y: cy),
                    Stamp([c[0]], x: cx - 1, y: cy - 1), Stamp([c[0]], x: cx + 1, y: cy - 1),
                    Stamp([c[0]], x: cx - 1, y: cy + 1), Stamp([c[0]], x: cx + 1, y: cy + 1), Stamp(["w"], x: cx, y: cy)]
    default: return [Stamp([c[1]], x: cx - 2, y: cy + 1), Stamp([c[0]], x: cx + 2, y: cy + 1), Stamp([c[1]], x: cx, y: cy + 2)]
    }
}
