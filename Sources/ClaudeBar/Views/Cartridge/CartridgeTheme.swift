import SwiftUI

extension Color {
    /// 0xRRGGBB, sRGB.
    init(cartridge hex: UInt32, opacity: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue: Double(hex & 0xFF) / 255,
                  opacity: opacity)
    }
}

/// Palette for the "Cartridge" popover: a warm ink card in dark mode, warm paper in light mode.
struct CartridgeTheme {
    let isDark: Bool
    let card: Color
    let border: Color
    let ink: Color
    let muted: Color
    let tagBorder: Color
    let tagInk: Color
    let cellOff: Color
    let weeklyOn: Color
    let weeklyOff: Color
    let knobFace: Color
    let sage: Color
    let amber: Color
    let ember: Color

    static func resolve(_ scheme: ColorScheme) -> CartridgeTheme {
        scheme == .dark ? .dark : .light
    }

    static let dark = CartridgeTheme(
        isDark: true,
        card: Color(cartridge: 0x1E1613),
        border: Color.white.opacity(0.10),
        ink: Color(cartridge: 0xF3E6D8),
        muted: Color(cartridge: 0xB89F8C),
        tagBorder: Color(cartridge: 0x5B4337),
        tagInk: Color(cartridge: 0xE6B79B),
        cellOff: Color(cartridge: 0x2C211C),
        weeklyOn: Color(cartridge: 0xB8957F),
        weeklyOff: Color(cartridge: 0x2B201A),
        knobFace: Color(cartridge: 0xF3E6D8),
        sage: Color(cartridge: 0x9CC283),
        amber: Color(cartridge: 0xE8A23F),
        ember: Color(cartridge: 0xE2573A)
    )

    static let light = CartridgeTheme(
        isDark: false,
        card: Color(cartridge: 0xF7EFE5),
        border: Color.black.opacity(0.10),
        ink: Color(cartridge: 0x2A1D17),
        muted: Color(cartridge: 0x7A6558),
        tagBorder: Color(cartridge: 0xD9C3B2),
        tagInk: Color(cartridge: 0xA45A3C),
        cellOff: Color(cartridge: 0xE6D8C8),
        weeklyOn: Color(cartridge: 0xA07D68),
        weeklyOff: Color(cartridge: 0xE9DCCD),
        knobFace: Color(cartridge: 0x2A1D17),
        sage: Color(cartridge: 0x5F8F4E),
        amber: Color(cartridge: 0xC98414),
        ember: Color(cartridge: 0xCC4528)
    )

    /// Sunrise to night. The usage bar reveals this left to right.
    static let skyStops: [Gradient.Stop] = [
        .init(color: Color(cartridge: 0xF4C78E), location: 0),
        .init(color: Color(cartridge: 0xE0885F), location: 0.45),
        .init(color: Color(cartridge: 0xD4573F), location: 0.8),
        .init(color: Color(cartridge: 0x8F3F7A), location: 1),
    ]

    /// Same thresholds the app already uses (`UsagePeriod.color`): green < 60, yellow < 80, red.
    func level(_ color: UsageColor) -> Color {
        switch color {
        case .green: return sage
        case .yellow: return amber
        case .red: return ember
        }
    }

    /// Whole-card warning glow, only at the red level.
    func glow(_ color: UsageColor) -> Color? {
        color == .red ? ember : nil
    }
}
