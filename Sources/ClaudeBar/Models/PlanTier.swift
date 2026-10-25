import Foundation

/// The user's Claude plan, as far as the organizations response tells us. Anything we cannot
/// recognize is `nil`, and the popover then shows no badge rather than a wrong one.
enum PlanTier: Equatable {
    case pro, max5x, max20x, max

    init?(rateLimitTier: String?, capabilities: [String]?) {
        let tier = (rateLimitTier ?? "").lowercased()
        let caps = (capabilities ?? []).map { $0.lowercased() }
        if tier.contains("max_20x") {
            self = .max20x
        } else if tier.contains("max_5x") {
            self = .max5x
        } else if caps.contains("claude_max") || tier.contains("claude_max") {
            self = .max
        } else if caps.contains("claude_pro") || tier.contains("claude_pro") {
            self = .pro
        } else {
            return nil
        }
    }

    var badge: String {
        switch self {
        case .pro:   return "PRO"
        case .max5x:  return "MAX 5X"
        case .max20x: return "MAX 20X"
        case .max:    return "MAX"
        }
    }
}
