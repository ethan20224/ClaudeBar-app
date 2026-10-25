import Foundation

final class StreakTracker {
    private let defaults: UserDefaults
    private let calendar: Calendar
    private let lastDayKey = "mascot.lastActiveDay"
    private let countKey = "mascot.streakCount"

    init(defaults: UserDefaults, calendar: Calendar = .current) {
        self.defaults = defaults
        self.calendar = calendar
    }

    var currentStreak: Int { defaults.integer(forKey: countKey) }

    func recordActivity(active: Bool, on day: Date) {
        guard active else { return }
        let today = calendar.startOfDay(for: day)

        guard defaults.object(forKey: lastDayKey) != nil else {
            store(day: today, count: 1)
            return
        }
        let lastDay = Date(timeIntervalSinceReferenceDate: defaults.double(forKey: lastDayKey))
        let lastStart = calendar.startOfDay(for: lastDay)

        if calendar.isDate(today, inSameDayAs: lastStart) {
            return // idempotent
        }
        let dayDiff = calendar.dateComponents([.day], from: lastStart, to: today).day ?? 0
        if dayDiff == 1 {
            store(day: today, count: currentStreak + 1)
        } else {
            store(day: today, count: 1) // gap (or past date) resets
        }
    }

    private func store(day: Date, count: Int) {
        defaults.set(day.timeIntervalSinceReferenceDate, forKey: lastDayKey)
        defaults.set(count, forKey: countKey)
    }
}
