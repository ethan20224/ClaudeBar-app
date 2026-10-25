import AppKit

/// Trackpad haptics via the Taptic Engine.
///
/// Uses `NSHapticFeedbackManager` — the ONLY macOS API that drives the
/// MacBook Force Touch trackpad. (CoreHaptics reports `supportsHaptics == false`
/// on Mac trackpads; it targets game controllers, so it silently does nothing
/// here.) No intensity/sharpness control exists — only three native feels.
///
/// One single perform per action: no layered taps, so it reads as one clean,
/// present press rather than a cheap staccato buzz. We deliberately avoid
/// `.alignment` (thin/crisp = the "cheap" feel) and lean on `.levelChange`,
/// the fullest, most present native tap.
enum HapticService {
    private static var performer: NSHapticFeedbackPerformer {
        NSHapticFeedbackManager.defaultPerformer
    }

    /// Opening the popover — fullest, most present tap.
    static func playOpen() {
        performer.perform(.levelChange, performanceTime: .now)
    }

    /// Closing the popover — same family, lighter body for a subtle difference.
    static func playClose() {
        performer.perform(.generic, performanceTime: .now)
    }

    /// Refresh tapped — mirrors open.
    static func playRefresh() {
        performer.perform(.levelChange, performanceTime: .now)
    }

    /// Petting Clawd — soft, one gentle tap.
    static func playPet() {
        performer.perform(.generic, performanceTime: .now)
    }
}
