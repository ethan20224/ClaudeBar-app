import Foundation

final class UsageHistoryRepository {
    private let maxSnapshots = 500
    private let key = "usageHistory"
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    private var history: [UsageSnapshot] {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
            return (try? decoder.decode([UsageSnapshot].self, from: data)) ?? []
        }
        set {
            let pruned = Array(newValue.suffix(maxSnapshots))
            if let data = try? encoder.encode(pruned) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }

    func append(snapshot: UsageSnapshot) {
        var current = history
        current.append(snapshot)
        history = current
    }

    func snapshots(last24Hours: Bool = true) -> [UsageSnapshot] {
        let filtered = history.filter { snapshot in
            if !last24Hours { return true }
            return snapshot.timestamp.timeIntervalSinceNow > -86400
        }
        return filtered
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
