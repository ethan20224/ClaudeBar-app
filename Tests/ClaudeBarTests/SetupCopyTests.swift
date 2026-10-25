import XCTest
@testable import ClaudeBar

final class SetupCopyTests: XCTestCase {
    private var allCopy: String { (SetupCopy.consentLines + SetupCopy.pasteSteps).joined(separator: "\n") }

    func testConsentCopyNamesEveryBrowserAndTheKeychainPrompt() {
        let text = SetupCopy.consentLines.joined(separator: " ")
        for browser in ["Claude desktop", "Chrome", "Brave", "Edge", "Arc", "Safari"] {
            XCTAssertTrue(text.contains(browser), "missing \(browser)")
        }
        XCTAssertTrue(text.contains("Safe Storage"))
        XCTAssertTrue(text.contains("until you press Connect"))
    }

    func testConsentCopyAdmitsTheBackgroundRefresh() {
        XCTAssertTrue(SetupCopy.consentLines.joined(separator: " ").contains("every few hours"))
    }

    func testCopyHasNoEmDashes() {
        XCTAssertFalse(allCopy.contains("\u{2014}"))
        XCTAssertFalse(allCopy.contains("--"))
    }
}
