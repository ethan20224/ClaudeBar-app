import Foundation

extension ClawdEditions {
    /// Franchise batch 3: games and brands. Personal-use fan tributes (trademarked).
    static let franchise3: [ClawdEdition] = [

        ClawdEdition(
            id: "fr-super-mario", name: "Super Mario", collection: .franchise,
            blurb: "Red cap, big mustache, and a jump that clears every pipe.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrr"], x: 5, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2), Stamp(["wr"], x: 6, y: 2)] },
                .init(.face) { _ in [Stamp(["nnnnnn"], x: 5, y: 6), Stamp(["n..n"], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["gg", "gg"], x: 14, y: 5 - p % 3)] },
            ]),

        ClawdEdition(
            id: "fr-pikachu", name: "Pikachu", collection: .franchise,
            blurb: "Yellow fur, black-tipped ears, red cheeks, and a zigzag tail full of sparks.",
            bodyColor: 0xF8D030, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["k.", "BB", "B."], x: 4, y: 0), Stamp([".k", "BB", ".B"], x: 10, y: 0)] },
                .init(.face) { _ in [Stamp(["r"], x: 4, y: 6), Stamp(["r"], x: 11, y: 6)] },
                .init(.back) { p in [p % 2 == 0 ? Stamp(["..g", ".g.", "gg."], x: 13, y: 6) : Stamp(["g..", ".g.", ".gg"], x: 13, y: 6),
                                     Stamp(["n"], x: 13, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 2 + p % 3), Stamp(["w"], x: 14 - p % 2, y: 2)] },
            ]),

        ClawdEdition(
            id: "fr-zelda-hero", name: "Zelda Hero", collection: .franchise,
            blurb: "Green tunic, pointed cap, and a sword with a shield to match.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["ee"], x: 6, y: 0), Stamp(["eeeeee"], x: 5, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2), Stamp(["ee"], x: 3, y: 3)] },
                .init(.back) { _ in [Stamp(["eeeeeeee"], x: 4, y: 8), Stamp(["nnnn"], x: 6, y: 8)] },
                .init(.hand) { p in [Stamp(["l", "l", "l", "l"], x: 14, y: 2 + p % 2), Stamp(["g"], x: 14, y: 6 + p % 2), Stamp(["n"], x: 14, y: 7 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["uu", "ug"], x: 0, y: 6 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-minecraft-creeper", name: "Minecraft Creeper", collection: .franchise,
            blurb: "Blocky, green, and a little too quiet. Ssssss.",
            bodyColor: 0x4CAF50, trademarked: true,
            parts: [
                .init(.face) { p in [Stamp(["kk..kk", "kk..kk", "..kk..", ".kkkk.", ".k..k."], x: 5, y: 3 + 0 * p)] },
                .init(.back) { _ in [Stamp(["e.e.e.e."], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [p % 2 == 0 ? Stamp(["w"], x: 14, y: 2) : Stamp(["o"], x: 14, y: 2),
                                                         Stamp(["e"], x: 1, y: 10 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-sonic", name: "Sonic", collection: .franchise,
            blurb: "Spiky blue quills, red sneakers, and a trail of gold rings.",
            bodyColor: 0x2D6BE0, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["B.B.B"], x: 1, y: 3), Stamp(["B", "B"], x: 2, y: 4), Stamp(["B.B"], x: 5, y: 2)] },
                .init(.face) { _ in [Stamp(["oooo"], x: 6, y: 6), Stamp(["ww", "ww"], x: 5, y: 4), Stamp(["ww", "ww"], x: 9, y: 4)] },
                .init(.back) { _ in [Stamp(["r", "r"], x: 4, y: 11), Stamp(["r", "r"], x: 6, y: 11), Stamp(["r", "r"], x: 9, y: 11), Stamp(["r", "r"], x: 11, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp([".gg.", "g..g", ".gg."], x: 12 + p % 2, y: 0 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-pac-man", name: "Pac-Man", collection: .franchise,
            blurb: "A yellow circle with an appetite, a pink ghost in pursuit, and a row of dots.",
            bodyColor: 0xFFD21F, trademarked: true,
            parts: [
                .init(.face) { p in [Stamp(p % 2 == 0 ? ["..BBB", "....B", "....."] : ["..BBB", "...BB", "....."], x: 9, y: 5), Stamp(["k"], x: 8, y: 4)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp([".hh.", "hhhh", "h.h."], x: 0, y: 0 + p % 2),
                    Stamp(["w"], x: 1, y: 1 + p % 2), Stamp(["w"], x: 3, y: 1 + p % 2),
                    Stamp(["g", ".", "g", ".", "g"], x: 15, y: 4) ] },
                .init(.back) { _ in [Stamp(["g.g.g.g.g.g."], x: 2, y: 11)] },
            ]),

        ClawdEdition(
            id: "fr-tetris", name: "Tetris", collection: .franchise,
            blurb: "Four squares at a time, rotating down. Clear the line and breathe.",
            trademarked: true,
            parts: [
                .init(.head) { p in p % 2 == 0
                    ? [Stamp(["pp.", ".pp"], x: 6, y: 0)]
                    : [Stamp([".p", "pp", "p."], x: 7, y: 0)] },
                .init(.back) { _ in [Stamp(["cccc"], x: 6, y: 8)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["oo", "oo"], x: 0, y: 9), Stamp(["ee", "ee"], x: 14, y: 9),
                    Stamp(["rr", ".r"], x: 0, y: 6 - p % 2), Stamp(["uu", "u."], x: 14, y: 6 + p % 2) ] },
            ]),

        ClawdEdition(
            id: "fr-among-us", name: "Among Us", collection: .franchise,
            blurb: "A bean in a spacesuit with a cyan visor and a tiny backpack. Suspicious.",
            bodyColor: 0xD8312B, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["cccccc", "cwccc."], x: 7, y: 4)] },
                .init(.back) { _ in [Stamp(["BB", "BB"], x: 2, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp(["k"], x: 14, y: 1 + p % 2), Stamp(["r"], x: 1 + p % 3, y: 11)] },
            ]),

        ClawdEdition(
            id: "fr-lego", name: "Lego", collection: .franchise,
            blurb: "Studs on top, snaps into anything. Step on one at your own risk.",
            bodyColor: 0xE3342F, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rr.rr.rr"], x: 4, y: 2), Stamp(["rr.rr.rr"], x: 4, y: 1)] },
                .init(.back) { _ in [Stamp(["gg"], x: 7, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["rr", "rr"], x: 0, y: 9), Stamp(["gg", "gg"], x: 14, y: 8 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-coca-cola", name: "Coca-Cola", collection: .franchise,
            blurb: "Red can, white ribbon, and bubbles rising from a fresh pop.",
            bodyColor: 0xE41E26, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["llllllll"], x: 4, y: 2), Stamp(["l..ll..l"], x: 4, y: 3)] },
                .init(.face) { _ in [Stamp(["wwwwww"], x: 5, y: 6), Stamp(["w..w"], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 6 + p % 3, y: 1 - p % 2), Stamp(["l"], x: 10 - p % 2, y: 0)] },
            ]),

        ClawdEdition(
            id: "fr-mcdonalds", name: "McDonald's", collection: .franchise,
            blurb: "A red carton of hot golden fries under a pair of golden arches.",
            bodyColor: 0xE41E26, trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["g.g.g.g.g"], x: 3, y: 2), Stamp(["g.g.g.g"], x: 4 + p % 2, y: 1), Stamp(["g.g"], x: 6, y: 0)] },
                .init(.face) { _ in [Stamp(["g.gg.g", "g.gg.g"], x: 5, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 1 + p % 2, y: 1), Stamp(["l"], x: 14 - p % 2, y: 2)] },
            ]),

        ClawdEdition(
            id: "fr-nike", name: "Nike", collection: .franchise,
            blurb: "A black swoosh across the chest and a shoebox of speed.",
            trademarked: true,
            parts: [
                .init(.back) { _ in [Stamp(["...kkk", "kkkkk.", "k....."], x: 4, y: 6)] },
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l.l"], x: (p * 2) % 12, y: 0), Stamp(["l.l"], x: (p * 3) % 12, y: 11)] },
            ]),

        ClawdEdition(
            id: "fr-netflix", name: "Netflix", collection: .franchise,
            blurb: "A big red ribbon N on black, and one more episode before bed.",
            bodyColor: 0x1A1A1A, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["r.r", "rrr", "r.r"], x: 7, y: 4), Stamp(["rr", "r.r", "r.r"], x: 6, y: 4)] },
                .init(.head) { _ in [Stamp(["rrrr"], x: 6, y: 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r"], x: 1, y: 1 + p % 3), Stamp(["r"], x: 14, y: 3 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-spotify", name: "Spotify", collection: .franchise,
            blurb: "A green disc with three curved sound waves, and headphones for the rest.",
            bodyColor: 0x1DB954, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["kkkkkk"], x: 5, y: 4), Stamp(["..kkkk"], x: 5, y: 5), Stamp(["kkkk.."], x: 6, y: 6)] },
                .init(.head) { _ in [Stamp(["dddddddd"], x: 4, y: 2), Stamp(["dd"], x: 3, y: 4), Stamp(["dd"], x: 11, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 14, y: 1 + p % 3), Stamp(["c"], x: 1, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-google", name: "Google", collection: .franchise,
            blurb: "Blue, red, yellow, green. Four dots that know the answer to everything.",
            trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["u", "r", "g", "e"], x: 4 + 0 * p, y: 3), Stamp(["u.r.g.e."], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["uu"], x: 5, y: 6), Stamp(["rr"], x: 7, y: 6), Stamp(["gg"], x: 9, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e"], x: 1, y: 1 + p % 3), Stamp(["r"], x: 14, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-tesla", name: "Tesla", collection: .franchise,
            blurb: "Silent, silver, and a charge cable plugged in for the night.",
            bodyColor: 0xC8CAD0, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["kkkkkk", ".kkkk."], x: 5, y: 3), Stamp(["rrrrrr"], x: 5, y: 8)] },
                .init(.back) { _ in [Stamp(["kk", "kk"], x: 3, y: 10), Stamp(["kk", "kk"], x: 11, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["d", "d", "d"], x: 15, y: 5), Stamp([p % 2 == 0 ? "g" : "c"], x: 15, y: 4)] },
            ]),

        ClawdEdition(
            id: "fr-playstation", name: "PlayStation", collection: .franchise,
            blurb: "Two sticks, a d-pad, and four symbol buttons that never rest.",
            bodyColor: 0x2B2B33, trademarked: true,
            parts: [
                .init(.face) { p in [Stamp([".w.", "www", ".w."], x: 4, y: 4), Stamp(["e", "r.c", "h"], x: 10, y: 3),
                                     Stamp([p % 2 == 0 ? "r" : "e"], x: 11, y: 5)] },
                .init(.hand) { p in [Stamp(["d"], x: 14, y: 5 + p % 2), Stamp(["d"], x: 1, y: 5 + (p + 1) % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 7, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-nintendo-switch", name: "Nintendo Switch", collection: .franchise,
            blurb: "A screen in the middle, a red controller on one side and a blue one on the other.",
            bodyColor: 0x2B2B33, trademarked: true,
            parts: [
                .init(.face) { p in [Stamp(["cc", "cc", "cc"], x: 5, y: 4), Stamp(["kk", "kk", "kk"], x: 9, y: 4), Stamp([p % 2 == 0 ? "w" : "c"], x: 10, y: 4)] },
                .init(.back) { _ in [Stamp(["c", "c", "c", "c"], x: 2, y: 4), Stamp(["r", "r", "r", "r"], x: 13, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 2, y: 1)] },
            ]),

        ClawdEdition(
            id: "fr-starbucks", name: "Starbucks", collection: .franchise,
            blurb: "A paper cup with a green sleeve, a plastic lid, and a name misspelled on the side.",
            bodyColor: 0xF4EFE6, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["llllllll"], x: 4, y: 2), Stamp(["dddddd"], x: 5, y: 1)] },
                .init(.face) { _ in [Stamp(["eeeeee", "ewwwwe", "eeeeee"], x: 5, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 6 + p % 3, y: 0), Stamp(["l"], x: 9 - p % 2, y: 0)] },
            ]),

        ClawdEdition(
            id: "fr-duolingo", name: "Duolingo", collection: .franchise,
            blurb: "Big eyes, orange feet, and a daily streak you absolutely cannot break.",
            bodyColor: 0x58CC02, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["B.B"], x: 4, y: 2), Stamp(["B.B"], x: 9, y: 2)] },
                .init(.face) { _ in [Stamp(["www", "wkw", "www"], x: 4, y: 3), Stamp(["www", "wkw", "www"], x: 9, y: 3), Stamp(["oo"], x: 7, y: 5)] },
                .init(.back) { _ in [Stamp(["w", "w"], x: 7, y: 7), Stamp(["oo"], x: 5, y: 11), Stamp(["oo"], x: 9, y: 11)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 14, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "fr-discord", name: "Discord", collection: .franchise,
            blurb: "A blurple smiley with a headset, always in voice chat with somebody.",
            bodyColor: 0x5865F2, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["ww", "ww"], x: 5, y: 4), Stamp(["ww", "ww"], x: 9, y: 4), Stamp(["wwww"], x: 6, y: 7)] },
                .init(.head) { _ in [Stamp(["dddddddd"], x: 4, y: 2), Stamp(["d"], x: 3, y: 4), Stamp(["d"], x: 12, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1 + p % 2, y: 2), Stamp(["w"], x: 14 - p % 2, y: 1)] },
            ]),

        ClawdEdition(
            id: "fr-twitch", name: "Twitch", collection: .franchise,
            blurb: "A purple chat bubble, a glowing LIVE light, and a very patient audience.",
            bodyColor: 0x9146FF, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["w", "w"], x: 7, y: 4), Stamp(["w", "w"], x: 9, y: 4)] },
                .init(.back) { _ in [Stamp(["BB", ".B"], x: 5, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "r" : "h", "r"], x: 14, y: 1), Stamp(["p"], x: 1, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-rubiks-cube", name: "Rubik's Cube", collection: .franchise,
            blurb: "Six colors, nine squares a face, and one very stubborn last corner.",
            trademarked: true,
            parts: [
                .init(.face) { p in [Stamp(["rwu", "gor", "egw"], x: 6, y: 4),
                                     Stamp([p % 2 == 0 ? "o" : "e"], x: 7, y: 5)] },
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 3)] },
                .init(.aura, followsBody: false) { p in [Stamp(["rwu"], x: 13, y: 0 + p % 2), Stamp(["gor"], x: 0, y: 1 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-hello-kitty", name: "Hello Kitty", collection: .franchise,
            blurb: "A white kitty with a big red bow, whiskers, and no mouth. Somehow still friendly.",
            bodyColor: 0xF4F4F4, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1), Stamp(["rr", "rr"], x: 11, y: 2)] },
                .init(.face) { _ in [Stamp(["g"], x: 7, y: 6), Stamp(["ll"], x: 2, y: 6), Stamp(["ll"], x: 12, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1 + p % 2, y: 1), Stamp(["h"], x: 14 - p % 2, y: 10)] },
            ]),

        ClawdEdition(
            id: "fr-angry-birds", name: "Angry Birds", collection: .franchise,
            blurb: "Heavy brows, a yellow beak, and a slingshot that means business.",
            bodyColor: 0xE0302B, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rr"], x: 7, y: 1), Stamp(["r"], x: 8, y: 0)] },
                .init(.face) { _ in [Stamp(["kk"], x: 5, y: 3), Stamp([".kk"], x: 8, y: 3), Stamp(["gg", "gg"], x: 7, y: 6)] },
                .init(.back) { _ in [Stamp(["ww", "ww"], x: 6, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["n", "n", "n", "n"], x: 0, y: 7), Stamp(["n.n"], x: 0, y: 7 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-ikea", name: "IKEA", collection: .franchise,
            blurb: "Blue and yellow tote bag, an Allen key in hand, and a hot plate of meatballs.",
            bodyColor: 0x0058A3, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["uugggguu", "uuuuuuuu"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["ll", ".l", ".l"], x: 14, y: 4 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["nn"], x: 0, y: 9 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-red-bull", name: "Red Bull", collection: .franchise,
            blurb: "Blue and silver quartered can, two charging red bulls, and golden wings.",
            bodyColor: 0x1E4BA0, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["lllluuuu"], x: 4, y: 2)] },
                .init(.back) { p in [
                    Stamp(["rrggrr"], x: 5, y: 6),
                    Stamp(["ll", "ll"], x: 1, y: 4 - p % 2), Stamp(["ll", "ll"], x: 13, y: 4 - p % 2),
                ] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 0, y: 2 + p % 2), Stamp(["g"], x: 15, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-in-n-out", name: "In-N-Out", collection: .franchise,
            blurb: "A white paper boat hat with a red stripe, a double-double, and crossed palms.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwww"], x: 5, y: 1), Stamp(["wwrrrrww"], x: 4, y: 2)] },
                .init(.hand) { p in [Stamp(["yy", "re", "yy"], x: 13, y: 5 + p % 2)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["ee", ".n", ".n"], x: 0, y: 8)] },
            ]),

        ClawdEdition(
            id: "fr-kfc", name: "KFC", collection: .franchise,
            blurb: "White suit, black glasses, a string bow tie, and a red-and-white striped bucket.",
            bodyColor: 0xF5F5F2, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["kk..kk"], x: 5, y: 4), Stamp(["wwww"], x: 6, y: 6)] },
                .init(.back) { _ in [Stamp(["ww.kk.ww", "wwwwwwww"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["yy", "rw", "rw"], x: 13, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-krispy-kreme", name: "Krispy Kreme", collection: .franchise,
            blurb: "Green-trimmed paper cap, a warm glazed ring, and the neon HOT NOW sign lit up.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwww"], x: 5, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2)] },
                .init(.hand) { _ in [Stamp(["yyy", "y.y", "yyy"], x: 13, y: 5)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "rr" : "oo"], x: 0, y: 1), Stamp(["r"], x: 2, y: 1)] },
            ]),

        ClawdEdition(
            id: "fr-chipotle", name: "Chipotle", collection: .franchise,
            blurb: "Wrapped tight in shiny silver burrito foil with a smoky red jalapeno crest.",
            bodyColor: 0xC4C9CE, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["llllllll"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["llrrrrll", "llllllll"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r", "r"], x: 14, y: 3 + p % 2), Stamp(["e"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-oreo", name: "Oreo", collection: .franchise,
            blurb: "Stamped dark cocoa wafers with a double-stuf ribbon of sweet white creme.",
            bodyColor: 0x261C18, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["wwwwwwww", "kkkkkkkk"], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 9 - p % 2), Stamp(["w", "w"], x: 14, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-nutella", name: "Nutella", collection: .franchise,
            blurb: "A glossy hazelnut-cocoa jar with a white ribbed lid and red-lettered label.",
            bodyColor: 0x4E2A14, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwww"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["wkrrrrrw", "wwwwwwww"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["n", "l", "l"], x: 14, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-pringles", name: "Pringles", collection: .franchise,
            blurb: "A glorious brown handlebar mustache, a crisp red bow tie, and a stack of crisps.",
            bodyColor: 0xF5EFE6, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["nn....nn"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["nnnnnnnn", ".nnnnnn."], x: 4, y: 5)] },
                .init(.back) { _ in [Stamp(["..rrrr..", "rrrrrrrr"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["yy", "yy"], x: 14, y: 6 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-mms", name: "M&M's", collection: .franchise,
            blurb: "Glossy red candy shell, a white M stamped on the front, and cartoon white gloves.",
            bodyColor: 0xD92929, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rrwwrr"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["..wwww..", "..w.w..."], x: 4, y: 6)] },
                .init(.hand) { p in [Stamp(["ww"], x: 1, y: 5 + p % 2), Stamp(["ww"], x: 13, y: 5 - p % 2 + 1)] },
            ]),

        ClawdEdition(
            id: "fr-pocky", name: "Pocky", collection: .franchise,
            blurb: "Bright red snack box and crisp biscuit sticks dipped in chocolate and strawberry.",
            bodyColor: 0xE02424, trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["n.h.n"], x: 5, y: 0 + p % 2), Stamp(["n.h.n"], x: 5, y: 1), Stamp(["y.y.y"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-tiger-sugar-boba", name: "Tiger Sugar Boba", collection: .franchise,
            blurb: "Caramelized brown-sugar tiger stripes, chewy tapioca pearls, and a wide straw.",
            bodyColor: 0xEDE0CC, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["kk"], x: 7, y: 0), Stamp(["kk"], x: 7, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nynnynny", "kkkkkkkk"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["n"], x: 1, y: 3 + p % 2), Stamp(["k"], x: 14, y: 9 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-patagonia", name: "Patagonia", collection: .franchise,
            blurb: "Cream pile fleece vest with anavy pocket and the jagged Fitz Roy sunset crest.",
            bodyColor: 0xEAE3D2, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["uuuuuuuu"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["ppoouuuu", "kkkkkkkk"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 14, y: 1 + p % 2), Stamp(["p"], x: 1, y: 2)] },
            ]),

        ClawdEdition(
            id: "fr-supreme", name: "Supreme", collection: .franchise,
            blurb: "Crisp red box logo across the chest and a fresh maple deck under the arm.",
            bodyColor: 0xEDEDED, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["rrwwwwrr", "rrrrrrrr"], x: 4, y: 6)] },
                .init(.hand) { p in [Stamp(["n", "n", "n"], x: 14, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-crocs", name: "Crocs", collection: .franchise,
            blurb: "Ventilated lime foam, sport-mode heel strap engaged, and tiny Jibbitz on top.",
            bodyColor: 0x78BE20, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["r.g.p.c."], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["k.k.k.k.", "kkkkkkkk"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 4 + p % 2), Stamp(["h"], x: 14, y: 3 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-rolex", name: "Rolex", collection: .franchise,
            blurb: "Emerald dial, fluted 18k gold bezel, and the five-pointed coronet on top.",
            bodyColor: 0x006039, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["g.g.g.g"], x: 4, y: 1), Stamp(["ggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["gygygygy", "eeeeeeee"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "g" : "w"], x: 14, y: 1 + p % 2), Stamp(["g"], x: 1, y: 3)] },
            ]),

        ClawdEdition(
            id: "fr-ferrari", name: "Ferrari", collection: .franchise,
            blurb: "Rosso Corsa bodywork, the yellow prancing-horse shield, and a checkered flag.",
            bodyColor: 0xD40000, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["..gkkg..", "..gggg.."], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["kw", "wk"], x: 13, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-nasa", name: "NASA", collection: .franchise,
            blurb: "Insignia blue sphere, a sweeping red vector chevron, and stars in orbit.",
            bodyColor: 0x0B3D91, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["..rrrr..", ".rr..rr."], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 3, y: 1), Stamp(["w"], x: 14 - p % 2, y: 2), Stamp(["r"], x: 14, y: 8 - p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-ups-delivery", name: "FedEx and UPS", collection: .franchise,
            blurb: "Pullman brown uniform, a gold shield on the cap, and a cardboard parcel at the door.",
            bodyColor: 0x4B3621, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["nnggnn"], x: 5, y: 1), Stamp(["nnnnnnnn"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["ppoooo", "nnnnnnnn"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["yyy", "yny"], x: 13, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "fr-polaroid", name: "Polaroid", collection: .franchise,
            blurb: "Classic five-color spectrum stripe and a white-bordered instant print.",
            bodyColor: 0xF2EFE9, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["..rogeu.", "wwwwwwww"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ww", "wc"], x: 14, y: 7 + p % 2)] },
            ]),
    ]
}
