import Foundation

enum ClawdSlot: String, CaseIterable {
    case head, face, hand, back, aura, skin, edition
}

/// Everything the catalog needs to decide what Clawd wears right now.
struct ClawdContext {
    var now: Date
    var calendar: Calendar = .current
    var utilization: Double = 0
    var burnPerHour: Double = 0
    var streak: Int = 0
    var calmDays: Int = 0
    var installDate: Date
    var claudeLive: Bool = false
    var liveMinutes: Double = 0
    var regionCode: String?

    var hour: Int { calendar.component(.hour, from: now) }
    var month: Int { calendar.component(.month, from: now) }
    var day: Int { calendar.component(.day, from: now) }

    /// True when today falls inside [from, to] (month/day), wrapping over New Year.
    func isWithin(_ from: (Int, Int), _ to: (Int, Int)) -> Bool {
        let today = month * 100 + day
        let a = from.0 * 100 + from.1
        let b = to.0 * 100 + to.1
        return a <= b ? (today >= a && today <= b) : (today >= a || today <= b)
    }
}

struct ClawdItem {
    enum Kind { case mood, outfit, scene, skin }

    let id: String
    let name: String
    let kind: Kind
    let slot: ClawdSlot?
    /// How to get it, shown in the Clawdex while locked.
    let hint: String
    /// True once the unlock condition holds (checked on every poll; unlocks are permanent).
    let earn: (ClawdContext) -> Bool
    /// Whether it is worn automatically right now (only consulted once unlocked).
    let wear: (ClawdContext) -> Bool
    /// Overlay art for a given animation phase. Canvas coordinates, body-relative.
    let stamps: (Int) -> [Stamp]
    /// Auras and scenery do not bob with the body.
    let followsBody: Bool
    /// Readable at 18pt tall; items that are not still show in the popover, simplified in the bar.
    let menuBarSafe: Bool

    init(id: String, name: String, kind: Kind, slot: ClawdSlot? = nil, hint: String,
         earn: @escaping (ClawdContext) -> Bool,
         wear: @escaping (ClawdContext) -> Bool = { _ in false },
         followsBody: Bool = true, menuBarSafe: Bool = true,
         stamps: @escaping (Int) -> [Stamp] = { _ in [] }) {
        self.id = id; self.name = name; self.kind = kind; self.slot = slot; self.hint = hint
        self.earn = earn; self.wear = wear; self.stamps = stamps
        self.followsBody = followsBody; self.menuBarSafe = menuBarSafe
    }
}

enum ClawdCatalog {
    // MARK: Outfits (worn automatically; first match per slot wins, so order is priority)

    static let newYear = ClawdItem(
        id: "newyear", name: "New Year's Eve", kind: .outfit, slot: .head,
        hint: "Dec 31 – Jan 2",
        earn: { $0.isWithin((12, 31), (1, 2)) }, wear: { $0.isWithin((12, 31), (1, 2)) },
        stamps: { p in
            [Stamp(["ww"], x: 7, y: 0), Stamp(["rggr"], x: 6, y: 1), Stamp(["cwwwwc"], x: 5, y: 2)]
                + ClawdArt.confetti(phase: p)
        })

    static let patriot = ClawdItem(
        id: "patriot", name: "Patriot", kind: .outfit, slot: .head,
        hint: "July 1 – 7 (US)",
        earn: { $0.isWithin((7, 1), (7, 7)) && ($0.regionCode == nil || $0.regionCode == "US") },
        wear: { $0.isWithin((7, 1), (7, 7)) && ($0.regionCode == nil || $0.regionCode == "US") },
        stamps: { p in
            let cape = p % 2 == 0
                ? Stamp(["uu", "rw", "wr", "rw", "wr", "rw"], x: 14, y: 3)
                : Stamp(["uu", "wr", "rw", "wr", "rw", "wr"], x: 14, y: 4)
            return [Stamp(["uwuuuu"], x: 5, y: 0), Stamp(["rwrwrw"], x: 5, y: 1), Stamp(["uuuuuuuu"], x: 4, y: 2), cape]
        })

    static let witch = ClawdItem(
        id: "witch", name: "Witch Hat", kind: .outfit, slot: .head,
        hint: "All of October",
        earn: { $0.month == 10 }, wear: { $0.month == 10 },
        stamps: { _ in [Stamp(["dd"], x: 7, y: 0), Stamp(["dppd"], x: 6, y: 1), Stamp(["dddddddddd"], x: 3, y: 2)] })

    static let santa = ClawdItem(
        id: "santa", name: "Santa Hat", kind: .outfit, slot: .head,
        hint: "December",
        earn: { $0.month == 12 }, wear: { $0.month == 12 },
        stamps: { _ in [Stamp([".rrrw"], x: 7, y: 0), Stamp(["rrrrrr"], x: 5, y: 1), Stamp(["wwwwwwww"], x: 4, y: 2)] })

    static let stPatrick = ClawdItem(
        id: "stpatrick", name: "Lucky Hat", kind: .outfit, slot: .head,
        hint: "March 14 – 17",
        earn: { $0.isWithin((3, 14), (3, 17)) }, wear: { $0.isWithin((3, 14), (3, 17)) },
        stamps: { _ in [Stamp(["eeeeee"], x: 5, y: 0), Stamp(["eeggee"], x: 5, y: 1), Stamp(["eeeeeeee"], x: 4, y: 2)] })

    static let party = ClawdItem(
        id: "party", name: "Party Hat", kind: .outfit, slot: .head,
        hint: "Your install anniversary",
        earn: { c in
            let a = c.calendar.dateComponents([.month, .day, .year], from: c.installDate)
            let y = c.calendar.component(.year, from: c.now)
            return a.month == c.month && a.day == c.day && (a.year ?? y) < y
        },
        wear: { c in
            let a = c.calendar.dateComponents([.month, .day], from: c.installDate)
            return a.month == c.month && a.day == c.day
        },
        stamps: { p in
            [Stamp(["ww"], x: 7, y: 0), Stamp(["rggr"], x: 6, y: 1), Stamp(["cwwwwc"], x: 5, y: 2)]
                + ClawdArt.confetti(phase: p)
        })

    static let crown = ClawdItem(
        id: "crown", name: "Crown", kind: .outfit, slot: .head,
        hint: "30-day streak",
        earn: { $0.streak >= 30 }, wear: { _ in true },
        stamps: { _ in [Stamp(["g..gg..g"], x: 4, y: 1), Stamp(["gggrrggg"], x: 4, y: 2)] })

    static let headphones = ClawdItem(
        id: "headphones", name: "Headphones", kind: .outfit, slot: .head,
        hint: "Late nights, 11pm – 5am",
        earn: { $0.hour >= 23 || $0.hour < 5 }, wear: { $0.hour >= 23 || $0.hour < 5 },
        stamps: { _ in [Stamp(["dddddddd"], x: 4, y: 2), Stamp(["d", "d"], x: 3, y: 3), Stamp(["d", "d"], x: 12, y: 3)] })

    static let ninja = ClawdItem(
        id: "ninja", name: "Ninja Headband", kind: .outfit, slot: .head,
        hint: "5 calm days in a row (peak under 50%)",
        earn: { $0.calmDays >= 5 }, wear: { _ in true },
        stamps: { p in
            [Stamp(["rrrrrrrr"], x: 4, y: 3), Stamp(["ll"], x: 7, y: 3),
             p % 2 == 0 ? Stamp(["rrr", ".r."], x: 12, y: 3) : Stamp(["rr.", "..r"], x: 12, y: 3)]
        })

    static let shades = ClawdItem(
        id: "shades", name: "Shades", kind: .outfit, slot: .face,
        hint: "7-day streak — worn when usage is low",
        earn: { $0.streak >= 7 }, wear: { $0.utilization < 15 },
        stamps: { _ in [Stamp([".kkwkkkkwkk."], x: 2, y: 4), Stamp(["...kk..kk..."], x: 2, y: 5)] })

    static let mug = ClawdItem(
        id: "mug", name: "Coffee Mug", kind: .outfit, slot: .hand,
        hint: "Mornings, 5am – 11am",
        earn: { $0.hour >= 5 && $0.hour < 11 }, wear: { $0.hour >= 5 && $0.hour < 11 },
        stamps: { p in
            [Stamp(["nn", "ww", "ww"], x: 14, y: 5),
             Stamp(["l"], x: 14 + (p % 2), y: 3 - (p % 2)), Stamp(["l"], x: 15 - (p % 2), y: 2)]
        })

    static let prideCape = ClawdItem(
        id: "pride", name: "Pride Cape", kind: .outfit, slot: .back,
        hint: "June",
        earn: { $0.month == 6 }, wear: { $0.month == 6 },
        stamps: { p in
            let rows = p % 2 == 0 ? ["rr", "oo", "gg", "ee", "cc", "pp"] : ["r.", "oo", "g.", "ee", "c.", "pp"]
            return [Stamp(rows, x: 14, y: 3 + (p % 2))]
        })

    static let hearts = ClawdItem(
        id: "valentine", name: "Valentine Hearts", kind: .outfit, slot: .aura,
        hint: "Feb 10 – 14",
        earn: { $0.isWithin((2, 10), (2, 14)) }, wear: { $0.isWithin((2, 10), (2, 14)) },
        followsBody: false,
        stamps: { p in
            [Stamp(["h.h", "hhh", ".h."], x: 0, y: 8 - (p % 4) * 2),
             Stamp(["h.h", "hhh", ".h."], x: 13, y: 6 - (p % 3) * 2 + 2)]
        })

    static let golden = ClawdItem(
        id: "golden", name: "Golden Clawd", kind: .skin, slot: .skin,
        hint: "100-day streak",
        earn: { $0.streak >= 100 }, wear: { _ in true },
        followsBody: false, stamps: { ClawdArt.sparkleAura(phase: $0) })

    static let shiny = ClawdItem(
        id: "shiny", name: "Shiny Clawd", kind: .skin, slot: .skin,
        hint: "Rare random day — about 1 in 40",
        earn: { _ in false }, wear: { _ in false },
        followsBody: false, stamps: { ClawdArt.sparkleAura(phase: $0) })

    /// Pick-only shiny colors (the random "shiny day" keeps its own id above).
    static let shinyPicks: [ClawdItem] = ["Teal", "Violet", "Pink", "Lime", "Sky"].enumerated().map { i, name in
        ClawdItem(id: "shiny\(i)", name: "Shiny \(name)", kind: .skin, slot: .skin,
                  hint: "Pick any shiny color", earn: { _ in false }, wear: { _ in false },
                  followsBody: false, stamps: { ClawdArt.sparkleAura(phase: $0) })
    }

    // MARK: Scenes and moods (listed so the Clawdex can show and unlock them)

    static let treadmill = ClawdItem(
        id: "treadmill", name: "Treadmill", kind: .scene,
        hint: "Burn usage fast while Claude works",
        earn: { _ in false }, menuBarSafe: true)

    static let wizard = ClawdItem(
        id: "wizard", name: "Wizard", kind: .scene,
        hint: "Keep Claude Code running for 45 minutes",
        earn: { $0.liveMinutes >= 45 })

    static func mood(_ id: String, _ name: String, _ hint: String) -> ClawdItem {
        ClawdItem(id: "mood-\(id)", name: name, kind: .mood, hint: hint, earn: { _ in false })
    }

    static let moods: [ClawdItem] = [
        mood("idle", "Idle", "Always around"),
        mood("working", "Working", "Claude is running"),
        mood("sleepy", "Napping", "30 quiet minutes"),
        mood("strained", "Sweating", "Usage at 75%"),
        mood("maxed", "Red-hot", "Usage at 90%"),
        mood("locked", "Ghost", "Usage at 100%"),
        mood("reset", "Finish line", "Your limit resets"),
        mood("pet", "Happy", "Pet Clawd in the popover"),
    ]

    /// Auto-wear priority = array order within a slot.
    static let outfits: [ClawdItem] = [
        newYear, patriot, witch, santa, stPatrick, party, crown, headphones, ninja,
        shades, mug, prideCape, hearts,
    ]
    static let skins: [ClawdItem] = [golden] + shinyPicks
    static let scenes: [ClawdItem] = [treadmill, wizard]

    static let all: [ClawdItem] = moods + outfits + skins + scenes

    static func item(_ id: String) -> ClawdItem? { all.first { $0.id == id } ?? (id == "shiny" ? shiny : nil) }

    /// Shiny body colors, picked by the day's roll.
    static let shinyColors: [UInt32] = [0x2FB5A8, 0x8E6BE8, 0xE86BA8, 0x8BC34A, 0x6BB8E8]
}
