import XCTest
@testable import ClaudeBar

/// The packaged app must never share a Keychain item with a developer build, so installing or
/// disconnecting it can't touch someone's existing key.
final class KeychainServiceNameTests: XCTestCase {
    func testDevRunsKeepTheOriginalServiceName() {
        XCTAssertEqual(KeychainRepository.serviceName(bundleID: nil), "com.claudebar")
    }

    func testPackagedAppUsesItsOwnServiceName() {
        XCTAssertEqual(KeychainRepository.serviceName(bundleID: "com.claudebar.app"), "com.claudebar.app")
    }

    func testEmptyBundleIdFallsBack() {
        XCTAssertEqual(KeychainRepository.serviceName(bundleID: ""), "com.claudebar")
    }
}
