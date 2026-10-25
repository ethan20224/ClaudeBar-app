import SwiftUI

/// Pixel-banded sky for the mascot stage. 6pt grid, six 2-cell bands, sun and stars driven by window progress.
struct SkyBackdrop: View {
    let elapsed: Double?
    let isDark: Bool

    init(elapsed: Double?, isDark: Bool) {
        self.elapsed = elapsed
        self.isDark = isDark
    }

    private static let cell: CGFloat = 6
    private static let bandCount = 6

    // MARK: Pure logic

    private static func rgb(_ hex: UInt32) -> (Double, Double, Double) {
        (Double((hex >> 16) & 0xFF), Double((hex >> 8) & 0xFF), Double(hex & 0xFF))
    }

    private static func mix(_ a: (Double, Double, Double), _ b: (Double, Double, Double), _ t: Double) -> (Double, Double, Double) {
        let t = min(max(t, 0), 1)
        return (a.0 + (b.0 - a.0) * t, a.1 + (b.1 - a.1) * t, a.2 + (b.2 - a.2) * t)
    }

    private static func color(_ c: (Double, Double, Double)) -> Color {
        Color(.sRGB, red: c.0 / 255, green: c.1 / 255, blue: c.2 / 255, opacity: 1)
    }

    private static func clamp01(_ e: Double) -> Double { min(max(e, 0), 1) }

    static func skyColors(elapsed: Double?, isDark: Bool) -> [Color] {
        let s = elapsed.map { sin(Double.pi * clamp01($0)) } ?? 0
        let top = isDark ? mix(rgb(0x1B1317), rgb(0x4A2F32), s) : mix(rgb(0xCFC8DE), rgb(0xA3CBE8), s)
        let horizon = isDark ? mix(rgb(0x3A252A), rgb(0xC9775A), s) : mix(rgb(0xEBDADF), rgb(0xF6E8D6), s)
        var bands = (0..<bandCount).map { i in
            mix(top, horizon, Double(i) / Double(bandCount - 1))
        }
        if let e = elapsed {
            let e = clamp01(e)
            if e > 0.85 {
                let k = min((e - 0.85) / 0.10, 1)
                bands[4] = mix(bands[4], isDark ? rgb(0x7A3A2E) : rgb(0xF2C2A8), k)
                bands[5] = mix(bands[5], isDark ? rgb(0x9A4630) : rgb(0xF0AE8E), k)
            }
            if e < 0.08 {
                let k = 1 - e / 0.08
                bands[4] = mix(bands[4], isDark ? rgb(0x8A4A38) : rgb(0xF4CDB0), 0.6 * k)
                bands[5] = mix(bands[5], isDark ? rgb(0xC07850) : rgb(0xF2BE98), 0.7 * k)
            }
        }
        return bands.map(color)
    }

    static func sunCell(elapsed: Double, cols: Int, rows: Int) -> (col: Int, row: Int) {
        let e = clamp01(elapsed)
        let s = sin(Double.pi * e)
        let w = Double(cols) * Double(cell)
        let h = Double(rows) * Double(cell)
        let x = 10 + e * (w - 38)
        let y = (h - 22) - s * (h - 34)
        return (Int((x / Double(cell)).rounded()), Int((y / Double(cell)).rounded()))
    }

    private static let starCells: [(col: Int, row: Int, weight: Double)] = [
        (3, 1, 1.0), (9, 3, 0.7), (14, 0, 0.9), (20, 2, 0.6), (27, 1, 1.0),
        (33, 3, 0.7), (38, 0, 0.9), (43, 2, 0.8), (46, 1, 0.6), (6, 0, 0.6),
    ]

    private static func sunColors(_ e: Double, isDark: Bool) -> (body: Color, highlight: Color) {
        let day = isDark ? (rgb(0xFFD9A0), rgb(0xFFE9CF)) : (rgb(0xFFBE4A), rgb(0xFFE08A))
        let dusk = (rgb(0xFF9A6A), rgb(0xFFC29A))
        let rise = (rgb(0xFFB878), rgb(0xFFD9A8))
        var body = day.0, hi = day.1
        if e > 0.85 {
            let k = min((e - 0.85) / 0.10, 1)
            body = mix(day.0, dusk.0, k); hi = mix(day.1, dusk.1, k)
        } else if e < 0.08 {
            let k = 1 - e / 0.08
            body = mix(day.0, rise.0, k); hi = mix(day.1, rise.1, k)
        }
        return (color(body), color(hi))
    }

    // MARK: View

    var body: some View {
        let elapsed = self.elapsed
        let isDark = self.isDark
        Canvas { ctx, size in
            let c = Self.cell
            let colors = Self.skyColors(elapsed: elapsed, isDark: isDark)
            let bandH = c * 2
            let bandsH = bandH * CGFloat(Self.bandCount)
            // Anchor bands to the bottom of the frame, extend the top band upward if taller.
            let yOff = size.height - bandsH
            for (i, col) in colors.enumerated() {
                let y0 = i == 0 ? 0 : yOff + CGFloat(i) * bandH
                let y1 = i == colors.count - 1 ? size.height : yOff + CGFloat(i + 1) * bandH
                ctx.fill(Path(CGRect(x: 0, y: y0, width: size.width, height: max(y1 - y0, 0))), with: .color(col))
            }

            let s = elapsed.map { sin(Double.pi * Self.clamp01($0)) } ?? 0
            if s <= 0.6 {
                let starHex: UInt32 = isDark ? 0xB09A90 : 0x8A7FA8
                let cols = Int(size.width / c)
                for star in Self.starCells where star.col < cols && star.row < 4 {
                    let op = (1 - s) * star.weight
                    let rect = CGRect(x: CGFloat(star.col) * c + 2, y: CGFloat(star.row) * c + 2, width: 2, height: 2)
                    ctx.fill(Path(rect), with: .color(Color(cartridge: starHex, opacity: op)))
                }
            }

            if let e = elapsed {
                let cols = Int(size.width / c)
                let rows = Int(size.height / c)
                let p = Self.sunCell(elapsed: e, cols: cols, rows: rows)
                let sc = Self.sunColors(Self.clamp01(e), isDark: isDark)
                let x = CGFloat(p.col) * c, y = CGFloat(p.row) * c
                ctx.fill(Path(CGRect(x: x, y: y, width: c * 3, height: c * 3)), with: .color(sc.body))
                ctx.fill(Path(CGRect(x: x + c, y: y, width: c, height: c)), with: .color(sc.highlight))
            }
        }
        .accessibilityHidden(true)
    }
}
