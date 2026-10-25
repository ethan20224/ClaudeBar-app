import Foundation

extension ClawdEditions {
    /// Batch 13: Music Scenes. See ClawdEditionsCore.swift for the format.
    static let batch13: [ClawdEdition] = [

        ClawdEdition(
            id: "b13-punk-mohawk", name: "Punk Mohawk", collection: .music,
            blurb: "A towering pink mohawk, safety pins, and three chords of attitude.",
            parts: [
                .init(.head) { p in [Stamp(["h", "h", "hh"], x: 7, y: 0 + p % 2), Stamp(["hh", "hh"], x: 7, y: 1 + p % 2 * 0),
                                     Stamp(["pp"], x: 7, y: 2)] },
                .init(.face) { _ in [Stamp(["l"], x: 3, y: 5), Stamp(["l"], x: 12, y: 5)] },
                .init(.back) { _ in [Stamp(["kkkkkkkk", "kkkkkkkk"], x: 4, y: 7), Stamp(["l.l.l.l."], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r"], x: 1 + p % 3, y: 1), Stamp(["g"], x: 14 - p % 2, y: 2)] },
            ]),

        ClawdEdition(
            id: "b13-metalhead", name: "Metalhead", collection: .music,
            blurb: "Black leather, a spiked collar, and hair that headbangs on its own.",
            bodyColor: 0x3A3A44,
            parts: [
                .init(.head) { p in [Stamp(["kkkkkkkk"], x: 4, y: 2), Stamp(["k", "k", "k"], x: 3, y: p % 2 == 0 ? 3 : 4),
                                     Stamp(["k", "k", "k"], x: 12, y: p % 2 == 0 ? 3 : 4)] },
                .init(.back) { _ in [Stamp(["l.l.l.l."], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["r", "r"], x: 14, y: p % 2 == 0 ? 2 : 3), Stamp(["r", "r"], x: 1, y: p % 2 == 0 ? 3 : 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 1, y: 8 - p % 3), Stamp(["g"], x: 14, y: 9 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b13-opera-diva", name: "Opera Diva", collection: .music,
            blurb: "Gold tiara, a pearl necklace, and a note that shatters glass.",
            parts: [
                .init(.head) { _ in [Stamp(["g.g.g.g"], x: 4, y: 1), Stamp(["gggggg"], x: 5, y: 2), Stamp(["r"], x: 7, y: 1)] },
                .init(.face) { p in [Stamp(["hh"], x: 5, y: 6), Stamp(["hh"], x: 9, y: 6),
                                     Stamp([p % 2 == 0 ? "kk" : "k"], x: 7, y: 7)] },
                .init(.back) { _ in [Stamp(["w.w.w.w."], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([".g", ".g", "gg"], x: 14, y: 6 - (p * 2) % 6)] },
            ]),

        ClawdEdition(
            id: "b13-jazz-sax", name: "Jazz Sax", collection: .music,
            blurb: "Shades, a beret, and a golden sax that smooths over every bug.",
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkk"], x: 5, y: 2), Stamp(["k"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["kkk"], x: 4, y: 4), Stamp(["kkk"], x: 9, y: 4), Stamp(["kk"], x: 7, y: 4)] },
                .init(.hand) { p in [Stamp(["g", "g", "g", "g"], x: 13, y: 5), Stamp(["gg", ".g"], x: 12, y: 9),
                                     Stamp([p % 2 == 0 ? "y" : "g"], x: 13, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 14, y: 3 - p % 3), Stamp(["p"], x: 1, y: 4 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b13-conductor", name: "Conductor", collection: .music,
            blurb: "Tails, a white bow tie, and a baton that commands the whole orchestra.",
            parts: [
                .init(.head) { _ in [Stamp(["kkkk"], x: 6, y: 1), Stamp(["kkkkkkkk"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["kkkkkkkk", "kkkkkkkk"], x: 4, y: 7), Stamp(["ww"], x: 7, y: 7), Stamp(["w", "w"], x: 5, y: 8),
                                     Stamp(["w", "w"], x: 10, y: 8)] },
                .init(.hand) { p in [Stamp(["l", "l", "l"], x: p % 2 == 0 ? 14 : 15, y: p % 2 == 0 ? 1 : 3), Stamp(["w"], x: 14, y: 4)] },
            ]),

        ClawdEdition(
            id: "b13-lofi-study", name: "Lo-fi Study", collection: .music,
            blurb: "Big headphones, a warm mug, and beats to relax and refactor to.",
            parts: [
                .init(.head) { _ in [Stamp(["dddddddd"], x: 4, y: 2), Stamp(["d", "d", "d"], x: 3, y: 3), Stamp(["d", "d", "d"], x: 12, y: 3),
                                     Stamp(["hh"], x: 2, y: 4), Stamp(["hh"], x: 12, y: 4)] },
                .init(.hand) { p in [Stamp(["nn", "nn"], x: 13, y: 9), Stamp(["c"], x: 13 + p % 2, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["p"], x: 1, y: 2 + p % 3), Stamp(["h"], x: 0, y: 7 - p % 2),
                                                         Stamp(["c"], x: 15, y: 1 + (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b13-beatboxer", name: "Beatboxer", collection: .music,
            blurb: "A bucket hat, a mic cupped tight, and a drum kit made of mouth.",
            parts: [
                .init(.head) { _ in [Stamp(["uuuuuu"], x: 5, y: 1), Stamp(["uuuuuuuuuu"], x: 3, y: 2)] },
                .init(.face) { p in [Stamp([p % 2 == 0 ? "kk" : "k"], x: 7, y: 6)] },
                .init(.hand) { _ in [Stamp(["dd", "dd"], x: 6, y: 8), Stamp(["l"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 14 - p % 3, y: 4), Stamp(["g"], x: 14 + p % 2, y: 6 - p % 3),
                                                         Stamp(["c"], x: 1, y: 3 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b13-idol-star", name: "Idol Star", collection: .music,
            blurb: "Sparkly stage outfit, a headset mic, and a fan club that never sleeps.",
            parts: [
                .init(.head) { _ in [Stamp(["hh"], x: 4, y: 2), Stamp(["hh"], x: 10, y: 2), Stamp(["kkkk"], x: 6, y: 2)] },
                .init(.face) { _ in [Stamp(["l", "l"], x: 3, y: 5), Stamp(["cc"], x: 3, y: 7)] },
                .init(.back) { p in [Stamp(["pwpwpwpw"], x: 4, y: 8), Stamp([p % 2 == 0 ? "g" : "w"], x: 3, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1 + p % 3, y: 0), Stamp(["h"], x: 14 - p % 2, y: 1 + p % 3),
                                                         Stamp(["w"], x: 0, y: 5 + p % 2)] },
            ]),
    ]

    /// Franchise 2: Movies. Silhouette and signature colors only, flagged trademarked.
    static let franchise2: [ClawdEdition] = [

        ClawdEdition(
            id: "fr-jurassic-park", name: "Jurassic Park", collection: .franchise,
            blurb: "Amber, a raptor claw, and a very large footprint rippling a water cup.",
            bodyColor: 0x6BA34B, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["o.o.o.o"], x: 5, y: 2)] },
                .init(.back) { p in [Stamp(["BB", "BBB"], x: 13, y: 7), Stamp(["g"], x: 14 + p % 2, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gg", "go"], x: 0, y: 0), Stamp(["r"], x: 14, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-back-to-the-future", name: "Back to the Future", collection: .franchise,
            blurb: "A puffy vest, a silver time machine, and fire trails at 88 miles per hour.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["yyyyyy"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 7), Stamp(["rrrrrrrr"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["oo"], x: 0, y: 11), Stamp(["rr"], x: 2 + p % 2, y: 11),
                                                         Stamp(["c"], x: 14 - p % 3, y: 0), Stamp(["yyy"], x: 13, y: 1)] },
            ]),

        ClawdEdition(
            id: "fr-ghostbusters", name: "Ghostbusters", collection: .franchise,
            blurb: "A khaki jumpsuit, a proton pack, and a friendly green slimer.",
            bodyColor: 0xB8A47A, trademarked: true,
            parts: [
                .init(.back) { _ in [Stamp(["yy", "yy", "yy"], x: 2, y: 5), Stamp(["rr"], x: 2, y: 5)] },
                .init(.hand) { p in [Stamp(["l", "l"], x: 14, y: 5), Stamp([p % 2 == 0 ? "o" : "r"], x: 15, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp([".ww.", "wkkw", "wwww", "w.w."], x: 0, y: 0 + p % 2),
                                                         Stamp(["ee", "ee"], x: 13, y: 0 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-the-matrix", name: "The Matrix", collection: .franchise,
            blurb: "Black coat, round shades, and green code falling through the dark.",
            bodyColor: 0x23282B, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["eeee"], x: 5, y: 4), Stamp(["eeee"], x: 9, y: 4)] },
                .init(.back) { _ in [Stamp(["kk", "kk", "kk"], x: 2, y: 8), Stamp(["kk", "kk", "kk"], x: 12, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e", "e"], x: 1, y: (p * 2) % 10), Stamp(["e"], x: 14, y: (p * 3) % 11),
                                                         Stamp(["e", "e", "e"], x: 15, y: (p * 2 + 4) % 9)] },
            ]),

        ClawdEdition(
            id: "fr-buzz-lightyear", name: "Buzz Lightyear", collection: .franchise,
            blurb: "White and green suit, purple trim, and wings out. To infinity.",
            bodyColor: 0xF4F4F4, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["pppppp"], x: 5, y: 2), Stamp(["eeee"], x: 6, y: 3)] },
                .init(.back) { p in [Stamp(["eeeeeeee"], x: 4, y: 8), Stamp(["ee", "pp"], x: 6, y: 6),
                                     Stamp([p % 2 == 0 ? "r" : "h"], x: 7, y: 7)] },
                .init(.hand) { p in [Stamp(["pp", "p."], x: 13, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-shrek", name: "Shrek", collection: .franchise,
            blurb: "Trumpet ears, a brown vest, and an onion with layers.",
            bodyColor: 0x8DB84A, trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["BB"], x: 2, y: 2 - p % 2), Stamp(["BB"], x: 12, y: 2 - p % 2),
                                     Stamp(["BB"], x: 7, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8), Stamp(["w", "w"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g.g"], x: 13, y: 9 + p % 2 * 0), Stamp(["ee"], x: 0, y: 10)] },
            ]),

        ClawdEdition(
            id: "fr-frozen-elsa", name: "Frozen Elsa", collection: .franchise,
            blurb: "An ice-blue gown, a side braid, and snow that obeys her.",
            bodyColor: 0xBFE3F5, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwww"], x: 5, y: 2), Stamp(["w", "w", "w"], x: 3, y: 3)] },
                .init(.back) { p in [Stamp(["c", "c", "c"], x: 12, y: 4), Stamp(["cccccccc"], x: 4, y: 8),
                                     Stamp(["w"], x: 12, y: 7 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 3, y: 1), Stamp(["l"], x: 14 - p % 2, y: 2 + p % 3),
                                                         Stamp(["c"], x: 0, y: 6 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-spider-man", name: "Spider-Man", collection: .franchise,
            blurb: "Red mask, blue suit, and a web line to the nearest rooftop.",
            bodyColor: 0xD9362B, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["www"], x: 4, y: 3), Stamp(["www"], x: 9, y: 3)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu"], x: 4, y: 8), Stamp(["k.k.k.k."], x: 4, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w", "w", "w"], x: 15, y: 0), Stamp(["w"], x: 14 - p % 2, y: 3),
                                                         Stamp(["w"], x: 13, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-batman", name: "Batman", collection: .franchise,
            blurb: "Pointed cowl, a long cape, and a yellow signal in the night sky.",
            bodyColor: 0x3B3F4A, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["k.", "kk"], x: 4, y: 1), Stamp([".k", "kk"], x: 10, y: 1)] },
                .init(.back) { p in [Stamp(["kk", "kkk"], x: 1, y: 7 + p % 2), Stamp(["kk", "kkk"], x: 13, y: 7 + p % 2),
                                     Stamp(["gg"], x: 7, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["yyyy", "gggg", "yyyy"], x: 12, y: 0), Stamp(["l"], x: 11 - p % 2, y: 3)] },
            ]),

        ClawdEdition(
            id: "fr-iron-man", name: "Iron Man", collection: .franchise,
            blurb: "Red and gold armor, a glowing chest reactor, and repulsor palms.",
            bodyColor: 0xC8312B, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["gggg"], x: 6, y: 5), Stamp(["cc"], x: 5, y: 4), Stamp(["cc"], x: 9, y: 4)] },
                .init(.back) { p in [Stamp(["g", "g"], x: 4, y: 7), Stamp(["g", "g"], x: 11, y: 7),
                                     Stamp([p % 2 == 0 ? "c" : "w"], x: 7, y: 7)] },
                .init(.hand) { p in [Stamp(["c"], x: 14, y: 5), Stamp([p % 2 == 0 ? "w" : "c"], x: 15, y: 5)] },
            ]),

        ClawdEdition(
            id: "fr-gandalf", name: "Gandalf", collection: .franchise,
            blurb: "A tall grey hat, a long beard, and a staff that says you shall not pass.",
            bodyColor: 0xA6A9B0, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["l"], x: 7, y: 0), Stamp(["ll"], x: 6, y: 1), Stamp(["llllllll"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["wwwwww", "wwwwww", ".wwww."], x: 5, y: 6)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n", "n", "n", "n"], x: 14, y: 3), Stamp([p % 2 == 0 ? "w" : "c"], x: 14, y: 2)] },
            ]),

        ClawdEdition(
            id: "fr-the-mandalorian", name: "The Mandalorian", collection: .franchise,
            blurb: "Beskar helmet with a T-shaped visor and a small green passenger.",
            bodyColor: 0x9EA3AB, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["kkkk", ".kk."], x: 6, y: 4), Stamp(["kkkkkk"], x: 5, y: 4)] },
                .init(.head) { _ in [Stamp(["yyyyyy"], x: 5, y: 2)] },
                .init(.back) { p in [Stamp(["nnn"], x: 2, y: 9), Stamp(["ee"], x: 13, y: 9 - p % 2), Stamp(["e.e"], x: 12, y: 8 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-darth-vader", name: "Darth Vader", collection: .franchise,
            blurb: "Black helm, a red saber, and very heavy breathing.",
            bodyColor: 0x1B1B20, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkk"], x: 5, y: 1), Stamp(["kkkkkkkk"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["ll"], x: 7, y: 6), Stamp(["yy"], x: 7, y: 7)] },
                .init(.back) { _ in [Stamp(["kk", "kk", "kk"], x: 2, y: 8), Stamp(["kk", "kk"], x: 12, y: 8)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "w" : "r", "r", "r", "r", "r"], x: 14, y: 0), Stamp(["d"], x: 14, y: 5)] },
            ]),

        ClawdEdition(
            id: "fr-minion", name: "Minion", collection: .franchise,
            blurb: "Yellow capsule, denim overalls, one big goggle, and a banana.",
            bodyColor: 0xF5D547, trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["k", "k"], x: 6, y: 1 + p % 2 * 0), Stamp(["k"], x: 9, y: 1), Stamp(["k"], x: 5, y: 2),
                                     Stamp(["k"], x: 10, y: 2)] },
                .init(.face) { _ in [Stamp(["yyyyyyyy"], x: 4, y: 3), Stamp(["wwww"], x: 6, y: 4), Stamp(["kk"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu", "uuuuuuuu"], x: 4, y: 7), Stamp(["uu"], x: 2, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g", "gg"], x: 14, y: 5 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-jaws", name: "Jaws", collection: .franchise,
            blurb: "A grey fin cutting the surface, and a theme you hear before you see.",
            bodyColor: 0x7C8FA0, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["B", "BB"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["w.w.w.w."], x: 4, y: 7), Stamp(["rrrrrrrr"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["cwcwcwcwcwcwcwcw"], x: 0 + p % 2 * 0, y: 11),
                                                         Stamp(["c"], x: 1 + p % 4, y: 9)] },
            ]),

        ClawdEdition(
            id: "fr-et", name: "E.T.", collection: .franchise,
            blurb: "Wrinkled brown friend, a glowing finger, and a bike in the moonlight.",
            bodyColor: 0x9B7A55, trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["BB"], x: 6, y: 1 + p % 2 * 0), Stamp(["B"], x: 5, y: 2), Stamp(["B"], x: 10, y: 2)] },
                .init(.hand) { p in [Stamp(["B", p % 2 == 0 ? "r" : "h"], x: 14, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 1 + p % 2), Stamp([".ww.", "wllw", ".ww."], x: 12, y: 0)] },
            ]),

        ClawdEdition(
            id: "fr-indiana-jones", name: "Indiana Jones", collection: .franchise,
            blurb: "Fedora, a leather jacket, a coiled whip, and a boulder behind him.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["nnnn"], x: 6, y: 1), Stamp(["nnnnnnnnnn"], x: 3, y: 2), Stamp(["k"], x: 6, y: 1)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 7), Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["n", "n"], x: 14, y: 6), Stamp([p % 2 == 0 ? "nn" : ".n"], x: 14, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["yy", "yy"], x: 0, y: 9 + p % 2 * 0), Stamp(["y"], x: 2, y: 8 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-jack-sparrow", name: "Jack Sparrow", collection: .franchise,
            blurb: "Tricorn hat, beaded braids, a red bandana, and the best pirate you have heard of.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 2), Stamp(["kk"], x: 7, y: 1), Stamp(["rrrr"], x: 6, y: 3)] },
                .init(.face) { _ in [Stamp(["kk"], x: 7, y: 6), Stamp(["n"], x: 6, y: 7), Stamp(["n"], x: 9, y: 7)] },
                .init(.back) { p in [Stamp(["g", "n", "g"], x: 3, y: 5 + p % 2), Stamp(["g", "n", "g"], x: 12, y: 5 + p % 2)] },
                .init(.hand) { p in [Stamp(["l", "l", "l"], x: 14, y: 2 + p % 2), Stamp(["g"], x: 14, y: 5)] },
            ]),

        ClawdEdition(
            id: "fr-wednesday", name: "Wednesday", collection: .franchise,
            blurb: "Two tight black braids, a white collar, and zero visible enthusiasm.",
            bodyColor: 0xDDD6CE, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 2), Stamp(["k", "k", "k", "k"], x: 3, y: 3),
                                     Stamp(["k", "k", "k", "k"], x: 12, y: 3)] },
                .init(.back) { p in [Stamp(["wwwwwwww"], x: 4, y: 7), Stamp(["kkkkkkkk"], x: 4, y: 8),
                                     Stamp(["k"], x: 3, y: 7 + p % 2), Stamp(["k"], x: 12, y: 7 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 1 + p % 3, y: 1), Stamp(["d"], x: 14, y: 4 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-mickey-mouse", name: "Mickey Mouse", collection: .franchise,
            blurb: "Big round ears, red shorts, yellow shoes, and white gloves.",
            bodyColor: 0x1E1E24, trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["kkk", "kkk"], x: 3, y: 0 + p % 2), Stamp(["kkk", "kkk"], x: 10, y: 0 + p % 2)] },
                .init(.face) { _ in [Stamp(["hhhhhh", "hhhhhh"], x: 5, y: 5), Stamp(["ww", "ww"], x: 5, y: 3), Stamp(["ww", "ww"], x: 9, y: 3)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["ww"], x: 2, y: 5 + p % 2), Stamp(["ww"], x: 12, y: 5 + p % 2)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["g"], x: 4, y: 11), Stamp(["g"], x: 6, y: 11), Stamp(["g"], x: 9, y: 11), Stamp(["g"], x: 11, y: 11)] },
            ]),

        ClawdEdition(
            id: "fr-stranger-things", name: "Stranger Things", collection: .franchise,
            blurb: "Blinking alphabet fairy lights, a stack of waffles, and red thunder from the Upside Down.",
            trademarked: true,
            parts: [
                .init(.head) { p in [
                    Stamp(["kkkkkkkk"], x: 4, y: 1),
                    Stamp([p % 2 == 0 ? "r.g.c.e." : "g.c.r.o."], x: 4, y: 2),
                ] },
                .init(.back) { _ in [Stamp(["uuhhhhuu", "hhhhhhhh"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["gy", "yg"], x: 14, y: 5 + p % 2)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["r", "r"], x: 1, y: 1 + p % 2),
                    Stamp([p % 2 == 0 ? "r" : "o"], x: 14, y: 2 - p % 2),
                    Stamp(["d"], x: 0 + p % 3, y: 10),
                ] },
            ]),
    ]
}
