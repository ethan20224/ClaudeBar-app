import SwiftUI

struct PopoverView: View {
    var model: AppModel
    var clawd: ClawdModel
    var presentation: PopoverPresentation
    @Environment(\.colorScheme) private var systemScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @AppStorage(AppearanceMode.key) private var appearanceRaw: String = AppearanceMode.system.rawValue

    init(model: AppModel, clawd: ClawdModel, presentation: PopoverPresentation) {
        self.model = model
        self.clawd = clawd
        self.presentation = presentation
        CartridgeFont.register()
    }

    /// The user's Light/Dark choice wins; System follows macOS.
    private var scheme: ColorScheme {
        (AppearanceMode(rawValue: appearanceRaw) ?? .system).colorScheme ?? systemScheme
    }

    private var theme: CartridgeTheme { .resolve(scheme) }

    private var glow: Color? {
        guard let usage = model.usage else { return nil }
        return theme.glow(usage.fiveHour.color)
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            ClawdStageView(
                clawd: clawd,
                backdrop: AnyView(SkyBackdrop(elapsed: model.usage?.fiveHour.elapsedFraction, isDark: theme.isDark))
            )
            .revealStagger(1)
            if model.isSetup {
                usageContent
                loginOffer
            } else if model.isInitializing || model.isReconnecting {
                CartridgeLoadingView(text: model.isReconnecting ? "RECONNECTING..." : "CONNECTING...", theme: theme)
                    .padding(.vertical, 24)
            } else {
                SetupView(model: model)
            }
        }
        .padding(.bottom, 14)
        .frame(width: 320)
        .background(cardBackground.ignoresSafeArea())
        .fixedSize(horizontal: false, vertical: true)
        .environment(\.colorScheme, scheme)
        .environment(\.popoverRevealed, presentation.revealed)
        // Grows out of the menu bar icon: slight scale from the icon's x, panel fade is on the window.
        .scaleEffect(
            (presentation.revealed || reduceMotion) ? 1 : 0.96,
            anchor: UnitPoint(x: presentation.anchorX, y: 0)
        )
        .animation(
            reduceMotion ? nil : Animation.timingCurve(0.23, 1, 0.32, 1, duration: 0.2),
            value: presentation.revealed
        )
    }

    private var cardBackground: some View {
        ZStack {
            theme.card
            if let glow {
                RadialGradient(colors: [glow.opacity(0.22), .clear], center: .bottom, startRadius: 0, endRadius: 260)
            }
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            Text("CLAUDE")
                .font(CartridgeFont.font(12))
                .tracking(1.4)
                .foregroundStyle(theme.muted)
            Spacer()
            AppearanceToggleButton(theme: theme)
            AnimationToggleButton(isPaused: clawd.animationsPaused, theme: theme, action: { clawd.onToggleAnimations?() })
            RefreshButton(
                isLoading: model.isLoading,
                theme: theme,
                action: { Task { await model.refresh(forceRefresh: true) } }
            )
            if let badge = model.planTier?.badge {
                Text(badge)
                    .font(CartridgeFont.font(11))
                    .tracking(1)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 1)
                    .foregroundStyle(theme.tagInk)
                    .overlay(Rectangle().stroke(theme.tagBorder, lineWidth: 1))
                    .accessibilityLabel("Plan \(badge.lowercased())")
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 12)
        .padding(.bottom, 4)
        .revealStagger(0)
    }

    /// Shown once, after the first successful connect.
    @ViewBuilder
    private var loginOffer: some View {
        if model.shouldOfferLoginItem {
            HStack(spacing: 12) {
                Text("OPEN AT LOGIN?")
                    .font(CartridgeFont.font(10))
                    .tracking(1.2)
                    .foregroundStyle(theme.muted)
                Spacer()
                Button("YES") { model.acceptLoginOffer() }
                Button("NO") { model.dismissLoginOffer() }
            }
            .buttonStyle(.plain)
            .font(CartridgeFont.font(10, bold: true))
            .foregroundStyle(theme.tagInk)
            .padding(.horizontal, 14)
            .padding(.top, 12)
        }
    }

    @ViewBuilder
    private var usageContent: some View {
        if let usage = model.usage {
            VStack(alignment: .leading, spacing: 14) {
                HeroWindowRow(label: "5-HOUR WINDOW", period: usage.fiveHour, theme: theme)
                WeeklyRow(label: "WEEKLY", period: usage.sevenDay, theme: theme)
            }
            .padding(.horizontal, 14)
            .padding(.top, 12)
            .revealStagger(2)
        } else if let error = model.error {
            CartridgeErrorView(
                message: error.errorDescription ?? "Unknown error",
                theme: theme,
                retry: { Task { await model.refresh(forceRefresh: true) } }
            )
            .padding(20)
        } else {
            CartridgeLoadingView(text: "LOADING...", theme: theme)
                .padding(.vertical, 24)
        }
    }
}

// MARK: - Reset text

/// Countdown and clock time for a period, in the caps style used by the cartridge rows.
struct ResetText {
    let countdown: String?
    let clock: String?
    let fallback: String

    init(period: UsagePeriod, includeWeekday: Bool = false) {
        fallback = period.utilization == 0 ? "NO ACTIVE WINDOW" : "RESET UNKNOWN"
        guard let next = period.nextResetDate, let interval = period.timeUntilReset else {
            countdown = nil
            clock = nil
            return
        }
        let total = max(0, Int(interval))
        let days = total / 86_400
        let hours = (total % 86_400) / 3600
        let minutes = (total % 3600) / 60
        if includeWeekday && days > 0 {
            countdown = "\(days)D \(hours)H"
        } else if total >= 3600 {
            countdown = "\(total / 3600)H \(String(format: "%02d", minutes))M"
        } else {
            countdown = "\(minutes)M"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = includeWeekday ? "EEE h:mm a" : "h:mm a"
        clock = formatter.string(from: next).uppercased()
    }

    var spoken: String {
        guard let countdown, let clock else { return fallback.lowercased() }
        return "resets in \(countdown.lowercased()) at \(clock.lowercased())"
    }
}

// MARK: - Rows

/// The 5-hour window: pixel numeral, reset block, sky bar.
struct HeroWindowRow: View {
    let label: String
    let period: UsagePeriod
    let theme: CartridgeTheme

    var body: some View {
        let reset = ResetText(period: period)
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(CartridgeFont.font(12))
                .tracking(1.6)
                .foregroundStyle(period.color == .red ? theme.ember : theme.muted)
            HStack(alignment: .bottom) {
                PixelNumeral(value: Int(period.utilization), cell: 6, digitColor: theme.ink, percentColor: theme.level(period.color))
                Spacer(minLength: 8)
                resetBlock(reset)
            }
            CellBar(fraction: period.utilization / 100, kind: .hero, theme: theme)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label.capitalized), \(Int(period.utilization)) percent, \(reset.spoken)")
    }

    @ViewBuilder
    private func resetBlock(_ reset: ResetText) -> some View {
        if let countdown = reset.countdown, let clock = reset.clock {
            VStack(alignment: .trailing, spacing: 0) {
                Text("RESETS IN").font(CartridgeFont.font(11)).tracking(1.2).foregroundStyle(theme.muted)
                Text(countdown).font(CartridgeFont.font(14)).foregroundStyle(theme.ink)
                Text(clock).font(CartridgeFont.font(12)).foregroundStyle(theme.muted)
            }
        } else {
            Text(reset.fallback).font(CartridgeFont.font(11)).tracking(1.2).foregroundStyle(theme.muted)
        }
    }
}

/// Weekly window: smaller, secondary.
struct WeeklyRow: View {
    let label: String
    let period: UsagePeriod
    let theme: CartridgeTheme

    var body: some View {
        let reset = ResetText(period: period, includeWeekday: true)
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label).font(CartridgeFont.font(12)).tracking(1.6).foregroundStyle(theme.muted)
                Spacer()
                Text("\(Int(period.utilization))%").font(CartridgeFont.font(12)).foregroundStyle(theme.ink)
            }
            CellBar(fraction: period.utilization / 100, kind: .slim, theme: theme)
            Text(captionText(reset))
                .font(CartridgeFont.font(11))
                .tracking(0.8)
                .foregroundStyle(theme.muted)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Weekly, \(Int(period.utilization)) percent, \(reset.spoken)")
    }

    private func captionText(_ reset: ResetText) -> String {
        guard let countdown = reset.countdown, let clock = reset.clock else { return reset.fallback }
        return "RESETS IN \(countdown) · \(clock)"
    }
}

// MARK: - Controls

struct RefreshButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.12), value: configuration.isPressed)
    }
}

/// Pixel glyph drawn from whole-point rects (grid units are points).
struct PixelIcon: View {
    let rects: [CGRect]
    let size: CGSize
    let color: Color

    var body: some View {
        Canvas { context, _ in
            for r in rects { context.fill(Path(r), with: .color(color)) }
        }
        .frame(width: size.width, height: size.height)
        .accessibilityHidden(true)
    }

    static let pause: [CGRect] = [CGRect(x: 1, y: 1, width: 3, height: 10), CGRect(x: 7, y: 1, width: 3, height: 10)]
    static let play: [CGRect] = [
        CGRect(x: 1, y: 1, width: 2, height: 10), CGRect(x: 3, y: 2, width: 2, height: 8),
        CGRect(x: 5, y: 3, width: 2, height: 6), CGRect(x: 7, y: 4, width: 2, height: 4),
    ]
    static let refresh: [CGRect] = [
        CGRect(x: 3, y: 1, width: 6, height: 2), CGRect(x: 1, y: 3, width: 2, height: 6),
        CGRect(x: 3, y: 9, width: 6, height: 2), CGRect(x: 9, y: 6, width: 2, height: 3),
        CGRect(x: 8, y: 1, width: 4, height: 2), CGRect(x: 10, y: 3, width: 2, height: 2),
    ]
}

struct AnimationToggleButton: View {
    let isPaused: Bool
    var theme: CartridgeTheme = .dark
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            PixelIcon(rects: isPaused ? PixelIcon.play : PixelIcon.pause, size: CGSize(width: 11, height: 12), color: theme.muted)
                .frame(width: 22, height: 22)
                .contentShape(Rectangle())
        }
        .buttonStyle(RefreshButtonStyle())
        .help(isPaused ? "Resume Clawd's animations" : "Pause Clawd's animations")
        .accessibilityLabel(isPaused ? "Resume Clawd's animations" : "Pause Clawd's animations")
    }
}

struct RefreshButton: View {
    let isLoading: Bool
    var theme: CartridgeTheme = .dark
    let action: () -> Void

    @State private var rotation: Double = 0
    @State private var rotationTask: Task<Void, Never>?

    var body: some View {
        Button(action: {
            HapticService.playRefresh()
            action()
        }) {
            PixelIcon(rects: PixelIcon.refresh, size: CGSize(width: 12, height: 12), color: theme.muted)
                .rotationEffect(.degrees(rotation))
                .frame(width: 22, height: 22)
                .contentShape(Rectangle())
        }
        .buttonStyle(RefreshButtonStyle())
        .disabled(isLoading)
        .accessibilityLabel("Refresh usage")
        .onChange(of: isLoading) { _, loading in
            if loading {
                startRotation()
            } else {
                stopRotation()
            }
        }
    }

    private func startRotation() {
        rotationTask?.cancel()
        rotationTask = Task {
            while !Task.isCancelled {
                withAnimation(.linear(duration: 0.6)) {
                    rotation += 360
                }
                try? await Task.sleep(for: .milliseconds(600))
            }
        }
    }

    private func stopRotation() {
        rotationTask?.cancel()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.55)) {
            rotation = ceil(rotation / 360) * 360
        }
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .popover
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

/// Always-colored usage bar. The stock ProgressView drops to grey whenever the popover window is
/// not the active window (which is the case on first open), so it is drawn by hand instead.
struct UsageBar: View {
    let fraction: Double
    let color: Color

    var body: some View {
        // GeometryReader must sit in an overlay, not be the bar's own body: as the body it has no
        // intrinsic height, and inside a real NSPopover (Auto Layout, not SwiftUI's own layout
        // pass) that makes the hosting view stretch to fill the whole screen instead of 11pt.
        Capsule()
            .fill(Color.primary.opacity(0.14))
            .frame(height: 11)
            .overlay(alignment: .leading) {
                GeometryReader { geo in
                    Capsule()
                        .fill(color)
                        .frame(width: max(0, min(1, fraction)) * geo.size.width)
                }
            }
            .accessibilityElement()
        .accessibilityLabel("Usage")
        .accessibilityValue("\(Int(max(0, min(1, fraction)) * 100)) percent")
    }
}
