import Foundation

enum BrowserCookieService {
    static func extractSessionKey() -> String? {
        if let key = ChromeCookieReader.extractSessionKey() {
            return key
        }
        if let key = SafariCookieReader.extractSessionKey() {
            return key
        }
        return nil
    }
}
