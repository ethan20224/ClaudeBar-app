import Foundation

/// Hand-made editions and the reference format for every batch file.
///
/// Canvas: 16x12 cells. Clawd's body sits at (2, 3): head rows 3-8 (cols 4-11),
/// side nubs at rows 5-6 (cols 2-3 and 12-13), legs at cols 4, 6, 9, 11 (rows 9-10),
/// eyes at (5, 4) and (10, 4). Free space: rows 0-2 above, cols 0-1 and 14-15 at the
/// sides, row 11 below. `B` paints in the edition's body color; other letters are the
/// legend in ClawdPixels.swift. Parts in a slot are skipped when a mood claims it.
extension ClawdEditions {
    static let core: [ClawdEdition] = [
        // MARK: Characters

        ClawdEdition(
            id: "wise-sage", name: "Wise Sage", collection: .characters,
            blurb: "Long beard, raised brows, and a staff. Has seen every stack trace.",
            parts: [
                .init(.face) { _ in [Stamp(["ww"], x: 4, y: 3), Stamp(["ww"], x: 10, y: 3),
                                     Stamp(["wwwwww", "wwwwww", ".wwww."], x: 5, y: 6)] },
                .init(.head) { _ in [Stamp([".ww."], x: 6, y: 2), Stamp(["g"], x: 7, y: 1)] },
                .init(.hand) { p in [Stamp(["g", "n", "n", "n", "n", "n", "n", "n", "n"], x: 1, y: 2),
                                     Stamp([p % 2 == 0 ? "w" : "g"], x: 0, y: 2)] },
            ]),

        ClawdEdition(
            id: "ocean-captain", name: "Ocean Liner Captain", collection: .characters,
            blurb: "White cap, navy coat, brass buttons. Nothing sinks on this ship.",
            parts: [
                .init(.head) { _ in [Stamp(["wwwwww"], x: 5, y: 1), Stamp(["uuuuuuuu"], x: 4, y: 2), Stamp(["g"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["nnnn"], x: 6, y: 6)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu", "uuuuuuuu"], x: 4, y: 7), Stamp(["g", "g"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 1 + p % 2, y: 10), Stamp(["l"], x: 14 - p % 2, y: 10)] },
            ]),

        // MARK: Fantasy & Sci-fi

        ClawdEdition(
            id: "rogue-robot", name: "Rogue Robot", collection: .fantasy,
            blurb: "Went off-script. Red eyes, loose wires, a spark where an arm used to be.",
            bodyColor: 0x8D8E96,
            parts: [
                .init(.face) { _ in [Stamp(["r"], x: 5, y: 4), Stamp(["r"], x: 10, y: 4),
                                     Stamp(["l.l.l"], x: 6, y: 6), Stamp(["dddd"], x: 6, y: 7)] },
                .init(.head) { p in [Stamp(["d"], x: 7, y: 2), Stamp([p % 2 == 0 ? "r" : "h"], x: 7, y: 1)] },
                .init(.hand) { p in [p % 2 == 0 ? Stamp(["g"], x: 14, y: 4) : Stamp(["w"], x: 15, y: 5)] },
                .init(.back) { _ in [Stamp(["d", "d"], x: 3, y: 9)] },
            ]),

        ClawdEdition(
            id: "wizard-school", name: "Wizard School", collection: .fantasy,
            blurb: "Round glasses, a striped scarf, and a wand with a mind of its own.",
            parts: [
                .init(.face) { _ in [Stamp(["yyy", "y.y", "yyy"], x: 4, y: 3), Stamp(["yyy", "y.y", "yyy"], x: 9, y: 3),
                                     Stamp(["yy"], x: 7, y: 4)] },
                .init(.head) { _ in [Stamp(["pp"], x: 7, y: 0), Stamp(["pppp"], x: 6, y: 1), Stamp(["dddddddddd"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["rgrgrgrg"], x: 4, y: 8), Stamp(["r", "g"], x: 12, y: 8)] },
                .init(.hand) { p in [Stamp(["n", "n", "n"], x: 14, y: 4), Stamp([p % 2 == 0 ? "g" : "w"], x: 14, y: 3),
                                     Stamp([p % 3 == 0 ? "w" : "."], x: 15, y: 2)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["g", "w", "w"], x: 1, y: 1 + p % 2), Stamp(["g", "w", "w"], x: 14, y: 0 + (p + 1) % 2),
                    Stamp(["g", "w"], x: 0, y: 6 + p % 2),
                    Stamp(["ww", "wr"], x: 14, y: 8 - p % 2),
                ] },
            ]),

        ClawdEdition(
            id: "space-knight", name: "Space Knight", collection: .fantasy,
            blurb: "Helmet crest, long cloak, and a humming blade of pure light.",
            parts: [
                .init(.head) { _ in [Stamp(["rr"], x: 7, y: 1), Stamp(["yyyyyyyy"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nn", "nn"], x: 2, y: 7), Stamp(["nn", "nn"], x: 12, y: 7)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "c" : "w", "c", "c", "c", "c", "c"], x: 14, y: 0),
                                     Stamp(["w", "w", "w", "w", "w", "w"], x: 15, y: 0), Stamp(["d", "d"], x: 14, y: 6)] },
            ]),

        // MARK: Around the World

        ClawdEdition(
            id: "diwali", name: "Diwali Night", collection: .cultures,
            blurb: "A marigold garland, a tiny flame, and rangoli colors on the floor.",
            parts: [
                .init(.back) { _ in [Stamp(["ogogogog"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "g" : "o", p % 2 == 0 ? "o" : "g"], x: 14, y: 3), Stamp(["nn"], x: 14, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["rgpgrgpgr"], x: 3, y: 11), Stamp(["g"], x: 1, y: 2 + p % 3),
                                                         Stamp(["o"], x: 0, y: 6 - p % 2)] },
            ]),

        ClawdEdition(
            id: "lunar-new-year", name: "Lunar New Year", collection: .cultures,
            blurb: "A red-and-gold cap and a swaying lantern for good luck.",
            parts: [
                .init(.head) { _ in [Stamp(["gggggg"], x: 5, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.hand) { p in [Stamp(["gg", "rr", "rr", "gg"], x: 14, y: 3), Stamp(["g"], x: 14 + p % 2, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r"], x: 1, y: 1 + p % 2), Stamp(["g"], x: 2, y: 4 - p % 2)] },
            ]),

        // MARK: Holidays

        ClawdEdition(
            id: "reindeer", name: "Reindeer", collection: .holidays,
            blurb: "Antlers, a glowing red nose, and a scarf for the long flight.",
            parts: [
                .init(.head) { _ in [Stamp(["n.n", ".n."], x: 3, y: 1), Stamp(["n.n", ".n."], x: 10, y: 1)] },
                .init(.face) { p in [Stamp([p % 2 == 0 ? "rr" : "hh"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["rwrwrwrw"], x: 4, y: 8), Stamp(["r", "w"], x: 12, y: 8)] },
            ]),

        // MARK: Food

        ClawdEdition(
            id: "apple", name: "Red Apple", collection: .food,
            blurb: "Crisp, shiny, and one bite away from a great idea. The fruit, not the logo.",
            bodyColor: 0xD9362B,
            parts: [
                .init(.head) { _ in [Stamp(["n"], x: 7, y: 2), Stamp(["ee", "e."], x: 8, y: 1)] },
                .init(.face) { _ in [Stamp(["ww"], x: 4, y: 3)] },
            ]),

        ClawdEdition(
            id: "pizza", name: "Pizza Slice", collection: .food,
            blurb: "Extra cheese, double pepperoni, a perfectly golden crust.",
            bodyColor: 0xF2C14E,
            parts: [
                .init(.face) { _ in [Stamp(["rr"], x: 7, y: 3), Stamp(["rr", "rr"], x: 5, y: 6), Stamp(["rr", "rr"], x: 9, y: 6),
                                     Stamp(["e"], x: 7, y: 7)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 6 + p % 2, y: 1), Stamp(["l"], x: 9 - p % 2, y: 0)] },
            ]),

        // MARK: Dev Life

        ClawdEdition(
            id: "rubber-duck", name: "Rubber Duck", collection: .devLife,
            blurb: "Explain your bug to it. It never interrupts, and it is always right.",
            bodyColor: 0xF5D547,
            parts: [
                .init(.face) { _ in [Stamp(["oooo", "oooo"], x: 6, y: 6)] },
                .init(.head) { _ in [Stamp(["B"], x: 7, y: 2), Stamp(["B"], x: 8, y: 1)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 14, y: 4 - p % 3), Stamp(["c"], x: 1, y: 6 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "bug-hunter", name: "Bug Hunter", collection: .devLife,
            blurb: "Deerstalker cap, magnifying glass, and a very small suspect on the floor.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnn"], x: 6, y: 1), Stamp(["nnnnnnnn"], x: 4, y: 2)] },
                .init(.hand) { _ in [Stamp([".yy.", "y..y", "y..y", ".yy."], x: 12, y: 7), Stamp(["cc", "cc"], x: 13, y: 8), Stamp(["n"], x: 12, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["kk"], x: 1 + (p * 3) % 9, y: 11)] },
            ]),

        // MARK: Animals

        ClawdEdition(
            id: "fox", name: "Fox", collection: .animals,
            blurb: "Sharp ears, a white muzzle, and a tail that gives it away.",
            bodyColor: 0xE8692E,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["wwww"], x: 6, y: 6), Stamp(["ww"], x: 7, y: 7), Stamp(["kk"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["BB", "BB", "ww"], x: 14, y: p % 2 == 0 ? 6 : 5)] },
            ]),

        ClawdEdition(
            id: "panda", name: "Panda", collection: .animals,
            blurb: "Black patches, round ears, and an unbothered attitude.",
            bodyColor: 0xDADCE0,
            parts: [
                .init(.head) { _ in [Stamp(["kk", "kk"], x: 4, y: 1), Stamp(["kk", "kk"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["kkk", "kwk", "kkk"], x: 4, y: 3), Stamp(["kkk", "kwk", "kkk"], x: 9, y: 3), Stamp(["kk"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["kk", "kk"], x: 2, y: 5), Stamp(["kk", "kk"], x: 12, y: 5),
                                     Stamp(["k", "k"], x: 4, y: 9), Stamp(["k", "k"], x: 6, y: 9),
                                     Stamp(["k", "k"], x: 9, y: 9), Stamp(["k", "k"], x: 11, y: 9)] },
            ]),

        ClawdEdition(
            id: "cat", name: "Cat", collection: .animals,
            blurb: "Pointed ears, whiskers, and a tail that has opinions.",
            bodyColor: 0x9AA0A6,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1), Stamp(["h"], x: 5, y: 2), Stamp(["h"], x: 10, y: 2)] },
                .init(.face) { _ in [Stamp(["ll"], x: 2, y: 7), Stamp(["ll"], x: 12, y: 7), Stamp(["hh"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["B", "B", "B", "B"], x: 14, y: 5), Stamp(["B"], x: 15, y: p % 2 == 0 ? 4 : 5)] },
            ]),

        // MARK: Jobs & Hobbies

        ClawdEdition(
            id: "chef", name: "Chef", collection: .jobs,
            blurb: "Tall hat, clean apron, and a spatula. Dinner is handled.",
            parts: [
                .init(.head) { _ in [Stamp(["wwww"], x: 6, y: 0), Stamp(["wwwwww"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["wwww", "wwww"], x: 6, y: 7)] },
                .init(.hand) { p in [Stamp(["yy", "yy", "n"], x: 0, y: p % 2 == 0 ? 3 : 4)] },
            ]),

        ClawdEdition(
            id: "pianist", name: "Pianist", collection: .jobs,
            blurb: "A bow tie, a keyboard, and little notes drifting up while the hands play.",
            parts: [
                .init(.head) { p in [Stamp(["nnnn"], x: 6, y: 2 - (p % 2)), Stamp(["nn"], x: 5, y: 3)] },
                .init(.back) { p in
                    let leftDown = p % 2 == 0
                    return [
                        Stamp(["dddddddddddd"], x: 2, y: 8),
                        Stamp(["wkwwkwkwwkwk", "wlwwlwwlwwlw"], x: 2, y: 9),
                        Stamp(["d"], x: 3, y: 11), Stamp(["d"], x: 12, y: 11),
                        Stamp(["rr"], x: 7, y: 7),
                        Stamp(["ww"], x: 5, y: leftDown ? 8 : 7),
                        Stamp(["ww"], x: 9, y: leftDown ? 7 : 8),
                    ]
                },
                .init(.aura, followsBody: false) { p in
                    let a = (p * 2) % 9
                    return [
                        Stamp([".c", ".c", "cc"], x: 0, y: 8 - a),
                        Stamp([".h", ".h", "hh"], x: 14, y: 6 - (a + 3) % 7),
                    ]
                },
            ]),

        ClawdEdition(
            id: "ww2-pilot", name: "WWII Pilot", collection: .characters,
            blurb: "Leather cap, goggles pushed up, a long white scarf, and a propeller plane overhead.",
            parts: [
                .init(.head) { _ in [
                    Stamp(["cc..cc"], x: 5, y: 1), Stamp(["yy"], x: 7, y: 1),
                    Stamp(["nnnnnnnn"], x: 4, y: 2), Stamp(["nnnnnnnn"], x: 4, y: 3),
                    Stamp(["n", "n"], x: 4, y: 4), Stamp(["n", "n"], x: 11, y: 4),
                ] },
                .init(.back) { p in [
                    Stamp(["wwwwwwww"], x: 4, y: 8),
                    p % 2 == 0 ? Stamp(["ww", "w"], x: 12, y: 8) : Stamp(["ww", ".w"], x: 12, y: 7),
                ] },
                .init(.aura, followsBody: false) { p in
                    let x = 15 - (p * 3) % 20
                    return [Stamp([p % 2 == 0 ? "lyyyy" : "yyyyy", ".yll."], x: x, y: 0)]
                },
            ]),

        ClawdEdition(
            id: "space-walker", name: "Space Walker", collection: .characters,
            blurb: "A full suit, a tether to the ship, and the whole Earth hanging in the corner.",
            parts: [
                .init(.head) { _ in [
                    Stamp(["llllllll"], x: 4, y: 2), Stamp(["l", "l", "l", "l"], x: 3, y: 3), Stamp(["l", "l", "l", "l"], x: 12, y: 3),
                    Stamp(["c"], x: 5, y: 3), Stamp(["cc"], x: 4, y: 3),
                ] },
                .init(.back) { p in [
                    Stamp(["llllllll"], x: 4, y: 7), Stamp(["llllllll"], x: 4, y: 8),
                    Stamp(["g"], x: 4, y: 6), Stamp(["g"], x: 11, y: 6),
                    Stamp([p % 2 == 0 ? "r" : "h", "c"], x: 7, y: 7),
                    Stamp(["yy", "yy", "yy"], x: 0, y: 5),
                ] },
                .init(.aura, followsBody: false) { p in [
                    Stamp([".xx.", "xeex", ".xx."], x: 12, y: 0),
                    Stamp(["l"], x: 0, y: 8 + p % 2), Stamp(["ll"], x: 0, y: 9 + (p + 1) % 2), Stamp(["l"], x: 2, y: 10),
                    Stamp(["g"], x: 1 + p % 3, y: 1), Stamp(["w"], x: 9 - p % 2, y: 0),
                ] },
            ]),

        ClawdEdition(
            id: "moon-landing", name: "Moon Landing", collection: .characters,
            blurb: "One small step: footprints, a planted flag, and home glowing overhead.",
            parts: [
                .init(.head) { _ in [
                    Stamp(["llllllll"], x: 4, y: 2), Stamp(["l", "l", "l", "l"], x: 3, y: 3), Stamp(["l", "l", "l", "l"], x: 12, y: 3),
                    Stamp(["cc"], x: 4, y: 3),
                ] },
                .init(.back) { _ in [
                    Stamp(["llllllll"], x: 4, y: 7), Stamp(["llllllll"], x: 4, y: 8),
                    Stamp(["g"], x: 4, y: 6), Stamp(["g"], x: 11, y: 6),
                ] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["yyyyyyyyyyyyyyyy"], x: 0, y: 11),
                    Stamp(["ll"], x: 0, y: 10), Stamp(["lll"], x: 13, y: 10),
                    Stamp(["l"], x: 1, y: 0 + 0), Stamp(["l", "l", "l", "l", "l", "l", "l", "l", "l", "l"], x: 1, y: 1),
                    p % 2 == 0 ? Stamp(["uurr", "wwww", "rrrr"], x: 2, y: 0) : Stamp(["uurr", "wwww", "rrrr"], x: 2, y: 1),
                    Stamp([".xx", "xee", ".xx"], x: 13, y: 0),
                    Stamp(["k.k"], x: 5, y: 11), Stamp(["k.k"], x: 9, y: 11),
                ] },
            ]),

        ClawdEdition(
            id: "roaring-twenties", name: "Roaring Twenties", collection: .characters,
            blurb: "A feathered headband, long pearls, a fringe that swings, and champagne for everyone.",
            parts: [
                .init(.head) { p in [
                    Stamp(["gggggggg"], x: 4, y: 3), Stamp(["r"], x: 7, y: 3),
                    p % 2 == 0 ? Stamp([".p", "pp", "p."], x: 8, y: 0) : Stamp(["p.", "pp", ".p"], x: 8, y: 0),
                ] },
                .init(.back) { p in [
                    Stamp(["w.w.w.w."], x: 4, y: 7), Stamp([".w.w.w.w"], x: 4, y: 8),
                    Stamp(["gggggggg"], x: 4, y: 8),
                    p % 2 == 0 ? Stamp([".g.gg.g."], x: 4, y: 9) : Stamp(["g.g..g.g"], x: 4, y: 9),
                ] },
                .init(.hand) { _ in [Stamp(["ww", ".l"], x: 14, y: 4), Stamp(["g"], x: 14, y: 3)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["w"], x: 14 + p % 2, y: 2 - p % 3), Stamp(["w"], x: 15 - p % 2, y: 1),
                    Stamp(["g"], x: 1, y: 1 + p % 3), Stamp(["g"], x: 3 - p % 2, y: 6 + p % 3),
                    Stamp(["g...g"], x: 0, y: 11), Stamp(["g...g"], x: 11, y: 11),
                ] },
            ]),

        ClawdEdition(
            id: "maiden-voyage", name: "Maiden Voyage", collection: .characters,
            blurb: "A grand liner, a lifebuoy ring, and an iceberg that looks suspiciously large.",
            parts: [
                .init(.back) { _ in [Stamp(["rwrwrwrw"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["uwuwuwuwuwuwuwuw"], x: 0, y: 11),
                    Stamp(["kk", "oo", "oo", "oo", "oo"], x: 0, y: 6),
                    Stamp(["ll"], x: 0, y: 5 - p % 3), Stamp(["l"], x: 1 - p % 2, y: 3 - p % 2),
                    Stamp([".l.", ".ll", "lcl", "lll", "lll"], x: 13, y: 6),
                    Stamp([p % 2 == 0 ? "w" : "c"], x: 14, y: 6),
                ] },
            ]),
    ]
}
