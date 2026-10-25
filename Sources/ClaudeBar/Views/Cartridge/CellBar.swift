import SwiftUI

/// Segmented pixel usage bar. Hero = sunrise-to-night sky with a knob; slim = weekly strip.
struct CellBar: View {
    enum Kind { case hero, slim }

    let fraction: Double
    let kind: Kind
    let theme: CartridgeTheme

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.popoverRevealed) private var revealed
    @State private var hasAppeared = false

    init(fraction: Double, kind: Kind, theme: CartridgeTheme) {
        self.fraction = fraction
        self.kind = kind
        self.theme = theme
    }

    private var clamped: Double {
        fraction.isFinite ? min(1, max(0, fraction)) : 0
    }

    var body: some View {
        // Cells fill up from empty each time the popover opens.
        let displayed = (revealed || reduceMotion) ? clamped : 0
        CellBarCanvas(fraction: displayed, kind: kind, theme: theme)
            .frame(maxWidth: .infinity)
            .frame(height: kind == .hero ? 18 : 8)
            .animation(
                (hasAppeared && !reduceMotion)
                    ? Animation.timingCurve(0.23, 1, 0.32, 1, duration: 0.3)
                    : nil,
                value: displayed
            )
            .onAppear { hasAppeared = true }
            .accessibilityElement()
            .accessibilityLabel("Usage")
            .accessibilityValue("\(Int(clamped * 100)) percent")
    }
}

private struct CellBarCanvas: View, Animatable {
    var fraction: Double
    let kind: CellBar.Kind
    let theme: CartridgeTheme

    var animatableData: Double {
        get { fraction }
        set { fraction = newValue }
    }

    private static let cellW: CGFloat = 8
    private static let gap: CGFloat = 2
    private static let pitch: CGFloat = 10

    var body: some View {
        Canvas { context, size in
            draw(context: context, size: size)
        }
    }

    private func draw(context: GraphicsContext, size: CGSize) {
        let n = max(1, Int(floor((size.width + Self.gap) / Self.pitch)))
        let f = min(1, max(0, fraction))
        var filled = Int((Double(n) * f).rounded())
        if f > 0 { filled = max(1, filled) }
        if f < 0.995 { filled = min(filled, n - 1) }
        filled = min(filled, n)

        let hero = kind == .hero
        let cellH: CGFloat = hero ? 12 : 8
        let cellY = (size.height - cellH) / 2
        let fullWidth = CGFloat(n) * Self.pitch - Self.gap
        let env = context.environment

        for i in 0..<n {
            let x = CGFloat(i) * Self.pitch
            let rect = CGRect(x: x, y: cellY, width: Self.cellW, height: cellH)
            let on = i < filled
            let color: Color
            if hero {
                color = on ? Self.sky(at: Double(x / fullWidth), env: env) : theme.cellOff
            } else {
                color = on ? theme.weeklyOn : theme.weeklyOff
            }
            context.fill(Path(rect), with: .color(color))
        }

        guard hero else { return }

        // Stars: deterministic positions, bright over filled region, dim over the rest.
        let filledEnd = CGFloat(filled) * Self.pitch - Self.gap
        var i = 0
        while true {
            let sx = 9 + CGFloat(i) * 24 + CGFloat((i * 7) % 5)
            if sx + 2 > fullWidth { break }
            let sy = cellY + 1 + CGFloat((i * 5 + 3) % 9)
            let rect = CGRect(x: sx, y: sy, width: 2, height: 2)
            if sx + 2 <= filledEnd {
                let opacity = 0.7 + 0.1 * Double(i % 3)
                context.fill(Path(rect), with: .color(Color.white.opacity(opacity)))
            } else if sx >= filledEnd {
                context.fill(Path(rect), with: .color(theme.ink.opacity(0.25)))
            }
            i += 1
        }

        // Knob.
        let knobW: CGFloat = 12
        let knobX: CGFloat
        if filled == 0 {
            knobX = 0
        } else {
            knobX = min(max(0, CGFloat(filled) * Self.pitch - knobW), max(0, size.width - knobW))
        }
        context.fill(Path(CGRect(x: knobX, y: 0, width: knobW, height: 18)), with: .color(theme.knobFace))
        let lastColor: Color = filled == 0
            ? Self.sky(at: 0, env: env)
            : Self.sky(at: Double(CGFloat(filled - 1) * Self.pitch / fullWidth), env: env)
        context.fill(Path(CGRect(x: knobX + 3, y: 3, width: 6, height: 12)), with: .color(lastColor))
    }

    /// Linear sRGB interpolation across CartridgeTheme.skyStops.
    private static func sky(at t: Double, env: EnvironmentValues) -> Color {
        let stops = CartridgeTheme.skyStops
        let t = min(1, max(0, t))
        guard let first = stops.first, let last = stops.last else { return .clear }
        if t <= first.location { return first.color }
        if t >= last.location { return last.color }
        for k in 1..<stops.count {
            let a = stops[k - 1], b = stops[k]
            if t <= b.location {
                let span = b.location - a.location
                let u = span > 0 ? (t - a.location) / span : 0
                let ra = a.color.resolve(in: env), rb = b.color.resolve(in: env)
                let r = Double(ra.red) + (Double(rb.red) - Double(ra.red)) * u
                let g = Double(ra.green) + (Double(rb.green) - Double(ra.green)) * u
                let bl = Double(ra.blue) + (Double(rb.blue) - Double(ra.blue)) * u
                return Color(.sRGB, red: r, green: g, blue: bl, opacity: 1)
            }
        }
        return last.color
    }
}
