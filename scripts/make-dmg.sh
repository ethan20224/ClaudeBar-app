#!/usr/bin/env bash
# Wraps dist/ClaudeBar.app in dist/ClaudeBar.dmg with an Applications shortcut, plus a SHA-256 file.
set -euo pipefail
cd "$(dirname "$0")/.."
APP="dist/ClaudeBar.app"
[ -d "$APP" ] || { echo "Build the app first: scripts/build-app.sh" >&2; exit 1; }
STAGE="$(mktemp -d)/ClaudeBar"
mkdir -p "$STAGE"
cp -R "$APP" "$STAGE/"
ln -s /Applications "$STAGE/Applications"
rm -f dist/ClaudeBar.dmg
hdiutil create -volname "ClaudeBar" -srcfolder "$STAGE" -ov -format UDZO dist/ClaudeBar.dmg >/dev/null
( cd dist && shasum -a 256 ClaudeBar.dmg > ClaudeBar.dmg.sha256 )
echo "Built dist/ClaudeBar.dmg"; cat dist/ClaudeBar.dmg.sha256
