// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ClaudeBar",
    platforms: [.macOS(.v14)],
    targets: [
        .systemLibrary(name: "CommonCrypto"),
        .systemLibrary(name: "CSQLite3"),
        .executableTarget(
            name: "ClaudeBar",
            dependencies: ["CommonCrypto", "CSQLite3"],
            path: "Sources/ClaudeBar",
            resources: [.process("Resources")]
        ),
        // XCTest unit tests. NOTE: this environment has Command Line Tools only
        // (no Xcode.app), so `swift test` cannot run XCTest. Tests are authored
        // for execution under Xcode/CI; the per-task verification gate here is
        // `swift build`. Do not add machine-specific unsafeFlags.
        .testTarget(
            name: "ClaudeBarTests",
            dependencies: ["ClaudeBar"],
            path: "Tests/ClaudeBarTests"
        ),
    ]
)
