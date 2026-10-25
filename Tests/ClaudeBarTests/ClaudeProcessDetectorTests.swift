import XCTest
@testable import ClaudeBar

final class ClaudeProcessDetectorTests: XCTestCase {
    func testFiresOnChangeOnly() {
        var probeValue = false
        let detector = ClaudeProcessDetector(probe: { probeValue }, interval: 3600)
        var changes: [Bool] = []
        detector.onChange = { changes.append($0) }

        detector.checkNow()              // false → false: no change
        probeValue = true
        detector.checkNow()              // false → true: change
        detector.checkNow()              // true → true: no change
        probeValue = false
        detector.checkNow()              // true → false: change

        XCTAssertEqual(changes, [true, false])
        XCTAssertFalse(detector.isLive)
    }

    func testInitialStateIsFalse() {
        let detector = ClaudeProcessDetector(probe: { true }, interval: 3600)
        XCTAssertFalse(detector.isLive) // not live until first checkNow()
    }
}

final class ClaudeProcessProbeParsingTests: XCTestCase {
    func testDaemonAndPtyHostAreIgnored() {
        let ps = """
        ??       /opt/homebrew/Caskroom/claude-code@latest/2.1.302/claude daemon run --origin transient
        ??       /opt/homebrew/Caskroom/claude-code@latest/2.1.302/claude --bg-pty-host /tmp/x
        ttys001  /bin/zsh -l
        """
        XCTAssertFalse(ClaudeProcessDetector.hasInteractiveSession(psOutput: ps))
    }

    func testTerminalSessionCounts() {
        let ps = """
        ??       /opt/homebrew/Caskroom/claude-code@latest/2.1.302/claude daemon run
        ttys003  /opt/homebrew/Caskroom/claude-code@latest/2.1.302/claude --session-id abc
        """
        XCTAssertTrue(ClaudeProcessDetector.hasInteractiveSession(psOutput: ps))
    }

    func testOtherProcessesNamedLikeClaudeDoNotCount() {
        XCTAssertFalse(ClaudeProcessDetector.hasInteractiveSession(psOutput: "ttys001  /usr/bin/vim claude.txt"))
    }
}
