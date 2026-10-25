import AppKit

/// Fires an occasional idle fidget at a randomized interval.
@MainActor
final class MascotMicroScheduler {
    var onTrigger: ((MicroMoment) -> Void)?

    private let interval: TimeInterval
    private let jitter: TimeInterval
    var pick: () -> MicroMoment
    private var timer: Timer?

    var isRunning: Bool { timer != nil }

    init(interval: TimeInterval = 150, jitter: TimeInterval = 120,
         pick: @escaping () -> MicroMoment = { MicroMoment.allCases.randomElement()! }) {
        self.interval = interval
        self.jitter = jitter
        self.pick = pick
    }

    func fireNow() { onTrigger?(pick()) }

    /// Idempotent: calling while running keeps the existing countdown.
    func start() {
        guard timer == nil else { return }
        let delay = interval + (jitter > 0 ? TimeInterval.random(in: 0...jitter) : 0)
        let t = Timer(timeInterval: delay, repeats: false) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                self.timer = nil
                self.fireNow()
                self.start()
            }
        }
        RunLoop.main.add(t, forMode: .common)
        timer = t
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
