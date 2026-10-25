import SwiftUI
import AppKit

/// User choice for the popover look. `system` follows macOS.
enum AppearanceMode: String, CaseIterable, Identifiable {
    case system, light, dark

    static let key = "appearanceMode"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light:  return "Light"
        case .dark:   return "Dark"
        }
    }

    /// Nil means "use whatever the system says".
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }

    var nsAppearance: NSAppearance? {
        switch self {
        case .system: return nil
        case .light:  return NSAppearance(named: .aqua)
        case .dark:   return NSAppearance(named: .darkAqua)
        }
    }

    var next: AppearanceMode {
        switch self {
        case .system: return .light
        case .light:  return .dark
        case .dark:   return .system
        }
    }

    static var stored: AppearanceMode {
        AppearanceMode(rawValue: UserDefaults.standard.string(forKey: key) ?? "") ?? .system
    }
}

extension PixelIcon {
    static let sun: [CGRect] = [
        CGRect(x: 4, y: 3, width: 4, height: 6), CGRect(x: 3, y: 4, width: 6, height: 4),
        CGRect(x: 5, y: 0, width: 2, height: 2), CGRect(x: 5, y: 10, width: 2, height: 2),
        CGRect(x: 0, y: 5, width: 2, height: 2), CGRect(x: 10, y: 5, width: 2, height: 2),
    ]
    static let moon: [CGRect] = [
        CGRect(x: 4, y: 1, width: 5, height: 2), CGRect(x: 2, y: 3, width: 4, height: 2),
        CGRect(x: 8, y: 3, width: 2, height: 2), CGRect(x: 1, y: 5, width: 4, height: 2),
        CGRect(x: 2, y: 7, width: 4, height: 2), CGRect(x: 8, y: 7, width: 2, height: 2),
        CGRect(x: 4, y: 9, width: 5, height: 2),
    ]
    /// Half-filled square: "follow the system".
    static let auto: [CGRect] = [
        CGRect(x: 1, y: 1, width: 5, height: 10),
        CGRect(x: 6, y: 1, width: 5, height: 2), CGRect(x: 6, y: 9, width: 5, height: 2),
        CGRect(x: 9, y: 3, width: 2, height: 6),
    ]
}

/// Header button that cycles System, Light, Dark. State lives in UserDefaults so
/// the Preferences picker and every window stay in sync.
struct AppearanceToggleButton: View {
    var theme: CartridgeTheme
    @AppStorage(AppearanceMode.key) private var raw: String = AppearanceMode.system.rawValue

    private var mode: AppearanceMode { AppearanceMode(rawValue: raw) ?? .system }

    private var icon: [CGRect] {
        switch mode {
        case .system: return PixelIcon.auto
        case .light:  return PixelIcon.sun
        case .dark:   return PixelIcon.moon
        }
    }

    var body: some View {
        Button {
            raw = mode.next.rawValue
        } label: {
            PixelIcon(rects: icon, size: CGSize(width: 12, height: 12), color: theme.muted)
                .frame(width: 22, height: 22)
                .contentShape(Rectangle())
        }
        .buttonStyle(RefreshButtonStyle())
        .help("Appearance: \(mode.title). Click for \(mode.next.title).")
        .accessibilityLabel("Appearance")
        .accessibilityValue(mode.title)
    }
}
