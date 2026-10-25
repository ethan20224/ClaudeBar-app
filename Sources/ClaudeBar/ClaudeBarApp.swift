import SwiftUI

@main
struct ClaudeBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings { PreferencesView(model: appDelegate.model).frame(width: 350, height: 500) }
    }
}
