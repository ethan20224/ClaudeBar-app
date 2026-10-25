import Foundation

extension ClawdEditions {
    /// Batch 11: Myths & Monsters and Prehistoric. See ClawdEditionsCore.swift for the format.
    static let batch11: [ClawdEdition] = [

        // MARK: Myths & Monsters

        ClawdEdition(
            id: "b11-kitsune", name: "Kitsune", collection: .myths,
            blurb: "Nine tails, a sly smile, and a little spirit fire for company.",
            bodyColor: 0xE8692E,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["wwww"], x: 6, y: 6), Stamp(["kk"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["B", "B", "w"], x: 14, y: p % 2 == 0 ? 5 : 4),
                                     Stamp(["B", "B"], x: 15, y: p % 2 == 0 ? 6 : 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["c"], x: 1, y: 1 + p % 3), Stamp(["c"], x: 14 - p % 2, y: 1 + (p + 1) % 3),
                    Stamp(["w"], x: 0, y: 4 + p % 2), Stamp(["c"], x: 15, y: 9 - p % 3),
                ] },
            ]),

        ClawdEdition(
            id: "b11-yeti", name: "Yeti", collection: .myths,
            blurb: "Big feet, bigger fluff, and shy of cameras since forever.",
            bodyColor: 0xE8EEF2,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww"], x: 4, y: 2), Stamp(["w.w"], x: 5, y: 1), Stamp(["w.w"], x: 8, y: 1)] },
                .init(.face) { p in [Stamp(["cc"], x: 6, y: 5), Stamp([p % 2 == 0 ? "kk" : "k."], x: 7, y: 7)] },
                .init(.back) { _ in [Stamp(["ww", "ww"], x: 2, y: 5), Stamp(["ww", "ww"], x: 12, y: 5)] },
                .init(.hand) { p in [Stamp(["ww", "ww"], x: 3, y: 10 + p % 2), Stamp(["ww", "ww"], x: 11, y: 10 + (p + 1) % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 4, y: 0), Stamp(["l"], x: 13 - p % 3, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b11-minotaur", name: "Minotaur", collection: .myths,
            blurb: "Horns down, nose ring on, and proud of every maze it solved.",
            bodyColor: 0x8A5A3C,
            parts: [
                .init(.head) { _ in [Stamp(["w.", "w."], x: 3, y: 1), Stamp([".w", ".w"], x: 11, y: 1),
                                     Stamp(["w"], x: 3, y: 0), Stamp(["w"], x: 12, y: 0)] },
                .init(.face) { p in [Stamp(["nnnn"], x: 6, y: 6), Stamp(["g"], x: 7 + p % 2, y: 8)] },
                .init(.back) { _ in [Stamp(["nn", "nn"], x: 2, y: 5), Stamp(["nn", "nn"], x: 12, y: 5)] },
                .init(.hand) { p in [Stamp(["w"], x: 14, y: 3), Stamp(["n", "n"], x: 14, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b11-medusa", name: "Medusa", collection: .myths,
            blurb: "A crown of snakes that never agree on a hairstyle. Eye contact optional.",
            bodyColor: 0x7FBF6A,
            parts: [
                .init(.head) { p in [
                    Stamp(["e.e.e.e.e.e"], x: 3, y: 2),
                    Stamp([p % 2 == 0 ? "e" : "."], x: 3, y: 1), Stamp([p % 2 == 0 ? "." : "e"], x: 6, y: 1),
                    Stamp([p % 2 == 0 ? "e" : "."], x: 9, y: 1), Stamp([p % 2 == 0 ? "." : "e"], x: 12, y: 1),
                    Stamp(["r"], x: 3, y: 0 + p % 2), Stamp(["r"], x: 12, y: 0 + (p + 1) % 2),
                ] },
                .init(.face) { _ in [Stamp(["yy"], x: 5, y: 4), Stamp(["yy"], x: 9, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 3 + p % 3), Stamp(["w"], x: 14, y: 5 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b11-cyclops", name: "Cyclops", collection: .myths,
            blurb: "One big eye, one big club, and surprisingly good depth perception.",
            bodyColor: 0x9CB86A,
            parts: [
                .init(.face) { p in [Stamp(["BBBB", "BBBB"], x: 5, y: 3), Stamp(["wwww", "wegw", p % 4 == 3 ? "wwww" : "wkkw", "wwww"], x: 6, y: 3)] },
                .init(.head) { _ in [Stamp(["nn"], x: 7, y: 2), Stamp(["dddd"], x: 6, y: 6)] },
                .init(.hand) { p in [Stamp(["nn", "nn", "n", "n", "n", "n"], x: 14, y: 1 + p % 2), Stamp(["d"], x: 14, y: 7 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b11-pegasus", name: "Pegasus", collection: .myths,
            blurb: "Cloud-white wings that flap just enough to look casual about flying.",
            bodyColor: 0xF2F4F8,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1), Stamp(["g"], x: 7, y: 1), Stamp(["g"], x: 7, y: 0)] },
                .init(.face) { _ in [Stamp(["hh"], x: 7, y: 6)] },
                .init(.back) { p in p % 2 == 0
                    ? [Stamp(["l.", "ll", "ll"], x: 1, y: 3), Stamp([".l", "ll", "ll"], x: 13, y: 3)]
                    : [Stamp(["ll", "ll", "l."], x: 0, y: 5), Stamp(["ll", "ll", ".l"], x: 14, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 0 + p % 3, y: 1), Stamp(["l"], x: 15 - p % 2, y: 0)] },
            ]),

        ClawdEdition(
            id: "b11-sphinx", name: "Sphinx", collection: .myths,
            blurb: "Asks one riddle per day. This week's: why does the build only fail on Fridays?",
            bodyColor: 0xD9B36A,
            parts: [
                .init(.head) { _ in [Stamp(["ugugugug"], x: 4, y: 2), Stamp(["u", "u"], x: 3, y: 3), Stamp(["u", "u"], x: 12, y: 3),
                                     Stamp(["g"], x: 7, y: 1)] },
                .init(.back) { _ in [Stamp(["BBBBBBBBBBBB"], x: 2, y: 9)] },
                .init(.hand) { p in [Stamp(["BB"], x: 0, y: 10), Stamp(["BB"], x: 14, y: 10), Stamp([p % 2 == 0 ? "y" : "g"], x: 15, y: 8)] },
                .init(.aura, followsBody: false) { _ in [Stamp([".y.", "yyy", "yyyyy"], x: 0, y: 8)] },
            ]),

        ClawdEdition(
            id: "b11-jackalope", name: "Jackalope", collection: .myths,
            blurb: "Part rabbit, part antelope, entirely a tall tale told around the campfire.",
            bodyColor: 0xC9A27A,
            parts: [
                .init(.head) { p in [Stamp(["Bh", "Bh", "Bh"], x: 5, y: 0), Stamp(p % 2 == 0 ? ["hB", "hB", "hB"] : ["hB", "hB", "BB"], x: 9, y: 0),
                                     Stamp(["n", "n"], x: 7, y: 1), Stamp(["n"], x: 6, y: 2), Stamp(["n"], x: 8, y: 2)] },
                .init(.face) { p in [Stamp([p % 2 == 0 ? "hh" : "h."], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["ww", "ww"], x: 14, y: 7)] },
            ]),

        ClawdEdition(
            id: "b11-werewolf", name: "Werewolf", collection: .myths,
            blurb: "A full moon, a fuzzy mood, and zero interest in the dress code.",
            bodyColor: 0x5A5F6B,
            parts: [
                .init(.head) { _ in [Stamp(["d.", "dd"], x: 4, y: 1), Stamp([".d", "dd"], x: 10, y: 1)] },
                .init(.face) { p in [Stamp(["yy"], x: 5, y: 4), Stamp(["yy"], x: 9, y: 4), Stamp(["dddd"], x: 6, y: 6),
                                     Stamp([p % 2 == 0 ? "w.w" : ".w."], x: 6, y: 7)] },
                .init(.back) { p in [Stamp(["d", "d", "d"], x: 14, y: 5), Stamp(["d"], x: 15, y: p % 2 == 0 ? 4 : 5)] },
                .init(.aura, followsBody: false) { p in [Stamp([".yy.", "yyyy", "yyyy", ".yy."], x: 0, y: 0), Stamp(["w"], x: 14, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b11-slime", name: "Slime", collection: .myths,
            blurb: "Wobbly, shiny, and always one drip away from a puddle.",
            bodyColor: 0x62D26F,
            parts: [
                .init(.head) { p in [Stamp(p % 2 == 0 ? ["BB"] : ["B"], x: 7, y: 2), Stamp(["w"], x: 5, y: 3)] },
                .init(.face) { p in [Stamp(["ww"], x: 6, y: 4 + p % 2), Stamp(["kk"], x: 7, y: 7)] },
                .init(.back) { p in [Stamp(["e", "e"], x: 3, y: 9 + p % 2), Stamp(["e"], x: 12, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e.e.e.e.e.e.e.e."], x: 0, y: 11), Stamp(["e"], x: 14, y: 8 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b11-zombie", name: "Zombie", collection: .myths,
            blurb: "Shuffles in slowly, groans about Mondays, and only wants a good brain-teaser.",
            bodyColor: 0x8FB08A,
            parts: [
                .init(.head) { _ in [Stamp(["dd"], x: 5, y: 2), Stamp(["d"], x: 10, y: 2)] },
                .init(.face) { p in [Stamp(["w"], x: 5, y: 4), Stamp(["k"], x: 10, y: 4), Stamp(["kkkk"], x: 6, y: 7),
                                     Stamp([p % 2 == 0 ? "r" : "."], x: 8, y: 8)] },
                .init(.hand) { p in [Stamp(["BBB"], x: 13, y: 4 - p % 2), Stamp(["B"], x: 15, y: 3 - p % 2)] },
                .init(.back) { _ in [Stamp(["dd", "d"], x: 4, y: 8), Stamp(["r"], x: 11, y: 7)] },
            ]),

        // MARK: Prehistoric

        ClawdEdition(
            id: "b11-trex", name: "T-Rex", collection: .prehistoric,
            blurb: "Terrifying teeth, tiny arms, and a tail that clears the room.",
            bodyColor: 0x6BA05A,
            parts: [
                .init(.face) { p in [Stamp(["w.w.w.w."], x: 4, y: 7), Stamp([p % 2 == 0 ? "kkkkkkkk" : "k.k.k.k."], x: 4, y: 8)] },
                .init(.head) { _ in [Stamp(["dd"], x: 4, y: 2), Stamp(["dd"], x: 10, y: 2)] },
                .init(.hand) { p in [Stamp(["B"], x: 2, y: 6 + p % 2), Stamp(["B"], x: 13, y: 6 + p % 2)] },
                .init(.back) { p in [Stamp(["BB", "BB", "B"], x: 13, y: 7), Stamp(["B"], x: 15, y: 9 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b11-triceratops", name: "Triceratops", collection: .prehistoric,
            blurb: "Three horns, one frill, and a very firm stance on personal space.",
            bodyColor: 0x8DA06A,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 1), Stamp(["rr", "rr"], x: 3, y: 2).self,
                                     Stamp(["rr"], x: 11, y: 2)] },
                .init(.face) { _ in [Stamp(["w"], x: 5, y: 2), Stamp(["w"], x: 10, y: 2), Stamp(["ww"], x: 7, y: 5), Stamp(["w"], x: 7, y: 4)] },
                .init(.back) { p in [Stamp(["B", "B"], x: 14, y: 7 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b11-stegosaurus", name: "Stegosaurus", collection: .prehistoric,
            blurb: "Back plates in a row, spikes on the tail, brain the size of a walnut.",
            bodyColor: 0x7FA861,
            parts: [
                .init(.head) { p in [Stamp(["o.o.o.o"], x: 5, y: 1), Stamp(["oo.oo.oo"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "o" : "."], x: 7, y: 0)] },
                .init(.face) { _ in [Stamp(["w.w"], x: 6, y: 7)] },
                .init(.back) { p in [Stamp(["B", "B"], x: 13, y: 8), Stamp(["w", "w"], x: 14, y: 8 + p % 2), Stamp(["w"], x: 15, y: 9)] },
            ]),

        ClawdEdition(
            id: "b11-pterodactyl", name: "Pterodactyl", collection: .prehistoric,
            blurb: "Wide wings, a pointy crest, and a swooping opinion of everything below.",
            bodyColor: 0xB07A5A,
            parts: [
                .init(.head) { _ in [Stamp(["n", "n"], x: 3, y: 1), Stamp(["nn"], x: 3, y: 2), Stamp(["o"], x: 7, y: 2)] },
                .init(.face) { _ in [Stamp(["oo"], x: 6, y: 6), Stamp(["o"], x: 7, y: 7)] },
                .init(.back) { p in p % 2 == 0
                    ? [Stamp(["nn", "nnn"], x: 0, y: 3), Stamp(["nn", "nnn"], x: 14, y: 3).self]
                    : [Stamp(["nnn", "nn"], x: 0, y: 6), Stamp(["nnn", "nn"], x: 13, y: 6)] },
            ]),

        ClawdEdition(
            id: "b11-mammoth", name: "Mammoth", collection: .prehistoric,
            blurb: "Shaggy coat, curved tusks, and a trunk that sniffs out snow.",
            bodyColor: 0x8A5E3F,
            parts: [
                .init(.head) { _ in [Stamp(["nn", "nn"], x: 4, y: 1), Stamp(["nn", "nn"], x: 10, y: 1), Stamp(["nnnnnnnn"], x: 4, y: 2)] },
                .init(.face) { p in [Stamp(["n", "n", "n", "n"], x: 7, y: 6), Stamp(["n"], x: 7 + p % 2, y: 10),
                                     Stamp(["w"], x: 5, y: 7), Stamp(["w"], x: 5, y: 8), Stamp(["w"], x: 10, y: 7), Stamp(["w"], x: 10, y: 8)] },
                .init(.back) { _ in [Stamp(["nn", "nn"], x: 2, y: 5), Stamp(["nn", "nn"], x: 12, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 4, y: 0), Stamp(["l"], x: 13 - p % 3, y: 1)] },
            ]),

        ClawdEdition(
            id: "b11-amber-fossil", name: "Amber Fossil", collection: .prehistoric,
            blurb: "Sealed in golden amber, a tiny bug keeping Clawd company for ages.",
            bodyColor: 0xE2A53A,
            parts: [
                .init(.face) { _ in [Stamp(["yy"], x: 4, y: 3), Stamp(["yy"], x: 10, y: 3)] },
                .init(.back) { p in [Stamp(["g", "g"], x: 3, y: 8), Stamp(["g", "g"], x: 12, y: 8),
                                     Stamp(["kk"], x: 7, y: 8 + p % 2), Stamp(["k"], x: 6, y: 7), Stamp(["k"], x: 9, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["y"], x: 1, y: 1 + p % 3), Stamp(["w"], x: 14 - p % 2, y: 2 + p % 2)] },
            ]),
    ]
}
