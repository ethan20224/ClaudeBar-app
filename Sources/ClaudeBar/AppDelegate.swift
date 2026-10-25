import AppKit
import SwiftUI

@MainActor
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    private var clickMonitor: Any?
    private var mouseMonitor: Any?
    private var dismissGlobalMonitor: Any?
    private var dismissLocalMonitor: Any?
    private var appearanceObservation: NSKeyValueObservation?
    private let mascot = MascotController()
    private let presentation = PopoverPresentation()
    let model = AppModel()

    private func loadIcon() -> NSImage? {
        if let url = Bundle.module.url(forResource: "claude-icon", withExtension: "png") ?? Bundle.main.url(forResource: "claude-icon", withExtension: "png", subdirectory: "Contents/Resources"),
           let image = NSImage(contentsOf: url) {
            return image
        }
        return nil
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        setupStatusItem()
        setupPopover()

        if let image = loadIcon() {
            NSApp.applicationIconImage = image
        }

        setupRightClickMenu()

        model.onStatusUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateStatusBar()
            }
        }
        Task { await model.start() }

        mascot.model.onOpenWindow = { [weak self] in
            guard let self else { return }
            self.popover?.performClose(nil)
            ClawdexWindow.show(model: self.mascot.model)
        }
        mascot.setReduceMotion(NSWorkspace.shared.accessibilityDisplayShouldReduceMotion)
        mascot.start()
        observeBackdropAndCursor()
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification,
            object: nil, queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.mascot.setReduceMotion(NSWorkspace.shared.accessibilityDisplayShouldReduceMotion)
            }
        }

        let notificationService = NotificationService()
        Task { await notificationService.requestPermission() }
    }

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.isVisible = true
        guard let button = statusItem?.button else { return }

        button.imagePosition = .imageLeading
        mascot.onImage = { [weak button] image in
            button?.image = image
        }

        button.action = #selector(togglePopover)
        button.target = self

        // Fire the haptic on the real mouse-DOWN edge (instant, button-like)
        // via a dedicated monitor, while the popover toggle keeps its known-good
        // mouse-up path. Filtered to clicks on the status item's own window so
        // popover/preferences clicks don't trigger it. Left-click only (right
        // click shows the menu, no haptic).
        clickMonitor = NSEvent.addLocalMonitorForEvents(matching: .leftMouseDown) { [weak self] event in
            guard let self,
                  let statusButton = self.statusItem?.button,
                  event.window == statusButton.window else { return event }
            if self.popover?.isShown == true {
                HapticService.playClose()
            } else {
                HapticService.playOpen()
            }
            return event
        }

        updateStatusBar()
    }

    /// Clawd's dark props lighten on a dark menu bar, and his eyes glance at the cursor.
    private func observeBackdropAndCursor() {
        guard let button = statusItem?.button else { return }
        let updateBackdrop = { [weak self, weak button] in
            guard let button else { return }
            let dark = button.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            self?.mascot.setDarkBackdrop(dark)
        }
        updateBackdrop()
        appearanceObservation = button.observe(\.effectiveAppearance, options: [.new]) { _, _ in
            Task { @MainActor in updateBackdrop() }
        }
        mouseMonitor = NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { [weak self] _ in
            Task { @MainActor in self?.updateEyeLook() }
        }
    }

    private func updateEyeLook() {
        guard let window = statusItem?.button?.window else { return }
        guard mascot.motionAllowed else { return }
        let dx = NSEvent.mouseLocation.x - window.frame.midX
        mascot.setEyeLook(dx < -160 ? -1 : (dx > 160 ? 1 : 0))
    }

    private func setupPopover() {
        popover = NSPopover()
        // We own dismissal (see installDismissMonitors): the system's transient close fires on the
        // status item's own press, racing the toggle so a second click reopened instead of closing.
        popover?.behavior = .applicationDefined
        // The open/close entrance is drawn by PopoverView + the window fade below, not the system.
        popover?.animates = false
        popover?.delegate = self
        let hostingController = NSHostingController(rootView: PopoverView(model: model, clawd: mascot.model, presentation: presentation))
        // Force view load to prevent first-render glitches
        _ = hostingController.view
        popover?.contentViewController = hostingController
        applyAppearance()
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
            Task { @MainActor in self?.applyAppearance() }
        }
    }

    /// Light/Dark override from Preferences or the popover header; nil follows the system.
    private func applyAppearance() {
        popover?.appearance = AppearanceMode.stored.nsAppearance
    }

    @objc private func togglePopover(_ sender: AnyObject?) {
        guard let button = statusItem?.button else { return }
        if popover?.isShown == true {
            closePopoverAnimated()
        } else {
            // Show popover first, then activate to ensure correct appearance inheritance
            popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            NSApp.activate(ignoringOtherApps: true)
            playOpenAnimation(from: button)
            installDismissMonitors()
        }
    }

    /// Outside click / Escape / app deactivation close the popover. Clicks on the status item itself
    /// are left to its action, which toggles.
    private func installDismissMonitors() {
        removeDismissMonitors()
        dismissGlobalMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown, .otherMouseDown]) { [weak self] _ in
            Task { @MainActor in
                guard let self, !self.isOverStatusItem(NSEvent.mouseLocation) else { return }
                self.closePopoverAnimated()
            }
        }
        dismissLocalMonitor = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown, .keyDown]) { [weak self] event in
            guard let self, let popoverWindow = self.popover?.contentViewController?.view.window else { return event }
            if event.type == .keyDown {
                if event.keyCode == 53 { self.closePopoverAnimated(); return nil }
                return event
            }
            if event.window == popoverWindow || event.window == self.statusItem?.button?.window
                || self.isOverStatusItem(NSEvent.mouseLocation) { return event }
            self.closePopoverAnimated()
            return event
        }
    }

    /// True when a screen point is over the menu bar item (the global monitor can see its clicks too).
    private func isOverStatusItem(_ point: NSPoint) -> Bool {
        guard let button = statusItem?.button, let window = button.window else { return false }
        return window.convertToScreen(button.convert(button.bounds, to: nil)).insetBy(dx: -2, dy: -4).contains(point)
    }

    private func removeDismissMonitors() {
        if let m = dismissGlobalMonitor { NSEvent.removeMonitor(m) }
        if let m = dismissLocalMonitor { NSEvent.removeMonitor(m) }
        dismissGlobalMonitor = nil
        dismissLocalMonitor = nil
    }

    private static let easeOut = CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)

    private func playOpenAnimation(from button: NSStatusBarButton) {
        guard let window = popover?.contentViewController?.view.window else {
            presentation.revealed = true
            return
        }
        if let buttonWindow = button.window, window.frame.width > 0 {
            let iconRect = buttonWindow.convertToScreen(button.convert(button.bounds, to: nil))
            presentation.anchorX = min(1, max(0, Double((iconRect.midX - window.frame.minX) / window.frame.width)))
        }
        let reduce = NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
        window.alphaValue = 0
        NSAnimationContext.runAnimationGroup { ctx in
            ctx.duration = reduce ? 0.12 : 0.16
            ctx.timingFunction = Self.easeOut
            window.animator().alphaValue = 1
        }
        // Next tick, so the hidden state renders once and the reveal animates from it.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.016) { [weak self] in
            self?.presentation.revealed = true
        }
    }

    /// Close is the faster half: ~120ms fade, no stagger.
    private func closePopoverAnimated() {
        guard let popover, let window = popover.contentViewController?.view.window else {
            popover?.performClose(nil)
            return
        }
        NSAnimationContext.runAnimationGroup({ ctx in
            ctx.duration = 0.12
            ctx.timingFunction = Self.easeOut
            window.animator().alphaValue = 0
        }, completionHandler: { [weak popover] in
            popover?.performClose(nil)
        })
    }

    func popoverDidClose(_ notification: Notification) {
        removeDismissMonitors()
        popover?.contentViewController?.view.window?.alphaValue = 1
        presentation.revealed = false
    }

    private func setupRightClickMenu() {
        guard let button = statusItem?.button else { return }

        let menu = NSMenu()
        menu.addItem(withTitle: "Claude Usage", action: nil, keyEquivalent: "").isEnabled = false
        menu.addItem(NSMenuItem.separator())

        let modes = [
            ("Percentage", "percentage"),
            ("Countdown", "countdown"),
            ("Both", "both")
        ]

        modes.forEach { title, mode in
            let item = NSMenuItem(title: title, action: #selector(setMenuBarMode(_:)), keyEquivalent: "")
            item.representedObject = mode
            menu.addItem(item)
        }

        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Open Clawdex...", action: #selector(openClawdex), keyEquivalent: "k")
        menu.addItem(withTitle: "Preferences...", action: #selector(openPreferences), keyEquivalent: ",")
        menu.addItem(withTitle: "Refresh", action: #selector(refreshNow), keyEquivalent: "r")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit Claude Bar", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")

        button.menu = menu
    }

    @objc private func setMenuBarMode(_ sender: NSMenuItem) {
        if let mode = sender.representedObject as? String {
            UserDefaults.standard.set(mode, forKey: "menuBarMode")
            updateStatusBar()
        }
    }

    @objc private func openClawdex() {
        ClawdexWindow.show(model: mascot.model)
    }

    @objc private func openPreferences() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 350, height: 500),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "Preferences"
        window.contentViewController = NSHostingController(rootView: PreferencesView(model: model))
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc private func refreshNow() {
        Task { await model.refresh() }
    }

    private func updateStatusBar() {
        guard let button = statusItem?.button else { return }

        let titleString = model.statusBarTitle

        let utilization = model.usage?.fiveHour.utilization ?? 0

        let textColor: NSColor
        if utilization >= 90 {
            textColor = .systemRed
        } else if utilization >= 75 {
            textColor = .systemOrange
        } else {
            textColor = .labelColor
        }

        let font = button.font ?? NSFont.systemFont(ofSize: 13.0)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: font
        ]

        button.attributedTitle = NSAttributedString(string: titleString, attributes: attributes)
        // The name is never drawn in the bar; hovering Clawd for a moment shows it as a tooltip.
        button.toolTip = mascot.model.displayName

        mascot.update(usage: model.usage)
    }
}

