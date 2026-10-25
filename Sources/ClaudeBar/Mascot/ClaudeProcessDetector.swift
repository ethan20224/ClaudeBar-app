import Foundation

final class ClaudeProcessDetector {
    private let probe: () -> Bool
    private let interval: TimeInterval
    private var timer: Timer?

    private(set) var isLive: Bool = false
    var onChange: ((Bool) -> Void)?

    init(probe: @escaping () -> Bool = ClaudeProcessDetector.pgrepProbe, interval: TimeInterval = 3) {
        self.probe = probe
        self.interval = interval
    }

    func checkNow() {
        let value = probe()
        guard value != isLive else { return }
        isLive = value
        onChange?(value)
    }

    func start() {
        stop()
        checkNow()
        let t = Timer(timeInterval: interval, repeats: true) { [weak self] _ in self?.checkNow() }
        RunLoop.main.add(t, forMode: .common)
        timer = t
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    /// Real probe: lists processes with `ps` and looks for an interactive `claude` session.
    /// Background helpers (the daemon and its pty host) outlive the terminal, so they are ignored.
    static func pgrepProbe() -> Bool {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/ps")
        process.arguments = ["-axo", "tty=,command="]
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = Pipe()
        do {
            try process.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            process.waitUntilExit()
            return hasInteractiveSession(psOutput: String(decoding: data, as: UTF8.self))
        } catch {
            return false
        }
    }

    /// True when any `ps -axo tty=,command=` line is a `claude` process attached to a terminal
    /// and not a background helper.
    static func hasInteractiveSession(psOutput: String) -> Bool {
        psOutput.split(separator: "\n").contains { line in
            let parts = line.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            guard parts.count == 2 else { return false }
            let tty = parts[0]
            let command = parts[1]
            guard tty != "??", tty != "?" else { return false }
            let exe = command.split(separator: " ", maxSplits: 1).first.map(String.init) ?? ""
            guard (exe as NSString).lastPathComponent == "claude" else { return false }
            return !command.contains(" daemon ") && !command.contains("--bg-pty-host")
        }
    }
}
