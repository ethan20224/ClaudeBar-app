import SwiftUI
import AppKit

/// A shareable image of a Clawdex trading card: the card on a flat Cartridge backdrop with a small
/// ClaudeBar mark. Rendered at 2x so it stays crisp when posted.
@MainActor
enum ClawdShareCard {
    static let size = CGSize(width: 540, height: 675)

    static func view(edition: ClawdEdition, finish: ClawdCardFinish, dark: Bool) -> some View {
        let theme = CartridgeTheme.resolve(dark ? .dark : .light)
        return ZStack {
            theme.card
            VStack(spacing: 26) {
                ClawdTradingCardView(edition: edition, finish: finish, isExpanded: true)
                    .environment(\.cardShowsFlipHint, false)
                    .frame(width: 336, height: 456)
                    .scaleEffect(1.15)
                    .frame(width: 336 * 1.15, height: 456 * 1.15)
                VStack(spacing: 6) {
                    Text("CLAWDEX \u{00B7} \(edition.collection.title.uppercased())")
                        .font(CartridgeFont.font(11))
                        .tracking(1.6)
                        .foregroundStyle(theme.muted)
                    Text("CLAUDEBAR")
                        .font(CartridgeFont.font(16, bold: true))
                        .tracking(2.4)
                        .foregroundStyle(theme.tagInk)
                }
            }
        }
        .frame(width: size.width, height: size.height)
        .environment(\.colorScheme, dark ? .dark : .light)
    }

    static func image(edition: ClawdEdition, finish: ClawdCardFinish, dark: Bool) -> NSImage? {
        let renderer = ImageRenderer(content: view(edition: edition, finish: finish, dark: dark))
        renderer.scale = 2
        return renderer.nsImage
    }

    static func pngData(_ image: NSImage) -> Data? {
        guard let tiff = image.tiffRepresentation, let rep = NSBitmapImageRep(data: tiff) else { return nil }
        return rep.representation(using: .png, properties: [:])
    }

    static func fileName(for editionName: String) -> String {
        let slug = editionName
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "-")
        return "ClaudeBar-Clawd-\(slug).png"
    }

    /// Asks where to save the card as a PNG.
    static func save(edition: ClawdEdition, finish: ClawdCardFinish, dark: Bool) {
        guard let image = image(edition: edition, finish: finish, dark: dark),
              let data = pngData(image) else { return }
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.png]
        panel.nameFieldStringValue = fileName(for: edition.name)
        panel.begin { response in
            guard response == .OK, let url = panel.url else { return }
            try? data.write(to: url)
        }
    }
}

/// Share and save buttons for the selected edition's card.
struct ClawdShareButtons: View {
    let edition: ClawdEdition
    let finish: ClawdCardFinish
    @Environment(\.colorScheme) private var scheme
    @State private var rendered: NSImage?

    private var dark: Bool { scheme == .dark }
    private var renderKey: String { "\(edition.id)|\(finish)|\(dark)" }

    var body: some View {
        HStack(spacing: 10) {
            if let rendered {
                ShareLink(item: Image(nsImage: rendered),
                          preview: SharePreview("\(edition.name), a Clawd costume", image: Image(nsImage: rendered))) {
                    icon("square.and.arrow.up")
                }
                .buttonStyle(PressableStyle())
                .accessibilityLabel("Share this card")
            } else {
                icon("square.and.arrow.up").opacity(0.4)
            }
            Button { ClawdShareCard.save(edition: edition, finish: finish, dark: dark) } label: {
                icon("arrow.down.to.line")
            }
            .buttonStyle(PressableStyle())
            .accessibilityLabel("Save this card as a PNG")
        }
        .task(id: renderKey) {
            rendered = ClawdShareCard.image(edition: edition, finish: finish, dark: dark)
        }
    }

    private func icon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 14))
            .foregroundStyle(.secondary)
            .frame(width: 36, height: 34)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.primary.opacity(0.06)))
    }
}
