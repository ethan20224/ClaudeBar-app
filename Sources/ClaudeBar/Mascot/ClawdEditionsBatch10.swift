import Foundation

extension ClawdEditions {
    /// Batch 10: Sports and Under the Sea. See ClawdEditionsCore.swift for the format.
    static let batch10: [ClawdEdition] = [

        // MARK: Sports

        ClawdEdition(
            id: "b10-striker", name: "Striker", collection: .sports,
            blurb: "Number nine jersey and a ball at the feet. Goal incoming.",
            parts: [
                .init(.back) { _ in [Stamp(["rrrrrrrr", "rrwwwwrr"], x: 4, y: 7)] },
                .init(.head) { _ in [Stamp(["rrrr"], x: 6, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ww", "wk"], x: 12 + p % 3, y: 10 - p % 2 * 0)] },
            ]),

        ClawdEdition(
            id: "b10-hoops", name: "Hoops", collection: .sports,
            blurb: "Headband on, ball up, and nothing but net.",
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 3)] },
                .init(.hand) { p in [Stamp(["oo", "oo"], x: 14, y: 6 - p % 3 * 2)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["wwww", "r..r"], x: 12, y: 0)] },
            ]),

        ClawdEdition(
            id: "b10-tennis-ace", name: "Tennis Ace", collection: .sports,
            blurb: "Visor down, racket ready, and a ball that never lands.",
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww", "..gggg.."], x: 4, y: 2)] },
                .init(.hand) { p in [Stamp(["gg", "gg", "n"], x: 14, y: p % 2 == 0 ? 3 : 4), Stamp(["n"], x: 14, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1 + (p * 3) % 12, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b10-surfer", name: "Surfer", collection: .sports,
            blurb: "Riding a wave and a good mood. Hang loose.",
            parts: [
                .init(.back) { p in [Stamp(["oooooooooooo"], x: 2, y: 10 - p % 2 * 0), Stamp(["o"], x: 14, y: 9)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["cwcwcwcwcwcwcwcw"], x: p % 2, y: 11), Stamp(["cc"], x: 0, y: 10), Stamp(["cc"], x: 14, y: 10 - p % 2),
                ] },
            ]),

        ClawdEdition(
            id: "b10-skater", name: "Skater", collection: .sports,
            blurb: "Backwards cap, a deck, and a trick that almost landed.",
            parts: [
                .init(.head) { _ in [Stamp(["uuuuuuuu"], x: 4, y: 2), Stamp(["uu"], x: 2, y: 3)] },
                .init(.back) { p in [Stamp(["nnnnnnnnnn"], x: 3, y: 11 - p % 2 * 0), Stamp(["kk"], x: 4, y: 11), Stamp(["kk"], x: 10, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 14 - p % 3, y: 10)] },
            ]),

        ClawdEdition(
            id: "b10-skier", name: "Skier", collection: .sports,
            blurb: "Goggles, a bobble hat, and a very fresh slope.",
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrr"], x: 5, y: 2), Stamp(["w"], x: 7, y: 1)] },
                .init(.face) { _ in [Stamp(["cccccccc"], x: 4, y: 4)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n"], x: 1, y: 5 + p % 2), Stamp(["n", "n", "n", "n"], x: 14, y: 5 + (p + 1) % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["wwwwwwwwwwwwwwww"], x: 0, y: 11), Stamp(["w"], x: 2 + (p * 4) % 12, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b10-boxer", name: "Boxer", collection: .sports,
            blurb: "Red gloves, quick feet, and a calm game face.",
            parts: [
                .init(.hand) { p in [Stamp(["rr", "rr"], x: p % 2 == 0 ? 0 : 1, y: 5), Stamp(["rr", "rr"], x: p % 2 == 0 ? 14 : 13, y: 5)] },
                .init(.back) { _ in [Stamp(["gggggggg"], x: 4, y: 8)] },
                .init(.head) { _ in [Stamp(["rrrr"], x: 6, y: 2)] },
            ]),

        ClawdEdition(
            id: "b10-cyclist", name: "Cyclist", collection: .sports,
            blurb: "Aero helmet, two wheels, and the wind at its back.",
            parts: [
                .init(.head) { _ in [Stamp([".yyyyyy.", "yyyyyyyy"], x: 4, y: 1)] },
                .init(.back) { p in [Stamp(["kkk", "k.k", "kkk"], x: 1, y: 9), Stamp(["kkk", "k.k", "kkk"], x: 12, y: 9),
                                     Stamp([p % 2 == 0 ? "d" : "l"], x: 2, y: 10), Stamp([p % 2 == 0 ? "l" : "d"], x: 13, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l.ll"], x: 0 + p % 3, y: 2), Stamp(["ll.l"], x: 12 - p % 3, y: 1)] },
            ]),

        ClawdEdition(
            id: "b10-golfer", name: "Golfer", collection: .sports,
            blurb: "Flat cap, one club, and a hole in one waiting to happen.",
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww", "ww......ww"], x: 4, y: 2)] },
                .init(.hand) { p in [Stamp(["l", "l", "l", "l", "l", "l"], x: 14, y: 4 + p % 2), Stamp(["l"], x: 15, y: 10)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["e", "e", "e"], x: 0, y: 9), Stamp(["ww"], x: 1, y: 9)] },
            ]),

        ClawdEdition(
            id: "b10-climber", name: "Climber", collection: .sports,
            blurb: "Helmet, rope, and a summit that is closer than it looks.",
            parts: [
                .init(.head) { _ in [Stamp(["oooooooo"], x: 4, y: 2), Stamp(["oooo"], x: 6, y: 1)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["g", "g", "g", "g"], x: 14, y: p % 2 == 0 ? 3 : 2), Stamp(["g"], x: 15, y: 1)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["l", "ll", "lll", "llll"], x: 0, y: 8)] },
            ]),

        ClawdEdition(
            id: "b10-weightlifter", name: "Weightlifter", collection: .sports,
            blurb: "Heavy plates and a heavier grin. Never skips arm day.",
            parts: [
                .init(.hand) { p in [Stamp(["dddddddddddddddd"], x: 0, y: 1 + p % 2),
                                     Stamp(["dd", "dd", "dd"], x: 0, y: p % 2), Stamp(["dd", "dd", "dd"], x: 14, y: p % 2)] },
                .init(.back) { _ in [Stamp(["rr"], x: 6, y: 8)] },
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 3)] },
            ]),

        ClawdEdition(
            id: "b10-goalie", name: "Goalie", collection: .sports,
            blurb: "Big gloves, wide stance, and nothing gets past.",
            parts: [
                .init(.hand) { p in [Stamp(["gg", "gg", "gg"], x: 0, y: 4 + p % 2 * 2), Stamp(["gg", "gg", "gg"], x: 14, y: 6 - p % 2 * 2)] },
                .init(.back) { _ in [Stamp(["gggggggg"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["l.l.l.l.l.l.l.l."], x: 0, y: 0)] },
            ]),

        // MARK: Under the Sea

        ClawdEdition(
            id: "b10-crab-cousin", name: "Crab Cousin", collection: .sea,
            blurb: "Sideways walker with two big claws and a lot to say.",
            bodyColor: 0xE8553D,
            parts: [
                .init(.head) { _ in [Stamp(["B", "B"], x: 5, y: 1), Stamp(["B", "B"], x: 10, y: 1), Stamp(["w"], x: 5, y: 1), Stamp(["w"], x: 10, y: 1)] },
                .init(.hand) { p in [Stamp(["BB", "B."], x: 0, y: p % 2 == 0 ? 3 : 4), Stamp(["BB", ".B"], x: 14, y: p % 2 == 0 ? 4 : 3)] },
                .init(.back) { p in [Stamp(p % 2 == 0 ? ["B.B.B.B.B.B."] : [".B.B.B.B.B.B"], x: 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b10-lobster", name: "Lobster", collection: .sea,
            blurb: "Bright red shell and snappy claws. Dinner has other plans.",
            bodyColor: 0xD9362B,
            parts: [
                .init(.head) { _ in [Stamp(["w.w"], x: 4, y: 2), Stamp(["l", "l"], x: 6, y: 0), Stamp(["l", "l"], x: 9, y: 0)] },
                .init(.hand) { p in [Stamp(["BB", "BB"], x: 0, y: 3 + p % 2), Stamp(["BB", "BB"], x: 14, y: 4 - p % 2),
                                     Stamp(["k"], x: p % 2 == 0 ? 1 : 0, y: 3)] },
                .init(.back) { _ in [Stamp(["BBB", "BB.", "B.."], x: 13, y: 8)] },
            ]),

        ClawdEdition(
            id: "b10-jellyfish", name: "Jellyfish", collection: .sea,
            blurb: "Soft glow, trailing tentacles, and no particular plans.",
            bodyColor: 0xE59BD0,
            parts: [
                .init(.head) { p in [Stamp(["BBBBBB"], x: 5, y: 2), Stamp(["BBBB"], x: 6, y: 1), Stamp([p % 2 == 0 ? "w" : "h"], x: 7, y: 1)] },
                .init(.back) { p in [Stamp(p % 2 == 0 ? ["B.B.B.B.", ".B.B.B.B"] : [".B.B.B.B", "B.B.B.B."], x: 4, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: 8 - p % 4), Stamp(["c"], x: 14, y: 3 + p % 4)] },
            ]),

        ClawdEdition(
            id: "b10-pufferfish", name: "Pufferfish", collection: .sea,
            blurb: "Puffs up when startled. Looks twice as brave, honestly.",
            bodyColor: 0xE3C06A,
            parts: [
                .init(.head) { p in [Stamp(["B", "B"], x: p % 2 == 0 ? 3 : 2, y: 5), Stamp(["B", "B"], x: p % 2 == 0 ? 12 : 13, y: 5),
                                     Stamp(["n", "n"], x: 5, y: 2), Stamp(["n", "n"], x: 10, y: 2), Stamp(["n"], x: 7, y: 2), Stamp(["n"], x: 8, y: 2)] },
                .init(.face) { _ in [Stamp(["oo"], x: 7, y: 6), Stamp(["ww"], x: 6, y: 8), Stamp(["ww"], x: 8, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 14, y: 2 + p % 3), Stamp(["c"], x: 1, y: 3 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b10-seahorse", name: "Seahorse", collection: .sea,
            blurb: "Curly tail, little snout, and a very gentle hover.",
            bodyColor: 0xF2B84B,
            parts: [
                .init(.face) { _ in [Stamp(["nn", "nn"], x: 1, y: 5), Stamp(["n"], x: 7, y: 6)] },
                .init(.head) { _ in [Stamp(["o.o.o"], x: 5, y: 2), Stamp(["o"], x: 7, y: 1)] },
                .init(.back) { p in [Stamp(["BB", ".B", "BB"], x: 13, y: 7), Stamp(["B"], x: 14 + p % 2, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e", "e"], x: 1, y: 8 - p % 3), Stamp(["c"], x: 0, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b10-anglerfish", name: "Anglerfish", collection: .sea,
            blurb: "Lights its own way through the deep, with a grin to match.",
            bodyColor: 0x4B4A66,
            parts: [
                .init(.head) { p in [Stamp(["l", "l"], x: 8, y: 1), Stamp(["yyy"], x: 8, y: 0), Stamp([p % 2 == 0 ? "g" : "w"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["w.w.w.w.w"], x: 4, y: 7), Stamp(["kkkkkkkk"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 11 + p % 3, y: 0), Stamp(["l"], x: 1, y: 1 + p % 4)] },
            ]),

        ClawdEdition(
            id: "b10-narwhal", name: "Narwhal", collection: .sea,
            blurb: "The unicorn of the sea, tusk first and unbothered.",
            bodyColor: 0x8FB4D9,
            parts: [
                .init(.head) { _ in [Stamp(["w", "w"], x: 1, y: 2), Stamp(["g"], x: 0, y: 1), Stamp(["w"], x: 2, y: 3)] },
                .init(.face) { _ in [Stamp(["l.l"], x: 6, y: 7)] },
                .init(.back) { p in [Stamp(["B.B"], x: 13, y: p % 2 == 0 ? 7 : 6), Stamp(["B"], x: 14, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["cwcwcwcwcwcwcwcw"], x: p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b10-whale", name: "Whale", collection: .sea,
            blurb: "Big, calm, and humming something low. Spouts when happy.",
            bodyColor: 0x4F7FB8,
            parts: [
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8), Stamp(["BB", ".B", "BB"], x: 13, y: 6)] },
                .init(.head) { p in [Stamp(["c", "c"], x: 7 + p % 2, y: 1 - 0), Stamp(["c.c"], x: 6, y: 0 + p % 2 * 0)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 4 + p % 3, y: 0), Stamp(["cwcwcwcwcwcwcwcw"], x: p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b10-clownfish", name: "Clownfish", collection: .sea,
            blurb: "Orange with white stripes, at home in any anemone.",
            bodyColor: 0xF28C28,
            parts: [
                .init(.face) { _ in [Stamp(["w", "w", "w", "w"], x: 6, y: 3), Stamp(["w", "w", "w", "w"], x: 10, y: 3),
                                     Stamp(["w", "w"], x: 3, y: 5)] },
                .init(.head) { p in [Stamp(["B", "B"], x: 7, y: 1 + p % 2 * 0), Stamp(["B"], x: 8, y: 2)] },
                .init(.back) { p in [Stamp(["BB", ".B"], x: 14, y: p % 2 == 0 ? 6 : 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["p.p.p.p.p"], x: 3, y: 11), Stamp(["h"], x: 4 + p % 2 * 2, y: 10)] },
            ]),

        ClawdEdition(
            id: "b10-starfish", name: "Starfish", collection: .sea,
            blurb: "Five arms, no worries, and a beach all to itself.",
            bodyColor: 0xF0804F,
            parts: [
                .init(.head) { _ in [Stamp(["B", "B"], x: 7, y: 1), Stamp(["B", "B"], x: 8, y: 1)] },
                .init(.hand) { p in [Stamp(["BB"], x: 0, y: 4 + p % 2), Stamp(["BB"], x: 14, y: 4 + p % 2)] },
                .init(.back) { p in [Stamp(["BB"], x: 3, y: 10 + p % 2 * 0), Stamp(["BB"], x: 11, y: 10), Stamp(["g", "g"], x: 7, y: 6)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["yyyyyyyyyyyyyyyy"], x: 0, y: 11)] },
            ]),
    ]
}
