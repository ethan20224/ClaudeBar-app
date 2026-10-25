import AppKit

enum MascotRenderer {
    /// Menu bar: 2pt per cell (4px at 2x, crisp). The 16x12 canvas is trimmed to 11 rows,
    /// so the image is 32x22pt and stays inside the 24pt bar.
    static let menuBarPxPerCell = 4
    static let menuBarPtPerCell: CGFloat = 2
    static let menuBarRows = 11

    static func render(_ canvas: PixelCanvas, theme: ClawdTheme,
                       pxPerCell: Int = menuBarPxPerCell, ptPerCell: CGFloat = menuBarPtPerCell) -> NSImage {
        let size = NSSize(width: CGFloat(canvas.w) * ptPerCell, height: CGFloat(canvas.h) * ptPerCell)
        guard let cg = cgImage(canvas, theme: theme, pxPerCell: pxPerCell) else { return NSImage(size: size) }
        let image = NSImage(cgImage: cg, size: size)
        image.isTemplate = false
        return image
    }

    /// Renders a pixel canvas with hard edges into an sRGB bitmap, so colors match
    /// the design values exactly.
    static func cgImage(_ canvas: PixelCanvas, theme: ClawdTheme, pxPerCell: Int) -> CGImage? {
        let pw = canvas.w * pxPerCell
        let ph = canvas.h * pxPerCell
        guard let space = CGColorSpace(name: CGColorSpace.sRGB),
              let ctx = CGContext(data: nil, width: pw, height: ph, bitsPerComponent: 8, bytesPerRow: 0,
                                  space: space, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil }

        ctx.setShouldAntialias(false)
        ctx.interpolationQuality = .none

        for y in 0..<canvas.h {
            for x in 0..<canvas.w {
                guard let color = theme.color(for: canvas[x, y])?.usingColorSpace(.sRGB) else { continue }
                ctx.setFillColor(red: color.redComponent, green: color.greenComponent,
                                 blue: color.blueComponent, alpha: color.alphaComponent)
                // CGContext origin is bottom-left; the grid's row 0 is the top.
                ctx.fill(CGRect(x: x * pxPerCell, y: (canvas.h - 1 - y) * pxPerCell, width: pxPerCell, height: pxPerCell))
            }
        }

        return ctx.makeImage()
    }
}
