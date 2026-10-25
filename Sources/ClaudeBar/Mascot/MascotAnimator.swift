import AppKit

/// Plays a `ClawdTimeline` into menu-bar images, one timer per frame so long
/// frames (an idle blink gap) cost nothing between ticks.
@MainActor
final class MascotAnimator {
    var onImage: ((NSImage) -> Void)?
    var onOneShotFinished: (() -> Void)?

    private var timer: Timer?
    private var timeline: ClawdTimeline?
    private var index = 0
    private var rowStart = 1

    func play(_ timeline: ClawdTimeline) {
        stop()
        self.timeline = timeline
        index = 0
        // Drop the empty row at the bottom (row 11) unless something draws in the top row.
        rowStart = timeline.frames.contains { $0.canvas.hasContent(inRow: 0) } ? 0 : 1
        emit()
        schedule()
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func schedule() {
        guard let timeline, timeline.frames.count > 1 else { return }
        let delay = timeline.frames[index].duration
        let t = Timer(timeInterval: delay, repeats: false) { [weak self] _ in
            Task { @MainActor in self?.advance() }
        }
        RunLoop.main.add(t, forMode: .common)
        timer = t
    }

    private func advance() {
        guard let timeline else { return }
        if index == timeline.frames.count - 1 {
            if timeline.isOneShot {
                stop()
                onOneShotFinished?()
                return
            }
            index = 0
        } else {
            index += 1
        }
        emit()
        schedule()
    }

    private func emit() {
        guard let timeline else { return }
        let canvas = timeline.frames[index].canvas.croppedRows(from: rowStart, count: MascotRenderer.menuBarRows)
        onImage?(MascotRenderer.render(canvas, theme: timeline.theme))
    }
}
