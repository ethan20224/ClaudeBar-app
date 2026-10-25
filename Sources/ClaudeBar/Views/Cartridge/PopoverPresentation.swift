import SwiftUI
import Observation

/// Drives the popover's open sequence. `revealed` flips true just after the popover shows and back
/// to false once it has closed, so every open replays the same entrance.
@MainActor
@Observable
final class PopoverPresentation {
    var revealed = false
    /// Horizontal position of the menu bar icon within the popover (0...1), the scale origin.
    var anchorX: Double = 0.5
}

private struct PopoverRevealedKey: EnvironmentKey {
    static let defaultValue = true
}

extension EnvironmentValues {
    var popoverRevealed: Bool {
        get { self[PopoverRevealedKey.self] }
        set { self[PopoverRevealedKey.self] = newValue }
    }
}

/// Fade + 6pt rise, staggered by row index. Content is the second beat after the panel itself.
private struct RevealStagger: ViewModifier {
    let index: Int
    @Environment(\.popoverRevealed) private var revealed
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        let shown = revealed || reduceMotion
        content
            .opacity(shown ? 1 : 0)
            .offset(y: shown ? 0 : 6)
            .animation(
                reduceMotion ? nil : Animation.timingCurve(0.23, 1, 0.32, 1, duration: 0.26).delay(0.04 * Double(index)),
                value: revealed
            )
    }
}

extension View {
    func revealStagger(_ index: Int) -> some View { modifier(RevealStagger(index: index)) }
}
