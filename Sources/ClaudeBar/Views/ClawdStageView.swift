import SwiftUI

/// Big Clawd in the popover: reacts to the same plan as the menu bar, looks at
/// the cursor, and can be petted by clicking.
struct ClawdStageView: View {
    var clawd: ClawdModel
    /// Drawn behind Clawd instead of the flat tint. Clawd itself is untouched.
    var backdrop: AnyView? = nil
    @Environment(\.colorScheme) private var scheme

    private static let stageWidth = 48
    private static let ptPerCell: CGFloat = 6

    var body: some View {
        VStack(spacing: 0) {
        ZStack(alignment: .topTrailing) {
            TimelineView(.animation(minimumInterval: 0.06, paused: clawd.plan.reduceMotion)) { context in
                stage(at: context.date)
            }
            .contentShape(Rectangle())
            .onTapGesture { clawd.onPet?() }
            .onContinuousHover { phase in
                switch phase {
                case .active(let p):
                    let w = CGFloat(Self.stageWidth) * Self.ptPerCell
                    clawd.onEyeLook?(p.x < w * 0.38 ? -1 : (p.x > w * 0.62 ? 1 : 0))
                case .ended:
                    clawd.onEyeLook?(0)
                }
            }

            Button {
                clawd.onOpenWindow?()
            } label: {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(6)
            }
            .buttonStyle(.plain)
            .help("Open Clawdex")
            .accessibilityLabel("Open Clawdex")
        }
        .frame(width: CGFloat(Self.stageWidth) * Self.ptPerCell, height: CGFloat(PixelCanvas.height) * Self.ptPerCell)
        .background {
            if let backdrop {
                backdrop.clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(0.05))
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 8)
        .padding(.bottom, 2)
        caption
        }
    }

    private var caption: some View {
        HStack(spacing: 6) {
            Text(clawd.displayName).font(.system(size: 12, weight: .medium))
            if !clawd.displaySubtitle.isEmpty {
                Text(clawd.displaySubtitle).font(.system(size: 11)).foregroundStyle(.secondary)
            }
        }
        .padding(.bottom, 6)
        .accessibilityElement(children: .combine)
    }

    private func stage(at date: Date) -> some View {
        var canvas = PixelCanvas(width: Self.stageWidth, height: PixelCanvas.height)
        var theme = ClawdTheme(body: ClawdTheme.rgb(0xD07A5C))
        let t = date.timeIntervalSince(clawd.planStart)

        if let timeline = clawd.timeline {
            theme = timeline.theme
            theme.darkBackdrop = scheme == .dark
            canvas.overlay(timeline.frame(at: t), x: (Self.stageWidth - PixelCanvas.width) / 2, y: 0)
        }

        return Image(nsImage: MascotRenderer.render(canvas, theme: theme, pxPerCell: 12, ptPerCell: Self.ptPerCell))
            .interpolation(.none)
            .resizable()
            .frame(width: CGFloat(Self.stageWidth) * Self.ptPerCell, height: CGFloat(PixelCanvas.height) * Self.ptPerCell)
    }
}
