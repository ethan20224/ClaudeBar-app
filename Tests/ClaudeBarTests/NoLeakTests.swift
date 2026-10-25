import XCTest

/// Source scan for things that must never ship: debug files in /tmp, the undocumented
/// ~/.claudebar key files, and the removed baby Clawd feature.
final class NoLeakTests: XCTestCase {
    private func swiftSources() throws -> [(path: String, text: String)] {
        let sources = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
            .appendingPathComponent("Sources")
        guard let walker = FileManager.default.enumerator(at: sources, includingPropertiesForKeys: nil) else {
            XCTFail("cannot walk \(sources.path)")
            return []
        }
        var files: [(String, String)] = []
        for case let url as URL in walker where url.pathExtension == "swift" {
            files.append((url.path, try String(contentsOf: url, encoding: .utf8)))
        }
        XCTAssertGreaterThan(files.count, 20, "scan found too few sources, path resolution is wrong")
        return files
    }

    func testNoTmpWritesOrHomeKeyFilesInSources() throws {
        let banned = ["\"/tmp/", ".claudebar/", "cb_api_response", "cb_state.log"]
        for (path, text) in try swiftSources() {
            for needle in banned {
                XCTAssertFalse(text.contains(needle), "\(needle) found in \(path)")
            }
        }
    }

    func testBabyClawdsStayRemoved() throws {
        for (path, text) in try swiftSources() {
            XCTAssertFalse(text.contains("babyCount"), "babyCount found in \(path)")
            XCTAssertFalse(text.contains("drawBabies"), "drawBabies found in \(path)")
        }
    }
}
