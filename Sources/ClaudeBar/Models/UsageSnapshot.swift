import Foundation

struct UsageSnapshot: Codable {
    let timestamp: Date
    let fiveHourPercent: Double
    let sevenDayPercent: Double
}
