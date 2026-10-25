import Foundation

extension ClawdEditions {
    /// Batch 1: Characters. See ClawdEditionsCore.swift for the format.
    static let batch1: [ClawdEdition] = [

        ClawdEdition(
            id: "b1-detective", name: "Detective", collection: .characters,
            blurb: "Fedora, trench coat, and a pipe. The case is practically closed.",
            parts: [
                .init(.head) { _ in [Stamp([".nnnnnn."], x: 4, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2),
                                     Stamp(["nnnnnnnnnn"], x: 3, y: 2), Stamp(["nnnnnn"], x: 5, y: 0)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn", "nnnnnnnn"], x: 4, y: 7), Stamp(["l", "l"], x: 7, y: 7)] },
                .init(.face) { p in [Stamp(["nnn"], x: 8, y: 7), Stamp(["k"], x: 11, y: 7),
                                     Stamp(["l"], x: 12 + p % 2, y: 6 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b1-caped-hero", name: "Caped Hero", collection: .characters,
            blurb: "Mask, cape, and a chest emblem. Rescues pull requests from certain doom.",
            parts: [
                .init(.face) { _ in [Stamp(["rwrrrrwr"], x: 4, y: 4)] },
                .init(.back) { p in [Stamp(["rr", "rr", "rr", "rr"], x: 2, y: 4 + p % 2),
                                     Stamp(["rr", "rr", "rr", "rr"], x: 12, y: 4 + p % 2),
                                     Stamp(["rr", "rr"], x: 2, y: 8 + p % 2), Stamp(["rr", "rr"], x: 12, y: 8 + p % 2)] },
                .init(.head) { p in [Stamp(["rr"], x: 7, y: 2), Stamp([p % 2 == 0 ? "g" : "w"], x: 14, y: 1)] },
                .init(.hand) { _ in [Stamp(["gg", "gg"], x: 7, y: 7)] },
            ]),

        ClawdEdition(
            id: "b1-vampire", name: "Vampire Count", collection: .characters,
            blurb: "High collar, slicked hair, and a bat or two. Only works night shifts.",
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 2), Stamp(["k..k"], x: 6, y: 3)] },
                .init(.face) { _ in [Stamp(["w"], x: 6, y: 7), Stamp(["w"], x: 9, y: 7)] },
                .init(.back) { _ in [Stamp(["p.", "pp", "pp", "pp"], x: 2, y: 4), Stamp([".p", "pp", "pp", "pp"], x: 12, y: 4),
                                     Stamp(["rrrrrr"], x: 5, y: 8)] },
                .init(.aura, followsBody: false) { p in
                    p % 2 == 0 ? [Stamp(["k.k", ".k."], x: 0, y: 0)] : [Stamp(["kkk"], x: 0, y: 1)] },
            ]),

        ClawdEdition(
            id: "b1-pirate-captain", name: "Pirate Captain", collection: .characters,
            blurb: "Tricorn hat, eyepatch, and a parrot with strong opinions about the wi-fi.",
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkk"], x: 5, y: 1), Stamp(["kkkkkkkkkk"], x: 3, y: 2),
                                     Stamp(["w"], x: 7, y: 1), Stamp(["w"], x: 8, y: 1)] },
                .init(.face) { _ in [Stamp(["kk"], x: 9, y: 4), Stamp(["k"], x: 10, y: 3), Stamp(["k"], x: 8, y: 3)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r", "e"], x: 0, y: 3 + p % 2), Stamp(["o"], x: 1, y: 3 + p % 2)] },
                .init(.hand) { _ in [Stamp(["y", "y", "yy"], x: 14, y: 5)] },
            ]),

        ClawdEdition(
            id: "b1-samurai", name: "Samurai", collection: .characters,
            blurb: "Crested helmet, calm focus, and a blade that never needs a rebase.",
            parts: [
                .init(.head) { _ in [Stamp(["g....g"], x: 5, y: 0), Stamp([".g..g."], x: 5, y: 1),
                                     Stamp(["rrrrrrrr"], x: 4, y: 2), Stamp(["r", "r"], x: 3, y: 3), Stamp(["r", "r"], x: 12, y: 3)] },
                .init(.back) { _ in [Stamp(["rwrwrwrw"], x: 4, y: 7), Stamp(["rrrrrrrr"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["y", "y", "y", "y", "y", "y"], x: 14, y: 0), Stamp([p % 4 == 0 ? "l" : "w"], x: 14, y: p % 4),
                                     Stamp(["g"], x: 14, y: 6), Stamp(["n", "n"], x: 14, y: 7)] },
            ]),

        ClawdEdition(
            id: "b1-viking", name: "Viking", collection: .characters,
            blurb: "Horned helmet, braided beard, and a shield that has seen things.",
            parts: [
                .init(.head) { _ in [Stamp(["yyyyyyyy"], x: 4, y: 2), Stamp(["w"], x: 3, y: 2), Stamp(["w"], x: 3, y: 1), Stamp(["w"], x: 2, y: 0),
                                     Stamp(["w"], x: 12, y: 2), Stamp(["w"], x: 12, y: 1), Stamp(["w"], x: 13, y: 0)] },
                .init(.face) { _ in [Stamp(["oooooo", "oooooo", ".oooo."], x: 5, y: 6)] },
                .init(.hand) { p in [Stamp(["nnn", "ngn", "nnn"], x: 0, y: 5), Stamp([p % 2 == 0 ? "g" : "o"], x: 1, y: 6)] },
                .init(.back) { p in [Stamp(["o"], x: 6, y: 9 + p % 2), Stamp(["o"], x: 9, y: 9 + (p + 1) % 2)] },
            ]),

        ClawdEdition(
            id: "b1-knight", name: "Castle Knight", collection: .characters,
            blurb: "Plumed helm, silver plate, and a shield with a very bold cross.",
            parts: [
                .init(.head) { p in [Stamp(["rr"], x: 7, y: 1), Stamp([p % 2 == 0 ? "r." : ".r"], x: 7, y: 0),
                                     Stamp(["yyyyyyyy"], x: 4, y: 2), Stamp(["l"], x: 4 + p % 4, y: 2)] },
                .init(.face) { _ in [Stamp(["yy", "yy", "yy"], x: 7, y: 3)] },
                .init(.back) { _ in [Stamp(["yyyyyyyy", "yyyyyyyy"], x: 4, y: 7), Stamp(["l", "l"], x: 5, y: 7)] },
                .init(.hand) { _ in [Stamp(["xwx", "www", "xwx", ".x."], x: 13, y: 5)] },
            ]),

        ClawdEdition(
            id: "b1-cowboy", name: "Cowboy", collection: .characters,
            blurb: "Wide hat, red bandana, and a tumbleweed that follows the standup.",
            parts: [
                .init(.head) { _ in [Stamp([".nnnn."], x: 5, y: 0), Stamp(["nnnnnn"], x: 5, y: 1), Stamp(["nnnnnnnnnnnn"], x: 2, y: 2),
                                     Stamp(["gggggg"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["rrrrrr"], x: 5, y: 7), Stamp(["rrrr"], x: 6, y: 8)] },
                .init(.hand) { _ in [Stamp(["g", "g"], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["nn", "nn"], x: (p * 2) % 14, y: 10)] },
            ]),

        ClawdEdition(
            id: "b1-astronaut", name: "Astronaut", collection: .characters,
            blurb: "Bubble helmet, a tiny flag, and zero gravity to blame for the typos.",
            parts: [
                .init(.head) { p in [Stamp(["cccccccc"], x: 4, y: 2), Stamp(["c"], x: 3, y: 3), Stamp(["c"], x: 3, y: 4),
                                     Stamp(["c"], x: 12, y: 3), Stamp(["c"], x: 12, y: 4), Stamp(["y"], x: 11, y: 1),
                                     Stamp([p % 2 == 0 ? "r" : "h"], x: 11, y: 0)] },
                .init(.back) { _ in [Stamp(["rrrr"], x: 6, y: 7), Stamp(["wwww"], x: 6, y: 8)] },
                .init(.hand) { _ in [Stamp(["y", "y", "y", "y", "y", "y"], x: 14, y: 3), Stamp(["rr", "ww"], x: 14, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 2, y: 1), Stamp(["g"], x: 0, y: 6 - p % 3),
                                                         Stamp(["w"], x: 8, y: 0 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b1-secret-agent", name: "Secret Agent", collection: .characters,
            blurb: "Dark shades, sharp tuxedo, and a briefcase of very discreet gadgets.",
            parts: [
                .init(.face) { p in [Stamp(["kkkkkkkk"], x: 4, y: 4), Stamp(["w"], x: 5 + (p % 3) * 2, y: 4)] },
                .init(.back) { _ in [Stamp(["dddddddd", "dddddddd"], x: 4, y: 7), Stamp(["ww"], x: 7, y: 7), Stamp(["r"], x: 7, y: 7)] },
                .init(.head) { _ in [Stamp(["dddddd"], x: 5, y: 2)] },
                .init(.hand) { _ in [Stamp(["nnnn", "nyyn", "nnnn"], x: 12, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r"], x: 14 - p % 3, y: 2)] },
            ]),

        ClawdEdition(
            id: "b1-rock-star", name: "Rock Star", collection: .characters,
            blurb: "Pink mohawk, dark shades, and a guitar solo that nobody asked for.",
            parts: [
                .init(.head) { p in [Stamp(["h.hh.h"], x: 5, y: 0 + p % 2), Stamp(["hhhhhh"], x: 5, y: 1 + p % 2 - p % 2), Stamp(["hhhh"], x: 6, y: 2)] },
                .init(.face) { _ in [Stamp(["kk.kk"], x: 4, y: 4), Stamp(["kk"], x: 9, y: 4), Stamp(["kkkk"], x: 6, y: 4)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n"], x: 15, y: 2), Stamp(["rrr", "rrr", "rrr"], x: 13, y: 6),
                                     Stamp([p % 2 == 0 ? "w" : "g"], x: 14, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 0, y: 4 - p % 3), Stamp(["h"], x: 1, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b1-king", name: "King", collection: .characters,
            blurb: "A gold crown, an ermine robe, and a very large to-do list.",
            parts: [
                .init(.head) { p in [Stamp(["g.gg.g"], x: 5, y: 1), Stamp(["gggggggg"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "r" : "c"], x: 7, y: 2)] },
                .init(.back) { _ in [Stamp(["wkwkwkwk"], x: 4, y: 7), Stamp(["rrrrrrrr"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["g", "g", "g", "g", "g", "g"], x: 14, y: 4), Stamp([p % 2 == 0 ? "r" : "h"], x: 14, y: 3)] },
            ]),

        ClawdEdition(
            id: "b1-queen", name: "Queen", collection: .characters,
            blurb: "Tall tiara, a pink gem, and a rose. Rules with grace and unit tests.",
            parts: [
                .init(.head) { p in [Stamp(["g.g.g.g"], x: 4, y: 1), Stamp(["gggggggg"], x: 4, y: 2),
                                     Stamp(["g"], x: 7, y: 0), Stamp([p % 2 == 0 ? "h" : "w"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["rr"], x: 7, y: 6), Stamp(["h"], x: 4, y: 6), Stamp(["h"], x: 11, y: 6)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 7), Stamp(["pppppppp"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["e", "e", "e"], x: 14, y: 5), Stamp([p % 2 == 0 ? "r" : "h"], x: 14, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 2, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b1-mad-scientist", name: "Mad Scientist", collection: .characters,
            blurb: "Wild hair, goggles, a bubbling flask. It was only supposed to be a small experiment.",
            parts: [
                .init(.head) { p in [Stamp(["l.l.ll.l"], x: 4, y: 1), Stamp(["llllllll"], x: 4, y: 2), Stamp(["l"], x: 3, y: 3),
                                     Stamp(["l"], x: 12, y: 3), Stamp(["cc.cc"], x: 5, y: 2),
                                     Stamp([p % 2 == 0 ? "g" : "w"], x: p % 2 == 0 ? 2 : 13, y: 1)] },
                .init(.back) { _ in [Stamp(["wwwwwwww", "wwwwwwww"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp([".l.", "lel", "eee"], x: 13, y: 6), Stamp(["e"], x: 14, y: 5 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b1-mummy", name: "Mummy", collection: .characters,
            blurb: "Wrapped up in work and bandages. Tomb deadlines are brutal.",
            bodyColor: 0xDDD0AE,
            parts: [
                .init(.head) { _ in [Stamp(["l.l"], x: 6, y: 2), Stamp(["llllllll"], x: 4, y: 3)] },
                .init(.back) { _ in [Stamp(["llllllll"], x: 4, y: 5), Stamp(["llllllll"], x: 4, y: 7), Stamp(["l"], x: 4, y: 6)] },
                .init(.hand) { p in [Stamp(["l"], x: 2, y: 9 + p % 2), Stamp(["l"], x: 13, y: 9 + (p + 1) % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["n"], x: 0 + (p * 3) % 14, y: 11), Stamp(["g"], x: 14, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b1-caveman", name: "Caveman", collection: .characters,
            blurb: "Fur tunic, big club, and a small campfire. Invented the standup.",
            parts: [
                .init(.head) { _ in [Stamp(["nn.nn.nn"], x: 4, y: 2), Stamp(["w"], x: 12, y: 1), Stamp(["w"], x: 13, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnn", "nnnnnn"], x: 4, y: 7), Stamp([".nnnn."], x: 4, y: 8)] },
                .init(.hand) { _ in [Stamp(["nn", "nn", "n", "n", "n", "n"], x: 14, y: 3)] },
                .init(.aura, followsBody: false) { p in
                    p % 2 == 0 ? [Stamp([".g.", "ooo", "rrr"], x: 0, y: 9)] : [Stamp(["g.g", "oor", "rrr"], x: 0, y: 9)] },
            ]),

        ClawdEdition(
            id: "b1-ringmaster", name: "Ringmaster", collection: .characters,
            blurb: "Red coat, tall hat, and a curled mustache. Welcome to the greatest standup on earth.",
            parts: [
                .init(.head) { _ in [Stamp(["rrrr"], x: 6, y: 0), Stamp(["rrrr"], x: 6, y: 1), Stamp(["gggg"], x: 6, y: 1),
                                     Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["k.k"], x: 5, y: 6), Stamp(["k.k"], x: 8, y: 6)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr", "rrrrrrrr"], x: 4, y: 7), Stamp(["g", "g"], x: 6, y: 7), Stamp(["g", "g"], x: 9, y: 7)] },
                .init(.hand) { p in [Stamp(["g", "r", "w", "r", "w", "n"], x: 14, y: 3 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 1 + p % 2), Stamp(["g"], x: 0, y: 4 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b1-magician", name: "Magician", collection: .characters,
            blurb: "A top hat, a wand, and a rabbit that is absolutely not on payroll.",
            parts: [
                .init(.head) { p in [Stamp(["dddd"], x: 6, y: 1), Stamp(["dddddddd"], x: 4, y: 2), Stamp(["rrrr"], x: 6, y: 2),
                                     Stamp(["l"], x: 6 + p % 2, y: 0), Stamp(["l"], x: 9 - p % 2, y: 0)] },
                .init(.back) { _ in [Stamp(["pp", "pp", "pp", "pp"], x: 2, y: 5), Stamp(["pp", "pp", "pp", "pp"], x: 12, y: 5),
                                     Stamp(["pppppppp"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["w", "d", "d"], x: 14, y: 4), Stamp([p % 2 == 0 ? "g" : "w"], x: 15, y: 3 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b1-robot-butler", name: "Robot Butler", collection: .characters,
            blurb: "Monocle, bow tie, and a silver cloche. Your build will be served shortly.",
            bodyColor: 0xB8BEC8,
            parts: [
                .init(.head) { p in [Stamp(["y"], x: 7, y: 2), Stamp(["y"], x: 7, y: 1), Stamp([p % 2 == 0 ? "c" : "w"], x: 7, y: 0)] },
                .init(.face) { _ in [Stamp(["ggg", "g.g", "ggg"], x: 9, y: 3), Stamp(["g"], x: 11, y: 6), Stamp(["g"], x: 11, y: 7),
                                     Stamp(["r.r"], x: 6, y: 6), Stamp(["r"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["dddddddd", "dddddddd"], x: 4, y: 7), Stamp(["ww"], x: 7, y: 7)] },
                .init(.hand) { p in [Stamp([".w.", "lll", "yyy"], x: 13, y: 6), Stamp(["w"], x: 14, y: 4 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b1-shadow-ninja", name: "Shadow Ninja", collection: .characters,
            blurb: "Charcoal hood, red scarf, and a throwing star. You never saw the merge.",
            bodyColor: 0x4A4A55,
            parts: [
                .init(.face) { _ in [Stamp(["w"], x: 5, y: 4), Stamp(["w"], x: 10, y: 4)] },
                .init(.back) { p in [Stamp(["rrrrrrrr"], x: 4, y: 7), Stamp(["rrr"], x: 12, y: 7 + p % 2),
                                     Stamp(["rr"], x: 13, y: 8 + p % 2)] },
                .init(.head) { _ in [Stamp(["g"], x: 11, y: 2), Stamp(["y"], x: 12, y: 1), Stamp(["y"], x: 13, y: 0)] },
                .init(.aura, followsBody: false) { p in
                    p % 2 == 0 ? [Stamp([".l.", "lyl", ".l."], x: 0, y: 1)] : [Stamp(["l.l", ".y.", "l.l"], x: 0, y: 1)] },
            ]),
    ]
}
