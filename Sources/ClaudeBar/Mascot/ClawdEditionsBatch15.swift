import Foundation

extension ClawdEditions {
    /// Batch 15: Tech & Dev Icons. See ClawdEditionsCore.swift for the format.
    static let batch15: [ClawdEdition] = [

        ClawdEdition(
            id: "b15-github-octocat", name: "GitHub Octocat", collection: .techIcons,
            blurb: "Cat ears on top, five tentacles below, and a green contribution grid.",
            bodyColor: 0x24292F, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["B.", "BB"], x: 4, y: 1), Stamp([".B", "BB"], x: 10, y: 1)] },
                .init(.face) { _ in [Stamp(["hhhhhh"], x: 5, y: 5)] },
                .init(.back) { p in [Stamp(["B.B.B."], x: 12, y: 8 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e.ee"], x: 0, y: 1 + p % 2), Stamp(["ee.e"], x: 0, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-docker-whale", name: "Docker Whale", collection: .techIcons,
            blurb: "A cheerful blue whale carrying a neat stack of shipping containers.",
            bodyColor: 0x2496ED, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["cc.cc.cc"], x: 4, y: 1), Stamp(["uu.uu.uu"], x: 4, y: 2), Stamp(["cc.cc"], x: 5, y: 0)] },
                .init(.back) { p in [Stamp(["BB", "B."], x: 13, y: 6 + p % 2), Stamp(["wwwwwwww"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["cwcwcwcwcwcwcwcw"], x: 0, y: 11), Stamp(["c"], x: 2, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-linux-tux", name: "Linux Tux", collection: .techIcons,
            blurb: "Black feathers, a white belly, a bright orange beak, and root access.",
            bodyColor: 0x22252A, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["oooo"], x: 6, y: 5)] },
                .init(.back) { _ in [Stamp(["wwwwww", "wwwwww"], x: 5, y: 7),
                                     Stamp(["oo"], x: 4, y: 10), Stamp(["oo"], x: 10, y: 10)] },
                .init(.aura, followsBody: false) { p in [Stamp(["e"], x: 1 + p % 2, y: 2), Stamp(["w"], x: 14, y: 1 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-rust-ferris", name: "Rust Ferris", collection: .techIcons,
            blurb: "A fellow crustacean with big friendly pincers and zero borrow-checker errors.",
            bodyColor: 0xE43717, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["B.B.B.B."], x: 4, y: 2)] },
                .init(.hand) { p in [Stamp(["BB", "B."], x: 0, y: 4 - p % 2), Stamp(["BB", ".B"], x: 14, y: 4 - p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 1 + p % 2, y: 1), Stamp(["g"], x: 14 - p % 2, y: 1)] },
            ]),

        ClawdEdition(
            id: "b15-python", name: "Python", collection: .techIcons,
            blurb: "Blue and gold twin serpents, readable syntax, and zero curly braces.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["uuuu"], x: 4, y: 1), Stamp(["uuuuuuuu"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["gggggggg"], x: 4, y: 8), Stamp(["gggg"], x: 8, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["u", "u"], x: 1, y: 3 + p % 2), Stamp(["g", "g"], x: 14, y: 6 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-swift-bird", name: "Swift Bird", collection: .techIcons,
            blurb: "Swept-back flame-orange wings built for fast compiles and strict concurrency.",
            bodyColor: 0xF05138, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["oo", "o."], x: 5, y: 1)] },
                .init(.back) { p in [Stamp(["ww", "www"], x: 1, y: 4 + p % 2), Stamp(["ww", "www"], x: 12, y: 4 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 14, y: 1 + p % 2), Stamp(["g"], x: 0, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-stack-overflow", name: "Stack Overflow", collection: .techIcons,
            blurb: "A grey tray overflowing with tilted orange bars of accepted answers.",
            trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["oooooo"], x: 5 + p % 2, y: 0), Stamp(["oooooo"], x: 5, y: 1), Stamp(["oooooo"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["d......d", "dddddddd"], x: 4, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 13, y: 1 + p % 2), Stamp(["g"], x: 1, y: 3 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-vim", name: "Vim", collection: .techIcons,
            blurb: "A green diamond V crest and a modal aura. Nobody knows how to exit.",
            bodyColor: 0x199F4B, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["ee.ee"], x: 5, y: 1), Stamp([".eee."], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["w..w", ".ww."], x: 6, y: 7)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g", "w", "r"], x: 14, y: 1 + p % 2),
                                                         Stamp(["e"], x: 1, y: 2 + p % 3)] },
            ]),

        ClawdEdition(
            id: "b15-homebrew", name: "Homebrew", collection: .techIcons,
            blurb: "A frothy golden mug of packages pouring straight into `/opt/homebrew`.",
            trademarked: true,
            parts: [
                .init(.head) { p in [Stamp(["wwwwwwww"], x: 4, y: 1), Stamp(["w.wwww.w"], x: 4, y: 2),
                                     Stamp(["w"], x: 5 + p % 3, y: 0)] },
                .init(.back) { _ in [Stamp(["gggggggg", "gggggggg"], x: 4, y: 7)] },
                .init(.hand) { _ in [Stamp(["ll", ".l", "ll"], x: 13, y: 5)] },
            ]),

        ClawdEdition(
            id: "b15-hugging-face", name: "Hugging Face", collection: .techIcons,
            blurb: "Golden smiley, rosy cheeks, and two open hands ready to share weights.",
            bodyColor: 0xFFD21E, trademarked: true,
            parts: [
                .init(.face) { _ in [Stamp(["o"], x: 4, y: 5), Stamp(["o"], x: 11, y: 5), Stamp(["kkkk"], x: 6, y: 6)] },
                .init(.hand) { p in [Stamp(["gg", "gg"], x: 1, y: 5 + p % 2), Stamp(["gg", "gg"], x: 13, y: 5 + p % 2)] },
                .init(.aura, followsBody: false) { p in [Stamp(["g"], x: 2, y: 1 + p % 2), Stamp(["o"], x: 13, y: 1 - p % 2 + 1)] },
            ]),

        ClawdEdition(
            id: "b15-arch-linux", name: "Arch Linux", collection: .techIcons,
            blurb: "A sharp cyan A-frame peak on top. Uses Arch, by the way.",
            bodyColor: 0x1793D1, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp([".cc.", "cccc"], x: 6, y: 0), Stamp(["cc..cc"], x: 5, y: 2)] },
                .init(.back) { _ in [Stamp(["ccc..ccc"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c"], x: 1, y: 2 + p % 2), Stamp(["w"], x: 14, y: 3 - p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-hacker-news", name: "Hacker News", collection: .techIcons,
            blurb: "Bright orange square, a crisp white Y, and 400 comments on the front page.",
            bodyColor: 0xFF6600, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["wwwwwwww"], x: 4, y: 2)] },
                .init(.back) { _ in [Stamp(["w..w", ".ww.", ".ww."], x: 6, y: 6)] },
                .init(.aura, followsBody: false) { p in [Stamp(["o"], x: 14, y: 1 + p % 3), Stamp(["w"], x: 1, y: 2 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-figma", name: "Figma", collection: .techIcons,
            blurb: "Five colorful pills stacked together and three multiplayer cursors hovering by.",
            trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp(["rr", "pp", "cc"], x: 6, y: 0), Stamp(["oo", "ee"], x: 8, y: 0)] },
                .init(.back) { _ in [Stamp(["rrppccoo"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["c.", "cc"], x: 1 + p % 2, y: 2), Stamp(["h.", "hh"], x: 13, y: 4 + p % 2)] },
            ]),

        ClawdEdition(
            id: "b15-vercel-triangle", name: "Vercel Triangle", collection: .techIcons,
            blurb: "Matte black pyramid, crisp white apex, deployed to the edge in two seconds.",
            bodyColor: 0x171717, trademarked: true,
            parts: [
                .init(.head) { _ in [Stamp([".ww.", "wwww", "wwwwww"], x: 5, y: 0)] },
                .init(.back) { _ in [Stamp(["wwwwwwww"], x: 4, y: 8)] },
                .init(.aura, followsBody: false) { p in [Stamp(["w"], x: 1, y: 1 + p % 2), Stamp(["l"], x: 14, y: 2 - p % 2)] },
            ]),
    ]
}
