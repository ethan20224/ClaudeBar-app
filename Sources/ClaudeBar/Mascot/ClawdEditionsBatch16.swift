import Foundation

extension ClawdEditions {
    /// Batch 16: Space & Cosmos and Art & Aesthetics. See ClawdEditionsCore.swift for the format.
    static let batch16: [ClawdEdition] = [

        // MARK: Space & Cosmos

        ClawdEdition(
            id: "b16-saturn", name: "Saturn", collection: .space,
            blurb: "Warm golden bands and a tilted ring of ice and dust orbiting the waist.",
            bodyColor: 0xD9A95B,
            parts: [
                .init(.head) { _ in [Stamp(["yyyyyyyy"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["yyggggggggggggyy"], x: 0, y: 6), Stamp(["..yyyyyyyyyyyy.."], x: 0, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 1 + p % 2), Stamp(["g"], x: 14, y: 2 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-black-hole", name: "Black Hole", collection: .space,
            blurb: "Event horizon in the middle and a blazing orange accretion disk bent by gravity.",
            bodyColor: 0x12131A,
            parts: [
                .init(.head) { _ in [Stamp(["oooo", "gggg"], x: 6, y: 1)] },
                .init(.back) { p in [Stamp([p % 2 == 0 ? "ooggggggggggoo" : "ggoooooooooogg"], x: 1, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 2 + p % 3, y: 0), Stamp(["r"], x: 13 - p % 3, y: 10)] },
            ]),

        ClawdEdition(
            id: "b16-supernova", name: "Supernova", collection: .space,
            blurb: "A star going out in style, flinging neon shockwaves across the canvas.",
            bodyColor: 0xF5B73B,
            parts: [
                .init(.head) { p in [Stamp([p % 2 == 0 ? "w.g.w" : "g.w.g"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["c", "p"], x: 1, y: 1 + p % 2), Stamp(["o", "r"], x: 14, y: 1 + (p + 1) % 2),
                    Stamp(["g"], x: 0, y: 8 - p % 2), Stamp(["h"], x: 15, y: 8 + p % 2),
                ] },
            ]),

        ClawdEdition(
            id: "b16-comet", name: "Comet", collection: .space,
            blurb: "An icy cyan nucleus trailing a sparkling dust tail across the night sky.",
            bodyColor: 0x62C8F2,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwww"], x: 5, y: 2)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["cc", "ll"], x: 12, y: 3 + p % 2),
                    Stamp(["ccc", "www"], x: 13, y: 2 - p % 2),
                    Stamp(["w"], x: 15, y: 1 + p % 3),
                ] },
            ]),

        ClawdEdition(
            id: "b16-mars-rover", name: "Mars Rover", collection: .space,
            blurb: "Six rocker-bogie wheels, a camera mast on top, and red dust everywhere.",
            bodyColor: 0xC8A97E,
            parts: [
                .init(.head) { p in [Stamp(["ll", "lc"], x: 7, y: 0), Stamp(["l"], x: 7, y: 2),
                                     Stamp([p % 2 == 0 ? "r" : "c"], x: 8, y: 0)] },
                .init(.back) { _ in [Stamp(["uuuuuuuu"], x: 4, y: 7), Stamp(["kk.kk.kk"], x: 4, y: 10)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["rrrrrrrrrrrrrrrr"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b16-jwst-telescope", name: "JWST Telescope", collection: .space,
            blurb: "Eighteen hexagonal gold mirrors and a five-layer silver sunshield.",
            bodyColor: 0x2B3040,
            parts: [
                .init(.head) { _ in [Stamp(["gggggg", "gyggyg"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["llllllllpppp"], x: 2, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "g" : "w"], x: 1, y: 1), Stamp(["r"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-solar-eclipse", name: "Solar Eclipse", collection: .space,
            blurb: "Moon-black silhouette ringed by a shimmering pearl and gold corona.",
            bodyColor: 0x16161D,
            parts: [
                .init(.head) { _ in [Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["g", "w", "g"], x: 3, y: 4), Stamp(["g", "w", "g"], x: 12, y: 4)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "w" : "g"], x: 7, y: 0), Stamp(["g"], x: 2, y: 2 + p % 2), Stamp(["g"], x: 13, y: 2 - p % 2 + 1)] },
            ]),

        ClawdEdition(
            id: "b16-nebula", name: "Nebula", collection: .space,
            blurb: "Pillars of violet, magenta, and teal starlight.",
            bodyColor: 0x7A49A5,
            parts: [
                .init(.head) { _ in [Stamp(["hppcch"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["ccpppphh"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["hp", "pc"], x: 0, y: 2 + p % 2), Stamp(["cp", "hw"], x: 14, y: 3 - p % 2),
                    Stamp(["w"], x: 2, y: 9 - p % 2),
                ] },
            ]),

        ClawdEdition(
            id: "b16-voyager-record", name: "Voyager Golden Record", collection: .space,
            blurb: "Etched in gold with pulsar maps and greetings from Earth, drifting past Pluto.",
            bodyColor: 0xD4AF37,
            parts: [
                .init(.head) { _ in [Stamp(["yyyyyyyy"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["y.g.y.g."], x: 4, y: 7), Stamp(["gggggggg"], x: 4, y: 8)] },
                .init(.hand) { p in [Stamp(["l", "l", "l"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-astronaut-ice-cream", name: "Astronaut Ice Cream", collection: .space,
            blurb: "Freeze-dried Neapolitan stripes in a foil pouch, floating in zero gravity.",
            bodyColor: 0xF2D8B3,
            parts: [
                .init(.head) { _ in [Stamp(["nnnwww", "hhhhhh"], x: 5, y: 1)] },
                .init(.back) { _ in [Stamp(["llllllll", "llllllll"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["h"], x: 1, y: 2 + p % 3), Stamp(["w"], x: 14, y: 4 - p % 2)] },
            ]),

        // MARK: Art & Aesthetics

        ClawdEdition(
            id: "b16-starry-night", name: "Starry Night", collection: .art,
            blurb: "Cobalt swirls, glowing cypress gold stars, and a painter's straw hat.",
            bodyColor: 0x264B96,
            parts: [
                .init(.head) { _ in [Stamp(["yyyyyy"], x: 5, y: 1), Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["uccuuggu"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [
                    Stamp(["gg", "gy"], x: 13, y: 0 + p % 2), Stamp(["cc", ".u"], x: 1, y: 1 + p % 2),
                    Stamp(["g"], x: 0, y: 6 - p % 2),
                ] },
            ]),

        ClawdEdition(
            id: "b16-mondrian", name: "Mondrian", collection: .art,
            blurb: "Primary red, blue, and yellow rectangles framed in crisp black gridlines.",
            bodyColor: 0xF5F5F2,
            parts: [
                .init(.head) { _ in [Stamp(["kkkkkkkk"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["rrkggkuu", "kkkkkkkk"], x: 4, y: 7)] },
                .init(.hand) { _ in [Stamp(["rr", "kk"], x: 2, y: 5), Stamp(["uu", "kk"], x: 12, y: 5)] },
            ]),

        ClawdEdition(
            id: "b16-dali", name: "Salvador Dali", collection: .art,
            blurb: "An upturned waxing mustache and a soft clock melting off the shoulder.",
            parts: [
                .init(.face) { p in [Stamp(["k....k", "kkkkkk"], x: 5, y: 5 - p % 2 * 0)] },
                .init(.head) { _ in [Stamp(["kkkkkk"], x: 5, y: 2)] },
                .init(.hand) { p in [Stamp(["gg", "gw", ".g"], x: 13, y: 5 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-great-wave", name: "Great Wave", collection: .art,
            blurb: "Prussian blue crests, white foam claws, and tiny Mount Fuji on the horizon.",
            bodyColor: 0x1F4E79,
            parts: [
                .init(.head) { p in [Stamp(["wwww", "uuuu"], x: 5 + p % 2, y: 1)] },
                .init(.back) { _ in [Stamp(["wcwccwcw"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp([".w.", "uuu"], x: 13, y: 8), Stamp(["w"], x: 1, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-pop-art", name: "Pop Art", collection: .art,
            blurb: "Screen-printed magenta, cyan, and halftone yellow straight off the factory wall.",
            bodyColor: 0xE83E8C,
            parts: [
                .init(.head) { _ in [Stamp(["gggggggg"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["ccccpppp"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g.g"], x: 0, y: 1 + p % 2), Stamp(["c.c"], x: 13, y: 9 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-origami", name: "Origami", collection: .art,
            blurb: "Crisp diagonal paper creases folded from a single square sheet of crane paper.",
            bodyColor: 0xF4EFEA,
            parts: [
                .init(.head) { _ in [Stamp(["l..ll..l"], x: 4, y: 2), Stamp([".ll..ll."], x: 4, y: 3)] },
                .init(.back) { _ in [Stamp(["ll....ll", ".ll..ll."], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["r.", "rr"], x: 14, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-stained-glass", name: "Stained Glass", collection: .art,
            blurb: "Lead-lined jewel panes of ruby, emerald, sapphire, and amber catching the sun.",
            bodyColor: 0x222228,
            parts: [
                .init(.head) { _ in [Stamp(["rkekckgk"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["ckpkokrk", "kkkkkkkk"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp([p % 2 == 0 ? "g" : "c"], x: 1, y: 2), Stamp([p % 2 == 0 ? "h" : "e"], x: 14, y: 3)] },
            ]),

        ClawdEdition(
            id: "b16-marble-statue", name: "Marble Statue", collection: .art,
            blurb: "Chiseled Carrara marble, a laurel crown, and a pedestal worthy of a museum.",
            bodyColor: 0xE6E4E0,
            parts: [
                .init(.head) { _ in [Stamp(["e.e.e.e."], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["llllllll"], x: 4, y: 8), Stamp(["dddddddddd"], x: 3, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 13, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b16-blueprint", name: "Blueprint", collection: .art,
            blurb: "Cyanotype grid lines, white dimension ticks, and exact 16x12 tolerances.",
            bodyColor: 0x1B5E91,
            parts: [
                .init(.head) { _ in [Stamp(["w.w.w.w."], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8), Stamp(["c.c.c.c."], x: 4, y: 6)] },
                .init(.aura, followsBody: false) { _ in [Stamp(["w..............w"], x: 0, y: 0), Stamp(["w..............w"], x: 0, y: 11)] },
            ]),

        ClawdEdition(
            id: "b16-glitch-art", name: "Glitch Art", collection: .art,
            blurb: "Chromatic aberration, shifted scanlines, and a V-sync that gave up.",
            parts: [
                .init(.head) { p in [Stamp(["cccc"], x: 3 + p % 2, y: 2), Stamp(["hhhh"], x: 9 - p % 2, y: 2)] },
                .init(.back) { p in [Stamp(p % 2 == 0 ? ["cc....hh"] : ["hh....cc"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 0, y: 4 + p % 3), Stamp(["r"], x: 15, y: 5 - p % 2)] },
            ]),
    ]
}
