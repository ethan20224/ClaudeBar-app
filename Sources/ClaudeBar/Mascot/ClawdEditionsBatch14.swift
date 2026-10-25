import Foundation

extension ClawdEditions {
    /// Batch 14: Video Games. See ClawdEditionsCore.swift for the format.
    static let batch14: [ClawdEdition] = [

        ClawdEdition(
            id: "b14-master-chief", name: "Master Chief", collection: .videoGames,
            blurb: "Olive Mjolnir armor, a mirrored gold visor, and a need for a weapon.",
            bodyColor: 0x4E6842, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["dddddd"], x: 5, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["gggggg", "ggyggg"], x: 5, y: 4)] },
                .init(.back) { _ in [Stamp(["dddddddd"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["d", "d", "c"], x: 14, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-doom-slayer", name: "Doom Slayer", collection: .videoGames,
            blurb: "Praetor helm, a glowing red Slayer mark, and heavy metal in the distance.",
            bodyColor: 0x3D5238, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["dddddd"], x: 5, y: 1), Stamp(["dddddddd"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["cccccc"], x: 5, y: 4)] },
                .init(.back) { _ in [Stamp(["eeeeeeee"], x: 4, y: 8), Stamp(["rr"], x: 3, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "r" : "o"], x: 14, y: 1 + p % 3), Stamp(["r"], x: 1, y: 9 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-god-of-war", name: "God of War", collection: .videoGames,
            blurb: "Ash-pale skin, a crimson tattoo stripe, a heavy beard, and twin chained blades.",
            bodyColor: 0xD8D4CE, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rr", "r."], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["r", "r"], x: 4, y: 4), Stamp(["kkkkkk", ".kkkk."], x: 5, y: 6)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["o", "r", "l"], x: 14, y: 3 + p % 2), Stamp(["o", "r", "l"], x: 1, y: 4 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-kirby", name: "Kirby", collection: .videoGames,
            blurb: "Round, pink, endlessly hungry, and riding a golden Warp Star.",
            bodyColor: 0xF598B6, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["h"], x: 4, y: 5), Stamp(["h"], x: 11, y: 5), Stamp(["r"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["rr"], x: 4, y: 10), Stamp(["rr"], x: 10, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp([".g.", "ggg", ".g."], x: 13, y: 1 + p % 2), Stamp(["w"], x: 1, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-mega-man", name: "Mega Man", collection: .videoGames,
            blurb: "Two-tone blue helmet, a charged arm cannon, and eight robot bosses to go.",
            bodyColor: 0x2E7CF6, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["cccccc"], x: 5, y: 1), Stamp(["uuuuccuuuu"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["cccccccc"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["uu", "uu"], x: 13, y: 5), Stamp([p % 2 == 0 ? "c" : "w"], x: 15, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 15, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b14-donkey-kong", name: "Donkey Kong", collection: .videoGames,
            blurb: "A swirled brown curl, a red monogrammed tie, and a wooden barrel ready to roll.",
            bodyColor: 0x7A4928, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["BB", "B."], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["yyyyyy"], x: 5, y: 6)] },
                .init(.back) { _ in [Stamp(["rr", "rg", "rr"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["nn", "yy", "nn"], x: 0, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-hollow-knight", name: "Hollow Knight", collection: .videoGames,
            blurb: "A pale horned shell, a tattered cloak, and a sharpened nail in hand.",
            bodyColor: 0xECEEF2, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["w.", "ww"], x: 4, y: 0), Stamp([".w", "ww"], x: 10, y: 0)] },
                .init(.back) { _ in [Stamp(["dddddddd", "d.d.d.d."], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["l", "l", "l", "d"], x: 14, y: 3 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 2, y: 2), Stamp(["l"], x: 13, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-sans", name: "Sans", collection: .videoGames,
            blurb: "Blue hoodie, pink slippers, a wide grin, and one flashing cyan eye.",
            bodyColor: 0xF0F2F5, trademarked: true,
            parts: [
                .init(.face) { p in [Stamp([p % 2 == 0 ? "c" : "y"], x: 10, y: 4), Stamp(["w.w.w."], x: 5, y: 6)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu"], x: 4, y: 7), Stamp(["llllllll"], x: 4, y: 6),
                                     Stamp(["hh"], x: 4, y: 10), Stamp(["hh"], x: 10, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 13 + p % 2, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-cuphead", name: "Cuphead", collection: .videoGames,
            blurb: "Porcelain rim, a bent red-and-white striped straw, and a finger-snap spark.",
            bodyColor: 0xEAEAEA, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rr", "ww", "r."], x: 4, y: 0), Stamp(["llllllll"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 8), Stamp(["ww", "ww"], x: 12, y: 4)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "c" : "g"], x: 14, y: 4)] },
            ]),

        ClawdEdition(
            id: "b14-cloud-strife", name: "Cloud Strife", collection: .videoGames,
            blurb: "Spiky golden hair, a single pauldron, and a Buster Sword taller than he is.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["g.gg.g"], x: 5, y: 0), Stamp(["gggggggg"], x: 4, y: 1), Stamp(["g.gggg.g"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["xxxxxxxx"], x: 4, y: 8), Stamp(["dd"], x: 3, y: 6)] },
                .init(.hand) { p in [Stamp(["ll", "ll", "ll", "ll", "ld", "gg", "n."], x: 14, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-ryu", name: "Ryu", collection: .videoGames,
            blurb: "White karate gi, a fluttering red headband, and a surging blue Hadouken.",
            trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["rrrrrrrr"], x: 4, y: 2), Stamp(p % 2 == 0 ? ["rr", ".r"] : ["r.", "rr"], x: 12, y: 2)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 7), Stamp(["kkkkkkkk"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["cw", "wc"], x: 14, y: 5 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 13 - p % 2, y: 4)] },
            ]),

        ClawdEdition(
            id: "b14-portal", name: "Portal", collection: .videoGames,
            blurb: "An orange portal above, a blue portal below, and a loyal Companion Cube.",
            trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["oooooo"], x: 5, y: 0 + p % 2)] },
                .init(.hand) { _ in [Stamp(["wwc"], x: 13, y: 5)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["cccccc"], x: 5, y: 11),
                    Stamp(["lhl", "hhh", "lhl"], x: 0, y: 8 - p % 2),
                ] },
            ]),

        ClawdEdition(
            id: "b14-skyrim-dragonborn", name: "Skyrim Dragonborn", collection: .videoGames,
            blurb: "Studded iron helm with curved horns and a Thu'um that shakes the mountains.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["y.", "yy"], x: 2, y: 1), Stamp([".y", "yy"], x: 12, y: 1),
                                     Stamp(["dddddddd"], x: 4, y: 2), Stamp(["dd"], x: 7, y: 3)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c.c"], x: 13, y: 4 + p % 2), Stamp(["w"], x: 15, y: 3)] },
            ]),

        ClawdEdition(
            id: "b14-sims-plumbob", name: "Sims Plumbob", collection: .videoGames,
            blurb: "A glowing green crystal hovering overhead. Mood: well rested and inspired.",
            trademarked: true,
            parts: [
                .init(.head) { p in [Stamp([".ee.", "eeee", ".ee."], x: 6, y: 0 + p % 2)] },
                .init(.back) { _ in [Stamp(["cccccccc"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "e" : "w"], x: 4, y: 1), Stamp([p % 2 == 0 ? "w" : "e"], x: 11, y: 1)] },
            ]),

        ClawdEdition(
            id: "b14-vault-boy", name: "Vault Boy", collection: .videoGames,
            blurb: "Wavy blonde hair, a blue and gold Vault jumpsuit, a Pip-Boy, and a thumbs up.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["gggggg"], x: 5, y: 1), Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["uuugguuu", "uuuuuuuu"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["de"], x: 2, y: 5), Stamp(["B"], x: 14, y: 4 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b14-elden-pot-boy", name: "Elden Ring Pot Boy", collection: .videoGames,
            blurb: "A round warrior jar sealed with red wax on top, ready for a friendly duel.",
            bodyColor: 0x9C8669, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rrrr"], x: 6, y: 1), Stamp(["yyyyyyyy"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["dddddddd"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["BB"], x: 1, y: 5 + p % 2), Stamp(["BB"], x: 13, y: 5 - p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 14, y: 1 + p % 2)] },
            ]),
    ]
}
