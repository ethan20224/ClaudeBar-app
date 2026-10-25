# What ClaudeBar reads, stores and sends

This page is written from the source code. If it ever disagrees with the code, the code wins; please open an issue.

## Nothing is read until you press Connect

On first launch ClaudeBar shows a Connect screen. It does not touch any browser, cookie or other app's
Keychain item before you press **Connect**. You can instead paste your session key yourself and ClaudeBar
will never read a browser.

## What Connect reads

- Your claude.ai login (the `sessionKey` cookie) from the cookie store of Claude desktop, Chrome, Brave, Edge, Arc,
  or Safari. For the Chromium based browsers it also reads that browser's "Safe Storage" item from your Keychain,
  which is how the cookie is decrypted. macOS may ask for your password at that moment.
- Chrome, Brave, Edge and Arc are read from their `Default` profile only.
- Not every browser path has been tested. If Connect cannot find a login, use "Paste key instead".
- Safari's cookie file may be unreadable unless you grant ClaudeBar Full Disk Access.

## Staying connected

If you connected with the Connect button, ClaudeBar re-reads the login every few hours and whenever claude.ai
signs you out, so it keeps working. If you pasted your key, it never reads a browser. Disconnect, in Preferences,
removes the stored key and turns this off.

## What it stores

- One Keychain item, service `com.claudebar.app`, account `sessionKey`, holding your session key.
- Preferences and a short history of usage percentages in the app's preferences.
- Nothing else. It does not write debug files.

## What it sends

Only requests to `claude.ai`: your organization list and your usage, using your session key. The requests carry
browser style headers because claude.ai expects them. There is no analytics, no telemetry, no account, and no
other server.

## Caveats

- These are the same endpoints the claude.ai website uses. They are not a documented public API and can change
  without notice, which will break ClaudeBar until it is updated.
- I have not checked whether Anthropic's terms allow this kind of use. Read them and decide for yourself.
