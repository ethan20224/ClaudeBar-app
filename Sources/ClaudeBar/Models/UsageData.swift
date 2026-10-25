import Foundation

struct UsagePeriod {
    let utilization: Double
    let resetsAt: Date?
    let periodSeconds: TimeInterval

    var nextResetDate: Date? {
        guard let resetsAt else { return nil }
        var candidate = resetsAt
        while candidate.timeIntervalSinceNow <= 0 {
            candidate = candidate.addingTimeInterval(periodSeconds)
        }
        return candidate
    }

    var timeUntilReset: TimeInterval? {
        guard let next = nextResetDate else { return nil }
        return next.timeIntervalSinceNow
    }

    var formattedCountdown: String {
        guard let interval = timeUntilReset else { return "–" }
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        if hours > 0 {
            return "\(hours)h\(String(format: "%02d", minutes))m"
        }
        return "\(minutes)m"
    }

    var formattedResetTime: String {
        guard let next = nextResetDate else { return "Unknown" }
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: next)
    }

    var color: UsageColor {
        switch utilization {
        case ..<60: return .green
        case 60..<80: return .yellow
        default: return .red
        }
    }
}

enum UsageColor {
    case green, yellow, red
}

struct UsageData {
    let fiveHour: UsagePeriod
    let sevenDay: UsagePeriod
    let fetchedAt: Date
}
