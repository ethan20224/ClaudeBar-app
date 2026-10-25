import Foundation

extension UsagePeriod {
    /// Fraction (0...1) of the current window already elapsed. nil when the reset date is unknown.
    var elapsedFraction: Double? {
        guard let remaining = timeUntilReset, periodSeconds > 0 else { return nil }
        return min(1, max(0, 1 - remaining / periodSeconds))
    }
}
