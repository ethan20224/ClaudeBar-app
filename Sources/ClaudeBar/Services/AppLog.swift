import os

/// Debug breadcrumbs go to the unified log (Console.app), never to a file. Callers pass state
/// and error descriptions only, never a session key or a response body.
enum AppLog {
    private static let logger = Logger(subsystem: "com.claudebar.app", category: "app")

    static func debug(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }
}
