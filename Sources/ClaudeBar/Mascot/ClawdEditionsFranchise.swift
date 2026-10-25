import Foundation

/// Editions based on real franchises, brands and characters. Personal-use fan tributes:
/// flip `ClawdEditions.includeTrademarked` to false to ship without them.
extension ClawdEditions {
    static let franchise: [ClawdEdition] = [
        ClawdEdition(
            id: "fr-harry-potter", name: "Harry Potter", collection: .franchise,
            blurb: "Round glasses, a lightning scar, a red and gold scarf, a wand, and a white owl on post duty.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["dddd.ddd"], x: 4, y: 2), Stamp(["d.dd.d"], x: 5, y: 1)] },
                .init(.face) { _ in [Stamp([".y.", "y.y", ".y."], x: 4, y: 3), Stamp([".y.", "y.y", ".y."], x: 9, y: 3),
                                     Stamp(["yy"], x: 7, y: 4), Stamp(["r"], x: 8, y: 3), Stamp(["r"], x: 7, y: 3)] },
                .init(.back) { p in [
                    Stamp(["dddddddd", "dddddddd"], x: 4, y: 7), Stamp(["rgrgrgrg"], x: 4, y: 6),
                    p % 2 == 0 ? Stamp(["r", "g", "r"], x: 12, y: 6) : Stamp(["r", "g", "r"], x: 12, y: 7),
                ] },
                .init(.hand) { p in [Stamp(["n", "n", "n"], x: 14, y: 5), Stamp([p % 2 == 0 ? "g" : "w"], x: 14, y: 4)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["w.w", "www", ".w."], x: 0, y: 1 + p % 2),
                    Stamp(["wgw"], x: (p * 3) % 13, y: 0),
                ] },
            ]),

        ClawdEdition(
            id: "fr-titanic", name: "Titanic", collection: .franchise,
            blurb: "Four funnels, a black hull, and an iceberg dead ahead. Everyone to the bow.",
            trademarked: true,
            parts: [
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8), Stamp(["y.y.y.y."], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["k", "o", "o"], x: 4, y: 0), Stamp(["k", "o", "o"], x: 6, y: 0),
                    Stamp(["k", "o", "o"], x: 9, y: 0), Stamp(["k", "o", "o"], x: 11, y: 0),
                    Stamp(["l"], x: 3 - p % 2, y: 0 - 0), Stamp(["l"], x: 1, y: 1 + p % 2),
                    Stamp(["dddddddddddddddd", "rrrrrrrrrrrrrrrr"], x: 0, y: 10),
                    Stamp([".l.", ".ll", "lcl", "lll"], x: 13, y: 6),
                    Stamp([p % 2 == 0 ? "w" : "c"], x: 14, y: 6),
                ] },
            ]),

        ClawdEdition(
            id: "fr-apple", name: "Apple", collection: .franchise,
            blurb: "Silver, smooth, and missing exactly one bite. Think different.",
            bodyColor: 0xC9CCD1, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp([".BB", "BB."], x: 7, y: 1), Stamp(["XX"], x: 10, y: 3)] },
                .init(.face) { _ in [Stamp(["X"], x: 11, y: 4)] },
            ]),

        ClawdEdition(
            id: "fr-star-wars-jedi", name: "Star Wars Jedi", collection: .franchise,
            blurb: "A hooded robe, a humming blade, and a small droid that beeps in the background.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 2), Stamp(["nnnnnnnn"], x: 4, y: 3),
                                     Stamp(["n", "n"], x: 4, y: 4), Stamp(["n", "n"], x: 11, y: 4)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn", "nnnnnnnn"], x: 4, y: 7), Stamp(["gggggggg"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp([p % 2 == 0 ? "w" : "c", "c", "c", "c", "c"], x: 14, y: 1), Stamp(["y", "y"], x: 14, y: 6)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["xl", "ll", "ll"], x: 0, y: 8),
                    Stamp([p % 2 == 0 ? "r" : "c"], x: 1, y: 9),
                    Stamp(["w"], x: 2 + (p % 3) * 4, y: 0), Stamp(["w"], x: 12 - (p % 2) * 3, y: 1),
                ] },
            ]),
    ]
}
