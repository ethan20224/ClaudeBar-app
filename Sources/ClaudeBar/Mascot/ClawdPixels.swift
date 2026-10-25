import AppKit

/// A grid of legend characters. "." (or a space) is transparent.
/// Legend: B body, k ink (eyes), d dark prop (adapts to the menu bar), w white,
/// r red, o orange, g gold, e green, c cyan, u navy blue, x robe blue, p purple,
/// h pink, n brown, y metal grey, l light grey.
struct PixelCanvas: Equatable {
    static let width = 16
    static let height = 12

    let w: Int
    let h: Int
    private(set) var cells: [Character]

    init(width: Int = PixelCanvas.width, height: Int = PixelCanvas.height) {
        self.w = width
        self.h = height
        self.cells = Array(repeating: ".", count: width * height)
    }

    subscript(x: Int, y: Int) -> Character {
        get { inBounds(x, y) ? cells[y * w + x] : "." }
        set { if inBounds(x, y) { cells[y * w + x] = newValue } }
    }

    func inBounds(_ x: Int, _ y: Int) -> Bool { x >= 0 && y >= 0 && x < w && y < h }

    mutating func rect(_ x: Int, _ y: Int, _ rw: Int, _ rh: Int, _ ch: Character) {
        for yy in y..<(y + rh) { for xx in x..<(x + rw) { self[xx, yy] = ch } }
    }

    /// Paints non-transparent cells of `rows` with its top-left at (x, y). Off-canvas cells are clipped.
    mutating func stamp(_ rows: [String], x: Int, y: Int) {
        for (r, row) in rows.enumerated() {
            for (c, ch) in row.enumerated() where ch != "." && ch != " " {
                self[x + c, y + r] = ch == "X" ? "." : ch
            }
        }
    }

    mutating func erase(_ x: Int, _ y: Int) { self[x, y] = "." }

    /// A copy limited to rows [y, y + rows), all columns.
    func croppedRows(from y: Int, count rows: Int) -> PixelCanvas {
        var out = PixelCanvas(width: w, height: rows)
        for yy in 0..<rows { for xx in 0..<w { out[xx, yy] = self[xx, y + yy] } }
        return out
    }

    func hasContent(inRow y: Int) -> Bool {
        (0..<w).contains { self[$0, y] != "." }
    }

    /// Paints `other` on top of this canvas, placed at (x, y).
    mutating func overlay(_ other: PixelCanvas, x: Int, y: Int) {
        for yy in 0..<other.h { for xx in 0..<other.w where other[xx, yy] != "." { self[x + xx, y + yy] = other[xx, yy] } }
    }
}

/// Colors for the legend characters, per body skin and menu-bar backdrop.
struct ClawdTheme: Equatable {
    var body: NSColor
    var bodyAlpha: CGFloat = 1
    var darkBackdrop: Bool = false
    /// Draws every non-transparent cell as flat grey (locked Clawdex tiles).
    var silhouette: Bool = false

    static func rgb(_ hex: UInt32, alpha: CGFloat = 1) -> NSColor {
        NSColor(srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
                green: CGFloat((hex >> 8) & 0xFF) / 255,
                blue: CGFloat(hex & 0xFF) / 255, alpha: alpha)
    }

    func color(for ch: Character) -> NSColor? {
        if silhouette { return ch == "." ? nil : NSColor(white: 0.5, alpha: 0.35) }
        switch ch {
        case "B": return bodyAlpha < 1 ? body.withAlphaComponent(bodyAlpha) : body
        case "k": return Self.rgb(0x111111)
        case "d": return darkBackdrop ? Self.rgb(0x6E6E7A) : Self.rgb(0x2B2B33)
        case "w": return Self.rgb(0xFFFFFF)
        case "r": return Self.rgb(0xD9362B)
        case "o": return Self.rgb(0xF28C28)
        case "g": return Self.rgb(0xF2C14E)
        case "e": return Self.rgb(0x3FAE5A)
        case "c": return Self.rgb(0x5AB8F0)
        case "u": return Self.rgb(0x2B3F9E)
        case "x": return Self.rgb(0x3B4BA8)
        case "p": return Self.rgb(0x9B5DE5)
        case "h": return Self.rgb(0xE8546B)
        case "n": return Self.rgb(0x7A5230)
        case "y": return Self.rgb(0x8D8E96)
        case "l": return Self.rgb(0xCFCFD6)
        default:  return nil
        }
    }
}
