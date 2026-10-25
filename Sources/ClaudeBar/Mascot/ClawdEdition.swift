import Foundation

/// Shelves in the Clawdex. Order here is the sidebar order.
enum ClawdCollection: String, CaseIterable {
    case characters, fantasy, cultures, holidays, food, devLife, animals, jobs,
         claudeLife, sports, sea, myths, retro, decades, nature, music, prehistoric, cozy,
         videoGames, techIcons, space, art, tabletop, objects, vehicles,
         franchise

    var title: String {
        switch self {
        case .characters: return "Characters"
        case .fantasy:    return "Fantasy & Sci-fi"
        case .cultures:   return "Around the World"
        case .holidays:   return "Holidays"
        case .food:       return "Food"
        case .devLife:    return "Dev Life"
        case .animals:    return "Animals"
        case .jobs:       return "Jobs & Hobbies"
        case .claudeLife: return "Claude Life"
        case .sports:     return "Sports"
        case .sea:        return "Under the Sea"
        case .myths:      return "Myths & Monsters"
        case .retro:      return "Retro Tech"
        case .decades:    return "Through the Decades"
        case .nature:     return "Nature & Weather"
        case .music:      return "Music Scenes"
        case .prehistoric: return "Prehistoric"
        case .cozy:       return "Cozy"
        case .videoGames: return "Video Games"
        case .techIcons:  return "Tech & Dev Icons"
        case .space:      return "Space & Cosmos"
        case .art:        return "Art & Aesthetics"
        case .tabletop:   return "Tabletop & Games"
        case .objects:    return "Everyday Objects"
        case .vehicles:   return "Vehicles & Rides"
        case .franchise:  return "Movies & Brands"
        }
    }

    var symbol: String {
        switch self {
        case .characters: return "theatermasks"
        case .fantasy:    return "wand.and.stars"
        case .cultures:   return "globe.europe.africa"
        case .holidays:   return "gift"
        case .food:       return "fork.knife"
        case .devLife:    return "terminal"
        case .animals:    return "pawprint"
        case .jobs:       return "briefcase"
        case .claudeLife: return "sparkles"
        case .sports:     return "sportscourt"
        case .sea:        return "fish"
        case .myths:      return "moon.stars"
        case .retro:      return "desktopcomputer"
        case .decades:    return "clock.arrow.circlepath"
        case .nature:     return "cloud.sun"
        case .music:      return "music.note"
        case .prehistoric: return "fossil.shell"
        case .cozy:       return "cup.and.saucer"
        case .videoGames: return "gamecontroller"
        case .techIcons:  return "cpu"
        case .space:      return "moon.stars.fill"
        case .art:        return "paintpalette"
        case .tabletop:   return "die.face.5"
        case .objects:    return "lamp.desk"
        case .vehicles:   return "car.fill"
        case .franchise:  return "film"
        }
    }
}

/// A full-character edition: a costume, creature or persona, not a single prop.
/// Parts are drawn like outfits (per slot, body-relative) so moods can still
/// take over a slot (a warning face never hides behind a prop).
struct ClawdEdition {
    struct Part {
        let slot: ClawdSlot
        let followsBody: Bool
        /// Art for an animation phase; canvas coordinates (16x12), body at (2, 3).
        let stamps: (Int) -> [Stamp]

        init(_ slot: ClawdSlot, followsBody: Bool = true, _ stamps: @escaping (Int) -> [Stamp]) {
            self.slot = slot; self.followsBody = followsBody; self.stamps = stamps
        }
    }

    let id: String
    let name: String
    let collection: ClawdCollection
    let blurb: String
    /// Optional recolor of the body (status colors still win over this).
    let bodyColor: UInt32?
    /// Depicts a real franchise, brand or character. Excluded when `ClawdEditions.includeTrademarked` is false.
    let trademarked: Bool
    let parts: [Part]

    init(id: String, name: String, collection: ClawdCollection, blurb: String,
         bodyColor: UInt32? = nil, trademarked: Bool = false, parts: [Part]) {
        self.id = id; self.name = name; self.collection = collection
        self.blurb = blurb; self.bodyColor = bodyColor; self.trademarked = trademarked; self.parts = parts
    }
}
