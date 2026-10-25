import Foundation

/// The mascot's mood. Exactly one is active at a time.
enum MascotState: CaseIterable {
    case idle
    case working
    case sleepy
    case strained
    case maxed
    case locked
    case reset

    /// Higher wins when multiple conditions hold simultaneously.
    /// reset > locked > maxed > strained > working > sleepy > idle
    var priority: Int {
        switch self {
        case .reset:    return 6
        case .locked:   return 5
        case .maxed:    return 4
        case .strained: return 3
        case .working:  return 2
        case .sleepy:   return 1
        case .idle:     return 0
        }
    }

    var catalogID: String {
        switch self {
        case .idle:     return "mood-idle"
        case .working:  return "mood-working"
        case .sleepy:   return "mood-sleepy"
        case .strained: return "mood-strained"
        case .maxed:    return "mood-maxed"
        case .locked:   return "mood-locked"
        case .reset:    return "mood-reset"
        }
    }
}
