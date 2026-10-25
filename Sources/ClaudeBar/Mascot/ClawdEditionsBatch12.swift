import Foundation

extension ClawdEditions {
    /// Batch 12: Retro Tech, Through the Decades, Nature & Weather. See ClawdEditionsCore.swift for the format.
    static let batch12: [ClawdEdition] = [

        // MARK: Retro Tech

        ClawdEdition(
            id: "b12-8bit-arcade", name: "8-bit Arcade", collection: .retro,
            blurb: "Blocky, bright, and one quarter away from the high score.",
            parts: [
                .init(.head) { p in [Stamp(["rr.rr"], x: 5, y: 2), Stamp([p % 2 == 0 ? "y" : "g"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["kk"], x: 4, y: 3), Stamp(["kk"], x: 10, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 1 + p % 3), Stamp(["c"], x: 14, y: 2 + (p + 1) % 3),
                                                         Stamp(["p.p", ".p."], x: 0, y: 9 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b12-crt-monitor", name: "CRT Monitor", collection: .retro,
            blurb: "Phosphor glow, a little static, and a chunky beige frame.",
            parts: [
                .init(.head) { _ in [Stamp(["llllllllllll"], x: 2, y: 2), Stamp(["l", "l", "l", "l"], x: 2, y: 3), Stamp(["l", "l", "l", "l"], x: 13, y: 3)] },
                .init(.back) { _ in [Stamp(["llllllll"], x: 4, y: 8), Stamp(["dd"], x: 7, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gggggggggg"], x: 3, y: p % 6 + 2), Stamp(["g"], x: 14, y: 9), Stamp([p % 2 == 0 ? "g" : "."], x: 1, y: 9)] },
            ]),

        ClawdEdition(
            id: "b12-floppy-disk", name: "Floppy Disk", collection: .retro,
            blurb: "1.44 megabytes of pure nostalgia. Please do not bend.",
            bodyColor: 0x3B5BA5,
            parts: [
                .init(.head) { _ in [Stamp(["llllll"], x: 5, y: 2), Stamp(["kk"], x: 9, y: 2), Stamp(["l"], x: 11, y: 3)] },
                .init(.face) { _ in [Stamp(["wwwwww"], x: 5, y: 6), Stamp(["wwwwww"], x: 5, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 14, y: 10 - p % 2), Stamp(["c"], x: 1, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b12-cassette", name: "Cassette", collection: .retro,
            blurb: "Press play, and flip it over when the song ends.",
            parts: [
                .init(.back) { p in [Stamp(["wwww", "wkwk"], x: 6, y: 7), Stamp([p % 2 == 0 ? "k.k" : ".k."], x: 7, y: 8)] },
                .init(.head) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["n", "n"], x: 14, y: 9 - p % 3), Stamp(["n"], x: 1 + p % 2, y: 10)] },
            ]),

        ClawdEdition(
            id: "b12-pager", name: "Pager", collection: .retro,
            blurb: "Beep beep. Somebody needs you right now, call them back.",
            bodyColor: 0x2C2F3A,
            parts: [
                .init(.face) { p in [Stamp(["gggg"], x: 6, y: 6), Stamp([p % 2 == 0 ? "gg" : "g."], x: 6, y: 7)] },
                .init(.head) { _ in [Stamp(["l"], x: 12, y: 2), Stamp(["ll"], x: 11, y: 1)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "r" : "."], x: 1, y: 3), Stamp([p % 2 == 0 ? "r" : "."], x: 14, y: 3),
                                                         Stamp([".r", "r."], x: 0, y: 5)] },
            ]),

        ClawdEdition(
            id: "b12-dial-up", name: "Dial-up", collection: .retro,
            blurb: "Screeches, squeals, and a patient wait for one tiny picture.",
            parts: [
                .init(.head) { _ in [Stamp(["l", "l"], x: 12, y: 1), Stamp(["l"], x: 11, y: 1)] },
                .init(.back) { _ in [Stamp(["dddd"], x: 6, y: 8), Stamp(["g.g.g"], x: 6, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["k"], x: 14, y: 2 + p % 4), Stamp(["k"], x: 1, y: 8 - p % 4), Stamp(["kkkk"], x: 0 + p % 3, y: 11)] },
            ]),

        ClawdEdition(
            id: "b12-game-cartridge", name: "Game Cartridge", collection: .retro,
            blurb: "Blow on it first. Works every time, scientifically unproven.",
            bodyColor: 0x8D8E96,
            parts: [
                .init(.head) { _ in [Stamp(["dddddddd"], x: 4, y: 2), Stamp(["dddddd"], x: 5, y: 1)] },
                .init(.face) { _ in [Stamp(["rrrr"], x: 6, y: 6), Stamp(["wwww"], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g.g.g.g."], x: 4, y: 11), Stamp(["w"], x: 1 + p % 2, y: 1)] },
            ]),

        ClawdEdition(
            id: "b12-calculator-watch", name: "Calculator Watch", collection: .retro,
            blurb: "Tells the time and also does your taxes. Peak nerd chic.",
            parts: [
                .init(.head) { _ in [Stamp(["dddddddd"], x: 4, y: 2)] },
                .init(.back) { p in [Stamp(["gggg"], x: 6, y: 7), Stamp(["l.l.l.l."], x: 4, y: 8), Stamp(["l.l.l.l."], x: 4, y: 9)] },
                .init(.hand) { p in [Stamp(["d"], x: 14, y: 5), Stamp([p % 2 == 0 ? "g" : "k"], x: 14, y: 4)] },
            ]),

        // MARK: Through the Decades

        ClawdEdition(
            id: "b12-50s-greaser", name: "50s Greaser", collection: .decades,
            blurb: "Pompadour, leather jacket, and a cool nod to the jukebox.",
            parts: [
                .init(.head) { p in [Stamp(["kkkkkk"], x: 5, y: 2), Stamp(["kk"], x: 4 + p % 2, y: 1), Stamp(["kk"], x: 6, y: 1)] },
                .init(.back) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 8), Stamp(["w"], x: 7, y: 8), Stamp(["w"], x: 8, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 14, y: 8 + p % 2), Stamp(["kk"], x: 14, y: 10)] },
            ]),

        ClawdEdition(
            id: "b12-60s-flower-power", name: "60s Flower Power", collection: .decades,
            blurb: "Peace, love, and daisies tucked behind every ear.",
            parts: [
                .init(.head) { _ in [Stamp(["pwp"], x: 3, y: 2), Stamp([".y."], x: 3, y: 3), Stamp(["owo"], x: 11, y: 2)] },
                .init(.back) { _ in [Stamp(["pyopyopy"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([".p.", "pyp", ".p."], x: 0, y: 8 + p % 2), Stamp(["o", "g"], x: 14, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b12-70s-disco", name: "70s Disco", collection: .decades,
            blurb: "Big collar, bigger hair, and a mirror ball doing the real work.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 2), Stamp(["n", "n"], x: 3, y: 3), Stamp(["n", "n"], x: 12, y: 3)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ll", "lw"], x: 0, y: 0),
                                                         Stamp([p % 2 == 0 ? "w" : "c"], x: 2 + p % 3, y: 3),
                                                         Stamp([p % 2 == 0 ? "p" : "y"], x: 14, y: 2 + p % 4)] },
            ]),

        ClawdEdition(
            id: "b12-80s-aerobics", name: "80s Aerobics", collection: .decades,
            blurb: "Neon headband, leg warmers, and a very enthusiastic five, six, seven, eight.",
            parts: [
                .init(.head) { _ in [Stamp(["pppppppp"], x: 4, y: 3)] },
                .init(.back) { p in [Stamp(["h"], x: 4, y: 9), Stamp(["h"], x: 6, y: 9), Stamp(["h"], x: 9, y: 9), Stamp(["h"], x: 11, y: 9),
                                     Stamp(["pp"], x: 1, y: p % 2 == 0 ? 4 : 6), Stamp(["pp"], x: 13, y: p % 2 == 0 ? 6 : 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1 + p % 2, y: 1), Stamp(["p"], x: 14 - p % 2, y: 1)] },
            ]),

        ClawdEdition(
            id: "b12-90s-grunge", name: "90s Grunge", collection: .decades,
            blurb: "Flannel, a beanie, and a quiet mood to match the guitar.",
            parts: [
                .init(.head) { _ in [Stamp(["dddddd"], x: 5, y: 2), Stamp(["dddddddd"], x: 4, y: 3)] },
                .init(.back) { _ in [Stamp(["rkrkrkrk"], x: 4, y: 8), Stamp(["krkrkrkr"], x: 4, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["k"], x: 1, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b12-y2k", name: "Y2K", collection: .decades,
            blurb: "Butterfly clips, frosted tips, and a flip phone for the new millennium.",
            parts: [
                .init(.head) { p in [Stamp(["c.c"], x: 3, y: 2), Stamp(["p.p"], x: 11, y: 2), Stamp([p % 2 == 0 ? "w" : "c"], x: 7, y: 2)] },
                .init(.hand) { p in [Stamp(["l", "g"], x: 14, y: 5), Stamp([p % 2 == 0 ? "c" : "w"], x: 15, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 1 + p % 4), Stamp(["c"], x: 14, y: 8 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b12-vaporwave", name: "Vaporwave", collection: .decades,
            blurb: "Pink skies, a marble bust vibe, and a sunset that never ends.",
            bodyColor: 0xF08BC4,
            parts: [
                .init(.face) { _ in [Stamp(["cccc"], x: 5, y: 4), Stamp(["cccc"], x: 9, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp([".oo.", "oooo", "oooo"], x: 0, y: 0), Stamp(["cccccccccccccccc"], x: 0, y: 11),
                                                         Stamp(["p"], x: 14, y: 1 + p % 4)] },
            ]),

        ClawdEdition(
            id: "b12-synthwave", name: "Synthwave", collection: .decades,
            blurb: "Neon grid, sunset stripes, and a midnight drive with no map.",
            bodyColor: 0x7A4FD6,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 4), Stamp(["pp"], x: 4, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["oooo", "pppp"], x: 12, y: 0), Stamp(["c.c.c.c.c.c.c.c."], x: p % 2, y: 11),
                                                         Stamp(["c"], x: 1, y: 2 + p % 3)] },
            ]),

        // MARK: Nature & Weather

        ClawdEdition(
            id: "b12-rainbow", name: "Rainbow", collection: .nature,
            blurb: "Every color after the rain, arching right over its head.",
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 0), Stamp(["oooooooo"], x: 4, y: 1), Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["r", "o", "g"], x: 2, y: 0), Stamp(["r", "o", "g"], x: 13, y: 0)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ww"], x: 0, y: 9 + p % 2), Stamp(["ww"], x: 14, y: 10 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b12-tornado", name: "Tornado", collection: .nature,
            blurb: "Spinning in place and very much not on a leaf-blowing schedule.",
            parts: [
                .init(.head) { p in [Stamp([p % 2 == 0 ? "dddddddd" : "ddddddd."], x: 4, y: 0), Stamp([p % 2 == 0 ? ".dddddd." : "dddddd.."], x: 4, y: 1), Stamp([".dddd."], x: 5, y: 2)] },
                .init(.back) { p in [Stamp(p % 2 == 0 ? ["ll", ".l"] : ["ll", "l."], x: 7, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["n"], x: 1 + p % 3 * 5, y: 10), Stamp(["g"], x: 14 - p % 3 * 5, y: 9)] },
            ]),

        ClawdEdition(
            id: "b12-lightning-bolt", name: "Lightning Bolt", collection: .nature,
            blurb: "Charged up, crackling, and not to be shaken hands with.",
            bodyColor: 0xF2C84B,
            parts: [
                .init(.head) { p in [Stamp(["..yy", ".yy.", "yy.."], x: 7, y: 0), Stamp([p % 2 == 0 ? "w" : "g"], x: 7, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 3, y: 4), Stamp(["w"], x: 14 - p % 3, y: 6),
                                                         Stamp(["y", "y"], x: 0, y: 8 - p % 2), Stamp(["y", "y"], x: 15, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b12-snowflake", name: "Snowflake", collection: .nature,
            blurb: "No two alike, and this one is definitely the cutest.",
            bodyColor: 0xCFE8F7,
            parts: [
                .init(.head) { _ in [Stamp(["w.w", ".w.", "w.w"], x: 6, y: 0), Stamp(["ww"], x: 7, y: 2)] },
                .init(.face) { _ in [Stamp(["cc"], x: 5, y: 7), Stamp(["cc"], x: 9, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: (p * 2) % 9), Stamp(["w"], x: 14, y: (p * 2 + 4) % 10), Stamp(["l"], x: 0, y: 4 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b12-volcano", name: "Volcano", collection: .nature,
            blurb: "Quiet most days. Then a spectacular, glowing opinion.",
            bodyColor: 0x6B4A3A,
            parts: [
                .init(.head) { p in [Stamp(["rr"], x: 7, y: 2), Stamp([p % 2 == 0 ? "o" : "y"], x: 7 + p % 2, y: 1), Stamp([p % 2 == 0 ? "r" : "o"], x: 8, y: 0)] },
                .init(.back) { _ in [Stamp(["rr"], x: 5, y: 8), Stamp(["o"], x: 9, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["d"], x: 2 + p % 3, y: 1), Stamp(["d"], x: 13 - p % 3, y: 0 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b12-aurora", name: "Aurora", collection: .nature,
            blurb: "Green ribbons of light, dancing slowly over a cold, clear night.",
            parts: [
                .init(.aura, followsBody: false) { p in [
                    Stamp(["gggggggggggggggg"], x: 0, y: 0), Stamp(["cc" + (p % 2 == 0 ? "gg" : "cc") + "cc" + (p % 2 == 0 ? "cc" : "gg") + "cccc" + "gg" + "cc"], x: 0, y: 1),
                    Stamp(["p.p.p.p.p.p.p.p."], x: p % 2, y: 2),
                    Stamp(["w"], x: 1 + p % 4, y: 11), Stamp(["w"], x: 14 - p % 3, y: 10)] },
                .init(.head) { _ in [Stamp(["w"], x: 4, y: 2), Stamp(["w"], x: 11, y: 2)] },
            ]),

        ClawdEdition(
            id: "b12-cactus", name: "Cactus", collection: .nature,
            blurb: "Prickly outside, soft inside, and tiny flowers on top.",
            bodyColor: 0x4E9A57,
            parts: [
                .init(.head) { p in [Stamp(["B", "B"], x: 7, y: 1), Stamp([p % 2 == 0 ? "p" : "r"], x: 7, y: 0)] },
                .init(.hand) { _ in [Stamp(["B", "B"], x: 1, y: 3), Stamp(["BB"], x: 1, y: 5), Stamp(["B", "B"], x: 14, y: 1), Stamp(["BB"], x: 13, y: 3)] },
                .init(.face) { _ in [Stamp(["w.w.w.w."], x: 4, y: 7)] },
            ]),

        ClawdEdition(
            id: "b12-mushroom", name: "Mushroom", collection: .nature,
            blurb: "A spotted red cap and a quiet life in the damp, mossy shade.",
            parts: [
                .init(.head) { p in [Stamp(["rrrrrr"], x: 5, y: 0), Stamp(["rrrrrrrrrr"], x: 3, y: 1), Stamp(["rrrrrrrrrr"], x: 3, y: 2),
                                     Stamp(["w"], x: 5, y: 1), Stamp(["w"], x: 9 + p % 2, y: 1)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 11), Stamp(["g.g"], x: 13, y: 11), Stamp(["w"], x: 14, y: 4 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b12-sunflower", name: "Sunflower", collection: .nature,
            blurb: "Always facing the light and always in a good mood about it.",
            parts: [
                .init(.head) { p in [Stamp(["y.yy.y"], x: 5, y: 0), Stamp(["yyyyyyyy"], x: 4, y: 1), Stamp(["yyyyyyyy"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "nn" : "n."], x: 7, y: 1)] },
                .init(.back) { p in [Stamp(["eee"], x: 1, y: 9 + p % 2), Stamp(["eee"], x: 12, y: 10 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b12-bonsai", name: "Bonsai", collection: .nature,
            blurb: "Patient, pruned, and a tiny tree of great composure.",
            bodyColor: 0x8A5A3C,
            parts: [
                .init(.head) { p in [Stamp([".ee.ee."], x: 4, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2), Stamp([p % 2 == 0 ? "e" : "."], x: 6, y: 0),
                                     Stamp(["n"], x: 7, y: 3)] },
                .init(.back) { _ in [Stamp(["dddddddd"], x: 4, y: 10), Stamp(["dddddd"], x: 5, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e"], x: 1 + p % 3, y: 1 + p % 4 * 2)] },
            ]),
    ]
}
