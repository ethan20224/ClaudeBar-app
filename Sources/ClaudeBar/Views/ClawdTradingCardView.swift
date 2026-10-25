import SwiftUI
import AppKit

// MARK: - Isolated Part & Blueprint Cache

@MainActor
enum ClawdBlueprintCache {
    private static var ghostImages: [String: NSImage] = [:]
    private static var partImages: [String: NSImage] = [:]

    static func ghostBody(dark: Bool, ptPerCell: CGFloat) -> NSImage {
        let key = "ghost|\(dark)|\(ptPerCell)"
        if let hit = ghostImages[key] { return hit }
        let canvas = ClawdArt.body(.init(eyes: .open(look: 0)))
        var theme = ClawdTheme(body: ClawdTheme.rgb(0xD07A5C), darkBackdrop: dark, silhouette: true)
        theme.bodyAlpha = 0.2
        let img = MascotRenderer.render(canvas, theme: theme, pxPerCell: Int(ptPerCell * 2), ptPerCell: ptPerCell)
        ghostImages[key] = img
        return img
    }

    static func partImage(edition: ClawdEdition, partIndex: Int, phase: Int, dark: Bool, ptPerCell: CGFloat) -> NSImage {
        let key = "\(edition.id)|part:\(partIndex)|p:\(phase)|d:\(dark)|\(ptPerCell)"
        if let hit = partImages[key] { return hit }
        var canvas = PixelCanvas()
        if edition.parts.indices.contains(partIndex) {
            for s in edition.parts[partIndex].stamps(phase) {
                canvas.stamp(s.rows, x: s.x, y: s.y)
            }
        }
        var plan = ClawdPlan()
        plan.edition = edition.id
        plan.darkBackdrop = dark
        let theme = ClawdComposer.theme(for: plan)
        let img = MascotRenderer.render(canvas, theme: theme, pxPerCell: Int(ptPerCell * 2), ptPerCell: ptPerCell)
        partImages[key] = img
        return img
    }

    static func collectorNumber(for editionID: String) -> String {
        if let idx = ClawdEditions.all.firstIndex(where: { $0.id == editionID }) {
            return String(format: "#%03d", idx + 1)
        }
        return "#000"
    }
}

/// Renders a single isolated `ClawdEdition.Part` over a faint reference silhouette of Clawd's body.
struct PartBlueprintSprite: View {
    let edition: ClawdEdition
    let partIndex: Int
    var ptPerCell: CGFloat
    var animate: Bool = true
    @Environment(\.colorScheme) private var scheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let dark = scheme == .dark
        TimelineView(.periodic(from: .now, by: 0.45)) { context in
            let phase = (animate && !reduceMotion) ? Int(context.date.timeIntervalSinceReferenceDate / 0.45) % 2 : 0
            ZStack {
                Image(nsImage: ClawdBlueprintCache.ghostBody(dark: dark, ptPerCell: ptPerCell))
                    .interpolation(.none)
                    .resizable()
                    .opacity(0.32)
                Image(nsImage: ClawdBlueprintCache.partImage(edition: edition, partIndex: partIndex, phase: phase, dark: dark, ptPerCell: ptPerCell))
                    .interpolation(.none)
                    .resizable()
            }
            .frame(width: CGFloat(PixelCanvas.width) * ptPerCell, height: CGFloat(PixelCanvas.height) * ptPerCell)
        }
        .accessibilityHidden(true)
    }
}

// MARK: - Finish Styling & Optical Material

struct CardPalette {
    let finish: ClawdCardFinish
    let editionColor: NSColor
    let isDark: Bool

    var usesDarkSurface: Bool {
        finish == .obsidian || isDark
    }

    var primaryInk: Color {
        usesDarkSurface ? Color(red: 0.95, green: 0.94, blue: 0.92) : Color(red: 0.12, green: 0.11, blue: 0.10)
    }

    var secondaryInk: Color {
        usesDarkSurface ? Color(red: 0.95, green: 0.94, blue: 0.92).opacity(0.66) : Color(red: 0.12, green: 0.11, blue: 0.10).opacity(0.62)
    }

    var tertiaryInk: Color {
        usesDarkSurface ? Color(red: 0.95, green: 0.94, blue: 0.92).opacity(0.45) : Color(red: 0.12, green: 0.11, blue: 0.10).opacity(0.45)
    }

    var editionAccent: Color {
        Color(nsColor: editionColor)
    }

    var cardBackground: LinearGradient {
        switch finish {
        case .matte:
            if isDark {
                return LinearGradient(
                    colors: [Color(red: 0.15, green: 0.15, blue: 0.16), Color(red: 0.11, green: 0.11, blue: 0.12)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            } else {
                return LinearGradient(
                    colors: [Color(red: 0.96, green: 0.95, blue: 0.94), Color(red: 0.92, green: 0.91, blue: 0.89)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            }
        case .clay:
            if isDark {
                return LinearGradient(
                    colors: [Color(red: 0.22, green: 0.14, blue: 0.12), Color(red: 0.13, green: 0.10, blue: 0.09)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            } else {
                return LinearGradient(
                    colors: [Color(red: 0.96, green: 0.90, blue: 0.87), Color(red: 0.90, green: 0.80, blue: 0.75)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            }
        case .gold:
            if isDark {
                return LinearGradient(
                    colors: [Color(red: 0.22, green: 0.18, blue: 0.10), Color(red: 0.13, green: 0.11, blue: 0.08)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            } else {
                return LinearGradient(
                    colors: [Color(red: 0.97, green: 0.93, blue: 0.83), Color(red: 0.91, green: 0.84, blue: 0.68)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            }
        case .prismatic:
            if isDark {
                return LinearGradient(
                    colors: [Color(red: 0.16, green: 0.16, blue: 0.20), Color(red: 0.11, green: 0.12, blue: 0.15)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            } else {
                return LinearGradient(
                    colors: [Color(red: 0.95, green: 0.95, blue: 0.97), Color(red: 0.89, green: 0.91, blue: 0.94)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            }
        case .obsidian:
            return LinearGradient(
                colors: [Color(red: 0.11, green: 0.11, blue: 0.13), Color(red: 0.07, green: 0.07, blue: 0.08)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
    }

    var outerBorderGradient: LinearGradient {
        switch finish {
        case .matte:
            let c = usesDarkSurface ? Color.white : Color.black
            return LinearGradient(colors: [c.opacity(0.22), c.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .clay:
            return LinearGradient(
                colors: [Color(red: 0.93, green: 0.64, blue: 0.52), Color.clay, Color(red: 0.58, green: 0.31, blue: 0.22)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case .gold:
            return LinearGradient(
                colors: [Color(red: 0.99, green: 0.90, blue: 0.62), Color(red: 0.85, green: 0.65, blue: 0.22), Color(red: 0.62, green: 0.45, blue: 0.14)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case .prismatic:
            return LinearGradient(
                colors: [
                    Color(red: 0.95, green: 0.62, blue: 0.56),
                    Color(red: 0.95, green: 0.82, blue: 0.48),
                    Color(red: 0.46, green: 0.84, blue: 0.76),
                    Color(red: 0.56, green: 0.72, blue: 0.96)
                ],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case .obsidian:
            return LinearGradient(
                colors: [Color.white.opacity(0.38), Color.white.opacity(0.10), Color.white.opacity(0.24)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
    }

    var accentColor: Color {
        switch finish {
        case .matte:     return editionAccent
        case .clay:      return Color.clay
        case .gold:      return Color(red: 0.88, green: 0.68, blue: 0.24)
        case .prismatic: return Color(red: 0.45, green: 0.76, blue: 0.88)
        case .obsidian:  return Color(red: 0.82, green: 0.84, blue: 0.88)
        }
    }

    func foilOverlay(tiltX: CGFloat, tiltY: CGFloat, isHovering: Bool) -> some View {
        let shiftX = 0.5 + tiltX * 0.42
        let shiftY = 0.5 + tiltY * 0.42
        let activeOpacity: Double = isHovering ? 1.0 : 0.42

        return GeometryReader { _ in
            switch finish {
            case .matte:
                RadialGradient(
                    colors: [Color.white.opacity(usesDarkSurface ? 0.07 : 0.22), .clear],
                    center: UnitPoint(x: shiftX, y: shiftY),
                    startRadius: 4,
                    endRadius: 190
                )
                .opacity(activeOpacity)

            case .clay:
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: max(0, shiftX - 0.45)),
                        .init(color: Color(red: 0.95, green: 0.66, blue: 0.52).opacity(usesDarkSurface ? 0.22 : 0.28), location: max(0, min(1, shiftX - 0.08))),
                        .init(color: Color.white.opacity(usesDarkSurface ? 0.16 : 0.34), location: max(0, min(1, shiftX))),
                        .init(color: Color.clay.opacity(0.16), location: max(0, min(1, shiftX + 0.12))),
                        .init(color: .clear, location: min(1, shiftX + 0.45))
                    ],
                    startPoint: UnitPoint(x: 0, y: max(0, shiftY - 0.3)),
                    endPoint: UnitPoint(x: 1, y: min(1, shiftY + 0.3))
                )
                .opacity(activeOpacity)

            case .gold:
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: max(0, shiftX - 0.42)),
                        .init(color: Color(red: 0.96, green: 0.78, blue: 0.32).opacity(usesDarkSurface ? 0.25 : 0.32), location: max(0, min(1, shiftX - 0.08))),
                        .init(color: Color(red: 1.0, green: 0.96, blue: 0.78).opacity(usesDarkSurface ? 0.22 : 0.42), location: max(0, min(1, shiftX))),
                        .init(color: Color(red: 0.85, green: 0.64, blue: 0.18).opacity(0.18), location: max(0, min(1, shiftX + 0.10))),
                        .init(color: .clear, location: min(1, shiftX + 0.42))
                    ],
                    startPoint: UnitPoint(x: 0, y: max(0, shiftY - 0.35)),
                    endPoint: UnitPoint(x: 1, y: min(1, shiftY + 0.35))
                )
                .opacity(activeOpacity)

            case .prismatic:
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: max(0, shiftX - 0.48)),
                        .init(color: Color(red: 0.96, green: 0.54, blue: 0.62).opacity(usesDarkSurface ? 0.20 : 0.24), location: max(0, min(1, shiftX - 0.18))),
                        .init(color: Color(red: 0.98, green: 0.84, blue: 0.44).opacity(usesDarkSurface ? 0.20 : 0.26), location: max(0, min(1, shiftX - 0.06))),
                        .init(color: Color(red: 0.42, green: 0.88, blue: 0.76).opacity(usesDarkSurface ? 0.22 : 0.26), location: max(0, min(1, shiftX + 0.06))),
                        .init(color: Color(red: 0.52, green: 0.70, blue: 0.98).opacity(usesDarkSurface ? 0.20 : 0.24), location: max(0, min(1, shiftX + 0.18))),
                        .init(color: .clear, location: min(1, shiftX + 0.48))
                    ],
                    startPoint: UnitPoint(x: 0, y: max(0, shiftY - 0.35)),
                    endPoint: UnitPoint(x: 1, y: min(1, shiftY + 0.35))
                )
                .opacity(activeOpacity)

            case .obsidian:
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: max(0, shiftX - 0.38)),
                        .init(color: Color.white.opacity(0.14), location: max(0, min(1, shiftX - 0.03))),
                        .init(color: Color(red: 0.76, green: 0.82, blue: 0.92).opacity(0.20), location: max(0, min(1, shiftX))),
                        .init(color: .clear, location: min(1, shiftX + 0.38))
                    ],
                    startPoint: UnitPoint(x: 0, y: max(0, shiftY - 0.3)),
                    endPoint: UnitPoint(x: 1, y: min(1, shiftY + 0.3))
                )
                .opacity(activeOpacity)
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Interactive 3D Collectible Card

struct ClawdTradingCardView: View {
    let edition: ClawdEdition
    let finish: ClawdCardFinish
    var isExpanded: Bool = false
    var onExpand: (() -> Void)? = nil

    @State private var isFlipped: Bool
    @State private var isMidFlip = false
    @State private var tiltX: CGFloat = 0
    @State private var tiltY: CGFloat = 0
    @State private var isHovering = false

    @Environment(\.colorScheme) private var scheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.cardShowsFlipHint) private var showsFlipHint

    init(
        edition: ClawdEdition,
        finish: ClawdCardFinish,
        isExpanded: Bool = false,
        isFlipped: Bool = false,
        onExpand: (() -> Void)? = nil
    ) {
        self.edition = edition
        self.finish = finish
        self.isExpanded = isExpanded
        self._isFlipped = State(initialValue: isFlipped)
        self.onExpand = onExpand
    }

    private var palette: CardPalette {
        let hex = edition.bodyColor ?? 0xD07A5C
        return CardPalette(finish: finish, editionColor: ClawdTheme.rgb(hex), isDark: scheme == .dark)
    }

    private var cornerRadius: CGFloat { isExpanded ? 18 : 13 }

    var body: some View {
        let p = palette
        let flipDegrees: Double = (isFlipped && !reduceMotion) ? 180 : 0
        let pitchDegrees: Double = reduceMotion ? 0 : Double(-tiltY * 7.5)
        let rollDegrees: Double = reduceMotion ? 0 : Double(tiltX * 8.5)

        ZStack {
            if isFlipped {
                backFace(p)
                    .rotation3DEffect(.degrees(reduceMotion ? 0 : 180), axis: (x: 0, y: 1, z: 0))
            } else {
                frontFace(p)
            }

            p.foilOverlay(tiltX: tiltX, tiltY: tiltY, isHovering: isHovering)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

            // Double-hairline collector frame: outer rim + inset inner frame
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(p.outerBorderGradient, lineWidth: isExpanded ? 1.5 : 1.2)
                .allowsHitTesting(false)

            RoundedRectangle(cornerRadius: cornerRadius - 4, style: .continuous)
                .strokeBorder(p.primaryInk.opacity(0.08), lineWidth: 0.75)
                .padding(4)
                .allowsHitTesting(false)
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(p.cardBackground)
                .shadow(
                    color: Color.black.opacity(p.usesDarkSurface ? 0.36 : 0.12),
                    radius: isHovering ? 14 : 8,
                    x: reduceMotion ? 0 : -tiltX * 5,
                    y: isHovering ? 7 : 4
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        // Blur bridge masks the 90-degree face swap so the flip reads as one continuous object.
        .blur(radius: (isMidFlip && !reduceMotion) ? 1.6 : 0)
        .rotation3DEffect(
            .degrees(flipDegrees),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.45
        )
        .rotation3DEffect(
            .degrees(pitchDegrees),
            axis: (x: 1, y: 0, z: 0),
            perspective: 0.4
        )
        .rotation3DEffect(
            .degrees(rollDegrees),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.4
        )
        .scaleEffect(isHovering && !reduceMotion ? 1.012 : 1.0)
        .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .onTapGesture {
            flipCard()
        }
        .onContinuousHover { phase in
            guard !reduceMotion else { return }
            switch phase {
            case .active(let loc):
                let w: CGFloat = isExpanded ? 336 : 276
                let h: CGFloat = isExpanded ? 456 : 226
                let nx = max(-1, min(1, (loc.x / w - 0.5) * 2))
                let ny = max(-1, min(1, (loc.y / h - 0.5) * 2))
                withAnimation(.interactiveSpring(response: 0.26, dampingFraction: 0.78)) {
                    isHovering = true
                    tiltX = nx
                    tiltY = ny
                }
            case .ended:
                withAnimation(.interactiveSpring(response: 0.38, dampingFraction: 0.76)) {
                    isHovering = false
                    tiltX = 0
                    tiltY = 0
                }
            }
        }
        .onChange(of: edition.id) { _, _ in
            isFlipped = false
            isMidFlip = false
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(edition.name) collector card, \(finish.title) finish, \(isFlipped ? "back blueprint view" : "front view")")
        .accessibilityHint("Click to flip between front art and back pixel blueprint")
    }

    private func flipCard() {
        HapticService.playPet()
        if reduceMotion {
            isFlipped.toggle()
            return
        }
        withAnimation(.easeOut(duration: 0.11)) {
            isMidFlip = true
        }
        withAnimation(.spring(duration: 0.44, bounce: 0.14)) {
            isFlipped.toggle()
        }
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(160))
            withAnimation(.easeOut(duration: 0.14)) {
                isMidFlip = false
            }
        }
    }

    // MARK: - Front Face

    private func frontFace(_ p: CardPalette) -> some View {
        VStack(spacing: 0) {
            // Top collector bar
            HStack(spacing: 6) {
                Text(ClawdBlueprintCache.collectorNumber(for: edition.id))
                    .font(.system(size: isExpanded ? 12 : 11, weight: .semibold, design: .monospaced))
                    .monospacedDigit()
                    .foregroundStyle(p.secondaryInk)

                HStack(spacing: 4) {
                    Image(systemName: edition.collection.symbol)
                        .font(.system(size: isExpanded ? 10 : 9, weight: .medium))
                    Text(edition.collection.title)
                        .font(.system(size: isExpanded ? 11 : 10, weight: .medium))
                        .lineLimit(1)
                }
                .foregroundStyle(p.secondaryInk)
                .padding(.horizontal, 7)
                .padding(.vertical, 2.5)
                .background(Capsule().fill(p.primaryInk.opacity(0.06)))

                Spacer(minLength: 4)

                cardUtilityButtons(p)
            }
            .padding(.horizontal, isExpanded ? 16 : 12)
            .padding(.top, isExpanded ? 14 : 10)
            .padding(.bottom, isExpanded ? 10 : 8)

            // Recessed pixel art stage well
            ZStack {
                RoundedRectangle(cornerRadius: isExpanded ? 11 : 9, style: .continuous)
                    .fill(p.usesDarkSurface ? Color.black.opacity(0.32) : Color.black.opacity(0.045))

                // Subtle radial aura behind Clawd tinted by edition color
                RadialGradient(
                    colors: [
                        p.editionAccent.opacity(p.usesDarkSurface ? 0.24 : 0.16),
                        p.accentColor.opacity(p.usesDarkSurface ? 0.08 : 0.05),
                        .clear
                    ],
                    center: UnitPoint(x: 0.5 + tiltX * 0.08, y: 0.5 + tiltY * 0.08),
                    startRadius: 6,
                    endRadius: isExpanded ? 125 : 85
                )
                .clipShape(RoundedRectangle(cornerRadius: isExpanded ? 11 : 9, style: .continuous))

                // Corner registration ticks inside the stage well
                stageRegistrationTicks(p)

                EditionSprite(
                    editionID: edition.id,
                    mood: .idle,
                    ptPerCell: isExpanded ? 14.5 : 11.5,
                    animate: true
                )
                .offset(x: reduceMotion ? 0 : tiltX * 2.5, y: reduceMotion ? 0 : tiltY * 2.0)

                // Inner rim of stage well
                RoundedRectangle(cornerRadius: isExpanded ? 11 : 9, style: .continuous)
                    .strokeBorder(p.primaryInk.opacity(0.08), lineWidth: 0.75)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, isExpanded ? 14 : 10)

            // Expanded card includes inscribed title & lore plate on the card itself
            if isExpanded {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(edition.name)
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundStyle(p.primaryInk)
                        Spacer()
                        Text(finish.title)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(p.accentColor)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(Capsule().fill(p.accentColor.opacity(0.14)))
                    }
                    Text(edition.blurb)
                        .font(.system(size: 12.5))
                        .foregroundStyle(p.secondaryInk)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 4)
            }

            // Bottom footer bar inside the card
            HStack(spacing: 5) {
                Spacer(minLength: 4)
                if showsFlipHint {
                    HStack(spacing: 3.5) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 9, weight: .medium))
                        Text("Flip")
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(p.tertiaryInk)
                }
            }
            .padding(.horizontal, isExpanded ? 16 : 12)
            .padding(.top, isExpanded ? 8 : 7)
            .padding(.bottom, isExpanded ? 13 : 9)
        }
    }

    // MARK: - Back Face (Exploded Pixel Blueprint + 4 Moods)

    private func backFace(_ p: CardPalette) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Back header
            HStack(spacing: 6) {
                Text("Blueprint")
                    .font(.system(size: isExpanded ? 12 : 11, weight: .semibold))
                    .foregroundStyle(p.primaryInk)
                Text(ClawdBlueprintCache.collectorNumber(for: edition.id))
                    .font(.system(size: isExpanded ? 11 : 10, weight: .medium, design: .monospaced))
                    .monospacedDigit()
                    .foregroundStyle(p.tertiaryInk)
                Spacer()
                if isExpanded {
                    Text(edition.name)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(p.secondaryInk)
                }
                cardUtilityButtons(p)
            }
            .padding(.horizontal, isExpanded ? 16 : 12)
            .padding(.top, isExpanded ? 14 : 10)
            .padding(.bottom, isExpanded ? 12 : 6)

            // Exploded parts grid
            VStack(alignment: .leading, spacing: isExpanded ? 6 : 4) {
                HStack {
                    Text("Exploded layers")
                        .font(.system(size: isExpanded ? 10.5 : 9.5, weight: .medium))
                        .foregroundStyle(p.secondaryInk)
                    Spacer()
                    Text("\(edition.parts.count) \(edition.parts.count == 1 ? "part" : "parts")")
                        .font(.system(size: isExpanded ? 10 : 9, weight: .regular, design: .monospaced))
                        .foregroundStyle(p.tertiaryInk)
                }
                .padding(.horizontal, isExpanded ? 16 : 12)

                HStack(spacing: isExpanded ? 8 : 6) {
                    ForEach(Array(edition.parts.prefix(4).enumerated()), id: \.offset) { idx, part in
                        VStack(spacing: isExpanded ? 5 : 3) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .fill(p.usesDarkSurface ? Color.black.opacity(0.28) : Color.black.opacity(0.045))
                                PartBlueprintSprite(
                                    edition: edition,
                                    partIndex: idx,
                                    ptPerCell: isExpanded ? 5.2 : 3.5,
                                    animate: true
                                )
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .strokeBorder(p.primaryInk.opacity(0.07), lineWidth: 0.6)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: isExpanded ? 96 : 56)

                            Text(part.slot.rawValue)
                                .font(.system(size: isExpanded ? 10 : 9, weight: .medium, design: .monospaced))
                                .foregroundStyle(p.secondaryInk)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, isExpanded ? 14 : 10)
            }

            if isExpanded {
                // Extracted pixel palette strip on expanded blueprint
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Pixel palette")
                            .font(.system(size: 10.5, weight: .medium))
                            .foregroundStyle(p.secondaryInk)
                        Spacer()
                        Text("16x12 grid")
                            .font(.system(size: 10, weight: .regular, design: .monospaced))
                            .foregroundStyle(p.tertiaryInk)
                    }
                    HStack(spacing: 6) {
                        ForEach(extractedSwatches(dark: p.usesDarkSurface), id: \.hex) { swatch in
                            HStack(spacing: 5) {
                                RoundedRectangle(cornerRadius: 3, style: .continuous)
                                    .fill(Color(nsColor: swatch.color))
                                    .frame(width: 12, height: 12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3, style: .continuous)
                                            .strokeBorder(p.primaryInk.opacity(0.18), lineWidth: 0.5)
                                    )
                                Text(swatch.hex)
                                    .font(.system(size: 9.5, weight: .medium, design: .monospaced))
                                    .foregroundStyle(p.secondaryInk)
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(p.primaryInk.opacity(0.05))
                            )
                        }
                        Spacer(minLength: 0)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)

                // Slot priority rules summary
                HStack(spacing: 6) {
                    Text("Slot safety")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(p.secondaryInk)
                    Spacer()
                    Text("Work claims hand · Warning claims face")
                        .font(.system(size: 9.5, weight: .regular, design: .monospaced))
                        .foregroundStyle(p.tertiaryInk)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(p.primaryInk.opacity(0.04))
                )
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }

            Spacer(minLength: 4)

            // Live 4-Moods Specimen Strip
            VStack(alignment: .leading, spacing: isExpanded ? 6 : 4) {
                HStack {
                    Text("Live mood states")
                        .font(.system(size: isExpanded ? 10.5 : 9.5, weight: .medium))
                        .foregroundStyle(p.secondaryInk)
                    Spacer()
                    Text("Slot-safe")
                        .font(.system(size: isExpanded ? 10 : 9, weight: .regular, design: .monospaced))
                        .foregroundStyle(p.tertiaryInk)
                }
                .padding(.horizontal, isExpanded ? 16 : 12)

                HStack(spacing: isExpanded ? 8 : 6) {
                    ForEach(Self.specimenMoods, id: \.state) { item in
                        VStack(spacing: isExpanded ? 5 : 3) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .fill(p.usesDarkSurface ? Color.black.opacity(0.28) : Color.black.opacity(0.045))
                                EditionSprite(
                                    editionID: edition.id,
                                    mood: item.state,
                                    ptPerCell: isExpanded ? 4.8 : 3.4,
                                    animate: true
                                )
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .strokeBorder(p.primaryInk.opacity(0.07), lineWidth: 0.6)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: isExpanded ? 92 : 54)

                            Text(item.label)
                                .font(.system(size: isExpanded ? 10 : 9, weight: .medium))
                                .foregroundStyle(p.secondaryInk)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, isExpanded ? 14 : 10)
            }
            .padding(.bottom, isExpanded ? 10 : 8)

            if isExpanded {
                HStack {
                    Text(edition.collection.title)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(p.tertiaryInk)
                    Spacer()
                    HStack(spacing: 3.5) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 9, weight: .medium))
                        Text("Flip to front")
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(p.tertiaryInk)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 13)
            }
        }
    }

    private struct SwatchInfo {
        let hex: String
        let color: NSColor
    }

    private func extractedSwatches(dark: Bool) -> [SwatchInfo] {
        var plan = ClawdPlan()
        plan.edition = edition.id
        plan.darkBackdrop = dark
        let theme = ClawdComposer.theme(for: plan)

        var chars: [Character] = ["B"]
        var seen: Set<Character> = ["B", ".", " ", "X"]
        for part in edition.parts {
            for stamp in part.stamps(0) {
                for row in stamp.rows {
                    for ch in row where seen.insert(ch).inserted {
                        chars.append(ch)
                    }
                }
            }
        }
        return chars.prefix(4).compactMap { ch in
            guard let c = theme.color(for: ch)?.usingColorSpace(.sRGB) else { return nil }
            let r = Int(round(c.redComponent * 255))
            let g = Int(round(c.greenComponent * 255))
            let b = Int(round(c.blueComponent * 255))
            return SwatchInfo(hex: String(format: "#%02X%02X%02X", r, g, b), color: c)
        }
    }

    private static let specimenMoods: [(label: String, state: MascotState)] = [
        ("Idle", .idle),
        ("Work", .working),
        ("Nap", .sleepy),
        ("Sweat", .strained)
    ]

    @ViewBuilder
    private func cardUtilityButtons(_ p: CardPalette) -> some View {
        HStack(spacing: 4) {
            if let onExpand, !isExpanded {
                Button {
                    HapticService.playOpen()
                    onExpand()
                } label: {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(p.secondaryInk)
                        .frame(width: 22, height: 22)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(p.primaryInk.opacity(0.06))
                        )
                }
                .buttonStyle(PressableStyle())
                .help("Inspect large card")
                .accessibilityLabel("Inspect large card")
            }
        }
    }

    private func stageRegistrationTicks(_ p: CardPalette) -> some View {
        let tickColor = p.primaryInk.opacity(0.14)
        return GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let inset: CGFloat = 7
            let len: CGFloat = 5
            Path { path in
                // Top-left
                path.move(to: CGPoint(x: inset, y: inset + len))
                path.addLine(to: CGPoint(x: inset, y: inset))
                path.addLine(to: CGPoint(x: inset + len, y: inset))
                // Top-right
                path.move(to: CGPoint(x: w - inset - len, y: inset))
                path.addLine(to: CGPoint(x: w - inset, y: inset))
                path.addLine(to: CGPoint(x: w - inset, y: inset + len))
                // Bottom-left
                path.move(to: CGPoint(x: inset, y: h - inset - len))
                path.addLine(to: CGPoint(x: inset, y: h - inset))
                path.addLine(to: CGPoint(x: inset + len, y: h - inset))
                // Bottom-right
                path.move(to: CGPoint(x: w - inset - len, y: h - inset))
                path.addLine(to: CGPoint(x: w - inset, y: h - inset))
                path.addLine(to: CGPoint(x: w - inset, y: h - inset - len))
            }
            .stroke(tickColor, lineWidth: 1)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Finish Picker Bar

struct ClawdFinishPicker: View {
    let selected: ClawdCardFinish
    let onSelect: (ClawdCardFinish) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Card finish")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Text(selected.title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.primary)
            }

            HStack(spacing: 6) {
                ForEach(ClawdCardFinish.allCases, id: \.self) { finish in
                    let isSelected = finish == selected
                    Button {
                        HapticService.playRefresh()
                        onSelect(finish)
                    } label: {
                        HStack(spacing: 5) {
                            swatchDot(for: finish)
                            Text(shortLabel(for: finish))
                                .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(isSelected ? Color.clay.opacity(0.15) : Color.primary.opacity(0.05))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .strokeBorder(isSelected ? Color.clay : Color.primary.opacity(0.08), lineWidth: isSelected ? 1.2 : 0.75)
                        )
                    }
                    .buttonStyle(PressableStyle())
                    .accessibilityLabel("\(finish.title) card finish\(isSelected ? ", selected" : "")")
                }
            }
        }
    }

    private func shortLabel(for finish: ClawdCardFinish) -> String {
        switch finish {
        case .matte:     return "Matte"
        case .clay:      return "Clay"
        case .gold:      return "Gold"
        case .prismatic: return "Holo"
        case .obsidian:  return "Dark"
        }
    }

    @ViewBuilder
    private func swatchDot(for finish: ClawdCardFinish) -> some View {
        Circle()
            .fill(swatchGradient(for: finish))
            .frame(width: 8, height: 8)
            .overlay(Circle().strokeBorder(Color.primary.opacity(0.18), lineWidth: 0.5))
    }

    private func swatchGradient(for finish: ClawdCardFinish) -> LinearGradient {
        switch finish {
        case .matte:
            return LinearGradient(colors: [Color(white: 0.85), Color(white: 0.62)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .clay:
            return LinearGradient(colors: [Color(red: 0.94, green: 0.65, blue: 0.52), Color.clay], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .gold:
            return LinearGradient(colors: [Color(red: 0.99, green: 0.88, blue: 0.52), Color(red: 0.82, green: 0.60, blue: 0.16)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .prismatic:
            return LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.56, blue: 0.62),
                    Color(red: 0.98, green: 0.84, blue: 0.44),
                    Color(red: 0.44, green: 0.86, blue: 0.78),
                    Color(red: 0.54, green: 0.72, blue: 0.98)
                ],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case .obsidian:
            return LinearGradient(colors: [Color(white: 0.24), Color(white: 0.08)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

// MARK: - Expanded Spotlight Overlay

struct ClawdExpandedCardModal: View {
    let edition: ClawdEdition
    let finish: ClawdCardFinish
    let onSelectFinish: (ClawdCardFinish) -> Void
    let onClose: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.46)
                .ignoresSafeArea()
                .onTapGesture {
                    HapticService.playClose()
                    onClose()
                }

            VStack(spacing: 16) {
                ClawdTradingCardView(
                    edition: edition,
                    finish: finish,
                    isExpanded: true
                )
                .frame(width: 336, height: 456)

                HStack(spacing: 10) {
                    ClawdFinishPicker(selected: finish, onSelect: onSelectFinish)
                        .frame(width: 280)

                    Button {
                        HapticService.playClose()
                        onClose()
                    } label: {
                        Label("Done", systemImage: "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.primary.opacity(0.08))
                            )
                    }
                    .buttonStyle(PressableStyle())
                    .keyboardShortcut(.cancelAction)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(nsColor: .windowBackgroundColor).opacity(0.94))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Color.primary.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.22), radius: 14, y: 6)
                )
            }
        }
    }
}

/// The share image hides the "Flip" hint, which only means something on screen.
private struct CardShowsFlipHintKey: EnvironmentKey { static let defaultValue = true }

extension EnvironmentValues {
    var cardShowsFlipHint: Bool {
        get { self[CardShowsFlipHintKey.self] }
        set { self[CardShowsFlipHintKey.self] = newValue }
    }
}
