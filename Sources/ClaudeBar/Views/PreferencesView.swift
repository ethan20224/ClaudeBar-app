import SwiftUI

struct PreferencesView: View {
    let model: AppModel
    @AppStorage(AppearanceMode.key) private var appearanceRaw: String = AppearanceMode.system.rawValue
    @State private var refreshInterval: Int = {
        let v = UserDefaults.standard.integer(forKey: "refreshInterval")
        return v > 0 ? v : 60
    }()
    @State private var notificationsEnabled: Bool = {
        if UserDefaults.standard.object(forKey: "notificationsEnabled") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notificationsEnabled")
    }()
    @State private var notify5hAt75: Bool = {
        if UserDefaults.standard.object(forKey: "notify5hAt75") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notify5hAt75")
    }()
    @State private var notify5hAt90: Bool = {
        if UserDefaults.standard.object(forKey: "notify5hAt90") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notify5hAt90")
    }()
    @State private var notify5hAt100: Bool = {
        if UserDefaults.standard.object(forKey: "notify5hAt100") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notify5hAt100")
    }()
    @State private var notify7dAt75: Bool = {
        if UserDefaults.standard.object(forKey: "notify7dAt75") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notify7dAt75")
    }()
    @State private var notify7dAt90: Bool = {
        if UserDefaults.standard.object(forKey: "notify7dAt90") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notify7dAt90")
    }()
    @State private var notify7dAt100: Bool = {
        if UserDefaults.standard.object(forKey: "notify7dAt100") == nil { return true }
        return UserDefaults.standard.bool(forKey: "notify7dAt100")
    }()

    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            Text("Preferences")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                Text("Refresh Interval")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Picker("", selection: $refreshInterval) {
                    Text("30 seconds").tag(30)
                    Text("60 seconds").tag(60)
                    Text("2 minutes").tag(120)
                    Text("5 minutes").tag(300)
                }
                .pickerStyle(.segmented)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Appearance")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Picker("", selection: $appearanceRaw) {
                    ForEach(AppearanceMode.allCases) { mode in
                        Text(mode.title).tag(mode.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }

            VStack(alignment: .leading, spacing: 8) {
                Toggle("Notifications Enabled", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { _, newValue in
                        UserDefaults.standard.set(newValue, forKey: "notificationsEnabled")
                    }

                if notificationsEnabled {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("5-Hour Window")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        Toggle("Alert at 75%", isOn: $notify5hAt75)
                            .onChange(of: notify5hAt75) { _, newValue in
                                UserDefaults.standard.set(newValue, forKey: "notify5hAt75")
                            }
                        Toggle("Alert at 90%", isOn: $notify5hAt90)
                            .onChange(of: notify5hAt90) { _, newValue in
                                UserDefaults.standard.set(newValue, forKey: "notify5hAt90")
                            }
                        Toggle("Alert at 100%", isOn: $notify5hAt100)
                            .onChange(of: notify5hAt100) { _, newValue in
                                UserDefaults.standard.set(newValue, forKey: "notify5hAt100")
                            }
                    }
                    .padding(.leading, 16)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("7-Day Limit")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        Toggle("Alert at 75%", isOn: $notify7dAt75)
                            .onChange(of: notify7dAt75) { _, newValue in
                                UserDefaults.standard.set(newValue, forKey: "notify7dAt75")
                            }
                        Toggle("Alert at 90%", isOn: $notify7dAt90)
                            .onChange(of: notify7dAt90) { _, newValue in
                                UserDefaults.standard.set(newValue, forKey: "notify7dAt90")
                            }
                        Toggle("Alert at 100%", isOn: $notify7dAt100)
                            .onChange(of: notify7dAt100) { _, newValue in
                                UserDefaults.standard.set(newValue, forKey: "notify7dAt100")
                            }
                    }
                    .padding(.leading, 16)
                }
            }

            accountSection
        }
        .padding(20)
        }
        .frame(width: 350, height: 500)
        .onAppear { model.loginItem.refresh() }
        .onDisappear {
            UserDefaults.standard.set(refreshInterval, forKey: "refreshInterval")
            NotificationCenter.default.post(name: NSNotification.Name("RefreshIntervalChanged"), object: nil)
        }
    }
}

private extension PreferencesView {
    var accountSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Launch at login", isOn: Binding(
                get: { model.loginItem.isOn },
                set: { model.loginItem.set($0) }
            ))
            if let message = model.loginItem.message {
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            if model.isSetup {
                Button("Disconnect from Claude") { model.disconnect() }
            }
            Text("ClaudeBar \(AppVersion.display())")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
