import Foundation

/// Collectible card surface finishes in the Clawdex, remembered per edition.
enum ClawdCardFinish: String, CaseIterable, Hashable {
    case matte, clay, gold, prismatic, obsidian

    var title: String {
        switch self {
        case .matte:     return "Matte"
        case .clay:      return "Clay Foil"
        case .gold:      return "Gold Holo"
        case .prismatic: return "Prismatic"
        case .obsidian:  return "Obsidian"
        }
    }
}

/// Everything Clawd remembers between launches: unlocked items, the user's pins,
/// install date, and each day's peak usage (for the "calm days" unlock).
final class ClawdProgress {
    private let defaults: UserDefaults
    private let unlockedKey = "clawd.unlocked"
    private let pinsKey = "clawd.pins"
    private let installKey = "clawd.installDate"
    private let peaksKey = "clawd.dailyPeaks"
    private let editionKey = "clawd.edition"
    private let favoritesKey = "clawd.favorites"
    private let seenKey = "clawd.seenEditions"
    private let cardFinishesKey = "clawd.cardFinishes"

    static let shinyOdds: UInt64 = 40
    static let calmThreshold: Double = 50

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if defaults.object(forKey: installKey) == nil {
            defaults.set(Date().timeIntervalSinceReferenceDate, forKey: installKey)
        }
        // Idle is always known.
        _ = unlock("mood-idle")
    }

    var installDate: Date {
        Date(timeIntervalSinceReferenceDate: defaults.double(forKey: installKey))
    }

    // MARK: Unlocks

    var unlocked: Set<String> {
        Set(defaults.stringArray(forKey: unlockedKey) ?? [])
    }

    func isUnlocked(_ id: String) -> Bool { unlocked.contains(id) }

    /// Returns true if `id` was newly unlocked.
    @discardableResult
    func unlock(_ id: String) -> Bool {
        var set = unlocked
        guard set.insert(id).inserted else { return false }
        defaults.set(Array(set).sorted(), forKey: unlockedKey)
        return true
    }

    /// Unlocks every earnable item whose condition holds now. Returns the new ids.
    @discardableResult
    func evaluate(_ ctx: ClawdContext) -> [String] {
        var fresh: [String] = []
        for item in ClawdCatalog.outfits + [ClawdCatalog.golden, ClawdCatalog.wizard] where item.earn(ctx) {
            if unlock(item.id) { fresh.append(item.id) }
        }
        if Self.shinyColor(on: ctx.now, calendar: ctx.calendar) != nil, unlock("shiny") {
            fresh.append("shiny")
        }
        return fresh
    }

    // MARK: Pins (wear this instead of the automatic pick)

    var pins: [ClawdSlot: String] {
        let raw = defaults.dictionary(forKey: pinsKey) as? [String: String] ?? [:]
        var out: [ClawdSlot: String] = [:]
        for (k, v) in raw { if let slot = ClawdSlot(rawValue: k) { out[slot] = v } }
        return out
    }

    /// Everything can be picked from day one; unlocks only decide what is worn automatically.
    func pin(_ item: ClawdItem) {
        guard let slot = item.slot else { return }
        var raw = defaults.dictionary(forKey: pinsKey) as? [String: String] ?? [:]
        raw[slot.rawValue] = item.id
        defaults.set(raw, forKey: pinsKey)
    }

    func unpin(slot: ClawdSlot) {
        var raw = defaults.dictionary(forKey: pinsKey) as? [String: String] ?? [:]
        raw[slot.rawValue] = nil
        defaults.set(raw, forKey: pinsKey)
    }

    func clearPins() { defaults.removeObject(forKey: pinsKey) }

    // MARK: Picks: scene and micro-moments

    var sceneChoice: String? {
        get { defaults.string(forKey: "clawd.sceneChoice") }
        set { defaults.set(newValue, forKey: "clawd.sceneChoice") }
    }

    var disabledMicros: Set<String> { Set(defaults.stringArray(forKey: "clawd.disabledMicros") ?? []) }

    func setMicro(_ key: String, enabled: Bool) {
        var set = disabledMicros
        if enabled { set.remove(key) } else { set.insert(key) }
        defaults.set(Array(set).sorted(), forKey: "clawd.disabledMicros")
    }

    // MARK: Editions (all unlocked from day one; the user picks one to wear)

    var edition: String? {
        get { defaults.string(forKey: editionKey).flatMap { ClawdEditions.edition($0) != nil ? $0 : nil } }
        set { defaults.set(newValue, forKey: editionKey) }
    }

    var favorites: Set<String> { Set(defaults.stringArray(forKey: favoritesKey) ?? []) }

    func toggleFavorite(_ id: String) {
        var set = favorites
        if set.contains(id) { set.remove(id) } else { set.insert(id) }
        defaults.set(Array(set).sorted(), forKey: favoritesKey)
    }

    var seenEditions: Set<String> { Set(defaults.stringArray(forKey: seenKey) ?? []) }

    func markSeen(_ ids: [String]) {
        defaults.set(Array(seenEditions.union(ids)).sorted(), forKey: seenKey)
    }

    var cardFinishes: [String: ClawdCardFinish] {
        let raw = defaults.dictionary(forKey: cardFinishesKey) as? [String: String] ?? [:]
        var out: [String: ClawdCardFinish] = [:]
        for (k, v) in raw {
            if let finish = ClawdCardFinish(rawValue: v) { out[k] = finish }
        }
        return out
    }

    func cardFinish(for editionID: String) -> ClawdCardFinish {
        cardFinishes[editionID] ?? .matte
    }

    func setCardFinish(_ finish: ClawdCardFinish, for editionID: String) {
        var raw = defaults.dictionary(forKey: cardFinishesKey) as? [String: String] ?? [:]
        raw[editionID] = finish == .matte ? nil : finish.rawValue
        defaults.set(raw, forKey: cardFinishesKey)
    }

    // MARK: Calm days

    private func dayKey(_ date: Date, _ calendar: Calendar) -> String {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", c.year ?? 0, c.month ?? 0, c.day ?? 0)
    }

    /// Track the day's peak 5-hour utilization. Days with no usage are not recorded.
    func recordPoll(utilization: Double, now: Date, calendar: Calendar = .current) {
        guard utilization > 0 else { return }
        var peaks = defaults.dictionary(forKey: peaksKey) as? [String: Double] ?? [:]
        let key = dayKey(now, calendar)
        peaks[key] = max(peaks[key] ?? 0, utilization)
        if peaks.count > 90 { for old in peaks.keys.sorted().prefix(peaks.count - 90) { peaks[old] = nil } }
        defaults.set(peaks, forKey: peaksKey)
    }

    /// Consecutive days, ending today or yesterday, whose peak stayed under the calm threshold.
    func calmDays(now: Date, calendar: Calendar = .current) -> Int {
        let peaks = defaults.dictionary(forKey: peaksKey) as? [String: Double] ?? [:]
        var day = calendar.startOfDay(for: now)
        if peaks[dayKey(day, calendar)] == nil, let y = calendar.date(byAdding: .day, value: -1, to: day) { day = y }
        var count = 0
        while let peak = peaks[dayKey(day, calendar)], peak < Self.calmThreshold {
            count += 1
            guard let prev = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = prev
        }
        return count
    }

    // MARK: Shiny

    /// Deterministic per calendar day (FNV-1a), so a shiny day stays shiny all day.
    static func shinyColor(on date: Date, calendar: Calendar = .current) -> UInt32? {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        let key = "\(c.year ?? 0)-\(c.month ?? 0)-\(c.day ?? 0)-clawd"
        var hash: UInt64 = 0xcbf29ce484222325
        for byte in key.utf8 { hash = (hash ^ UInt64(byte)) &* 0x100000001b3 }
        guard hash % shinyOdds == 0 else { return nil }
        return ClawdCatalog.shinyColors[Int((hash / shinyOdds) % UInt64(ClawdCatalog.shinyColors.count))]
    }
}
