import Foundation

extension ClawdEditions {
    /// Batch 8: Animals. See ClawdEditionsCore.swift for the format.
    static let batch8: [ClawdEdition] = [

        ClawdEdition(
            id: "b8-bunny", name: "Bunny", collection: .animals,
            blurb: "Tall ears, twitchy nose, and a hop in every step.",
            bodyColor: 0xE3DAD0,
            parts: [
                .init(.head) { p in [Stamp(["Bh", "Bh", "Bh"], x: 5, y: 0),
                                     Stamp(p % 2 == 0 ? ["hB", "hB", "hB"] : ["hB", "hB", "BB"], x: 9, y: 0)] },
                .init(.face) { p in [Stamp([p % 2 == 0 ? "hh" : "h."], x: 7, y: 6), Stamp(["ww"], x: 7, y: 7)] },
                .init(.back) { _ in [Stamp(["ww", "ww"], x: 14, y: 7)] },
            ]),

        ClawdEdition(
            id: "b8-penguin", name: "Penguin", collection: .animals,
            blurb: "Dressed for dinner at all times, and very sure about the waddle.",
            bodyColor: 0x4A4A55,
            parts: [
                .init(.back) { _ in [Stamp(["wwww", "wwww", "wwww"], x: 6, y: 6),
                                     Stamp(["ww"], x: 5, y: 3), Stamp(["ww"], x: 9, y: 3)] },
                .init(.face) { _ in [Stamp(["oo"], x: 7, y: 5)] },
                .init(.hand) { p in [Stamp(["oo"], x: 3 + p % 2, y: 11), Stamp(["oo"], x: 10 - p % 2, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1 + (p % 3), y: 0), Stamp(["l"], x: 14 - (p % 2), y: 1)] },
            ]),

        ClawdEdition(
            id: "b8-frog", name: "Frog", collection: .animals,
            blurb: "Big eyes, bigger mouth, and a tongue that always finds the fly.",
            bodyColor: 0x5DB04A,
            parts: [
                .init(.head) { _ in [Stamp(["BB", "BB"], x: 4, y: 1), Stamp(["BB", "BB"], x: 10, y: 1),
                                     Stamp(["w", "w"], x: 5, y: 1), Stamp(["w", "w"], x: 10, y: 1)] },
                .init(.face) { p in [Stamp(["kkkkkk"], x: 5, y: 7),
                                     Stamp([p % 3 == 0 ? "rr" : ".."], x: 7, y: 8)] },
                .init(.back) { _ in [Stamp(["B", "B"], x: 3, y: 9), Stamp(["B", "B"], x: 12, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["k"], x: 14 - (p * 2) % 5, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b8-shark", name: "Shark", collection: .animals,
            blurb: "Fin out, teeth showing, and absolutely no small talk.",
            bodyColor: 0x7C93A8,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 7, y: 1), Stamp(["B"], x: 7, y: 0)] },
                .init(.face) { _ in [Stamp(["w.w.w.w."], x: 4, y: 7), Stamp(["kkkkkkkk"], x: 4, y: 8)] },
                .init(.back) { p in [Stamp(["l", "l"], x: 5, y: 7), Stamp(["B.", "BB", "B."], x: 14, y: p % 2 == 0 ? 5 : 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c.c.c.c.c.c.c.c."], x: p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b8-owl", name: "Owl", collection: .animals,
            blurb: "Wide eyes, ear tufts, and an opinion about your late-night commits.",
            bodyColor: 0xA37548,
            parts: [
                .init(.head) { _ in [Stamp(["B.B"], x: 4, y: 2), Stamp(["B"], x: 4, y: 1),
                                     Stamp(["B.B"], x: 9, y: 2), Stamp(["B"], x: 11, y: 1)] },
                .init(.face) { p in [Stamp(["ggg", p % 4 == 3 ? "ggg" : "gkg", "ggg"], x: 4, y: 3),
                                     Stamp(["ggg", p % 4 == 3 ? "ggg" : "gkg", "ggg"], x: 9, y: 3),
                                     Stamp(["oo"], x: 7, y: 5), Stamp(["o"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["l.l.l.", ".l.l.l"], x: 5, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b8-dino", name: "Dino", collection: .animals,
            blurb: "Back plates, a swishy tail, and an ancient love of snacks.",
            bodyColor: 0x6BBF59,
            parts: [
                .init(.head) { p in [Stamp(["o.o.o.o"], x: 5, y: 2), Stamp([p % 2 == 0 ? "o" : "."], x: 6, y: 1),
                                     Stamp([p % 2 == 0 ? "." : "o"], x: 8, y: 1)] },
                .init(.face) { _ in [Stamp(["w.w"], x: 6, y: 7)] },
                .init(.back) { p in [Stamp(["BB", "BBB"], x: 13, y: 7), Stamp(["BB"], x: 14 + p % 2, y: 9),
                                     Stamp(["o", "o"], x: 12, y: 5)] },
            ]),

        ClawdEdition(
            id: "b8-octopus", name: "Octopus", collection: .animals,
            blurb: "Eight arms, zero free hands. Somehow still multitasking.",
            bodyColor: 0xA66BD1,
            parts: [
                .init(.head) { _ in [Stamp(["BBBB"], x: 6, y: 2), Stamp(["BB"], x: 7, y: 1)] },
                                .init(.back) { p in [Stamp(p % 2 == 0 ? ["B.B.B.B.B.B."] : [".B.B.B.B.B.B"], x: 2, y: 11),
                                     Stamp(["B", "B"], x: 4, y: 9), Stamp(["B", "B"], x: 11, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 14, y: 5 - p % 4), Stamp(["c"], x: 1, y: 7 - (p + 2) % 4)] },
            ]),

        ClawdEdition(
            id: "b8-bear", name: "Bear", collection: .animals,
            blurb: "Round ears, honey on the mind, and a hug that ends arguments.",
            bodyColor: 0x9B6B43,
            parts: [
                .init(.head) { p in [Stamp(["BB", "BB"], x: 3, y: 1 + p % 2 * 0), Stamp(["BB", "BB"], x: 11, y: 1),
                                     Stamp(["n"], x: 4, y: 2), Stamp(["n"], x: 11, y: 2)] },
                .init(.face) { _ in [Stamp(["gggg", "gkkg"], x: 6, y: 6)] },
                .init(.back) { p in [Stamp(["B"], x: 14 - p % 2, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g", "g"], x: 1, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b8-lion", name: "Lion", collection: .animals,
            blurb: "A mane that enters the room first, and a very regal yawn.",
            bodyColor: 0xE0A33A,
            parts: [
                .init(.head) { p in [Stamp(["nnnnnnnn"], x: 4, y: 2), Stamp(["nn", "nn"], x: 3, y: 3),
                                     Stamp(["nn", "nn"], x: 11, y: 3), Stamp(["n"], x: 5 + p % 2 * 5, y: 1)] },
                .init(.face) { _ in [Stamp(["ww"], x: 7, y: 6), Stamp(["kk"], x: 7, y: 5)] },
                .init(.back) { p in [Stamp(["nnnnnnnn"], x: 4, y: 8), Stamp(["B", "B", "B"], x: 14, y: 6),
                                     Stamp(["n"], x: 14, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b8-elephant", name: "Elephant", collection: .animals,
            blurb: "Big ears, a trunk with a mind of its own, and a perfect memory.",
            bodyColor: 0xA9B4C2,
            parts: [
                .init(.head) { p in [Stamp(["BBB", "BhB", "BhB"], x: 1, y: p % 2 == 0 ? 3 : 2),
                                     Stamp(["BBB", "BhB", "BhB"], x: 12, y: p % 2 == 0 ? 3 : 2)] },
                .init(.face) { p in [Stamp(["yy", "yy", "yy"], x: 7, y: 6), Stamp([p % 2 == 0 ? "yy" : ".yy"], x: p % 2 == 0 ? 7 : 6, y: 9)] },
                .init(.back) { _ in [Stamp(["w"], x: 5, y: 7), Stamp(["w"], x: 10, y: 7), Stamp(["y"], x: 14, y: 8)] },
            ]),

        ClawdEdition(
            id: "b8-monkey", name: "Monkey", collection: .animals,
            blurb: "Banana radar, a curly tail, and zero respect for gravity.",
            bodyColor: 0x8B5A3C,
            parts: [
                .init(.head) { _ in [Stamp(["BB", "Bh"], x: 2, y: 3), Stamp(["BB", "hB"], x: 12, y: 3)] },
                .init(.face) { _ in [Stamp(["gggg", "gggg"], x: 6, y: 6), Stamp(["k.k"], x: 6, y: 6)] },
                .init(.back) { p in [Stamp(["B", "B", "B"], x: 14, y: 6), Stamp(["B"], x: 15, y: 5),
                                     Stamp(["B"], x: 14 + p % 2, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 10 - p % 2 * 0), Stamp(["n"], x: 1, y: 9)] },
            ]),

        ClawdEdition(
            id: "b8-pig", name: "Pig", collection: .animals,
            blurb: "Floppy ears, a snout for snacks, and a very curly opinion.",
            bodyColor: 0xF2A0B5,
            parts: [
                .init(.head) { _ in [Stamp(["BB", "B."], x: 4, y: 1), Stamp(["BB", ".B"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["rrrr", "krrk"], x: 6, y: 6)] },
                .init(.back) { p in [Stamp(["B"], x: 14, y: 7), Stamp(p % 2 == 0 ? ["B", ".B"] : [".B", "B"], x: 14, y: 5)] },
            ]),

        ClawdEdition(
            id: "b8-chicken", name: "Chicken", collection: .animals,
            blurb: "Red comb, orange beak, and a strong case for breakfast.",
            bodyColor: 0xE6E1D3,
            parts: [
                .init(.head) { p in [Stamp(["r.rr.r", "rrrrrr"], x: 5, y: 1 + p % 2 * 0)] },
                .init(.face) { _ in [Stamp(["oo"], x: 7, y: 5), Stamp(["r"], x: 7, y: 6)] },
                .init(.back) { p in [Stamp(["B", "BB"], x: 13, y: p % 2 == 0 ? 6 : 7), Stamp(["B"], x: 14, y: p % 2 == 0 ? 5 : 6),
                                     Stamp(["o"], x: 4, y: 10), Stamp(["o"], x: 6, y: 10), Stamp(["o"], x: 9, y: 10), Stamp(["o"], x: 11, y: 10)] },
            ]),

        ClawdEdition(
            id: "b8-cow", name: "Cow", collection: .animals,
            blurb: "Spots, horns, and a bell that announces every deploy.",
            bodyColor: 0xE6E1D3,
            parts: [
                .init(.head) { _ in [Stamp(["w", "w"], x: 4, y: 1), Stamp(["w", "w"], x: 11, y: 1),
                                     Stamp(["kk"], x: 2, y: 3), Stamp(["kk"], x: 12, y: 3)] },
                .init(.face) { _ in [Stamp(["hhhh", "hkhk"], x: 6, y: 6)] },
                .init(.back) { p in [Stamp(["kk", "kk"], x: 4, y: 5), Stamp(["kkk", "kk."], x: 9, y: 7),
                                     Stamp(["k", "k", "k"], x: 14, y: 5), Stamp(["k"], x: 14 + p % 2, y: 8)] },
            ]),

        ClawdEdition(
            id: "b8-sheep", name: "Sheep", collection: .animals,
            blurb: "A cloud of wool, a soft little face, and a calm that spreads.",
            bodyColor: 0xC8A98A,
            parts: [
                .init(.head) { p in [Stamp([".wwwwww."], x: 4, y: p % 2 == 0 ? 1 : 2), Stamp(["wwwwwwww"], x: 4, y: 2 + p % 2 * 0),
                                     Stamp(["d"], x: 3, y: 4), Stamp(["d"], x: 12, y: 4)] },
                .init(.back) { _ in [Stamp(["wwwwwwww", "wwwwwwww"], x: 4, y: 7), Stamp(["ww", "ww"], x: 2, y: 5), Stamp(["ww", "ww"], x: 12, y: 5),
                                     Stamp(["d", "d"], x: 4, y: 9), Stamp(["d", "d"], x: 6, y: 9), Stamp(["d", "d"], x: 9, y: 9), Stamp(["d", "d"], x: 11, y: 9)] },
            ]),

        ClawdEdition(
            id: "b8-giraffe", name: "Giraffe", collection: .animals,
            blurb: "Head in the clouds, spots on everything, and the best view in town.",
            bodyColor: 0xE8B84A,
            parts: [
                .init(.head) { p in [Stamp(["k", "B", "B"], x: 6, y: 0), Stamp(["k", "B", "B"], x: 9, y: 0),
                                     Stamp(["n", "n"], x: 3 - 0, y: 2), Stamp(["n"], x: 4, y: 2 + p % 2 * 0)] },
                .init(.face) { _ in [Stamp(["oooo", "okko"], x: 6, y: 6)] },
                .init(.back) { p in [Stamp(["nn", "nn"], x: 4, y: 5), Stamp(["nn", "n."], x: 9, y: 7), Stamp(["n"], x: 11, y: 4),
                                     Stamp(["B", "B", "B"], x: 14, y: 6), Stamp(["n"], x: 14, y: 8 + p % 2 * 0)] },
            ]),

        ClawdEdition(
            id: "b8-turtle", name: "Turtle", collection: .animals,
            blurb: "Slow, steady, and carrying the whole house on its back.",
            bodyColor: 0x8CC66B,
            parts: [
                .init(.back) { _ in [Stamp(["nnnnnnnn", "ngnnnngn", "nnggggnn"], x: 4, y: 6),
                                     Stamp(["B"], x: 14, y: 8)] },
                .init(.face) { p in [Stamp([p % 3 == 0 ? "kkkk" : "k..k"], x: 6, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 14, y: 3 - p % 3), Stamp(["c"], x: 1, y: 5 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b8-bee", name: "Bee", collection: .animals,
            blurb: "Stripes, a stinger, and a buzz that means business.",
            bodyColor: 0xF2C230,
            parts: [
                .init(.head) { p in [Stamp(["k", "k"], x: 5, y: 1), Stamp(["k", "k"], x: 10, y: 1),
                                     Stamp(["cc"], x: 6, y: p % 2 == 0 ? 0 : 1), Stamp(["cc"], x: 8, y: p % 2 == 0 ? 0 : 1)] },
                .init(.back) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 6), Stamp(["kkkkkkkk"], x: 4, y: 8),
                                     Stamp(["k"], x: 12, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 2 + p % 3), Stamp(["g"], x: 14, y: 6 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b8-butterfly", name: "Butterfly", collection: .animals,
            blurb: "Big painted wings and a quick flutter. Quite the transformation.",
            bodyColor: 0xB58BE0,
            parts: [
                .init(.head) { _ in [Stamp(["k", "."], x: 6, y: 1), Stamp(["k", "."], x: 9, y: 1)] },
                .init(.back) { p in p % 2 == 0
                    ? [Stamp(["ooo", "ooo", "ohh", "ohh", "ooo", ".oo"], x: 0, y: 1), Stamp(["ooo", "ooo", "hho", "hho", "ooo", "oo."], x: 13, y: 1)]
                    : [Stamp(["..o", ".oo", ".oh", ".oh", ".oo", "..o"], x: 1, y: 2), Stamp(["o..", "oo.", "ho.", "ho.", "oo.", "o.."], x: 14, y: 2)] },
            ]),

        ClawdEdition(
            id: "b8-bat", name: "Bat", collection: .animals,
            blurb: "Big ears, tiny fangs, and a strict nocturnal schedule.",
            bodyColor: 0x7A6A9C,
            parts: [
                .init(.head) { _ in [Stamp(["B", "B"], x: 4, y: 1), Stamp(["B", "B"], x: 11, y: 1)] },
                .init(.face) { _ in [Stamp(["w"], x: 6, y: 7), Stamp(["w"], x: 9, y: 7)] },
                .init(.back) { p in p % 2 == 0
                    ? [Stamp([".d", "dd", "ddd", "d.d"], x: 0, y: 3), Stamp(["d.", "dd", "ddd", "d.d"], x: 14, y: 3)]
                    : [Stamp(["dd", "ddd", "d.d"], x: 0, y: 5), Stamp(["dd", "ddd", "d.d"], x: 13, y: 5)] },
            ]),
    ]
}
