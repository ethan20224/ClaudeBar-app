import SwiftUI

enum SetupCopy {
    static let consentLines = [
        "Connect looks for your claude.ai login in Claude desktop, Chrome, Brave, Edge, Arc or Safari.",
        "macOS may ask for your password to unlock the browser's Safe Storage key.",
        "Nothing is read until you press Connect. The login stays on your Mac, in your Keychain.",
        "To stay connected, ClaudeBar re-reads it every few hours and whenever claude.ai signs you out.",
    ]

    static let pasteSteps = [
        "1. Open claude.ai in your browser",
        "2. Open DevTools (\u{2325}\u{2318}I)",
        "3. Application, then Cookies, then claude.ai",
        "4. Copy the value of sessionKey",
    ]
}

struct SetupView: View {
    @Bindable var model: AppModel
    @FocusState private var focused: Bool
    @State private var showPaste = false
    @Environment(\.colorScheme) private var colorScheme

    private var theme: CartridgeTheme { CartridgeTheme.resolve(colorScheme) }
    private var pasteVisible: Bool { showPaste || model.error == .invalidSessionKey }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text("CONNECT TO CLAUDE")
                    .font(CartridgeFont.font(13, bold: true))
                    .tracking(1.4)
                    .foregroundStyle(theme.ink)
                Text("Show your usage limits in the menu bar.")
                    .font(.system(size: 11))
                    .foregroundStyle(theme.muted)
            }

            VStack(alignment: .leading, spacing: 5) {
                ForEach(SetupCopy.consentLines, id: \.self) { line in
                    Text(line)
                        .font(.system(size: 11))
                        .foregroundStyle(theme.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            if let error = model.error {
                Text(error.errorDescription ?? "Error")
                    .font(.system(size: 11))
                    .foregroundStyle(theme.ember)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Button(action: {
                Task { await model.connectAutomatically() }
            }) {
                HStack(spacing: 8) {
                    if model.isLoading && !pasteVisible {
                        ProgressView()
                            .controlSize(.small)
                            .scaleEffect(0.8)
                            .frame(width: 14, height: 14)
                    }
                    Text("CONNECT")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(CartridgeStateButtonStyle(theme: theme, enabled: !model.isLoading))
            .disabled(model.isLoading)

            Button(action: { withAnimation(.easeOut(duration: 0.16)) { showPaste.toggle() } }) {
                Text(pasteVisible ? "HIDE PASTE OPTION" : "PASTE KEY INSTEAD")
                    .font(CartridgeFont.font(10))
                    .tracking(1.0)
                    .foregroundStyle(theme.tagInk)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)

            if pasteVisible {
                pasteSection
            }
        }
        .padding(14)
    }

    private var pasteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(SetupCopy.pasteSteps, id: \.self) { step in
                    Text(step)
                }
            }
            .font(.system(size: 11))
            .foregroundStyle(theme.muted)

            SecureField("sk-ant-...", text: $model.pendingKey)
                .textFieldStyle(.plain)
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(theme.ink)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(theme.cellOff.opacity(0.5))
                .overlay(
                    Rectangle().strokeBorder(focused ? theme.tagInk : theme.tagBorder,
                                             lineWidth: focused ? 2 : 1)
                )
                .focused($focused)
                .onSubmit { Task { await model.saveKey() } }

            Button(action: { Task { await model.saveKey() } }) {
                Text("SAVE KEY").frame(maxWidth: .infinity)
            }
            .buttonStyle(CartridgeStateButtonStyle(theme: theme,
                                                   enabled: !(model.pendingKey.isEmpty || model.isLoading)))
            .disabled(model.pendingKey.isEmpty || model.isLoading)
        }
        .onAppear { focused = true }
    }
}
