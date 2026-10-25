import Foundation

extension ClawdEditions {
    /// Batch 2: Fantasy & Sci-fi. See ClawdEditionsCore.swift for the format.
    static let batch2: [ClawdEdition] = [

        ClawdEdition(
            id: "b2-dragon", name: "Dragon", collection: .fantasy,
            blurb: "Small wings, big attitude, and a little smoke when a build fails.",
            bodyColor: 0x4CAF50,
            parts: [
                .init(.head) { _ in [Stamp(["w.", "ww"], x: 4, y: 1), Stamp([".w", "ww"], x: 10, y: 1),
                                     Stamp(["g", "g"], x: 7, y: 2)] },
                .init(.face) { _ in [Stamp(["kk"], x: 7, y: 6), Stamp(["gggggg"], x: 5, y: 8)] },
                .init(.back) { p in [Stamp(["e.", "ee", ".e"], x: 0, y: p % 2 == 0 ? 3 : 4),
                                     Stamp([".e", "ee", "e."], x: 14, y: p % 2 == 0 ? 3 : 4),
                                     Stamp(["BBB"], x: 13, y: 9), Stamp(["g"], x: 15, y: p % 2 == 0 ? 8 : 9)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "r" : "o", "o"], x: 14, y: 6)] },
            ]),

        ClawdEdition(
            id: "b2-mermaid", name: "Mermaid", collection: .fantasy,
            blurb: "Flowing hair, a shell top, and a tail that makes waves.",
            bodyColor: 0x3FB7B0,
            parts: [
                .init(.head) { _ in [Stamp(["oooooooo"], x: 4, y: 2), Stamp(["oooooo"], x: 5, y: 1)] },
                .init(.back) { p in [Stamp(["o", "o", "o", "o", "o", "o", "o"], x: 3, y: 3),
                                     Stamp(["o", "o", "o", "o", "o", "o", "o"], x: 12, y: 3),
                                     Stamp(["eeeeeeee", ".eeeeee."], x: 4, y: 9),
                                     Stamp([p % 2 == 0 ? "ee.ee" : ".eeee."], x: 5, y: 11),
                                     Stamp(["e..e"], x: 6, y: p % 2 == 0 ? 11 : 10)] },
                .init(.face) { _ in [Stamp(["hh"], x: 5, y: 6), Stamp(["hh"], x: 9, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: 8 - p % 3), Stamp(["w"], x: 14, y: 6 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b2-alien", name: "Friendly Alien", collection: .fantasy,
            blurb: "Came in peace, stayed for the snacks. Big eyes, bigger heart.",
            bodyColor: 0x7ED957,
            parts: [
                .init(.head) { p in [Stamp(["y", "y"], x: 5, y: 1), Stamp(["y", "y"], x: 10, y: 1),
                                     Stamp([p % 2 == 0 ? "g" : "w"], x: 5, y: 0), Stamp([p % 2 == 0 ? "w" : "g"], x: 10, y: 0)] },
                .init(.face) { _ in [Stamp(["kkk", "kkk"], x: 4, y: 4), Stamp(["kkk", "kkk"], x: 9, y: 4),
                                     Stamp(["w"], x: 5, y: 4), Stamp(["w"], x: 10, y: 4), Stamp(["kk"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 2, y: 1), Stamp(["g"], x: 14 - p % 2, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b2-saucer-pilot", name: "Saucer Pilot", collection: .fantasy,
            blurb: "Parked the flying saucer. Mind the glow, it has a mind of its own.",
            parts: [
                .init(.head) { _ in [Stamp([".cccccc."], x: 4, y: 2), Stamp(["cc....cc"], x: 4, y: 1), Stamp(["..cccc.."], x: 4, y: 0)] },
                .init(.back) { p in [Stamp(["..yyyyyyyyyy..", "yyyyyyyyyyyyyy"], x: 1, y: 9),
                                     Stamp([p % 3 == 0 ? "g" : "l", p % 3 == 1 ? "g" : "l", p % 3 == 2 ? "g" : "l",
                                            p % 3 == 0 ? "g" : "l", p % 3 == 1 ? "g" : "l", p % 3 == 2 ? "g" : "l"], x: 3, y: 10),
                                     Stamp([".yyyyyyyyyy."], x: 2, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 1 + p % 2), Stamp(["g"], x: 14, y: 3 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b2-cyborg", name: "Cyborg", collection: .fantasy,
            blurb: "Half human, half hardware, fully caffeinated.",
            parts: [
                .init(.face) { p in [Stamp(["yyyy", "yyyy", "yyyy", "yyyy", "yyyy", "yyyy"], x: 4, y: 3),
                                     Stamp(["r"], x: 5, y: 4), Stamp(["k", "k", "k"], x: 8, y: 4),
                                     Stamp([p % 2 == 0 ? "r" : "o"], x: 6, y: 4), Stamp(["lll"], x: 5, y: 7)] },
                .init(.head) { p in [Stamp(["y", "y"], x: 5, y: 1), Stamp([p % 2 == 0 ? "r" : "o"], x: 5, y: 0)] },
                .init(.back) { _ in [Stamp(["yy", "yy"], x: 12, y: 5), Stamp(["d", "d"], x: 4, y: 9), Stamp(["d", "d"], x: 6, y: 9)] },
                .init(.hand) { p in [Stamp(["yy", "yy"], x: 14, y: 5), Stamp([p % 2 == 0 ? "c" : "w"], x: 15, y: 4)] },
            ]),

        ClawdEdition(
            id: "b2-elf-archer", name: "Elf Archer", collection: .fantasy,
            blurb: "Sharp ears, steady aim, and a green hood for the deep woods.",
            parts: [
                .init(.head) { _ in [Stamp(["eeeeee"], x: 5, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2), Stamp(["r", "r"], x: 10, y: 0)] },
                .init(.back) { _ in [Stamp(["B."], x: 2, y: 3), Stamp([".B"], x: 13, y: 3), Stamp(["n", "n", "n"], x: 3, y: 8)] },
                .init(.hand) { p in [Stamp([".n", "n.", "n.", "n.", "n.", ".n"], x: 13, y: 2),
                                     Stamp(["w", "w", "w", "w", "w", "w"], x: 15, y: 2),
                                     Stamp([p % 2 == 0 ? "y" : "."], x: 14, y: 5)] },
                .init(.face) { _ in [Stamp(["e", "e"], x: 4, y: 7)] },
            ]),

        ClawdEdition(
            id: "b2-dwarf-miner", name: "Dwarf Miner", collection: .fantasy,
            blurb: "Hard hat, headlamp, and a beard that has seen things deep underground.",
            parts: [
                .init(.head) { p in [Stamp(["yyyyyy"], x: 5, y: 1), Stamp(["yyyyyyyy"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "g" : "w", "g"], x: 7, y: 0)] },
                .init(.face) { _ in [Stamp(["oooooo", "oooooo", ".oooo.", "..oo.."], x: 5, y: 6)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n", "n", "n"], x: 14, y: 3),
                                     Stamp(["yyy"], x: 13, y: 3), Stamp([p % 2 == 0 ? "y" : "."], x: 12, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 0 + p % 2, y: 9), Stamp(["c"], x: 1, y: 10)] },
            ]),

        ClawdEdition(
            id: "b2-bridge-troll", name: "Bridge Troll", collection: .fantasy,
            blurb: "Lives under a bridge, charges one riddle per crossing.",
            bodyColor: 0x6E8B5A,
            parts: [
                .init(.head) { _ in [Stamp(["B", "B"], x: 5, y: 1), Stamp(["B"], x: 9, y: 2), Stamp(["n", "n"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["kkkk"], x: 5, y: 3), Stamp(["w", "w"], x: 6, y: 7), Stamp(["w", "w"], x: 9, y: 7)] },
                .init(.hand) { p in [Stamp(["nn", "nn", "n.", "n."], x: 14, y: p % 2 == 0 ? 4 : 5)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["yyyyyyyyyyyyyyyy"], x: 0, y: 11), Stamp(["l.l.l.l.l.l.l.l."], x: 0, y: 10)] },
            ]),

        ClawdEdition(
            id: "b2-unicorn", name: "Unicorn", collection: .fantasy,
            blurb: "A spiral horn, a rainbow mane, and a sparkle in every step.",
            bodyColor: 0xC9B8E8,
            parts: [
                .init(.head) { p in [Stamp(["g"], x: 7, y: 2), Stamp(["g"], x: 7, y: 1), Stamp(["w"], x: 7, y: 0),
                                     Stamp(["B."], x: 4, y: 2), Stamp([".B"], x: 11, y: 2),
                                     Stamp([p % 2 == 0 ? "c" : "h"], x: 9, y: 1)] },
                .init(.back) { p in [Stamp(["h", "r", "g", "e", "c", "p"], x: 3, y: 3),
                                     Stamp(["p", "c", "e", "g"], x: 12 + p % 2, y: 8)] },
                .init(.face) { _ in [Stamp(["hh"], x: 7, y: 6)] },
            ]),

        ClawdEdition(
            id: "b2-phoenix", name: "Phoenix", collection: .fantasy,
            blurb: "Rises from every crash, a little warmer each time.",
            bodyColor: 0xF26B21,
            parts: [
                .init(.head) { p in [Stamp([p % 2 == 0 ? "r.r" : ".r."], x: 6, y: 1), Stamp(["g", "g"], x: 8, y: 1),
                                     Stamp([p % 2 == 0 ? "o" : "r"], x: 7, y: 0), Stamp(["g"], x: 5, y: 2)] },
                .init(.face) { _ in [Stamp(["gg"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["r.", "or", ".o"], x: 0, y: p % 2 == 0 ? 3 : 4), Stamp([".r", "ro", "o."], x: 14, y: p % 2 == 0 ? 3 : 4),
                                     Stamp([p % 2 == 0 ? "rog" : "gor"], x: 6, y: 9), Stamp([p % 2 == 0 ? "o" : "r"], x: 7, y: 11)] },
            ]),

        ClawdEdition(
            id: "b2-kraken", name: "Kraken", collection: .fantasy,
            blurb: "Eight arms, zero chill. The sea rules, and so does your sprint board.",
            bodyColor: 0x7B4FA3,
            parts: [
                .init(.head) { _ in [Stamp(["BBBBBB"], x: 5, y: 2), Stamp(["BBBB"], x: 6, y: 1), Stamp(["w"], x: 6, y: 2)] },
                .init(.back) { p in [Stamp(["B", "B", "B", "B"], x: 2, y: p % 2 == 0 ? 8 : 7), Stamp(["B", "B", "B", "B"], x: 13, y: p % 2 == 0 ? 7 : 8),
                                     Stamp(["B", "B"], x: 4, y: 9), Stamp(["B", "B"], x: 6, y: 9),
                                     Stamp(["B", "B"], x: 9, y: 9), Stamp(["B", "B"], x: 11, y: 9),
                                     Stamp(["B.B.B.B.B.B"], x: 3, y: 11)] },
                .init(.face) { _ in [Stamp(["h.h.h"], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: 3 + p % 3), Stamp(["c"], x: 14, y: 5 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b2-time-traveler", name: "Time Traveler", collection: .fantasy,
            blurb: "Brass goggles and a swirling portal. Back before the deploy finishes.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 2), Stamp(["yy..yy"], x: 5, y: 1), Stamp(["cc", "cc"], x: 5, y: 1), Stamp(["cc"], x: 9, y: 1)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "xxx" : "pxp", "xcx", "pxp"], x: 12, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([".xx.", "xccx", "xwcx", ".xx."], x: 0, y: 4),
                                                         Stamp([p % 2 == 0 ? "w" : "c"], x: p % 2 == 0 ? 1 : 2, y: p % 2 == 0 ? 5 : 6)] },
                .init(.hand) { p in [Stamp(["gg"], x: 14, y: 6), Stamp([p % 2 == 0 ? "r" : "g"], x: 14, y: 5)] },
            ]),

        ClawdEdition(
            id: "b2-bounty-hunter", name: "Bounty Hunter", collection: .fantasy,
            blurb: "Full helmet, glowing visor, jetpack. Always gets the bug.",
            parts: [
                .init(.head) { p in [Stamp(["dddddd"], x: 5, y: 1), Stamp(["dddddddd"], x: 4, y: 2), Stamp(["r"], x: 7, y: 0),
                                     Stamp([p % 2 == 0 ? "r" : "o"], x: 8, y: 1)] },
                .init(.face) { p in [Stamp(["kkkkkkkk", "kkkkkkkk"], x: 4, y: 4), Stamp([p % 2 == 0 ? "rr" : ".."], x: 5, y: 4),
                                     Stamp([p % 2 == 0 ? ".." : "rr"], x: 9, y: 4), Stamp(["d.d.d.d."], x: 4, y: 7)] },
                .init(.back) { p in [Stamp(["dd", "dd", "dd"], x: 2, y: 4), Stamp(["dd", "dd", "dd"], x: 12, y: 4),
                                     Stamp([p % 2 == 0 ? "or" : "ro"], x: 2, y: 7), Stamp([p % 2 == 0 ? "ro" : "or"], x: 12, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g" ], x: 1, y: 9 + p % 2), Stamp(["g"], x: 14, y: 10 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b2-rebel-pilot", name: "Rebel Pilot", collection: .fantasy,
            blurb: "Orange flight helmet, goggles up, and one very long shot at glory.",
            parts: [
                .init(.head) { _ in [Stamp(["oooooo"], x: 5, y: 1), Stamp(["oooooooo"], x: 4, y: 2), Stamp(["ww"], x: 7, y: 1),
                                     Stamp(["o", "o"], x: 3, y: 3), Stamp(["o", "o"], x: 12, y: 3)] },
                .init(.face) { _ in [Stamp(["yccy"], x: 4, y: 3), Stamp(["yccy"], x: 9, y: 3), Stamp(["yy"], x: 8, y: 3)] },
                .init(.back) { p in [Stamp(["wwww"], x: 6, y: 8), Stamp(["w"], x: p % 2 == 0 ? 11 : 12, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l.l."], x: 0 + p % 2, y: 1), Stamp(["l.l."], x: 11 - p % 2, y: 0)] },
            ]),

        ClawdEdition(
            id: "b2-droid-sidekick", name: "Droid Sidekick", collection: .fantasy,
            blurb: "Beeps, rolls, and fixes everything. Mostly. Loyal to a fault.",
            bodyColor: 0xDADCE0,
            parts: [
                .init(.head) { p in [Stamp(["y"], x: 7, y: 2), Stamp([p % 2 == 0 ? "r" : "g"], x: 7, y: 1), Stamp(["y"], x: 7, y: 0),
                                     Stamp(["xxxx"], x: 6, y: 2)] },
                .init(.face) { p in [Stamp(["ccc", "ckc"], x: 6, y: 4), Stamp(["r", "g", "c"], x: 5, y: 7), Stamp(["l"], x: p % 2 == 0 ? 9 : 10, y: 7)] },
                .init(.back) { p in [Stamp(["kkkkkkkk", "kyykkyyk", "kkkkkkkk"], x: 4, y: 9),
                                     Stamp([p % 2 == 0 ? "y" : "k"], x: 5, y: 10), Stamp([p % 2 == 0 ? "k" : "y"], x: 10, y: 10)] },
            ]),

        ClawdEdition(
            id: "b2-forest-wizard", name: "Forest Wizard", collection: .fantasy,
            blurb: "Moss beard, leaf hat, and a staff that hums with spring.",
            parts: [
                .init(.head) { _ in [Stamp(["ee"], x: 7, y: 0), Stamp(["eeee"], x: 6, y: 1), Stamp(["nnnnnnnnnn"], x: 3, y: 2), Stamp(["e"], x: 3, y: 1)] },
                .init(.face) { _ in [Stamp(["eeeeee", "eeeeee", ".eeee.", "..ee.."], x: 5, y: 6)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n", "n", "n", "n", "n"], x: 14, y: 3),
                                     Stamp([p % 2 == 0 ? "c" : "e"], x: 14, y: 2), Stamp([p % 2 == 0 ? "e" : "c"], x: 13, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 0 + p % 3, y: 3 + p % 4), Stamp(["g"], x: 1, y: 8 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b2-necromancer", name: "Hooded Sorcerer", collection: .fantasy,
            blurb: "Spooky hood, skull staff, glowing eyes. Secretly returns every shopping cart.",
            parts: [
                .init(.head) { _ in [Stamp(["pppppp"], x: 5, y: 1), Stamp(["pppppppp"], x: 4, y: 2), Stamp(["pp"], x: 7, y: 0)] },
                .init(.back) { _ in [Stamp(["p", "p", "p", "p", "p", "p"], x: 3, y: 3), Stamp(["p", "p", "p", "p", "p", "p"], x: 12, y: 3)] },
                .init(.face) { p in [Stamp(["e"], x: 5, y: 4), Stamp(["e"], x: 10, y: 4), Stamp([p % 2 == 0 ? "e" : "c"], x: 5, y: 5), Stamp([p % 2 == 0 ? "e" : "c"], x: 10, y: 5)] },
                .init(.hand) { p in [Stamp(["ww", "kk"], x: 14, y: 2), Stamp(["n", "n", "n", "n", "n", "n"], x: 14, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e"], x: 1, y: 8 - p % 4), Stamp(["e"], x: 0, y: 4 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b2-golem", name: "Stone Golem", collection: .fantasy,
            blurb: "Mossy, mighty, and glowing with an old rune. Slow to move, fast to forgive.",
            bodyColor: 0x8D8E96,
            parts: [
                .init(.head) { _ in [Stamp(["e.e", "eee"], x: 5, y: 1), Stamp(["e"], x: 10, y: 2), Stamp(["yy"], x: 9, y: 1)] },
                .init(.face) { p in [Stamp(["kkkk"], x: 6, y: 3), Stamp([p % 2 == 0 ? "c" : "w", "c"], x: 7, y: 5), Stamp(["k", "k"], x: 11, y: 7)] },
                .init(.back) { _ in [Stamp(["yy", "yy", "yy", "yy"], x: 0, y: 5), Stamp(["yy", "yy", "yy", "yy"], x: 14, y: 5),
                                     Stamp(["e.e"], x: 0, y: 5), Stamp(["ee"], x: 4, y: 9), Stamp(["ee"], x: 9, y: 9)] },
            ]),

        ClawdEdition(
            id: "b2-fairy", name: "Fairy", collection: .fantasy,
            blurb: "Gossamer wings, a flower crown, and a glittering trail of good ideas.",
            bodyColor: 0xF4A6C8,
            parts: [
                .init(.head) { _ in [Stamp(["h.g.h"], x: 5, y: 2), Stamp(["g"], x: 7, y: 1)] },
                .init(.back) { p in [Stamp(["c.", "cc", ".c", ".c"], x: 0, y: p % 2 == 0 ? 2 : 3), Stamp([".c", "cc", "c.", "c."], x: 14, y: p % 2 == 0 ? 2 : 3),
                                     Stamp(["cc", "c."], x: 1, y: p % 2 == 0 ? 6 : 7), Stamp(["cc", ".c"], x: 13, y: p % 2 == 0 ? 6 : 7)] },
                .init(.hand) { p in [Stamp(["n", "n"], x: 14, y: 5), Stamp([p % 2 == 0 ? "g" : "w"], x: 14, y: 4), Stamp([p % 3 == 0 ? "w" : "."], x: 15, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1 + p % 3, y: 9), Stamp(["w"], x: 14 - p % 3, y: 10)] },
            ]),

        ClawdEdition(
            id: "b2-hologram", name: "Hologram", collection: .fantasy,
            blurb: "A flickering cyan projection. Mostly there, and you can see right through it.",
            bodyColor: 0x4FC3E8,
            parts: [
                .init(.face) { p in [Stamp(["wwwwwwww"], x: 4, y: 3 + (p * 2) % 6), Stamp(["cccc"], x: 6, y: 6)] },
                .init(.head) { p in [Stamp([p % 2 == 0 ? "c" : "w"], x: 5, y: 2), Stamp([p % 3 == 0 ? "w" : "c"], x: 10, y: 2), Stamp(["c"], x: 7, y: 1)] },
                .init(.back) { _ in [Stamp(["cc", "cc"], x: 2, y: 8), Stamp(["cc", "cc"], x: 12, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["xxxxxxxxxxxxxxxx"], x: 0, y: 11), Stamp([p % 2 == 0 ? "c.c.c.c.c.c.c.c." : ".c.c.c.c.c.c.c.c"], x: 0, y: 11)] },
            ]),
    ]
}
