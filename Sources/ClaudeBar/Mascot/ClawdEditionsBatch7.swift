import Foundation

extension ClawdEditions {
    /// Batch 7: Dev Life and Jobs & Hobbies. See ClawdEditionsCore.swift for the format.
    static let batch7: [ClawdEdition] = [
        // MARK: Dev Life

        ClawdEdition(
            id: "b7-night-owl", name: "Night Owl", collection: .devLife,
            blurb: "Round glasses, a crescent moon, and a commit pushed at 3 a.m.",
            bodyColor: 0x9C7A55,
            parts: [
                .init(.head) { _ in [Stamp(["B", "B"], x: 4, y: 1), Stamp(["B", "B"], x: 11, y: 1)] },
                .init(.face) { _ in [Stamp(["ggg", "g.g", "ggg"], x: 4, y: 3), Stamp(["ggg", "g.g", "ggg"], x: 9, y: 3),
                                     Stamp(["gg"], x: 7, y: 4), Stamp(["oo"], x: 7, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gg", "g.", "gg"], x: 1, y: 0),
                                                         Stamp([p % 2 == 0 ? "w" : "l"], x: 14, y: 1),
                                                         Stamp([p % 3 == 0 ? "w" : "l"], x: 15, y: 4),
                                                         Stamp([p % 2 == 0 ? "l" : "w"], x: 4, y: 0)] },
            ]),

        ClawdEdition(
            id: "b7-deadline-panic", name: "Deadline Panic", collection: .devLife,
            blurb: "Hair on end, clock ringing, and the demo is in ten minutes.",
            parts: [
                .init(.head) { p in [Stamp(["B", "B"], x: 5, y: 1), Stamp(["B", "B"], x: 7 + p % 2, y: 1),
                                     Stamp(["B", "B"], x: 10, y: 1),
                                     Stamp(["c"], x: 3, y: 2 + p % 2), Stamp(["c"], x: 2, y: 4 + (p + 1) % 2)] },
                .init(.face) { _ in [Stamp(["kk", "kk"], x: 7, y: 6)] },
                .init(.aura, followsBody: false) { p in
                    let hand: Stamp = p % 2 == 0 ? Stamp(["w"], x: 14 + p % 2, y: 1) : Stamp(["w"], x: 14, y: 2)
                    return [Stamp(["rrrr", "rwwr", "rwwr", "rrrr"], x: 12 + p % 2, y: 0), hand,
                            Stamp(["k"], x: 13 + p % 2, y: 1)]
                },
            ]),

        ClawdEdition(
            id: "b7-ship-it", name: "Ship It", collection: .devLife,
            blurb: "Nose cone on, fins out, flame lit. Merging straight to main.",
            parts: [
                .init(.head) { _ in [Stamp(["rr"], x: 7, y: 0), Stamp(["rwwr"], x: 6, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp([".r", ".r", "rr"], x: 2, y: 8), Stamp(["r.", "r.", "rr"], x: 12, y: 8),
                                     Stamp(["yyyy", "yccy", "yccy", "yyyy"], x: 6, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "orrrro" : "goooog"], x: 5, y: 11),
                                                         Stamp(["l"], x: 1, y: 10 - p % 2), Stamp(["l"], x: 14, y: 9 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b7-prompt", name: "Prompt Cursor", collection: .devLife,
            blurb: "Slate body, a blinking underscore, and a window ready for any command.",
            bodyColor: 0x5B6074,
            parts: [
                .init(.head) { _ in [Stamp(["uuu"], x: 4, y: 1), Stamp(["uuuuuuuu"], x: 4, y: 2),
                                     Stamp(["r"], x: 5, y: 2), Stamp(["g"], x: 6, y: 2), Stamp(["e"], x: 7, y: 2)] },
                .init(.back) { p in
                    var s = [Stamp(["w.", ".w", "w."], x: 5, y: 6)]
                    if p % 2 == 0 { s.append(Stamp(["ww"], x: 8, y: 8)) }
                    return s
                },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "cc" : ".."], x: 13, y: 1),
                                                         Stamp([p % 2 == 0 ? "cc" : ".."], x: 13, y: 2)] },
            ]),

        ClawdEdition(
            id: "b7-merge-conflict", name: "Merge Conflict", collection: .devLife,
            blurb: "Two branches, one line, zero chance of a clean rebase.",
            parts: [
                .init(.head) { p in [Stamp(["...e", "eeee", "...e"], x: 2 + p % 2, y: 0),
                                     Stamp(["r...", "rrrr", "r..."], x: 10 - p % 2, y: 0),
                                     Stamp([p % 2 == 0 ? "gg" : "oo"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["wkwk", "wkwk"], x: 6, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 7 + p % 2, y: 0), Stamp(["o"], x: 6 + (p % 2) * 3, y: 2)] },
            ]),

        ClawdEdition(
            id: "b7-coffee-overdose", name: "Coffee Overdose", collection: .devLife,
            blurb: "Fourth cup, wide eyes, and the code is somehow getting faster.",
            parts: [
                .init(.head) { p in [Stamp(["nnnn", "wwww"], x: 6, y: 1 + p % 2), Stamp(["w"], x: 10, y: 2 + p % 2),
                                     Stamp([p % 2 == 0 ? "l" : "."], x: 7, y: 0)] },
                .init(.face) { _ in [Stamp(["hhh", "h.h", "hhh"], x: 4, y: 3), Stamp(["hhh", "h.h", "hhh"], x: 9, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp([".l.", "lnl", "lll"], x: 0, y: 9),
                                                         Stamp([".l", "ll"], x: 14, y: 10),
                                                         Stamp(["g"], x: 1 - p % 2, y: 4), Stamp(["g"], x: 14 + p % 2, y: 6),
                                                         Stamp(["y"], x: 0 + p % 2, y: 7)] },
            ]),

        ClawdEdition(
            id: "b7-pair-programmer", name: "Pair Programmer", collection: .devLife,
            blurb: "A tiny second Clawd peeking in with a very good idea.",
            parts: [
                .init(.head) { p in [Stamp(["gg", "gg"], x: 7, y: 0), Stamp(["yy"], x: 7, y: 2),
                                     Stamp([p % 2 == 0 ? "g" : "."], x: 5, y: 0), Stamp([p % 2 == 0 ? "g" : "."], x: 10, y: 0)] },
                .init(.aura, followsBody: false) { p in [Stamp(["BBB", "kBk", "BBB", "B.B"], x: 13, y: 7 + p % 2),
                                                         Stamp(["ww", "ww"], x: 14, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["lylylylyly"], x: 3, y: 11),
                                                         Stamp([p % 2 == 0 ? "c" : "w"], x: 7, y: 11)] },
            ]),

        ClawdEdition(
            id: "b7-cloud", name: "Cloud", collection: .devLife,
            blurb: "Fluffy, scalable, and somehow always someone else's computer.",
            bodyColor: 0xDADCE0,
            parts: [
                .init(.head) { _ in [Stamp(["BB"], x: 7, y: 0), Stamp(["BBBBBB"], x: 5, y: 1), Stamp(["BBBBBBBB"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["BBBBBBBBBB", "BBBBBBBBBB"], x: 3, y: 9)] },
                .init(.face) { _ in [Stamp(["h"], x: 4, y: 6), Stamp(["h"], x: 11, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: 9 - (p % 4) * 2),
                                                         Stamp(["x"], x: 14, y: 2 + (p % 4) * 2)] },
            ]),

        ClawdEdition(
            id: "b7-friendly-bug", name: "Friendly Bug", collection: .devLife,
            blurb: "It is not a bug, it is a feature. This one even says hello.",
            bodyColor: 0xE0402F,
            parts: [
                .init(.head) { p in [Stamp(["d"], x: 4, y: 2), Stamp(["d"], x: 3 + p % 2, y: 1),
                                     Stamp(["d"], x: 11, y: 2), Stamp(["d"], x: 12 - p % 2, y: 1)] },
                .init(.back) { p in [Stamp(["dd", "dd", "dd"], x: 7, y: 6),
                                     Stamp(["d"], x: 5, y: 7), Stamp(["d"], x: 10, y: 7), Stamp(["d"], x: 5, y: 5), Stamp(["d"], x: 10, y: 5),
                                     Stamp(["d"], x: 1 - p % 2, y: 4), Stamp(["d"], x: 1 - (p + 1) % 2, y: 8),
                                     Stamp(["d"], x: 14 + p % 2, y: 4), Stamp(["d"], x: 14 + (p + 1) % 2, y: 8)] },
            ]),

        ClawdEdition(
            id: "b7-zero-day", name: "Zero Day Hero", collection: .devLife,
            blurb: "A cape, a mask, and a patch shipped before anyone read the advisory.",
            parts: [
                .init(.face) { _ in [Stamp(["p.pppp.p"], x: 4, y: 4)] },
                .init(.back) { p in [Stamp([".r", "rr", "rr"], x: 1, y: 4), Stamp(["rr"], x: p % 2 == 0 ? 0 : 1, y: 7),
                                     Stamp(["r.", "rr", "rr"], x: 13, y: 4), Stamp(["rr"], x: p % 2 == 0 ? 13 : 14, y: 7),
                                     Stamp(["gggg", "g..g", "gggg"], x: 6, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 1 + p % 2), Stamp(["w"], x: 14, y: 1 + (p + 1) % 2)] },
            ]),

        // MARK: Jobs & Hobbies

        ClawdEdition(
            id: "b7-doctor", name: "Doctor", collection: .jobs,
            blurb: "Head mirror, stethoscope, and a calm voice for any stack trace.",
            parts: [
                .init(.head) { p in [Stamp(["yyyyyyyy"], x: 4, y: 2),
                                     p % 2 == 0 ? Stamp(["ww", "wl"], x: 7, y: 0) : Stamp(["wl", "ll"], x: 7, y: 0)] },
                .init(.back) { _ in [Stamp(["y......y", "y......y", ".y....y.", "..yrry.."], x: 4, y: 5)] },
                .init(.aura, followsBody: false) { p in [p % 2 == 0 ? Stamp(["r.r", "rrr", ".r."], x: 13, y: 0)
                                                                     : Stamp([".r.", "rrr", ".r."], x: 13, y: 0)] },
            ]),

        ClawdEdition(
            id: "b7-firefighter", name: "Firefighter", collection: .jobs,
            blurb: "Red helmet, reflective stripe, and a hose aimed at tiny fires.",
            parts: [
                .init(.head) { _ in [Stamp(["r"], x: 7, y: 0), Stamp(["rrrr"], x: 6, y: 1), Stamp(["gg"], x: 7, y: 1),
                                     Stamp(["rrrrrrrrrr"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu", "gggggggg"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["yy"], x: 0, y: 4), Stamp(["c"], x: 0, y: 6 + p % 2),
                                                         Stamp([p % 2 == 0 ? "o" : "g"], x: 0, y: 8), Stamp(["rr"], x: 0, y: 9),
                                                         Stamp([p % 2 == 0 ? "o" : "r"], x: 1, y: 10), Stamp(["r"], x: 0, y: 10)] },
            ]),

        ClawdEdition(
            id: "b7-pilot", name: "Pilot", collection: .jobs,
            blurb: "Captain's cap, wing pin, and a smooth ride at cruising altitude.",
            parts: [
                .init(.head) { _ in [Stamp(["uuuuuu"], x: 5, y: 1), Stamp(["uuuuuuuu"], x: 4, y: 2), Stamp(["gg"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["xxx"], x: 4, y: 4), Stamp(["xxx"], x: 9, y: 4), Stamp(["yy"], x: 7, y: 4)] },
                .init(.back) { _ in [Stamp(["gg.rr.gg", ".gg..gg."], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l", "l"], x: (p * 2) % 16, y: 0), Stamp(["ww"], x: (p * 2 + 1) % 16, y: 0)] },
            ]),

        ClawdEdition(
            id: "b7-scientist", name: "Scientist", collection: .jobs,
            blurb: "Lab coat, goggles, and a beaker that is probably fine.",
            parts: [
                .init(.head) { _ in [Stamp(["yyy.yyy", "ycy.ycy", "yyy.yyy"], x: 4, y: 0)] },
                .init(.back) { _ in [Stamp(["ww", "ww", "ww"], x: 4, y: 6), Stamp(["ww", "ww", "ww"], x: 10, y: 6),
                                     Stamp(["l.l", "l.l", "lel", "eee"], x: 13, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e"], x: 14, y: 6 - p % 3), Stamp(["e"], x: 15, y: 5 - (p + 1) % 2)] },
            ]),

        ClawdEdition(
            id: "b7-gardener", name: "Gardener", collection: .jobs,
            blurb: "Straw hat, watering can, and a sprout that is clearly on schedule.",
            parts: [
                .init(.head) { _ in [Stamp(["gggg"], x: 6, y: 1), Stamp(["gggggggggggg"], x: 2, y: 2), Stamp(["nnnn"], x: 6, y: 2)] },
                .init(.back) { _ in [Stamp(["yyy", "yyy"], x: 13, y: 7), Stamp(["y"], x: 12, y: 8), Stamp(["y"], x: 14, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 12, y: 9 + p % 2), Stamp(["ehe"], x: 11, y: 11)] },
            ]),

        ClawdEdition(
            id: "b7-dj", name: "DJ", collection: .jobs,
            blurb: "Big headphones, spinning vinyl, and a beat dropped right on the deploy.",
            parts: [
                .init(.head) { p in [Stamp(["dddddddddd"], x: 3, y: 2), Stamp(["pp", "pp"], x: 2, y: 3), Stamp(["pp", "pp"], x: 12, y: 3),
                                     Stamp([p % 2 == 0 ? "h" : "p"], x: 2, y: 3)] },
                .init(.back) { p in [Stamp([".dd.", "drrd", "drrd", ".dd."], x: 12, y: 7),
                                     Stamp(["w"], x: p % 2 == 0 ? 13 : 14, y: p % 2 == 0 ? 7 : 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: 4 - p % 3), Stamp(["c"], x: 14, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b7-guitarist", name: "Guitarist", collection: .jobs,
            blurb: "A red bandana, a loud riff, and an encore that is not scheduled.",
            parts: [
                .init(.head) { p in [Stamp(["rrrrrrrr"], x: 4, y: 3), Stamp(["rr"], x: 12, y: 3), Stamp(["r"], x: 13, y: 4 + p % 2)] },
                .init(.back) { _ in [Stamp(["dd"], x: 14, y: 1), Stamp(["n", "n", "n", "n", "n"], x: 14, y: 2),
                                     Stamp([".oo.", "oooo", "oddo", ".oo."], x: 12, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: 4 - p % 3), Stamp(["c"], x: 0, y: 7 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b7-painter", name: "Painter", collection: .jobs,
            blurb: "A beret, a wet brush, and splashes that are definitely intentional.",
            parts: [
                .init(.head) { _ in [Stamp(["r"], x: 7, y: 0), Stamp(["rrrr"], x: 6, y: 1), Stamp(["rrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["h"], x: 5, y: 7), Stamp(["c"], x: 10, y: 6), Stamp(["g"], x: 6, y: 8),
                                     Stamp(["x"], x: 9, y: 8), Stamp(["e"], x: 11, y: 5)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "r" : "x"], x: 14, y: 1), Stamp(["y"], x: 14, y: 2),
                                     Stamp(["n", "n", "n", "n"], x: 14, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "r" : "x"], x: 14, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b7-gamer", name: "Gamer", collection: .jobs,
            blurb: "Headset on, controller out, and exactly one life left.",
            parts: [
                .init(.head) { p in [Stamp(["dddddddd"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "c" : "x", p % 2 == 0 ? "c" : "x"], x: 3, y: 3),
                                     Stamp([p % 2 == 0 ? "c" : "x", p % 2 == 0 ? "c" : "x"], x: 12, y: 3)] },
                .init(.back) { _ in [Stamp(["ykyyyygy", "kkkyyxre"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in
                    var s = [Stamp(["r"], x: 1, y: 1), Stamp(["r"], x: 3, y: 1)]
                    if p % 2 == 0 { s.append(Stamp(["r"], x: 5, y: 1)) }
                    return s
                },
            ]),

        ClawdEdition(
            id: "b7-runner", name: "Runner", collection: .jobs,
            blurb: "Sweatband, fresh sneakers, and a personal best every Tuesday.",
            parts: [
                .init(.head) { p in [Stamp(["rrrrrrrr"], x: 4, y: 3), Stamp(["rr"], x: 12, y: 3), Stamp(["r"], x: 13, y: 4 + p % 2),
                                     Stamp(["c"], x: 3, y: 1 + p % 3)] },
                .init(.back) { _ in [Stamp(["ww"], x: 3, y: 10), Stamp(["rr"], x: 3, y: 11), Stamp(["ww"], x: 6, y: 10),
                                     Stamp(["rr"], x: 6, y: 11), Stamp(["ww"], x: 9, y: 10), Stamp(["rr"], x: 9, y: 11),
                                     Stamp(["ww"], x: 11, y: 10), Stamp(["rr"], x: 11, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ll"], x: p % 2, y: 4), Stamp(["ll"], x: (p + 1) % 2, y: 7),
                                                         Stamp(["l"], x: p % 2, y: 9)] },
            ]),
    ]
}
