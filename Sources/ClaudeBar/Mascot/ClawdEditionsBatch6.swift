import Foundation

extension ClawdEditions {
    /// Batch 6: Food and drink. See ClawdEditionsCore.swift for the format.
    static let batch6: [ClawdEdition] = [

        ClawdEdition(
            id: "b6-donut", name: "Donut", collection: .food,
            blurb: "Pink icing, rainbow sprinkles, and a hole where the worries go.",
            bodyColor: 0xF08CB0,
            parts: [
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8), Stamp(["n", "n"], x: 3, y: 7), Stamp(["n", "n"], x: 12, y: 7)] },
                .init(.face) { p in [Stamp(["c", "g"], x: 6, y: 3), Stamp(["w"], x: 9, y: 3), Stamp(["g"], x: 4, y: 6),
                                     Stamp(["u"], x: 11, y: 6), Stamp(["w"], x: 7, y: 7), Stamp(["g"], x: 9, y: 7), Stamp(["c"], x: 5, y: 7),
                                     Stamp(["d", "d"], x: 7, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: p % 2 == 0 ? 1 : 14, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b6-nigiri", name: "Salmon Nigiri", collection: .food,
            blurb: "A silky slice over a pillow of rice, with a dab of wasabi for courage.",
            bodyColor: 0xF48A63,
            parts: [
                .init(.face) { _ in [Stamp(["w", "w"], x: 6, y: 6), Stamp(["w", "w"], x: 9, y: 6), Stamp(["w"], x: 7, y: 7), Stamp(["w"], x: 8, y: 3)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8), Stamp(["wwwwwwwwww"], x: 3, y: 9), Stamp(["wwwwwwwwww"], x: 3, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ee", "ee"], x: 14, y: 9), Stamp(["k"], x: 1, y: 8 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b6-taco", name: "Taco", collection: .food,
            blurb: "Crunchy shell, fresh lettuce, and zero regrets on Tuesday.",
            bodyColor: 0xF2BE4A,
            parts: [
                .init(.head) { p in [Stamp(["e.ee.ee."], x: 4, y: 2), Stamp(["eeeeeeee"], x: 4, y: 1), Stamp(["r", "r"], x: 6 + p % 2, y: 0), Stamp(["g"], x: 10, y: 1)] },
                .init(.back) { _ in [Stamp(["oooooooo"], x: 4, y: 8), Stamp(["o"], x: 3, y: 7), Stamp(["o"], x: 12, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1 + p % 2, y: 10), Stamp(["e"], x: 13 + p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b6-boba", name: "Boba Tea", collection: .food,
            blurb: "Milk tea, a fat straw, and pearls that always know where you are.",
            bodyColor: 0xD9B98C,
            parts: [
                .init(.head) { _ in [Stamp(["llllllll"], x: 4, y: 2), Stamp(["h"], x: 9, y: 1), Stamp(["h"], x: 10, y: 0)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "k.k.k.k." : ".k.k.k.k"], x: 4, y: 7),
                                     Stamp([p % 2 == 0 ? ".k.k.k.k" : "k.k.k.k."], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 13, y: 8 - p % 3), Stamp(["c"], x: 1, y: 6 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b6-ice-cream", name: "Ice Cream Cone", collection: .food,
            blurb: "Strawberry scoop, a cherry on top, and a race against the sun.",
            bodyColor: 0xF5A3C0,
            parts: [
                .init(.head) { p in [Stamp(["r"], x: 7, y: 2), Stamp([p % 2 == 0 ? "n" : "."], x: 8, y: 1), Stamp(["hh"], x: 3, y: 2), Stamp(["hh"], x: 11, y: 2)] },
                .init(.back) { _ in [Stamp(["gggggggg"], x: 4, y: 8), Stamp(["ogogogo"], x: 4, y: 9), Stamp(["ogogo"], x: 5, y: 10), Stamp(["go"], x: 7, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: p % 2 == 0 ? 12 : 13, y: 9 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b6-burger", name: "Cheeseburger", collection: .food,
            blurb: "Sesame bun, melty cheese, and a stack taller than the plan.",
            bodyColor: 0x8C4A2A,
            parts: [
                .init(.head) { _ in [Stamp(["oooooooo"], x: 4, y: 2), Stamp(["oooooo"], x: 5, y: 1), Stamp(["w", "w"], x: 6, y: 1), Stamp(["w"], x: 9, y: 2)] },
                .init(.back) { p in [Stamp(["eeeeeeee"], x: 4, y: 7), Stamp(["gggggggg"], x: 4, y: 8), Stamp(["g"], x: p % 2 == 0 ? 5 : 6, y: 9), Stamp(["oooooooo"], x: 4, y: 11)] },
                .init(.face) { _ in [Stamp(["r.r"], x: 6, y: 6)] },
            ]),

        ClawdEdition(
            id: "b6-hot-dog", name: "Hot Dog", collection: .food,
            blurb: "Snug in its bun with a zigzag of mustard. A ballpark classic.",
            bodyColor: 0xC75A3E,
            parts: [
                .init(.back) { _ in [Stamp(["g", "g", "g", "g", "g", "g"], x: 3, y: 3), Stamp(["g", "g", "g", "g", "g", "g"], x: 12, y: 3),
                                     Stamp(["gggggggggg"], x: 3, y: 9)] },
                .init(.face) { p in [Stamp(p % 2 == 0 ? ["g.g.g.g."] : [".g.g.g.g"], x: 4, y: 6)] },
                .init(.head) { _ in [Stamp(["oooooooo"], x: 4, y: 2)] },
            ]),

        ClawdEdition(
            id: "b6-ramen", name: "Ramen Bowl", collection: .food,
            blurb: "Slurp-ready noodles, a soft egg, and steam that smells like home.",
            bodyColor: 0xE8A33D,
            parts: [
                .init(.head) { _ in [Stamp(["g.g.g.g.", "gggggggg"], x: 4, y: 1), Stamp(["ww"], x: 9, y: 2), Stamp(["o"], x: 10, y: 2)] },
                .init(.back) { _ in [Stamp(["wwwwwwww", "wwwwwwww"], x: 4, y: 7), Stamp(["rrrrrrrr"], x: 4, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 5 + p % 2, y: 0), Stamp(["l"], x: 9 - p % 2, y: 1 - p % 2 * 1)] },
                .init(.hand) { _ in [Stamp(["n", "n", "n"], x: 13, y: 1), Stamp(["n", "n", "n"], x: 14, y: 0)] },
            ]),

        ClawdEdition(
            id: "b6-cupcake", name: "Cupcake", collection: .food,
            blurb: "A swirl of frosting, a cherry, and a wrapper full of good news.",
            bodyColor: 0xC98B5B,
            parts: [
                .init(.head) { p in [Stamp(["hhhhhhhh"], x: 4, y: 2), Stamp(["hhhhhh"], x: 5, y: 1), Stamp(["hhhh"], x: 6, y: 0),
                                     Stamp([p % 2 == 0 ? "r" : "o"], x: 7, y: 0)] },
                .init(.back) { _ in [Stamp(["n.n.n.n."], x: 4, y: 7), Stamp(["n.n.n.n."], x: 4, y: 8)] },
                .init(.face) { _ in [Stamp(["c"], x: 5, y: 2), Stamp(["g"], x: 9, y: 1), Stamp(["w"], x: 10, y: 2)] },
            ]),

        ClawdEdition(
            id: "b6-watermelon", name: "Watermelon Slice", collection: .food,
            blurb: "Juicy red, a crisp green rind, and seeds for spitting contests.",
            bodyColor: 0xE5484D,
            parts: [
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8), Stamp(["eeeeeeeeee"], x: 3, y: 9)] },
                .init(.face) { p in [Stamp(["k"], x: 5, y: 6), Stamp(["k"], x: 8, y: 6), Stamp(["k"], x: 10, y: 7), Stamp(["k"], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["k"], x: 14, y: 4 + p % 4), Stamp(["c"], x: 1, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b6-banana", name: "Banana", collection: .food,
            blurb: "Peeled halfway, spotted with character, and extremely slip-prone.",
            bodyColor: 0xF2CC3A,
            parts: [
                .init(.head) { _ in [Stamp(["nn"], x: 7, y: 2), Stamp(["n"], x: 8, y: 1)] },
                .init(.back) { p in [Stamp(["B", "B", "B"], x: 1, y: 6 + p % 2), Stamp(["B", "B", "B"], x: 14, y: 6 + (p + 1) % 2),
                                     Stamp(["o"], x: 1, y: 9 + p % 2), Stamp(["o"], x: 14, y: 9 + (p + 1) % 2)] },
                .init(.face) { _ in [Stamp(["n"], x: 6, y: 7), Stamp(["n"], x: 9, y: 5), Stamp(["n"], x: 11, y: 7)] },
            ]),

        ClawdEdition(
            id: "b6-avocado", name: "Avocado", collection: .food,
            blurb: "Perfectly ripe for about four minutes. Pit included.",
            bodyColor: 0xB4D26B,
            parts: [
                .init(.back) { _ in [Stamp(["eeeeeeee"], x: 4, y: 8), Stamp(["e", "e", "e", "e", "e", "e"], x: 3, y: 3), Stamp(["e", "e", "e", "e", "e", "e"], x: 12, y: 3),
                                     Stamp(["eeeeee"], x: 5, y: 2)] },
                .init(.face) { p in [Stamp(["nn", "nn"], x: 7, y: 6), Stamp([p % 2 == 0 ? "w" : "."], x: 7, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e"], x: 13, y: 1 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b6-cheese", name: "Cheese Wedge", collection: .food,
            blurb: "Full of holes and full of confidence. Mind the mouse.",
            bodyColor: 0xF4C22B,
            parts: [
                .init(.back) { _ in [Stamp(["oooooooo"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["oo", "oo"], x: 4, y: 6), Stamp(["o"], x: 10, y: 6), Stamp(["o"], x: 7, y: 7), Stamp(["o"], x: 8, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l", "l"], x: 14 - p % 2, y: 9), Stamp(["lk"], x: 13, y: 11), Stamp(["h"], x: 15, y: 11)] },
            ]),

        ClawdEdition(
            id: "b6-popcorn", name: "Popcorn Bucket", collection: .food,
            blurb: "Striped bucket, fluffy kernels, and the movie starts now.",
            bodyColor: 0xD9423E,
            parts: [
                .init(.head) { p in [Stamp(["w.ww.ww."], x: 4, y: 2), Stamp(["wgwwgwww"], x: 4, y: 1), Stamp([p % 2 == 0 ? ".ww." : "gw.w"], x: 5, y: 0)] },
                .init(.back) { _ in [Stamp(["w.w.w.w."], x: 4, y: 7), Stamp(["w.w.w.w."], x: 4, y: 8), Stamp(["w.w.w.w."], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 3 - p % 3), Stamp(["g"], x: 14, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b6-latte", name: "Latte", collection: .food,
            blurb: "A heart in the foam and enough steam to start the morning.",
            bodyColor: 0x9C6B45,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp([".w.w", "wwww", ".ww.", "..w."], x: 6, y: 5)] },
                .init(.back) { _ in [Stamp(["w", "w", "w", "w"], x: 12, y: 4), Stamp(["ww"], x: 13, y: 4), Stamp(["w"], x: 14, y: 5), Stamp(["ww"], x: 13, y: 6),
                                     Stamp(["yyyyyyyyyy"], x: 3, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 6 + p % 2, y: 1), Stamp(["l"], x: 9 - p % 2, y: 0)] },
            ]),

        ClawdEdition(
            id: "b6-croissant", name: "Croissant", collection: .food,
            blurb: "Layers upon layers, buttery to the tips, flaky in all the right ways.",
            bodyColor: 0xDB9A4C,
            parts: [
                .init(.face) { _ in [Stamp(["n"], x: 6, y: 3), Stamp(["n"], x: 9, y: 3), Stamp(["n"], x: 6, y: 6), Stamp(["n"], x: 9, y: 6),
                                     Stamp(["n", "n"], x: 7, y: 7), Stamp(["n", "n"], x: 8, y: 7)] },
                .init(.back) { _ in [Stamp(["oooo"], x: 6, y: 2), Stamp(["o", "o"], x: 3, y: 7), Stamp(["o", "o"], x: 12, y: 7), Stamp(["o"], x: 2, y: 8), Stamp(["o"], x: 13, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1 + p % 2, y: 10), Stamp(["o"], x: 13 - p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b6-dumpling", name: "Dumpling", collection: .food,
            blurb: "Pleated by hand, steamed with care, and gone in one bite.",
            bodyColor: 0xEBDDC1,
            parts: [
                .init(.head) { _ in [Stamp(["B.B.B.B."], x: 4, y: 2), Stamp([".B.B.B.B"], x: 4, y: 1)] },
                .init(.face) { _ in [Stamp(["n"], x: 5, y: 3), Stamp(["n"], x: 7, y: 3), Stamp(["n"], x: 9, y: 3), Stamp(["n"], x: 11, y: 3)] },
                .init(.back) { _ in [Stamp(["gggggggggg"], x: 3, y: 11), Stamp(["g"], x: 3, y: 10), Stamp(["g"], x: 12, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 1, y: 6 - p % 3), Stamp(["l"], x: 14, y: 5 - (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b6-pretzel", name: "Pretzel", collection: .food,
            blurb: "Twisted, salty, and honestly a bit of a knot of feelings.",
            bodyColor: 0xA9632E,
            parts: [
                .init(.head) { _ in [Stamp(["BB.BB.BB"], x: 4, y: 2), Stamp(["B.....B"], x: 4, y: 1)] },
                .init(.face) { p in [Stamp(["w"], x: 6, y: 3), Stamp(["w"], x: 9, y: 7), Stamp(["w"], x: 5, y: 7), Stamp([p % 2 == 0 ? "w" : "."], x: 11, y: 6),
                                     Stamp(["dd"], x: 6, y: 6), Stamp(["dd"], x: 8, y: 6)] },
                .init(.back) { _ in [Stamp(["B", "B"], x: 3, y: 9), Stamp(["B", "B"], x: 12, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 2, y: 2), Stamp(["w"], x: 14 - p % 2, y: 4)] },
            ]),

        ClawdEdition(
            id: "b6-cookie", name: "Chocolate Chip Cookie", collection: .food,
            blurb: "Warm from the oven, gooey chips, and a glass of milk on standby.",
            bodyColor: 0xCF9D5D,
            parts: [
                .init(.face) { _ in [Stamp(["nn"], x: 6, y: 3), Stamp(["nn"], x: 11, y: 5), Stamp(["nn"], x: 4, y: 7), Stamp(["nn"], x: 9, y: 8), Stamp(["n"], x: 7, y: 6)] },
                .init(.hand) { p in [Stamp(["w", "w", "w"], x: 14, y: 6), Stamp(["l"], x: 14, y: 6 - p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 1 + p % 3, y: 11), Stamp(["n"], x: 12 - p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b6-strawberry", name: "Strawberry", collection: .food,
            blurb: "Sweet, a little tart, and wearing a tiny green hat.",
            bodyColor: 0xE5383B,
            parts: [
                .init(.head) { p in [Stamp(["e.ee.e"], x: 5, y: 2), Stamp([".eeee."], x: 5, y: 1), Stamp(["e"], x: p % 2 == 0 ? 7 : 8, y: 0)] },
                .init(.face) { _ in [Stamp(["g"], x: 4, y: 6), Stamp(["g"], x: 6, y: 7), Stamp(["g"], x: 8, y: 6), Stamp(["g"], x: 10, y: 7), Stamp(["g"], x: 11, y: 5), Stamp(["g"], x: 7, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: p % 2 == 0 ? 1 : 14, y: 2 + p % 3)] },
            ]),
    ]
}
