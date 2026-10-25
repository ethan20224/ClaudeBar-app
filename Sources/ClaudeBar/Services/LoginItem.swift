import Foundation
import Observation
import ServiceManagement

protocol LoginItemControlling {
    var isEnabled: Bool { get }
    var requiresApproval: Bool { get }
    func setEnabled(_ on: Bool) throws
}

struct SystemLoginItem: LoginItemControlling {
    var isEnabled: Bool { SMAppService.mainApp.status == .enabled }
    var requiresApproval: Bool { SMAppService.mainApp.status == .requiresApproval }

    func setEnabled(_ on: Bool) throws {
        if on {
            try SMAppService.mainApp.register()
        } else {
            try SMAppService.mainApp.unregister()
        }
    }
}

/// Drives the "Launch at login" toggle. The switch always shows what macOS reports, so a failed
/// registration (for example an unsigned build) can't look like it worked.
@MainActor
@Observable
final class LoginItemModel {
    private let controller: LoginItemControlling
    private(set) var isOn: Bool
    private(set) var message: String?

    init(controller: LoginItemControlling) {
        self.controller = controller
        self.isOn = controller.isEnabled
        self.message = Self.hint(for: controller)
    }

    func set(_ on: Bool) {
        var failure: String?
        do {
            try controller.setEnabled(on)
        } catch {
            failure = error.localizedDescription
        }
        isOn = controller.isEnabled
        message = failure ?? Self.hint(for: controller)
    }

    func refresh() {
        isOn = controller.isEnabled
        message = Self.hint(for: controller)
    }

    private static func hint(for controller: LoginItemControlling) -> String? {
        controller.requiresApproval ? "Approve ClaudeBar in System Settings, General, Login Items." : nil
    }
}

enum AppVersion {
    static func display(info: [String: Any]? = Bundle.main.infoDictionary) -> String {
        guard let short = info?["CFBundleShortVersionString"] as? String, !short.isEmpty else { return "dev" }
        if let build = info?["CFBundleVersion"] as? String, !build.isEmpty { return "\(short) (\(build))" }
        return short
    }
}
