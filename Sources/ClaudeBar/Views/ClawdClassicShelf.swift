import SwiftUI

/// Moods, outfits, skins, scenes and micro-moments: everything is pickable from day one.
/// Moods are previews only (the menu bar must keep telling the truth about usage).
struct ClawdClassicShelf: View {
    var clawd: ClawdModel
    private let columns = [GridItem(.adaptive(minimum: 132, maximum: 170), spacing: 14)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                section("Moods", "Tied to your real usage. Preview plays in the menu bar for 10 seconds.") {
                    ForEach(ClawdCatalog.moods, id: \.id) { moodTile($0) }
                }
                section("Outfits", "Tap to wear one. Tap again to go back to automatic.") {
                    ForEach(ClawdCatalog.outfits, id: \.id) { slotTile($0) }
                }
                section("Skins", "Golden and every shiny color.") {
                    ForEach(ClawdCatalog.skins, id: \.id) { slotTile($0) }
                }
                section("Scenes", "Clawd on a treadmill or in a wizard hat whenever it is calm.") {
                    ForEach(ClawdCatalog.scenes, id: \.id) { sceneTile($0) }
                }
                section("Micro-moments", "Little fidgets. Play one now, or choose which may happen by themselves.") {
                    ForEach(MicroMoment.allCases, id: \.self) { microTile($0) }
                }
            }
            .padding(.horizontal, 24).padding(.bottom, 28)
        }
    }

    private func section<Content: View>(_ title: String, _ note: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 15, weight: .semibold))
                Text(note).font(.system(size: 12)).foregroundStyle(.secondary)
            }
            LazyVGrid(columns: columns, spacing: 16) { content() }
        }
    }

    // MARK: Tiles

    private func moodTile(_ item: ClawdItem) -> some View {
        let plan = ClawdPreview.plan(for: item)
        return ClassicTile(plan: plan, key: item.id, title: item.name, subtitle: item.hint, selected: false, tap: { previewMood(item) }) {
            Text("Preview").font(.system(size: 11, weight: .medium)).foregroundStyle(Color.clay)
        }
    }

    private func slotTile(_ item: ClawdItem) -> some View {
        let worn = item.slot.flatMap { clawd.pins[$0] } == item.id
        return ClassicTile(plan: ClawdPreview.plan(for: item), key: item.id, title: item.name, subtitle: item.hint, selected: worn, tap: {
            guard let slot = item.slot else { return }
            if worn { clawd.onUnpin?(slot) } else { clawd.onPin?(item) }
        }) {
            Text(worn ? "Wearing" : "Wear").font(.system(size: 11, weight: .medium))
                .foregroundStyle(worn ? Color.clay : .secondary)
        }
    }

    private func sceneTile(_ item: ClawdItem) -> some View {
        let on = clawd.sceneChoice == item.id
        return ClassicTile(plan: ClawdPreview.plan(for: item), key: item.id, title: item.name, subtitle: item.hint, selected: on, tap: {
            clawd.onPickScene?(on ? nil : item.id)
        }) {
            Text(on ? "Active" : "Use").font(.system(size: 11, weight: .medium)).foregroundStyle(on ? Color.clay : .secondary)
        }
    }

    private func microTile(_ m: MicroMoment) -> some View {
        var plan = ClawdPlan(); plan.micro = m
        let allowed = !clawd.disabledMicros.contains("\(m)")
        return ClassicTile(plan: plan, key: "micro-\(m)", title: Self.microName(m),
                           subtitle: allowed ? "Can happen on its own" : "Only when you play it",
                           selected: false, tap: { clawd.onPlayMicro?(m) }) {
            HStack(spacing: 10) {
                Text("Play").font(.system(size: 11, weight: .medium)).foregroundStyle(Color.clay)
                Toggle("Random", isOn: Binding(get: { allowed }, set: { clawd.onSetMicroEnabled?(m, $0) }))
                    .toggleStyle(.checkbox).controlSize(.mini).font(.system(size: 11))
            }
        }
    }

    private func previewMood(_ item: ClawdItem) {
        if item.id == "mood-pet" { clawd.onPet?(); return }
        if let state = MascotState.allCases.first(where: { $0.catalogID == item.id }) { clawd.onPreviewMood?(state) }
    }

    static func microName(_ m: MicroMoment) -> String {
        switch m {
        case .sneeze: return "Sneeze"
        case .stretch: return "Stretch"
        case .bugChase: return "Bug chase"
        case .yawn: return "Yawn"
        case .dance: return "Dance"
        case .hiccup: return "Hiccup"
        }
    }
}

/// A generic Clawdex tile: sprite that moves on hover, a name, a caption and a small footer control.
struct ClassicTile<Footer: View>: View {
    let plan: ClawdPlan
    let key: String
    let title: String
    let subtitle: String
    let selected: Bool
    let tap: () -> Void
    @ViewBuilder var footer: Footer
    @State private var hovering = false

    var body: some View {
        Button(action: tap) {
            VStack(spacing: 8) {
                PlanSprite(plan: plan, key: key, ptPerCell: 6.5, animate: hovering || selected)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(hovering || selected ? 0.075 : 0.035)))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(selected ? Color.clay : .clear, lineWidth: 1.5))
                VStack(spacing: 2) {
                    Text(title).font(.system(size: 12, weight: .medium)).lineLimit(1)
                    Text(subtitle).font(.system(size: 10)).foregroundStyle(.secondary).lineLimit(2).multilineTextAlignment(.center)
                }
                footer
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PressableStyle())
        .onHover { hovering = $0 }
        .animation(.clawdOutFast, value: hovering)
    }
}

/// Sprite for any plan (mood, outfit, skin, scene, micro-moment), calm until asked to move.
struct PlanSprite: View {
    let plan: ClawdPlan
    let key: String
    let ptPerCell: CGFloat
    let animate: Bool
    @Environment(\.colorScheme) private var scheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let dark = scheme == .dark
        let timeline = ClawdPreviewCache.timeline(plan: plan, key: key, dark: dark)
        TimelineView(.periodic(from: .now, by: 0.1)) { context in
            let moving = animate && !reduceMotion
            let i = moving ? timeline.index(at: context.date.timeIntervalSinceReferenceDate) : 0
            Image(nsImage: ClawdPreviewCache.image(timeline, key: "\(key)|\(dark)", index: i, ptPerCell: ptPerCell))
                .interpolation(.none).resizable()
                .frame(width: CGFloat(PixelCanvas.width) * ptPerCell, height: CGFloat(PixelCanvas.height) * ptPerCell)
        }
        .accessibilityHidden(true)
    }
}
