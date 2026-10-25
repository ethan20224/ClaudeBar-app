import Foundation

extension ClawdEditions {
    /// Batch 3: Around the World, part A (Asia, Middle East, Africa).
    static let batch3: [ClawdEdition] = [
        ClawdEdition(
            id: "b3-hanami", name: "Hanami", collection: .cultures,
            blurb: "Picnic under the cherry trees in Japan, where everyone watches the blossoms fall.",
            parts: [
                .init(.head) { _ in [Stamp(["n.n.n"], x: 6, y: 2), Stamp(["h.hh.h"], x: 5, y: 1), Stamp([".h..h."], x: 5, y: 0)] },
                .init(.back) { _ in [Stamp(["h", "w", "e"], x: 14, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: 1 + p % 4), Stamp(["w"], x: 14, y: 2 + (p + 2) % 4),
                                                         Stamp(["h"], x: 0, y: 6 + (p + 1) % 4), Stamp(["h"], x: 15, y: 7 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b3-matsuri", name: "Matsuri", collection: .cultures,
            blurb: "A happi coat, a headband, and a paper fan for the summer festival.",
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww"], x: 4, y: 2), Stamp(["r"], x: 7, y: 2), Stamp(["w"], x: 12, y: 3)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu", "uwuuuuwu"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp([".rr.", "rwwr", "rwwr", ".rr."], x: 12, y: p % 2 == 0 ? 6 : 5), Stamp(["n"], x: 13, y: p % 2 == 0 ? 10 : 9)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "o" : "g"], x: 1, y: 2), Stamp(["r"], x: 0, y: 3)] },
            ]),

        ClawdEdition(
            id: "b3-hanbok", name: "Hanbok Day", collection: .cultures,
            blurb: "A bright jacket with a ribbon bow and a classic black gat hat from Korea.",
            parts: [
                .init(.head) { _ in [Stamp(["kkkk"], x: 6, y: 0), Stamp(["kkkk"], x: 6, y: 1), Stamp(["kkkkkkkkkk"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["hhhhhhhh", "hhhhhhhh"], x: 4, y: 7), Stamp(["rr"], x: 5, y: 7), Stamp(["r"], x: 6, y: 8), Stamp(["g", "g"], x: 9, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "h" : "w"], x: 14, y: 1 + p % 3), Stamp(["h"], x: 1, y: 5 + (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b3-dragon-dance", name: "Dragon Dance", collection: .cultures,
            blurb: "Lion and dragon dancers bring luck at New Year parades. This one has a red head and a long tail.",
            parts: [
                .init(.head) { p in [Stamp(["g..g"], x: 5, y: 0), Stamp(["rggr"], x: 5, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "ww" : "w."], x: 3, y: 3), Stamp([p % 2 == 0 ? "ww" : ".w"], x: 11, y: 3)] },
                .init(.back) { p in [Stamp(["rgrg"], x: 12, y: p % 2 == 0 ? 9 : 8), Stamp(["rgrg"], x: 12, y: p % 2 == 0 ? 10 : 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 1 + p % 3), Stamp(["o"], x: 0, y: 4 + (p + 1) % 3), Stamp(["r"], x: 14, y: 1 + (p + 2) % 3)] },
            ]),

        ClawdEdition(
            id: "b3-mid-autumn", name: "Mid-Autumn", collection: .cultures,
            blurb: "Mooncakes, a glowing lantern, and a big bright full moon to share with family.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnn"], x: 6, y: 1), Stamp(["ngng"], x: 6, y: 2), Stamp(["g"], x: 7, y: 0)] },
                .init(.hand) { p in [Stamp(["n"], x: 1, y: 1), Stamp(["rr", "oo", "oo", "rr"], x: 0, y: 2), Stamp(["g"], x: p % 2 == 0 ? 0 : 1, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp([".ggg", "gogg", "gggg", ".gg."], x: 12, y: 0), Stamp([p % 2 == 0 ? "w" : "."], x: 11, y: 4),
                                                         Stamp([p % 2 == 0 ? "." : "w"], x: 15, y: 5)] },
            ]),

        ClawdEdition(
            id: "b3-holi", name: "Holi Colors", collection: .cultures,
            blurb: "The spring festival of colors, where friends toss bright powder and laugh.",
            parts: [
                .init(.head) { _ in [Stamp(["h.pp.c"], x: 5, y: 2), Stamp(["o..e"], x: 6, y: 1)] },
                .init(.face) { _ in [Stamp(["h"], x: 4, y: 6), Stamp(["c"], x: 11, y: 6), Stamp(["p"], x: 6, y: 8), Stamp(["o"], x: 9, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: 1 + p % 4), Stamp(["c"], x: 14, y: 1 + (p + 1) % 4),
                                                         Stamp(["o"], x: 0, y: 5 + (p + 2) % 4), Stamp(["p"], x: 15, y: 6 + p % 4),
                                                         Stamp(["e"], x: 2, y: 9 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b3-ankle-bells", name: "Ankle Bells", collection: .cultures,
            blurb: "Classical Indian dancers wear jingling ankle bells to keep time with the music.",
            parts: [
                .init(.head) { _ in [Stamp(["gggg"], x: 6, y: 2), Stamp(["g"], x: 7, y: 1), Stamp(["r"], x: 8, y: 1), Stamp(["hh"], x: 3, y: 2)] },
                .init(.back) { p in [Stamp(["g"], x: 4, y: 10), Stamp(["g"], x: 6, y: 10), Stamp(["g"], x: 9, y: 10), Stamp(["g"], x: 11, y: 10),
                                     Stamp([p % 2 == 0 ? "w" : "."], x: 3, y: 10), Stamp([p % 2 == 0 ? "." : "w"], x: 12, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 2 + p % 3), Stamp(["g"], x: 14, y: 3 + (p + 1) % 3), Stamp(["o"], x: 0, y: 8 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b3-songkran", name: "Songkran Splash", collection: .cultures,
            blurb: "Thai New Year means water fights, flower garlands, and cooling off together.",
            parts: [
                .init(.back) { _ in [Stamp(["ogwogwog"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["y..y", "yccy", "yyyy"], x: 12, y: 5), Stamp([p % 2 == 0 ? "c" : "."], x: 14, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 15, y: 3 + p % 3), Stamp(["c"], x: 14, y: 2 + (p + 1) % 3), Stamp(["c"], x: 1, y: 2 + p % 4),
                                                         Stamp(["w"], x: 0, y: 4 + (p + 2) % 4), Stamp(["c"], x: 2, y: 1 + (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b3-non-la", name: "Conical Hat", collection: .cultures,
            blurb: "The woven non la shades farmers and market sellers all over Vietnam.",
            parts: [
                .init(.head) { _ in [Stamp(["gg"], x: 7, y: 0), Stamp(["gggg"], x: 6, y: 1), Stamp(["gggggggg"], x: 4, y: 2), Stamp(["rr"], x: 3, y: 3), Stamp(["rr"], x: 11, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "e.e.e" : ".e.e.e"], x: 0, y: 11), Stamp([p % 2 == 0 ? ".e.e." : "e.e.e"], x: 10, y: 11),
                                                         Stamp(["g"], x: 14, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b3-parol", name: "Parol Star", collection: .cultures,
            blurb: "A glowing star lantern from the Philippines, hung up for the long Christmas season.",
            parts: [
                .init(.hand) { p in [Stamp(["..r.", ".rrr", "rrgr", ".rrr", "r..r"], x: 0, y: 0),
                                     Stamp([p % 2 == 0 ? "g" : "o"], x: 1, y: 5), Stamp(["r"], x: 1 + p % 2, y: 6)] },
                .init(.back) { _ in [Stamp(["g", "r"], x: 14, y: 0)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "grgr" : "rgrg"], x: 4, y: 0), Stamp([p % 2 == 0 ? "grg" : "rgr"], x: 9, y: 0),
                                                         Stamp([".g.", "ggg", ".g."], x: 13, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b3-gamelan", name: "Gamelan Night", collection: .cultures,
            blurb: "A batik shirt and a bronze gong, ready to play Indonesia's shimmering orchestra music.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnnnn"], x: 5, y: 2), Stamp(["g"], x: 7, y: 2)] },
                .init(.back) { _ in [Stamp(["nunuunun", "unnunnun"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["nnnn"], x: 12, y: 1), Stamp(["n.", "n."], x: 12, y: 2), Stamp(["n.", "n."], x: 15, y: 2),
                                     Stamp(["gg", "gg"], x: 13, y: p % 2 == 0 ? 4 : 3)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "g" : "."], x: 1, y: 3), Stamp([p % 2 == 0 ? "." : "g"], x: 0, y: 5),
                                                         Stamp([p % 2 == 0 ? "." : "g"], x: 1, y: 7)] },
            ]),

        ClawdEdition(
            id: "b3-tulip-tea", name: "Tulip Tea", collection: .cultures,
            blurb: "Tulips grew in old Turkish gardens, and tea comes in tiny waisted glasses.",
            parts: [
                .init(.head) { _ in [Stamp(["r.r"], x: 6, y: 0), Stamp(["rrr"], x: 6, y: 1), Stamp([".e."], x: 7, y: 2), Stamp(["e"], x: 5, y: 2)] },
                .init(.hand) { _ in [Stamp(["oo", "oo", ".o"], x: 13, y: 6), Stamp(["wwww"], x: 12, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 13 + p % 2, y: 4), Stamp(["l"], x: 14 - p % 2, y: 3), Stamp(["r"], x: 1, y: 10), Stamp(["e"], x: 1, y: 11)] },
            ]),

        ClawdEdition(
            id: "b3-nowruz", name: "Nowruz Table", collection: .cultures,
            blurb: "Persian New Year welcomes spring with green sprouts and a goldfish in a bowl.",
            parts: [
                .init(.head) { _ in [Stamp(["p.h.p"], x: 6, y: 2), Stamp([".p.h."], x: 6, y: 1)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e.e"], x: 0, y: 8 - p % 2), Stamp(["eee"], x: 0, y: 9), Stamp(["ggg"], x: 0, y: 10), Stamp([" g "], x: 0, y: 11),
                                                         Stamp([".c.c", "cocc", "cccc"], x: 12, y: 9), Stamp(["o"], x: p % 2 == 0 ? 13 : 14, y: 10),
                                                         Stamp(["e"], x: 14, y: 2 + p % 3), Stamp(["h"], x: 2, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b3-eid-lantern", name: "Eid Lantern", collection: .cultures,
            blurb: "Festive lanterns and twinkling stars light up the streets during Ramadan and Eid.",
            parts: [
                .init(.head) { _ in [Stamp(["g"], x: 7, y: 1), Stamp(["g"], x: 8, y: 2)] },
                .init(.hand) { p in [Stamp(["g"], x: 13, y: 2), Stamp(["ggg", "rwr", "rrr", "ggg"], x: 12, y: 3 + p % 2), Stamp(["g"], x: 13, y: 7 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gg.", "g..", "gg."], x: 0, y: 1), Stamp([p % 2 == 0 ? "w" : "."], x: 2, y: 4),
                                                         Stamp([p % 2 == 0 ? "." : "w"], x: 3, y: 0), Stamp([p % 2 == 0 ? "g" : "."], x: 15, y: 0)] },
            ]),

        ClawdEdition(
            id: "b3-fez-tea", name: "Fez and Mint Tea", collection: .cultures,
            blurb: "A red fez with a swinging tassel and a high-poured pot of sweet Moroccan mint tea.",
            parts: [
                .init(.head) { p in [Stamp(["rrrr"], x: 6, y: 1), Stamp(["rrrrrr"], x: 5, y: 2), Stamp(["k"], x: 6, y: 0), Stamp(["g"], x: p % 2 == 0 ? 11 : 10, y: 2),
                                     Stamp(["k"], x: p % 2 == 0 ? 11 : 10, y: 3)] },
                .init(.hand) { p in [Stamp([" y", "yyy", "yyy"], x: 12, y: 1), Stamp(["c"], x: 13, y: p % 2 == 0 ? 4 : 5), Stamp(["c"], x: 13, y: 6),
                                     Stamp(["w", "e"], x: 13, y: 7)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["cucucucuc"], x: 3, y: 11)] },
            ]),

        ClawdEdition(
            id: "b3-desert-explorer", name: "Desert Explorer", collection: .cultures,
            blurb: "A striped headcloth, a warm sun, and a little pyramid to go and discover.",
            parts: [
                .init(.head) { _ in [Stamp(["gugugugu"], x: 4, y: 2), Stamp(["ugug"], x: 6, y: 1), Stamp(["g", "u"], x: 3, y: 3), Stamp(["g", "u"], x: 12, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp([".g.", "ggg"], x: 0, y: 9), Stamp(["ggggg"], x: 0, y: 11),
                                                         Stamp([p % 2 == 0 ? "oo" : "o."], x: 14, y: 0), Stamp([p % 2 == 0 ? "oo" : ".o"], x: 14, y: 1),
                                                         Stamp([p % 2 == 0 ? "g" : "."], x: 13, y: 10)] },
            ]),

        ClawdEdition(
            id: "b3-kente-drum", name: "Kente and Drum", collection: .cultures,
            blurb: "A bold woven kente-style scarf and a talking drum that carries a whole conversation.",
            parts: [
                .init(.back) { _ in [Stamp(["rgeurgeu"], x: 4, y: 8), Stamp(["r", "g", "e"], x: 11, y: 9)] },
                .init(.hand) { p in [Stamp(["nnn", ".n.", "nnn"], x: 0, y: 6), Stamp(["rrr"], x: 0, y: 5), Stamp(["n"], x: 0 + p % 2 * 2, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "g" : "."], x: 1, y: 3), Stamp([p % 2 == 0 ? "." : "g"], x: 0, y: 2),
                                                         Stamp([p % 3 == 0 ? "o" : "."], x: 14, y: 3), Stamp(["g"], x: 15, y: 6 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b3-jebena", name: "Coffee Ceremony", collection: .cultures,
            blurb: "In Ethiopia, coffee is roasted and poured fresh from a clay jebena, with incense and friends.",
            parts: [
                .init(.back) { _ in [Stamp(["wwwwwwww", "wrwgwrwg"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp([".n", "nn", "nn", "nn"], x: 12, y: 5), Stamp(["n"], x: 13, y: 4), Stamp(["k"], x: 14, y: 5), Stamp(["l"], x: 13 + p % 2, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e.e.e.e"], x: 0, y: 11), Stamp([p % 2 == 0 ? "l" : "."], x: 1, y: 8), Stamp([p % 2 == 0 ? "." : "l"], x: 0, y: 7),
                                                         Stamp([p % 2 == 0 ? "l" : "."], x: 1, y: 6), Stamp(["g"], x: 2, y: 10)] },
            ]),

        ClawdEdition(
            id: "b3-safari-guide", name: "Safari Guide", collection: .cultures,
            blurb: "A wide hat, binoculars, and sharp eyes for spotting elephants on the Kenyan plains.",
            parts: [
                .init(.head) { _ in [Stamp(["gggg"], x: 6, y: 0), Stamp(["gnnng"], x: 5, y: 1), Stamp(["gggggggggg"], x: 3, y: 2)] },
                .init(.face) { _ in [Stamp(["kkk", "kck", "kkk"], x: 4, y: 3), Stamp(["kkk", "kck", "kkk"], x: 9, y: 3), Stamp(["kk"], x: 7, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["eeee"], x: 12, y: 8), Stamp([".n"], x: 13, y: 9), Stamp(["n"], x: 14, y: 10),
                                                         Stamp(["oo"], x: 0, y: p % 2), Stamp(["g"], x: 1, y: 11)] },
            ]),

        ClawdEdition(
            id: "b3-protea", name: "Protea Crown", collection: .cultures,
            blurb: "South Africa's national flower, a spiky pink protea, perched on top like a crown.",
            parts: [
                .init(.head) { p in [Stamp(["h.h..h.h"], x: 4, y: 0), Stamp(["hhwwwwhh"], x: 4, y: 1), Stamp(["hhhhhhhh"], x: 4, y: 2), Stamp([p % 2 == 0 ? "w" : "g"], x: 7, y: 0)] },
                .init(.back) { _ in [Stamp(["e", "e"], x: 3, y: 7), Stamp(["e", "e"], x: 12, y: 7), Stamp(["e"], x: 2, y: 8), Stamp(["e"], x: 13, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 2 + p % 3), Stamp(["o"], x: 14, y: 3 + (p + 1) % 3), Stamp(["h"], x: 0, y: 8 - p % 2)] },
            ]),
    ]
}
