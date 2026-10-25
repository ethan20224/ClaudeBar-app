import SwiftUI

/// Usage percentage drawn as pixel digits plus a pixel "%". Glyphs are 3x5 cells, 4-cell advance.
struct PixelNumeral: View {
    let value: Int
    let cell: CGFloat
    let digitColor: Color
    let percentColor: Color

    init(value: Int, cell: CGFloat = 6, digitColor: Color, percentColor: Color) {
        self.value = min(max(value, 0), 100)
        self.cell = cell
        self.digitColor = digitColor
        self.percentColor = percentColor
    }

    private static let glyphs: [Character: [UInt8]] = [
        "0": [0b111, 0b101, 0b101, 0b101, 0b111],
        "1": [0b010, 0b110, 0b010, 0b010, 0b111],
        "2": [0b111, 0b001, 0b111, 0b100, 0b111],
        "3": [0b111, 0b001, 0b111, 0b001, 0b111],
        "4": [0b101, 0b101, 0b111, 0b001, 0b001],
        "5": [0b111, 0b100, 0b111, 0b001, 0b111],
        "6": [0b111, 0b100, 0b111, 0b101, 0b111],
        "7": [0b111, 0b001, 0b001, 0b001, 0b001],
        "8": [0b111, 0b101, 0b111, 0b101, 0b111],
        "9": [0b111, 0b101, 0b111, 0b001, 0b111],
        "%": [0b101, 0b001, 0b010, 0b100, 0b101],
    ]

    private var text: String { "\(value)%" }

    var body: some View {
        let chars = Array(text)
        let cell = self.cell
        let digitColor = self.digitColor
        let percentColor = self.percentColor
        Canvas { ctx, _ in
            for (i, ch) in chars.enumerated() {
                guard let rows = Self.glyphs[ch] else { continue }
                let color = ch == "%" ? percentColor : digitColor
                let ox = CGFloat(i * 4) * cell
                for (r, bits) in rows.enumerated() {
                    for c in 0..<3 where bits & (0b100 >> UInt8(c)) != 0 {
                        let rect = CGRect(x: (ox + CGFloat(c) * cell).rounded(),
                                          y: (CGFloat(r) * cell).rounded(),
                                          width: cell.rounded(),
                                          height: cell.rounded())
                        ctx.fill(Path(rect), with: .color(color))
                    }
                }
            }
        }
        .frame(width: CGFloat(chars.count * 4 - 1) * cell, height: 5 * cell)
        .accessibilityElement()
        .accessibilityLabel("\(value) percent")
    }
}
