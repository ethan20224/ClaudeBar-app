import Foundation

extension ClawdEditions {
    /// Batch 17: Tabletop & Games, Everyday Objects, and Vehicles & Rides.
    static let batch17: [ClawdEdition] = [

        // MARK: Tabletop & Games

        ClawdEdition(
            id: "b17-d20-crit", name: "D20 Critical Hit", collection: .tabletop,
            blurb: "Faceted crimson icosahedron rolling a natural twenty right on the table.",
            bodyColor: 0xC62828,
            parts: [
                .init(.head) { _ in [Stamp(["g.gggg.g"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["g..gg..g", ".gggggg."], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 1, y: 1 + p % 2), Stamp(["w"], x: 14, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-chess-king", name: "Chess King", collection: .tabletop,
            blurb: "Carved ivory crown with a cross finial on top, moving one careful square at a time.",
            bodyColor: 0xEDE6D6,
            parts: [
                .init(.head) { _ in [Stamp([".g.", "ggg", ".g."], x: 6, y: 0), Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["kwkwkwkwkwkwkwkw"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b17-monopoly-tycoon", name: "Monopoly Tycoon", collection: .tabletop,
            blurb: "Tall silk top hat, a gold monocle, a white mustache, and hotels on Boardwalk.",
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkk"], x: 5, y: 0), Stamp(["kkkkkk"], x: 5, y: 1), Stamp(["kkkkkkkk"], x: 4, y: 2)] },
                .init(.face) { _ in [Stamp(["g"], x: 10, y: 3), Stamp(["wwwwww"], x: 5, y: 6)] },
                .init(.hand) { p in [Stamp(["ee", "eg"], x: 14, y: 5 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-poker-royal-flush", name: "Poker Royal Flush", collection: .tabletop,
            blurb: "Ace of spades on the chest, a stack of casino chips, and a stone-cold poker face.",
            bodyColor: 0xF7F7F7,
            parts: [
                .init(.head) { _ in [Stamp(["rr....rr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp([".kk.", "kkkk", ".kk."], x: 6, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["rr", "ww", "uu"], x: 0, y: 8), Stamp(["r"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-mahjong-dragon", name: "Mahjong Dragon Tile", collection: .tabletop,
            blurb: "Smooth ivory face, bamboo green backing, and a red dragon carved in the center.",
            bodyColor: 0xF5EFE2,
            parts: [
                .init(.head) { _ in [Stamp(["eeeeeeee"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["..rrrr..", "...rr..."], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e", "w"], x: 14, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-8-ball", name: "8-Ball", collection: .tabletop,
            blurb: "Glossy billiard black with a white number circle. Outlook is decidedly good.",
            bodyColor: 0x1A1A20,
            parts: [
                .init(.head) { _ in [Stamp(["ww"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["..wwww..", "..wkkw.."], x: 4, y: 6)] },
                .init(.hand) { p in [Stamp(["y", "y", "y", "c"], x: 14, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-tarot-magician", name: "Tarot Magician", collection: .tabletop,
            blurb: "An infinity halo overhead, a gold-trimmed border, and all four suits at hand.",
            parts: [
                .init(.head) { _ in [Stamp(["gg..gg"], x: 5, y: 0), Stamp([".gggg."], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr", "gggggggg"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 0, y: 1 + p % 3), Stamp(["g"], x: 15, y: 1 + (p + 1) % 3)] },
            ]),

        ClawdEdition(
            id: "b17-domino", name: "Domino", collection: .tabletop,
            blurb: "Black tile, brass spinner pin in the middle, and white pips ready to topple.",
            bodyColor: 0x202026,
            parts: [
                .init(.head) { _ in [Stamp(["w..w..w."], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["gggggggg", "w.w..w.w"], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["k", "k"], x: 14, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-claw-machine", name: "Claw Machine", collection: .tabletop,
            blurb: "A shiny three-pronged arcade claw descending from the top of the cabinet.",
            parts: [
                .init(.head) { p in [Stamp(["ll"], x: 7, y: 0), Stamp(["l..l"], x: 6, y: 1 + p % 2), Stamp(["l....l"], x: 5, y: 2)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["rrrrrrrrrrrrrrrr"], x: 0, y: 11), Stamp(["h", "c"], x: 1, y: 9), Stamp(["g", "p"], x: 14, y: 9)] },
            ]),

        // MARK: Everyday Objects

        ClawdEdition(
            id: "b17-lava-lamp", name: "Lava Lamp", collection: .objects,
            blurb: "Silver cap and base with warm magenta wax blobs drifting up and down.",
            bodyColor: 0x3A1C71,
            parts: [
                .init(.head) { _ in [Stamp(["llll"], x: 6, y: 1), Stamp(["dddddd"], x: 5, y: 2)] },
                .init(.back) { p in [Stamp(p % 2 == 0 ? ["..hh..oo", "dddddddd"] : ["oo..hh..", "dddddddd"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 6, y: 4 - p % 2), Stamp(["o"], x: 9, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-snow-globe", name: "Snow Globe", collection: .objects,
            blurb: "A wooden plinth underneath and a gentle swirl of white flakes when shaken.",
            parts: [
                .init(.head) { _ in [Stamp(["cccccc"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["nnnnnnnnnn"], x: 3, y: 10)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["w"], x: 2 + p % 3, y: 2), Stamp(["w"], x: 13 - p % 3, y: 3),
                    Stamp(["w"], x: 4, y: 1 + p % 2), Stamp(["c"], x: 11, y: 1 + (p + 1) % 2),
                ] },
            ]),

        ClawdEdition(
            id: "b17-toaster", name: "Toaster", collection: .objects,
            blurb: "Brushed chrome sides, a push lever on the right, and two golden slices popping up.",
            bodyColor: 0xB8BEC6,
            parts: [
                .init(.head) { p in [Stamp(["yyy..yyy", "nyy..yyn"], x: 4, y: p % 2 == 0 ? 0 : 1)] },
                .init(.back) { _ in [Stamp(["dddddddd"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["k", "r"], x: 14, y: 6 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-swiss-army-knife", name: "Swiss Army Knife", collection: .objects,
            blurb: "Iconic red scales, a white cross emblem, and a gadget for every occasion.",
            bodyColor: 0xD32F2F,
            parts: [
                .init(.back) { _ in [Stamp(["...ww...", "..wwww..", "...ww..."], x: 4, y: 6)] },
                .init(.hand) { p in [Stamp(["ll", "l."], x: 0, y: 3 + p % 2), Stamp(["ll", ".l"], x: 14, y: 3 - p % 2 + 1)] },
            ]),

        ClawdEdition(
            id: "b17-polaroid-camera", name: "Polaroid Camera", collection: .objects,
            blurb: "A rainbow stripe down the front, a flashbar on top, and a fresh photo sliding out.",
            bodyColor: 0xEAE6DF,
            parts: [
                .init(.head) { _ in [Stamp(["dddddd"], x: 5, y: 1), Stamp(["llcwll"], x: 5, y: 2)] },
                .init(.back) { p in [Stamp(["rogeu"], x: 6, y: 6), Stamp(["wwww", "wccw"], x: 6, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-vinyl-turntable", name: "Vinyl Turntable", collection: .objects,
            blurb: "Spinning black grooves, a warm red center label, and a silver tonearm on the track.",
            bodyColor: 0x1F1F24,
            parts: [
                .init(.head) { _ in [Stamp(["dddddddd"], x: 4, y: 2)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "ddrrrrdd" : "d.rrrr.d"], x: 4, y: 7)] },
                .init(.hand) { _ in [Stamp(["l", "l", "g"], x: 13, y: 4)] },
            ]),

        ClawdEdition(
            id: "b17-gumball-machine", name: "Gumball Machine", collection: .objects,
            blurb: "A cast-iron red base, a coin slot, and a glass dome full of colorful sweets.",
            bodyColor: 0xD82E2E,
            parts: [
                .init(.head) { p in [Stamp(["rgecup", "hocgpp"], x: 5, y: 1 + p % 2 * 0)] },
                .init(.back) { _ in [Stamp(["llll"], x: 6, y: 7), Stamp(["rrrrrrrr"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "c" : "h"], x: 14, y: 8)] },
            ]),

        ClawdEdition(
            id: "b17-traffic-light", name: "Traffic Light", collection: .objects,
            blurb: "Signal yellow housing cycling smoothly through red, amber, and green.",
            bodyColor: 0x2C2E33,
            parts: [
                .init(.head) { _ in [Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { p in [
                    Stamp([p % 3 == 0 ? "rr" : "oo"], x: 7, y: 6),
                    Stamp([p % 3 == 1 ? "gg" : "ee"], x: 7, y: 8),
                ] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "e" : "g"], x: 14, y: 3)] },
            ]),

        ClawdEdition(
            id: "b17-disco-ball", name: "Disco Ball", collection: .objects,
            blurb: "Mirrored silver tiles throwing glints of light across the whole menu bar.",
            bodyColor: 0xB8C0C8,
            parts: [
                .init(.head) { _ in [Stamp(["ll"], x: 7, y: 0), Stamp(["lwldwl"], x: 5, y: 2)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "wlwldlwd" : "dwlwlwdl"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1 + p % 3, y: 1), Stamp(["c"], x: 14 - p % 3, y: 2), Stamp(["h"], x: 0, y: 8 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-tamagotchi-egg", name: "Tamagotchi Egg", collection: .objects,
            blurb: "Pastel shell, a tiny bead chain on top, and three little buttons at the bottom.",
            bodyColor: 0x7ED6DF,
            parts: [
                .init(.head) { _ in [Stamp(["ll"], x: 7, y: 0), Stamp(["h.h.h."], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["g.g.g"], x: 5, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "h" : "g"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-cuckoo-clock", name: "Cuckoo Clock", collection: .objects,
            blurb: "Carved chalet roof, swinging brass pendulum, and a little bird on the hour.",
            bodyColor: 0x7A4B2A,
            parts: [
                .init(.head) { _ in [Stamp([".nn.", "nnnnnn", "nnnnnnnn"], x: 4, y: 0)] },
                .init(.hand) { p in [Stamp(["cc", "co"], x: 13 + p % 2, y: 4)] },
                .init(.back) { p in [Stamp(["g"], x: 7 + p % 2, y: 10)] },
            ]),

        // MARK: Vehicles & Rides

        ClawdEdition(
            id: "b17-f1-racer", name: "F1 Racer", collection: .vehicles,
            blurb: "Scuderia red livery, rear wing spoiler, and soft-compound slick tires.",
            bodyColor: 0xD92323,
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrrrr", "kkkk"], x: 4, y: 1)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 7), Stamp(["kk"], x: 2, y: 9), Stamp(["kk"], x: 12, y: 9)] },
                .init(.aura, followsBody: false) { p in [Stamp(["kwkw"], x: 0, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-yellow-submarine", name: "Yellow Submarine", collection: .vehicles,
            blurb: "Sunny yellow hull, round portholes, and a periscope scanning the waves.",
            bodyColor: 0xF5C82E,
            parts: [
                .init(.head) { p in [Stamp(p % 2 == 0 ? ["gg", "g."] : ["gg", ".g"], x: 7, y: 0), Stamp(["g"], x: 7, y: 2)] },
                .init(.back) { _ in [Stamp(["c.c.c."], x: 5, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: 3 - p % 2), Stamp(["w"], x: 14, y: 9 - p % 3)] },
            ]),

        ClawdEdition(
            id: "b17-hot-air-balloon", name: "Hot Air Balloon", collection: .vehicles,
            blurb: "Rainbow canopy panels, a twin burner flame, and a wicker basket below.",
            bodyColor: 0xE65C40,
            parts: [
                .init(.head) { _ in [Stamp(["rcgeph"], x: 5, y: 1), Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnn"], x: 6, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["www"], x: 1, y: 2 + p % 2), Stamp(["www"], x: 12, y: 1 + (p + 1) % 2)] },
            ]),

        ClawdEdition(
            id: "b17-steam-train", name: "Steam Train", collection: .vehicles,
            blurb: "Cast-iron smokestack, brass bell, cowcatcher, and puffs of white steam.",
            bodyColor: 0x262930,
            parts: [
                .init(.head) { _ in [Stamp(["kkkk", ".kk."], x: 6, y: 0), Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["rrrrrrrr", "gggggggg"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["ww"], x: 8 + p % 3, y: 0), Stamp(["l"], x: 12 + p % 2, y: 0)] },
            ]),

        ClawdEdition(
            id: "b17-monster-truck", name: "Monster Truck", collection: .vehicles,
            blurb: "Oversized mud tires, chrome exhaust stacks, and flame decals on the fenders.",
            bodyColor: 0x1E6AE1,
            parts: [
                .init(.head) { _ in [Stamp(["l....l"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["ooggooggoo"], x: 3, y: 7), Stamp(["kkk..kkk"], x: 4, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 4, y: 0 + p % 2), Stamp(["o"], x: 11, y: 0 + (p + 1) % 2)] },
            ]),

        ClawdEdition(
            id: "b17-mech-suit", name: "Mech Suit", collection: .vehicles,
            blurb: "V-fin antenna crest, shoulder thrusters, and cockpit hatches locked in.",
            bodyColor: 0xDCE1E8,
            parts: [
                .init(.head) { _ in [Stamp(["g..g", ".gg."], x: 6, y: 0), Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu", "rrrrrrrr"], x: 4, y: 7)] },
                .init(.hand) { p in [Stamp(["dd", "cc"], x: 1, y: 4 + p % 2), Stamp(["dd", "cc"], x: 13, y: 4 - p % 2 + 1)] },
            ]),

        ClawdEdition(
            id: "b17-pirate-ship", name: "Pirate Ship", collection: .vehicles,
            blurb: "Billowing white sails, an oak hull, and a jolly roger flying from the mainmast.",
            bodyColor: 0x6E4726,
            parts: [
                .init(.head) { _ in [Stamp(["kw", "kk"], x: 7, y: 0), Stamp(["wwwwww"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["cccccccccccccccc"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b17-vespa-scooter", name: "Vespa Scooter", collection: .vehicles,
            blurb: "Mint-green curves, a round chrome headlamp, and a breezy ride through Rome.",
            bodyColor: 0x68C3A3,
            parts: [
                .init(.head) { _ in [Stamp(["llgll"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnnnn"], x: 4, y: 7), Stamp(["kk....kk"], x: 4, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["l"], x: 1, y: 8 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b17-skateboarder", name: "Skateboarder", collection: .vehicles,
            blurb: "Backwards cap, a maple deck underfoot, and orange urethane wheels mid-kickflip.",
            parts: [
                .init(.head) { _ in [Stamp(["rrrrrr"], x: 5, y: 1), Stamp(["rrrrrrrr"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["nnnnnnnnnn"], x: 3, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o....o"], x: 5, y: 11 - p % 2 * 0)] },
            ]),

        ClawdEdition(
            id: "b17-jetpack", name: "Jetpack", collection: .vehicles,
            blurb: "Twin silver thrusters strapped to the back and a trail of orange rocket exhaust.",
            parts: [
                .init(.head) { _ in [Stamp(["cccccccc"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["ll", "ll"], x: 2, y: 5), Stamp(["ll", "ll"], x: 12, y: 5)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp([p % 2 == 0 ? "or" : "go"], x: 2, y: 8 + p % 2),
                    Stamp([p % 2 == 0 ? "go" : "or"], x: 12, y: 8 + p % 2),
                ] },
            ]),
    ]
}
