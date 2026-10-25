import SwiftUI

/// Three pixel cells that light in sequence, plus a caps label.
struct CartridgeLoadingView: View {
    let text: String
    let theme: CartridgeTheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(text: String, theme: CartridgeTheme) {
        self.text = text
        self.theme = theme
    }

    var body: some View {
        HStack(spacing: 10) {
            if reduceMotion {
                cells(lit: -1)
            } else {
                TimelineView(.periodic(from: .now, by: 0.4)) { ctx in
                    cells(lit: Int(ctx.date.timeIntervalSinceReferenceDate / 0.4) % 3)
                }
            }
            Text(text.uppercased())
                .font(CartridgeFont.font(12))
                .tracking(1.2)
                .foregroundStyle(theme.muted)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(text)
    }

    private func cells(lit: Int) -> some View {
        HStack(spacing: 3) {
            ForEach(0..<3, id: \.self) { i in
                Rectangle()
                    .fill(i == lit ? theme.tagInk : theme.cellOff)
                    .frame(width: 6, height: 6)
            }
        }
    }
}

/// Pixel warning mark, message, and a RETRY button.
struct CartridgeErrorView: View {
    let message: String
    let theme: CartridgeTheme
    let retry: () -> Void

    init(message: String, theme: CartridgeTheme, retry: @escaping () -> Void) {
        self.message = message
        self.theme = theme
        self.retry = retry
    }

    var body: some View {
        VStack(spacing: 10) {
            warningMark
            Text(message)
                .font(.system(size: 12))
                .foregroundStyle(theme.muted)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .textSelection(.enabled)
            Button(action: retry) {
                Text("RETRY")
            }
            .buttonStyle(CartridgeStateButtonStyle(theme: theme))
        }
        .frame(maxWidth: .infinity)
        .padding(20)
    }

    /// 7x7 triangle with exclamation mark.
    private var warningMark: some View {
        let rows = [
            "...#...",
            "..###..",
            "..#.#..",
            ".##.##.",
            ".##.##.",
            "#######",
            "#######",
        ].map { Array($0) }
        let cell: CGFloat = 3
        return Canvas { ctx, _ in
            for (y, row) in rows.enumerated() {
                for (x, ch) in row.enumerated() where ch == "#" {
                    let r = CGRect(x: CGFloat(x) * cell, y: CGFloat(y) * cell, width: cell, height: cell)
                    ctx.fill(Path(r), with: .color(theme.amber))
                }
            }
        }
        .frame(width: cell * 7, height: cell * 7)
        .accessibilityHidden(true)
    }
}

/// Outlined pixel button: 1px border, caps label, press scale 0.97.
struct CartridgeStateButtonStyle: ButtonStyle {
    let theme: CartridgeTheme
    var enabled: Bool = true
    @Environment(\.isFocused) private var isFocused

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(CartridgeFont.font(12, bold: true))
            .tracking(1.2)
            .foregroundStyle(theme.ink.opacity(enabled ? 1 : 0.4))
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(configuration.isPressed ? theme.cellOff : Color.clear)
            .overlay(Rectangle().strokeBorder(isFocused ? theme.tagInk : theme.tagBorder, lineWidth: isFocused ? 2 : 1))
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
            .contentShape(Rectangle())
    }
}
