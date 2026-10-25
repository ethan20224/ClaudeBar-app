#!/usr/bin/env bash
# Gates for a built ClaudeBar.app. Exits non-zero if any gate fails.
set -uo pipefail
cd "$(dirname "$0")/.."
APP="${1:-dist/ClaudeBar.app}"
BIN="$APP/Contents/MacOS/ClaudeBar"
PLIST="$APP/Contents/Info.plist"
fail=0
check() { # name, command...
  local name="$1"; shift
  if "$@" >/dev/null 2>&1; then echo "PASS  $name"; else echo "FAIL  $name"; fail=1; fi
}

[ -d "$APP" ] || { echo "FAIL  $APP does not exist"; exit 1; }

check "executable exists" test -x "$BIN"
check "resource bundle is in Contents/Resources" test -d "$APP/Contents/Resources/ClaudeBar_ClaudeBar.bundle"
check "app icon present" test -f "$APP/Contents/Resources/AppIcon.icns"
check "bundle id is com.claudebar.app" test "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$PLIST")" = "com.claudebar.app"
check "LSUIElement is true (menu bar only)" test "$(/usr/libexec/PlistBuddy -c 'Print :LSUIElement' "$PLIST")" = "true"
check "LSMinimumSystemVersion is 14.0" test "$(/usr/libexec/PlistBuddy -c 'Print :LSMinimumSystemVersion' "$PLIST")" = "14.0"
check "version matches VERSION file" test "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$PLIST")" = "$(tr -d '[:space:]' < VERSION)"

# Every slice must target macOS 14.0.
minos_ok=1
for arch in $(lipo -archs "$BIN" 2>/dev/null); do
  m=$(otool -arch "$arch" -l "$BIN" | awk '/LC_BUILD_VERSION/{f=1} f&&/minos/{print $2; exit}')
  [ "$m" = "14.0" ] || minos_ok=0
done
check "every architecture has minos 14.0" test "$minos_ok" = 1

sig=$(codesign -dv --verbose=4 "$APP" 2>&1)
check "signature is ad-hoc" grep -q 'Signature=adhoc' <<<"$sig"
check "no team identifier" grep -q 'TeamIdentifier=not set' <<<"$sig"
check "signature verifies" codesign --verify --deep --strict "$APP"

# No identity or home-path strings anywhere in the app, except the intentional copyright name.
# The local account name comes from $USER at run time, so it is never written into this file.
PAT="/Users/|@gmail\.com|Apple Development|$USER"
leak=$(grep -rIlaE "$PAT" "$APP" 2>/dev/null | grep -v 'Info.plist$' || true)
binleak=$(strings -a "$BIN" | grep -E "$PAT" | head -3 || true)
[ -z "$leak" ] && echo "PASS  no identity or home path in app files" || { echo "FAIL  identity strings in: $leak"; fail=1; }
[ -z "$binleak" ] && echo "PASS  no identity or home path in the binary" || { echo "FAIL  binary leaks: $binleak"; fail=1; }

echo "architectures: $(lipo -archs "$BIN" 2>/dev/null)"
[ "$fail" = 0 ] && echo "ALL GATES PASSED" || echo "GATES FAILED"
exit $fail
