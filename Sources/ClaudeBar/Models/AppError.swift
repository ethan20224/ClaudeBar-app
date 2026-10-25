import Foundation

enum AppError: LocalizedError, Equatable {
    case invalidSessionKey
    case authenticationFailed
    case networkError(String)
    case keychainError(String)
    case organizationNotFound
    case decodingError(String)
    case noBrowserLogin

    var errorDescription: String? {
        switch self {
        case .invalidSessionKey:
            return "Invalid session key. Must start with sk-ant-"
        case .authenticationFailed:
            return "Session expired. Please re-enter your session key."
        case .networkError(let msg):
            return "Network error: \(msg)"
        case .keychainError(let msg):
            return "Keychain error: \(msg)"
        case .organizationNotFound:
            return "Could not find Claude organization."
        case .decodingError(let msg):
            return "Unexpected response: \(msg)"
        case .noBrowserLogin:
            return "No claude.ai login found in your browsers. Sign in to claude.ai, then press Connect again, or paste your session key."
        }
    }
}
