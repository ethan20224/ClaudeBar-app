import Foundation

extension ClawdEditions {
    /// Batch 4: Around the World, part B (Europe, the Americas, Oceania).
    static let batch4: [ClawdEdition] = [

        ClawdEdition(
            id: "b4-dia-de-muertos", name: "Dia de Muertos", collection: .cultures,
            blurb: "Marigold crown and friendly painted eyes, joining the colorful Mexican celebration of loved ones.",
            parts: [
                .init(.head) { p in [Stamp(["ogogogog"], x: 4, y: 2),
                                     Stamp([p % 2 == 0 ? "g.o.g." : ".o.g.o"], x: 5, y: 1)] },
                .init(.face) { _ in [Stamp(["www", "w.w", "www"], x: 4, y: 3), Stamp(["www", "w.w", "www"], x: 9, y: 3),
                                     Stamp(["k.k.k"], x: 6, y: 7), Stamp(["h"], x: 6, y: 6), Stamp(["h"], x: 9, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 1, y: (p * 2) % 10), Stamp(["g"], x: 14, y: (p * 2 + 5) % 10),
                                                         Stamp(["o"], x: 0, y: 11), Stamp(["g"], x: 15, y: 11)] },
            ]),

        ClawdEdition(
            id: "b4-mariachi", name: "Mariachi", collection: .cultures,
            blurb: "A wide embroidered sombrero and a little guitar, ready to serenade the whole plaza.",
            parts: [
                .init(.head) { _ in [Stamp(["dddd"], x: 6, y: 0), Stamp(["gggggg"], x: 5, y: 1), Stamp(["dddddddddddd"], x: 2, y: 2)] },
                .init(.face) { _ in [Stamp(["kkkk"], x: 6, y: 7)] },
                .init(.back) { _ in [Stamp(["rr"], x: 7, y: 8)] },
                .init(.hand) { p in [Stamp(["g", "n", "n", "n", "n", "n"], x: 14, y: 1),
                                     Stamp(["nn", "nk", "nn"], x: 14, y: 6),
                                     Stamp(["y"], x: 15, y: 6 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 0 + p % 2, y: 4 + (p % 3)), Stamp(["g"], x: 1, y: 8 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b4-carnival", name: "Carnival Samba", collection: .cultures,
            blurb: "A tall feather crown and a shaker, dancing along with Rio's big street party.",
            parts: [
                .init(.head) { p in
                    let cs = Array("rogecxph")
                    let hs = [2, 3, 3, 3, 3, 3, 3, 2]
                    return (0..<8).map { i in
                        let h = hs[i] - ((p + i) % 2 == 0 ? 0 : 1)
                        return Stamp(Array(repeating: String(cs[i]), count: h + 1), x: 4 + i, y: 2 - h)
                    }
                },
                .init(.back) { _ in [Stamp(["gwgwgwgw"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["rr", "oo", "n"], x: p % 2 == 0 ? 0 : 1, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: (p * 2) % 9), Stamp(["c"], x: 14, y: (p * 2 + 4) % 9),
                                                         Stamp(["g"], x: 15, y: (p * 3) % 9)] },
            ]),

        ClawdEdition(
            id: "b4-gaucho", name: "Gaucho", collection: .cultures,
            blurb: "Flat-brimmed hat, a red neckerchief and a gourd of mate, shared on the Argentine plains.",
            parts: [
                .init(.head) { _ in [Stamp(["dddddd"], x: 5, y: 1), Stamp(["dddddddddd"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 8), Stamp(["rr"], x: 7, y: 9)] },
                .init(.hand) { p in [Stamp(["nn", "nn", "nn"], x: 14, y: 6), Stamp(["y", "y", "y"], x: 15, y: 3),
                                     Stamp(["l"], x: 14 + p % 2, y: 2 - p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "e.e..e.e" : ".e.e.e..e"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b4-chullo", name: "Andean Chullo", collection: .cultures,
            blurb: "A hand-knit chullo with earflaps and a pompom, plus pan pipes for the mountain air.",
            parts: [
                .init(.head) { p in [Stamp(["rr"], x: 7 + p % 2, y: 0), Stamp(["gwgwgw"], x: 5, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2),
                                     Stamp(["u", "w", "u"], x: 3, y: 3), Stamp(["u", "w", "u"], x: 12, y: 3),
                                     Stamp(["g"], x: 3 - p % 2, y: 6), Stamp(["g"], x: 12 + p % 2, y: 6)] },
                .init(.hand) { _ in [Stamp(["...g", "..gg", ".ggn", "ggnn"], x: 12, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 0, y: 2 + p % 2), Stamp(["l"], x: 15, y: 1 + (p + 1) % 2)] },
            ]),

        ClawdEdition(
            id: "b4-canada", name: "Maple Toque", collection: .cultures,
            blurb: "A cozy knit toque, buffalo-plaid scarf and fresh maple syrup from a Canadian sugar shack.",
            parts: [
                .init(.head) { p in [Stamp(["ww"], x: 7, y: 0 + p % 2 * 0), Stamp(["rrrrrr"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["rdrdrdrd", "drdrdrdr"], x: 4, y: 7)] },
                .init(.hand) { _ in [Stamp(["rr", "oo", "ww", "oo"], x: 14, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp([".r.", "rrr", ".r."], x: 0, y: (p * 2) % 9), Stamp(["r"], x: 14, y: (p * 2 + 5) % 9)] },
            ]),

        ClawdEdition(
            id: "b4-highland-piper", name: "Highland Piper", collection: .cultures,
            blurb: "A blue tam with a red pompom, a tartan scarf and bagpipes echoing over the glen.",
            parts: [
                .init(.head) { p in [Stamp(["r"], x: 7 + p % 2, y: 0), Stamp(["uuuuuuuu"], x: 4, y: 1), Stamp(["uuuuuuuuuu"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["rureuerr", "ueruerur"], x: 4, y: 7), Stamp(["g"], x: 12, y: 9)] },
                .init(.hand) { p in [Stamp(["rrr", "rrr"], x: 13, y: 7), Stamp(["n", "n", "n", "n"], x: 15, y: 3),
                                     Stamp(["n", "n"], x: 14, y: 5), Stamp(["n", "n"], x: 13, y: 9),
                                     Stamp([p % 2 == 0 ? "g" : "w"], x: 15, y: 2)] },
            ]),

        ClawdEdition(
            id: "b4-tea-time", name: "Tea Time", collection: .cultures,
            blurb: "A tidy bowler hat and a steaming cup, because the English afternoon always has room for tea.",
            parts: [
                .init(.head) { _ in [Stamp(["dddd"], x: 6, y: 0), Stamp(["uuuuuu"], x: 5, y: 1), Stamp(["dddddddddd"], x: 3, y: 2)] },
                .init(.hand) { p in [Stamp(["nnn", "www"], x: 12, y: 8), Stamp(["w"], x: 15, y: 8), Stamp(["lllll"], x: 12, y: 10),
                                     Stamp(["l"], x: 13 + p % 2, y: 7), Stamp(["l"], x: 14 - p % 2, y: 6)] },
            ]),

        ClawdEdition(
            id: "b4-palace-guard", name: "Palace Guard", collection: .cultures,
            blurb: "A tall bearskin hat and a scarlet tunic, standing very still outside the palace gates.",
            parts: [
                .init(.head) { p in [Stamp(["dddd"], x: 6, y: 0), Stamp(["dddddd"], x: 5, y: 1), Stamp(["dddddddd"], x: 4, y: 2),
                                     Stamp(["w"], x: 10 + p % 2, y: 0)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr", "rrrrrrrr"], x: 4, y: 7), Stamp(["g", "g"], x: 7, y: 7), Stamp(["g", "g"], x: 8, y: 7),
                                     Stamp(["wwwwwwww"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 1 + p % 2, y: 11), Stamp(["l"], x: 14 - p % 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "b4-parisian", name: "Parisian", collection: .cultures,
            blurb: "A tilted beret, a fresh baguette and a view of the tower on a sunny morning in Paris.",
            parts: [
                .init(.head) { _ in [Stamp(["u"], x: 6, y: 0), Stamp([".uuuuu"], x: 4, y: 1), Stamp(["uuuuuuuu"], x: 4, y: 2)] },
                .init(.hand) { _ in [Stamp(["gg", "go", "gg", "go", "gg", "gg"], x: 0, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp([".l.", ".l.", "l.l", "l.l", "lll"], x: 13, y: 7),
                                                         Stamp([p % 2 == 0 ? "g" : "w"], x: 14, y: 6),
                                                         Stamp([p % 3 == 0 ? "h" : "."], x: 1, y: 9)] },
            ]),

        ClawdEdition(
            id: "b4-gondolier", name: "Gondolier", collection: .cultures,
            blurb: "A straw boater, a striped shirt and a long oar, gliding through the canals of Venice.",
            parts: [
                .init(.head) { _ in [Stamp(["gggggg"], x: 5, y: 0), Stamp(["rrrrrr"], x: 5, y: 1), Stamp(["gggggggggg"], x: 3, y: 2)] },
                .init(.back) { _ in [Stamp(["wuwuwuwu", "wuwuwuwu"], x: 4, y: 7), Stamp(["rr"], x: 7, y: 6)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n", "n", "n", "n", "n", "n"], x: 15, y: 0), Stamp(["nn", "nn", "nn"], x: 14, y: 8 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "c.c.c.c.c.c.c.c." : ".c.c.c.c.c.c.c.c"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b4-oktoberfest", name: "Oktoberfest", collection: .cultures,
            blurb: "A green felt hat with a feather, blue-and-white checks and a warm Bavarian pretzel.",
            parts: [
                .init(.head) { p in [Stamp(["eeee"], x: 6, y: 0), Stamp(["eeeeee"], x: 5, y: 1), Stamp(["eeeeeeeeee"], x: 3, y: 2),
                                     Stamp(["w", "w"], x: 11 + p % 2, y: 0)] },
                .init(.back) { _ in [Stamp(["wxwxwxwx", "xwxwxwxw"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["n.n", ".n.", "nnn"], x: 13, y: 8), Stamp([p % 2 == 0 ? "w" : "."], x: 13, y: 8)] },
            ]),

        ClawdEdition(
            id: "b4-tulip-windmill", name: "Tulips and Clogs", collection: .cultures,
            blurb: "A spring tulip, bright wooden clogs and a windmill turning slowly in the Dutch breeze.",
            parts: [
                .init(.head) { _ in [Stamp(["r.r", "rrr"], x: 6, y: 0), Stamp(["e"], x: 7, y: 2), Stamp(["e"], x: 6, y: 2), Stamp(["e"], x: 8, y: 2)] },
                .init(.back) { _ in [Stamp(["gg"], x: 3, y: 10), Stamp(["gg"], x: 5, y: 10), Stamp(["gg"], x: 8, y: 10), Stamp(["gg"], x: 10, y: 10)] },
                .init(.aura, followsBody: false) { p in
                    let blades: [String] = p % 2 == 0 ? [".w.", "wnw", ".w."] : ["w.w", ".n.", "w.w"]
                    return [Stamp(blades, x: 0, y: 2), Stamp(["l"], x: 1, y: 5), Stamp(["l"], x: 1, y: 6),
                            Stamp(["lll"], x: 0, y: 7), Stamp(["lll"], x: 0, y: 8)]
                },
            ]),

        ClawdEdition(
            id: "b4-alpine", name: "Alpine Alphorn", collection: .cultures,
            blurb: "An edelweiss in the hair and a long alphorn echoing between snowy Swiss peaks.",
            parts: [
                .init(.head) { p in [Stamp([".w.", "wgw", ".w."], x: 7, y: 0), Stamp(["e"], x: 6, y: 2), Stamp(["e"], x: 10, y: 2),
                                     Stamp([p % 2 == 0 ? "w" : "l"], x: 5, y: 1)] },
                .init(.hand) { _ in [Stamp(["nn..", ".nn.", "..nn", "...n"], x: 12, y: 6), Stamp(["gg"], x: 14, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp([".w."], x: 0, y: 8), Stamp(["lwl"], x: 0, y: 9), Stamp(["lllll"], x: 0, y: 10),
                                                         Stamp(["c"], x: 14, y: (p * 2) % 6), Stamp(["c"], x: 1, y: (p * 2 + 3) % 7)] },
            ]),

        ClawdEdition(
            id: "b4-flamenco", name: "Flamenco", collection: .cultures,
            blurb: "A red rose in the hair, a ruffled dress and a fluttering fan for a passionate Spanish dance.",
            parts: [
                .init(.head) { _ in [Stamp(["rr"], x: 4, y: 2), Stamp(["e"], x: 6, y: 2), Stamp(["r"], x: 4, y: 1)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr", "rwrrwrrw"], x: 4, y: 7)] },
                .init(.hand) { p in [p % 2 == 0 ? Stamp(["r.r.r", ".rrr.", "..n.."], x: 0, y: 0)
                                                : Stamp(["rr.rr", ".rrr.", "..n.."], x: 0, y: 0)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r"], x: 14, y: (p * 2) % 9), Stamp(["h"], x: 15, y: (p * 2 + 4) % 9)] },
            ]),

        ClawdEdition(
            id: "b4-olive-wreath", name: "Olive Wreath", collection: .cultures,
            blurb: "A leafy olive wreath, a white drape and a painted vase, in the spirit of ancient Greece.",
            parts: [
                .init(.head) { p in [Stamp(["eeeeeeee"], x: 4, y: 2), Stamp(["e"], x: 3, y: 3), Stamp(["e"], x: 12, y: 3),
                                     Stamp([p % 2 == 0 ? "e..e..e." : ".e..e..e"], x: 4, y: 1), Stamp(["g"], x: 7, y: 2)] },
                .init(.back) { _ in [Stamp(["wwwwwwww", ".wwwwww."], x: 4, y: 7), Stamp(["g"], x: 11, y: 7)] },
                .init(.hand) { _ in [Stamp([".o.", "ooo", "uuu", "ooo"], x: 13, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ll", "ww", "ww", "ww", "ww", "ww", "ll"], x: 0, y: 4),
                                                         Stamp([p % 2 == 0 ? "g" : "."], x: 1, y: 2)] },
            ]),

        ClawdEdition(
            id: "b4-ushanka", name: "Winter Ushanka", collection: .cultures,
            blurb: "A fluffy fur hat with earflaps, a blue scarf and a tiny nesting doll, ready for a snowy walk.",
            parts: [
                .init(.head) { p in [Stamp(["llllll"], x: 5, y: 1), Stamp(["llllllll"], x: 4, y: 2),
                                     Stamp(["l", "l", "l"], x: 3, y: 3), Stamp(["l", "l", "l"], x: 12, y: 3),
                                     Stamp(["l"], x: 3 - p % 2, y: 6), Stamp(["l"], x: 12 + p % 2, y: 6)] },
                .init(.back) { _ in [Stamp(["xxxxxxxx"], x: 4, y: 8), Stamp(["x"], x: 12, y: 9)] },
                .init(.hand) { _ in [Stamp(["rr", "hh", "rg", "rr"], x: 14, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: (p * 2) % 9), Stamp(["c"], x: 14, y: (p * 2 + 3) % 8),
                                                         Stamp(["c"], x: 0, y: (p * 2 + 6) % 9)] },
            ]),

        ClawdEdition(
            id: "b4-outback", name: "Outback", collection: .cultures,
            blurb: "A wide-brimmed hat and a boomerang, with red desert dust and a few friendly flies.",
            parts: [
                .init(.head) { _ in [Stamp(["nnnnnn"], x: 5, y: 0), Stamp(["dddddd"], x: 5, y: 1), Stamp(["nnnnnnnnnnnn"], x: 2, y: 2)] },
                .init(.hand) { p in [p % 2 == 0 ? Stamp([".nn", "n..", "n.."], x: 13, y: 7)
                                                : Stamp(["nn.", "..n", "..n"], x: 13, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ono.on.no.o.n.on"], x: 0, y: 11),
                                                         Stamp(["k"], x: 1 + p % 3, y: 3 + p % 2), Stamp(["k"], x: 14 - p % 2, y: 5 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b4-kiwi", name: "Kiwi Bird", collection: .cultures,
            blurb: "A shy brown kiwi with a long beak and a silver fern, a little local from Aotearoa New Zealand.",
            bodyColor: 0x8B6B47,
            parts: [
                .init(.face) { _ in [Stamp(["gg", "g.", "g."], x: 7, y: 6)] },
                .init(.head) { p in [Stamp([p % 2 == 0 ? "d.d" : ".d."], x: 6, y: 2), Stamp(["d"], x: 9, y: 2)] },
                .init(.back) { _ in [Stamp(["d.d.d.d."], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in
                    [Stamp(["e", "e", "e", "e", "e", "e", "e"], x: 14, y: 4),
                     Stamp(["e"], x: 15, y: p % 2 == 0 ? 4 : 5), Stamp(["e"], x: 13, y: p % 2 == 0 ? 6 : 5),
                     Stamp(["e"], x: 15, y: 7), Stamp(["e"], x: 13, y: 9), Stamp(["e"], x: 15, y: 10)]
                },
            ]),

        ClawdEdition(
            id: "b4-aloha", name: "Aloha Lei", collection: .cultures,
            blurb: "A flower lei, a hibiscus in the hair and a little ukulele, welcoming everyone with aloha.",
            parts: [
                .init(.head) { p in [Stamp([".r.", "rgr", ".r."], x: 10, y: 0 + 0), Stamp([p % 2 == 0 ? "e" : "."], x: 9, y: 2)] },
                .init(.back) { _ in [Stamp(["hrhohrho"], x: 4, y: 8), Stamp(["ohro"], x: 6, y: 9)] },
                .init(.hand) { p in [Stamp(["n", "n", "n", "n"], x: 1, y: 2), Stamp(["oo", "ok", "oo"], x: 0, y: 6 - 0),
                                     Stamp(["g"], x: 0 + p % 2, y: 1)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gg", "gg"], x: 14, y: 0), Stamp([p % 2 == 0 ? "o" : "."], x: 13, y: 1),
                                                         Stamp([p % 2 == 0 ? "." : "o"], x: 15, y: 2)] },
            ]),
    ]
}
