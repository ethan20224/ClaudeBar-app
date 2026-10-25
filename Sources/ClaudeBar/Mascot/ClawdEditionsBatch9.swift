import Foundation

extension ClawdEditions {
    /// Batch 9: Claude Life and Cozy. See ClawdEditionsCore.swift for the format.
    static let batch9: [ClawdEdition] = [

        // MARK: Claude Life

        ClawdEdition(
            id: "b9-thinking-cloud", name: "Thinking Cloud", collection: .claudeLife,
            blurb: "A little cloud of maybes floats up while the answer takes shape.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp([".www.", "wwwww", ".www."], x: 10, y: 0 + p % 2),
                    Stamp(["l"], x: 9, y: 3 - p % 2), Stamp(["w"], x: 12, y: 3),
                ] },
                .init(.head) { p in [Stamp([p % 2 == 0 ? "c" : "l"], x: 12, y: 1 + p % 2)] },
                .init(.face) { _ in [Stamp(["ww"], x: 4, y: 3), Stamp(["ww"], x: 10, y: 3)] },
            ]),

        ClawdEdition(
            id: "b9-token-muncher", name: "Token Muncher", collection: .claudeLife,
            blurb: "Nom nom nom. Every little token is delicious and none go to waste.",
            parts: [
                .init(.face) { p in [Stamp(p % 2 == 0 ? ["kkkk", "kkkk"] : ["kkkk"], x: 6, y: 6),
                                     Stamp([p % 2 == 0 ? "rr" : "ww"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["yy", "yy"], x: 14 - p % 4 * 2 + (p % 4 == 3 ? 1 : 0), y: 5),
                    Stamp(["y"], x: 0 + p % 3, y: 11),
                    Stamp(["g"], x: 14, y: 9), Stamp(["g"], x: 1, y: 8 + p % 2),
                ] },
                .init(.hand) { p in [Stamp(["g"], x: 13 - p % 2, y: 7)] },
            ]),

        ClawdEdition(
            id: "b9-context-squish", name: "Context Squish", collection: .claudeLife,
            blurb: "The window is getting tight. Squeeze in one more file, just one.",
            parts: [
                .init(.back) { p in [
                    Stamp(["x", "x", "x", "x", "x", "x", "x", "x", "x", "x"], x: 0 + p % 2, y: 1),
                    Stamp(["x", "x", "x", "x", "x", "x", "x", "x", "x", "x"], x: 15 - p % 2, y: 1),
                ] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["y", "y"], x: 2 + p % 3, y: 5), Stamp(["y", "y"], x: 13 - p % 3, y: 5),
                    Stamp(["w"], x: 7, y: 0 + p % 2), Stamp(["w"], x: 8, y: 11 - p % 2),
                ] },
                .init(.face) { p in [Stamp(["kk"], x: 5, y: 4 - p % 2 * 0), Stamp(["kk"], x: 9, y: 4)] },
            ]),

        ClawdEdition(
            id: "b9-sub-agents", name: "Sub-agents", collection: .claudeLife,
            blurb: "Clawd delegates. Three tiny Clawds trot behind, each on an important errand.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp(["BB", "kB"], x: 0, y: 9 + p % 2),
                    Stamp(["BB"], x: 2, y: 10 - p % 2),
                    Stamp(["BB", "Bk"], x: 14, y: 9 + (p + 1) % 2),
                ] },
                .init(.head) { _ in [Stamp(["gg"], x: 7, y: 2)] },
                .init(.hand) { p in [Stamp(["g"], x: 13, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b9-hallucination", name: "Hallucination", collection: .claudeLife,
            blurb: "Confident, swirly, and absolutely sure that function exists.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp([p % 2 == 0 ? "p" : "c"], x: 2 + p % 4, y: 1), Stamp([p % 2 == 0 ? "c" : "p"], x: 12 - p % 4, y: 1),
                    Stamp([p % 2 == 0 ? "h" : "p"], x: 1, y: 4 + p % 3), Stamp([p % 2 == 0 ? "p" : "h"], x: 14, y: 4 + (p + 1) % 3),
                    Stamp(["c"], x: 3 + (p + 2) % 4, y: 10), Stamp(["p"], x: 11 - p % 4, y: 10),
                ] },
                .init(.face) { p in [Stamp([p % 2 == 0 ? "p" : "h"], x: 5, y: 4), Stamp([p % 2 == 0 ? "h" : "p"], x: 10, y: 4)] },
            ]),

        ClawdEdition(
            id: "b9-prompt-engineer", name: "Prompt Engineer", collection: .claudeLife,
            blurb: "Hard hat on, cursor blinking. Measure twice, prompt once.",
            parts: [
                .init(.head) { _ in [Stamp(["yyyy"], x: 6, y: 1), Stamp(["yyyyyyyy"], x: 4, y: 2)] },
                .init(.back) { p in [Stamp(["w.", ".w", "w."], x: 6, y: 7), Stamp([p % 2 == 0 ? "ww" : ".."], x: 9, y: 9)] },
                .init(.hand) { _ in [Stamp(["g", "g"], x: 14, y: 4), Stamp(["g"], x: 15, y: 3)] },
            ]),

        ClawdEdition(
            id: "b9-rate-limited", name: "Rate Limited", collection: .claudeLife,
            blurb: "A big red stop sign and a deep breath. Back in a moment, promise.",
            parts: [
                .init(.hand) { p in [
                    Stamp([".rrrr.", "rwwwwr", "rwrrwr", "rwwwwr", ".rrrr."], x: 0, y: 0 + p % 2),
                    Stamp(["n", "n", "n", "n"], x: 2, y: 5),
                ] },
                .init(.face) { p in [Stamp(["h"], x: 5, y: 4), Stamp(["h"], x: 10, y: 4),
                                     Stamp([p % 2 == 0 ? "kk" : "k."], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 13 + p % 2, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b9-hourglass", name: "Hourglass", collection: .claudeLife,
            blurb: "Golden sand trickling down until the five-hour window resets.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.hand) { p in [
                    Stamp(["nnn", "cgc", ".g.", "cgc", "nnn"], x: 13, y: 4),
                    Stamp([p % 2 == 0 ? "g" : "y"], x: 14, y: 6 + p % 2),
                ] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 2 + p % 4)] },
            ]),

        ClawdEdition(
            id: "b9-battery", name: "Battery Pack", collection: .claudeLife,
            blurb: "Four glowing bars on the chest and a terminal cap on top.",
            parts: [
                .init(.head) { _ in [Stamp(["llll"], x: 6, y: 1), Stamp(["dddddddd"], x: 4, y: 2)] },
                .init(.back) { p in [
                    Stamp(["eeeeeeee"], x: 4, y: 6),
                    Stamp([p % 3 == 0 ? "gggggggg" : "eeeeeeee"], x: 4, y: 7),
                    Stamp(["eeeeeeee"], x: 4, y: 8),
                ] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "g" : "e"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b9-thermometer", name: "Thermometer", collection: .claudeLife,
            blurb: "Cool cyan in the morning, warm red by the end of a long sprint.",
            parts: [
                .init(.hand) { p in [
                    Stamp(["w", "w", p % 2 == 0 ? "o" : "r", "r", "r"], x: 14, y: 3),
                    Stamp(["rr", "rr"], x: 13, y: 8),
                ] },
                .init(.head) { p in [Stamp([p % 2 == 0 ? "cccc" : "oooo"], x: 6, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: 2 + p % 2), Stamp(["r"], x: 15, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b9-moon-phase", name: "Moon Phase", collection: .claudeLife,
            blurb: "Waxing, waning, and keeping watch over every late-night session.",
            bodyColor: 0x3D4663,
            parts: [
                .init(.head) { _ in [Stamp([".gg.", "gg..", "gg..", ".gg."], x: 6, y: 0)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["w"], x: 1, y: 1 + p % 2), Stamp(["g"], x: 14, y: 2 - p % 2),
                    Stamp(["w"], x: 2 + p % 3, y: 10),
                ] },
            ]),

        ClawdEdition(
            id: "b9-night-shift", name: "Night Shift", collection: .claudeLife,
            blurb: "Striped pajamas and a sleepy cap on one side, business tie on the other.",
            parts: [
                .init(.head) { p in [Stamp(["uuuuuu", "cccccc"], x: 5, y: 1), Stamp(["w"], x: 11, y: 2 + p % 2)] },
                .init(.back) { _ in [Stamp(["cucucucu"], x: 4, y: 7), Stamp(["r", "r"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 14, y: 1 + p % 2), Stamp(["c"], x: 1, y: 3 - p % 2)] },
            ]),

        // MARK: Cozy

        ClawdEdition(
            id: "b9-reading-nook", name: "Reading Nook", collection: .cozy,
            blurb: "Glasses on, a book open, and one more chapter before bed.",
            parts: [
                .init(.face) { _ in [Stamp(["yyy", "y.y"], x: 4, y: 4), Stamp(["yyy", "y.y"], x: 9, y: 4), Stamp(["y"], x: 7, y: 4)] },
                .init(.back) { p in [Stamp(["rrwwrr"], x: 5, y: 8), Stamp(["rwwwwr"], x: 5, y: 9 - p % 2 * 0)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["n", "n", "n", "g"], x: 14, y: 6), Stamp(["n"], x: 13, y: 6),
                    Stamp([p % 2 == 0 ? "y" : "o"], x: 14, y: 5),
                ] },
            ]),

        ClawdEdition(
            id: "b9-knitting", name: "Knitting", collection: .cozy,
            blurb: "Click, click, click. A scarf grows slowly and so does the calm.",
            parts: [
                .init(.hand) { p in [Stamp(["w", "w"], x: 14 - p % 2, y: 6), Stamp(["w", "w"], x: 13 + p % 2, y: 6)] },
                .init(.back) { p in [Stamp(["rrrrrrrr", p % 2 == 0 ? "r.r.r.r." : ".r.r.r.r"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["rr", "rr"], x: 0, y: 10), Stamp(["r"], x: 2 + p % 2, y: 11),
                    Stamp(["r"], x: 3, y: 10 + p % 2 * 0),
                ] },
            ]),

        ClawdEdition(
            id: "b9-camping", name: "Camping", collection: .cozy,
            blurb: "A tent, a crackling fire, and sparks drifting up into the stars.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp([".gg.", "gggg"], x: 0, y: 9),
                    Stamp(["w"], x: 1, y: 8),
                    Stamp([p % 2 == 0 ? "r" : "o", "nn"], x: 13, y: 9 + p % 2 * 0),
                    Stamp([p % 2 == 0 ? "o" : "y"], x: 14, y: 8), Stamp(["y"], x: 13 + p % 3, y: 6 - p % 2),
                    Stamp(["w"], x: 2, y: 0), Stamp([p % 2 == 0 ? "w" : "l"], x: 14, y: 1),
                ] },
                .init(.head) { _ in [Stamp(["rrrr"], x: 6, y: 2)] },
            ]),

        ClawdEdition(
            id: "b9-picnic", name: "Picnic", collection: .cozy,
            blurb: "A checkered blanket, a basket, and the sun doing its very best.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp(["rwrwrwrwrwrwrwrw"], x: 0, y: 11),
                    Stamp(["nnn", "n.n"], x: 0, y: 8), Stamp(["rr"], x: 1, y: 7),
                    Stamp([p % 2 == 0 ? "y" : "o"], x: 14, y: 0), Stamp(["y"], x: 13 + p % 2 * 2, y: 1),
                    Stamp(["r"], x: 14, y: 10),
                ] },
                .init(.head) { _ in [Stamp(["nnnnnn"], x: 5, y: 2)] },
            ]),

        ClawdEdition(
            id: "b9-blanket-burrito", name: "Blanket Burrito", collection: .cozy,
            blurb: "Wrapped to the chin, perfectly warm, and not getting up today.",
            parts: [
                .init(.back) { p in [
                    Stamp(["pppppppppppp", "phpphpphpphp"], x: 2, y: 8),
                    Stamp(["pppppppp"], x: 4, y: 7), Stamp(["pp", "pp"], x: 2, y: 5), Stamp(["pp", "pp"], x: 12, y: 5),
                ] },
                .init(.face) { p in [Stamp([p % 4 == 3 ? "kk" : "ww"], x: 5, y: 4), Stamp([p % 4 == 3 ? "kk" : "ww"], x: 9, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 12 + p % 3, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b9-plant-parent", name: "Plant Parent", collection: .cozy,
            blurb: "A leafy sprout on the head and a watering can for everyone else.",
            parts: [
                .init(.head) { p in [Stamp(["e", "e"], x: 7, y: 1), Stamp(p % 2 == 0 ? ["ee", "e."] : ["ee", ".e"], x: 8, y: 0), Stamp(["e"], x: 6, y: 1)] },
                .init(.hand) { p in [Stamp(["ccc", "cc"], x: 13, y: 8 + p % 2 * 0), Stamp(["c"], x: 14, y: 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["e", "e"], x: 1, y: 8), Stamp(["ee"], x: 0, y: 9), Stamp(["nn"], x: 0, y: 11),
                    Stamp(["c"], x: 15, y: 9 + p % 3),
                ] },
            ]),

        ClawdEdition(
            id: "b9-candle-night", name: "Candle Night", collection: .cozy,
            blurb: "One small flame, long shadows, and a very quiet evening.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp([p % 2 == 0 ? "y" : "o", "r"].filter { _ in true }, x: 14, y: 3 - 0),
                    Stamp(["w", "w", "w", "w"], x: 14, y: 5), Stamp(["nn"], x: 13, y: 9),
                    Stamp(["y"], x: 13 - p % 2 * 0, y: 2 + p % 2), Stamp(["h"], x: 1, y: 1 + p % 3),
                ] },
                .init(.face) { _ in [Stamp(["h"], x: 5, y: 4), Stamp(["h"], x: 10, y: 4)] },
            ]),
    ]
}
