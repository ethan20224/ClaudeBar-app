import SwiftUI
import AppKit

// MARK: - Motion + color tokens

extension Animation {
    /// Strong ease-out: instant response, soft landing.
    static let clawdOut = Animation.timingCurve(0.23, 1, 0.32, 1, duration: 0.2)
    static let clawdOutFast = Animation.timingCurve(0.23, 1, 0.32, 1, duration: 0.14)
}

extension Color {
    /// Clawd's body color, the single accent in the Clawdex.
    static let clay = Color(red: 0.816, green: 0.478, blue: 0.361)
}

struct PressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.clawdOutFast, value: configuration.isPressed)
    }
}

struct SidebarMaterial: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let v = NSVisualEffectView()
        v.material = .sidebar
        v.blendingMode = .behindWindow
        v.state = .followsWindowActiveState
        return v
    }
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

// MARK: - Cached previews

@MainActor
enum ClawdPreviewCache {
    private static var timelines: [String: ClawdTimeline] = [:]
    private static var images: [String: NSImage] = [:]

    static func timeline(edition: String, mood: MascotState, dark: Bool) -> ClawdTimeline {
        let key = "\(edition)|\(mood)|\(dark)"
        if let hit = timelines[key] { return hit }
        var plan = ClawdPlan()
        plan.mood = mood
        plan.edition = edition
        plan.darkBackdrop = dark
        let tl = ClawdComposer.timeline(for: plan)
        timelines[key] = tl
        return tl
    }

    static func timeline(plan: ClawdPlan, key: String, dark: Bool) -> ClawdTimeline {
        let k = "plan|\(key)|\(dark)"
        if let hit = timelines[k] { return hit }
        var p = plan
        p.darkBackdrop = dark
        let tl = ClawdComposer.timeline(for: p)
        timelines[k] = tl
        return tl
    }

    static func image(_ timeline: ClawdTimeline, key: String, index: Int, ptPerCell: CGFloat) -> NSImage {
        let k = "\(key)|\(index)|\(ptPerCell)"
        if let hit = images[k] { return hit }
        let img = MascotRenderer.render(timeline.frames[index].canvas, theme: timeline.theme,
                                        pxPerCell: Int(ptPerCell * 2), ptPerCell: ptPerCell)
        images[k] = img
        return img
    }
}

/// A pixel sprite that only moves when asked to (calm by default).
struct EditionSprite: View {
    let editionID: String
    var mood: MascotState = .idle
    var ptPerCell: CGFloat
    var animate: Bool
    @Environment(\.colorScheme) private var scheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let dark = scheme == .dark
        let timeline = ClawdPreviewCache.timeline(edition: editionID, mood: mood, dark: dark)
        let key = "\(editionID)|\(mood)|\(dark)"
        TimelineView(.periodic(from: .now, by: 0.1)) { context in
            let moving = animate && !reduceMotion
            let index = moving ? timeline.index(at: context.date.timeIntervalSinceReferenceDate) : 0
            Image(nsImage: ClawdPreviewCache.image(timeline, key: key, index: index, ptPerCell: ptPerCell))
                .interpolation(.none)
                .resizable()
                .frame(width: CGFloat(PixelCanvas.width) * ptPerCell, height: CGFloat(PixelCanvas.height) * ptPerCell)
        }
        .accessibilityHidden(true)
    }
}

// MARK: - Window

@MainActor
final class ClawdexWindow {
    private static var window: NSWindow?

    static func show(model: ClawdModel) {
        if let window {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        let w = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1100, height: 720),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        w.title = "Clawdex"
        w.titleVisibility = .hidden
        w.titlebarAppearsTransparent = true
        w.isReleasedWhenClosed = false
        w.minSize = NSSize(width: 900, height: 560)
        let host = NSHostingController(rootView: ClawdexWindowView(clawd: model))
        // Keep the window the size we choose instead of shrinking to the view's minimum.
        host.sizingOptions = []
        w.contentViewController = host
        w.setContentSize(NSSize(width: 1100, height: 720))
        w.center()
        w.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        window = w
    }
}

enum ClawdShelf: Hashable {
    case all, favorites, collection(ClawdCollection), classic
}

struct ClawdexWindowView: View {
    var clawd: ClawdModel
    @State private var shelf: ClawdShelf = .all
    @State private var query = ""
    @State private var selectedID: String?
    @State private var expandedCard = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var editions: [ClawdEdition] {
        let base: [ClawdEdition]
        switch shelf {
        case .all:                 base = ClawdEditions.all
        case .favorites:           base = ClawdEditions.all.filter { clawd.favorites.contains($0.id) }
        case .collection(let c):   base = ClawdEditions.editions(in: c)
        case .classic:             base = []
        }
        let q = query.trimmingCharacters(in: .whitespaces).lowercased()
        guard !q.isEmpty else { return base }
        return base.filter {
            $0.name.lowercased().contains(q) || $0.blurb.lowercased().contains(q) || $0.collection.title.lowercased().contains(q)
        }
    }

    private var selected: ClawdEdition? { selectedID.flatMap(ClawdEditions.edition) }

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                sidebar
                    .frame(width: 228)
                    .frame(maxHeight: .infinity)
                    .background(SidebarMaterial())
                VStack(spacing: 0) {
                    header
                    content
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(nsColor: .windowBackgroundColor))
                if let edition = selected {
                    Divider()
                    detail(edition)
                        .frame(width: 312)
                        .background(Color(nsColor: .windowBackgroundColor))
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(reduceMotion ? nil : .clawdOut, value: selectedID)

            if expandedCard, let edition = selected {
                let finish = clawd.cardFinish(for: edition.id)
                ClawdExpandedCardModal(
                    edition: edition,
                    finish: finish,
                    onSelectFinish: { clawd.onSetCardFinish?(edition.id, $0) },
                    onClose: { expandedCard = false }
                )
                .transition(
                    reduceMotion
                        ? .opacity
                        : .scale(scale: 0.95).combined(with: .opacity)
                )
            }
        }
        .animation(reduceMotion ? nil : .clawdOut, value: expandedCard)
        .frame(minWidth: 900, minHeight: 560)
        .ignoresSafeArea()
    }

    // MARK: Sidebar

    private var sidebar: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Clawdex")
                .font(.system(size: 17, weight: .semibold))
                .padding(.horizontal, 20)
                .padding(.top, 38)
                .padding(.bottom, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 2) {
                    shelfRow(.all, "All editions", "square.grid.2x2", ClawdEditions.all.count)
                    shelfRow(.favorites, "Favorites", "star", clawd.favorites.count)

                    Text("Collections")
                        .font(.system(size: 11, weight: .medium)).foregroundStyle(.secondary)
                        .padding(.horizontal, 12).padding(.top, 14).padding(.bottom, 4)
                    ForEach(ClawdCollection.allCases, id: \.self) { c in
                        shelfRow(.collection(c), c.title, c.symbol, ClawdEditions.editions(in: c).count)
                    }

                    Text("Classic")
                        .font(.system(size: 11, weight: .medium)).foregroundStyle(.secondary)
                        .padding(.horizontal, 12).padding(.top, 14).padding(.bottom, 4)
                    shelfRow(.classic, "Moods, outfits & more", "sparkles", ClawdCatalog.moods.count + ClawdCatalog.outfits.count + ClawdCatalog.skins.count + ClawdCatalog.scenes.count + MicroMoment.allCases.count)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 16)
            }
        }
    }

    private func shelfRow(_ value: ClawdShelf, _ title: String, _ symbol: String, _ count: Int) -> some View {
        let on = shelf == value
        return Button {
            shelf = value
            selectedID = nil
        } label: {
            HStack(spacing: 8) {
                Image(systemName: symbol)
                    .font(.system(size: 12, weight: .regular))
                    .frame(width: 18)
                    .foregroundStyle(on ? Color.clay : .secondary)
                Text(title)
                    .font(.system(size: 13, weight: on ? .medium : .regular))
                    .lineLimit(1)
                Spacer(minLength: 4)
                Text("\(count)").font(.system(size: 11)).monospacedDigit().foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 7).fill(on ? Color.clay.opacity(0.14) : .clear))
            .contentShape(Rectangle())
        }
        .buttonStyle(PressableStyle())
        .accessibilityLabel("\(title), \(count)")
    }

    // MARK: Header + grid

    private var headerTitle: String {
        switch shelf {
        case .all: return "All editions"
        case .favorites: return "Favorites"
        case .collection(let c): return c.title
        case .classic: return "Moods, outfits & more"
        }
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                Text(headerTitle).font(.system(size: 22, weight: .semibold)).lineLimit(1).layoutPriority(1)
                if shelf != .classic {
                    Text("\(editions.count) \(editions.count == 1 ? "edition" : "editions")")
                        .font(.system(size: 12)).foregroundStyle(.secondary)
                }
            }
            Spacer()
            if shelf != .classic {
                TextField("Search", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 180)
                Button { surprise() } label: {
                    Label("Surprise me", systemImage: "dice").font(.system(size: 12, weight: .medium))
                }
                .buttonStyle(PressableStyle())
                .controlSize(.small)
                .disabled(ClawdEditions.all.isEmpty)
            }
        }
        .padding(.horizontal, 24).padding(.top, 38).padding(.bottom, 14)
    }

    @ViewBuilder
    private var content: some View {
        if shelf == .classic {
            ClawdClassicShelf(clawd: clawd)
        } else if editions.isEmpty {
            emptyState
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 128, maximum: 170), spacing: 14)], spacing: 18) {
                    ForEach(Array(editions.enumerated()), id: \.element.id) { i, e in
                        EditionTile(
                            edition: e,
                            isSelected: selectedID == e.id,
                            isWorn: clawd.edition == e.id,
                            isFavorite: clawd.favorites.contains(e.id),
                            isNew: !clawd.seenEditions.contains(e.id),
                            index: i
                        ) { select(e) }
                    }
                }
                .padding(.horizontal, 24).padding(.bottom, 28)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 6) {
            Text(shelf == .favorites && query.isEmpty ? "No favorites yet" : "Nothing here")
                .font(.system(size: 15, weight: .medium))
            Text(shelf == .favorites && query.isEmpty
                 ? "Open an edition and tap the star to keep it close."
                 : (query.isEmpty ? "This shelf is still empty." : "No edition matches \"\(query)\"."))
                .font(.system(size: 12)).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: Detail

    private func detail(_ e: ClawdEdition) -> some View {
        let worn = clawd.edition == e.id
        let fav = clawd.favorites.contains(e.id)
        let finish = clawd.cardFinish(for: e.id)
        return VStack(alignment: .leading, spacing: 14) {
            ClawdTradingCardView(
                edition: e,
                finish: finish,
                onExpand: { expandedCard = true }
            )
            .frame(height: 226)
            .padding(.top, 38)

            VStack(alignment: .leading, spacing: 4) {
                Text(e.name).font(.system(size: 20, weight: .semibold))
                Text(e.collection.title).font(.system(size: 12)).foregroundStyle(.secondary)
                Text(e.blurb).font(.system(size: 13)).foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true).padding(.top, 6)
            }

            ClawdFinishPicker(
                selected: finish,
                onSelect: { clawd.onSetCardFinish?(e.id, $0) }
            )

            Spacer()

            HStack(spacing: 10) {
                Button {
                    clawd.onWearEdition?(worn ? nil : e.id)
                } label: {
                    Text(worn ? "Take off" : "Wear in menu bar")
                        .font(.system(size: 13, weight: .medium))
                        .frame(maxWidth: .infinity).padding(.vertical, 8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(worn ? Color.primary.opacity(0.08) : Color.clay))
                        .foregroundStyle(worn ? Color.primary : Color.white)
                }
                .buttonStyle(PressableStyle())

                Button { clawd.onToggleFavorite?(e.id) } label: {
                    Image(systemName: fav ? "star.fill" : "star")
                        .font(.system(size: 14))
                        .foregroundStyle(fav ? Color.clay : .secondary)
                        .frame(width: 36, height: 34)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.primary.opacity(0.06)))
                }
                .buttonStyle(PressableStyle())
                .accessibilityLabel(fav ? "Remove from favorites" : "Add to favorites")

                ClawdShareButtons(edition: e, finish: finish)
            }
        }
        .padding(.horizontal, 18).padding(.bottom, 18)
    }

    // MARK: Actions

    private func select(_ e: ClawdEdition) {
        selectedID = (selectedID == e.id) ? nil : e.id
        if selectedID == nil { expandedCard = false }
        if selectedID != nil { clawd.onMarkSeen?([e.id]) }
    }

    private func surprise() {
        guard let pick = ClawdEditions.all.randomElement() else { return }
        shelf = .all
        query = ""
        selectedID = pick.id
        clawd.onMarkSeen?([pick.id])
        clawd.onWearEdition?(pick.id)
    }
}

// MARK: - Tile

struct EditionTile: View {
    let edition: ClawdEdition
    let isSelected: Bool
    let isWorn: Bool
    let isFavorite: Bool
    let isNew: Bool
    let index: Int
    let action: () -> Void

    @State private var hovering = false
    @State private var appeared = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    EditionSprite(editionID: edition.id, ptPerCell: 6.5, animate: hovering || isSelected)
                        .frame(maxWidth: .infinity)
                    HStack(spacing: 4) {
                        if isNew { Circle().fill(Color.clay).frame(width: 6, height: 6) }
                        if isFavorite { Image(systemName: "star.fill").font(.system(size: 9)).foregroundStyle(Color.clay) }
                    }
                    .padding(6)
                }
                .padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(hovering || isSelected ? 0.075 : 0.035)))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color.clay : .clear, lineWidth: 1.5))

                VStack(spacing: 1) {
                    Text(edition.name).font(.system(size: 12, weight: .medium)).lineLimit(1)
                    Text(isWorn ? "Wearing" : edition.collection.title)
                        .font(.system(size: 10)).lineLimit(1)
                        .foregroundStyle(isWorn ? Color.clay : .secondary)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PressableStyle())
        .onHover { hovering = $0 }
        .animation(.clawdOutFast, value: hovering)
        .opacity(appeared || reduceMotion ? 1 : 0)
        .offset(y: appeared || reduceMotion ? 0 : 6)
        .onAppear {
            // Short stagger for the first screenful only; nothing waits on it.
            withAnimation(.clawdOut.delay(Double(min(index, 12)) * 0.03)) { appeared = true }
        }
        .accessibilityLabel("\(edition.name), \(edition.collection.title)\(isWorn ? ", wearing" : "")")
    }
}
