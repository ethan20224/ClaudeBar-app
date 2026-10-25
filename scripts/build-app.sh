#!/usr/bin/env bash
# Builds dist/ClaudeBar.app: release build, resource bundle, Info.plist, icon, ad-hoc signature.
# ARCHS="arm64" forces a single architecture. By default it tries universal (arm64 + x86_64)
# and falls back to arm64 if the x86_64 slice does not build.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

VERSION="$(tr -d '[:space:]' < VERSION)"
BUILD="${BUILD_NUMBER:-$(git rev-list --count HEAD 2>/dev/null || echo 1)}"
DIST="dist"
APP="$DIST/ClaudeBar.app"

# Keep the machine's file paths out of the binary.
PREFIX_FLAGS=(-Xswiftc -file-prefix-map -Xswiftc "$ROOT=/ClaudeBar" -Xswiftc -debug-prefix-map -Xswiftc "$ROOT=/ClaudeBar")

build() { swift build -c release "${PREFIX_FLAGS[@]}" "$@"; }

if [ -n "${ARCHS:-}" ]; then
  ARCH_FLAGS=(); for a in $ARCHS; do ARCH_FLAGS+=(--arch "$a"); done
  build "${ARCH_FLAGS[@]}"
else
  if build --arch arm64 --arch x86_64; then
    ARCH_FLAGS=(--arch arm64 --arch x86_64); ARCHS="arm64 x86_64"
  else
    echo "x86_64 slice did not build, falling back to arm64 only" >&2
    ARCH_FLAGS=(--arch arm64); ARCHS="arm64"
    build "${ARCH_FLAGS[@]}"
  fi
fi
BIN_DIR="$(swift build -c release "${ARCH_FLAGS[@]}" --show-bin-path)"

rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp "$BIN_DIR/ClaudeBar" "$APP/Contents/MacOS/ClaudeBar"
cp -R "$BIN_DIR/ClaudeBar_ClaudeBar.bundle" "$APP/Contents/Resources/"

sed -e "s/@VERSION@/$VERSION/" -e "s/@BUILD@/$BUILD/" Packaging/Info.plist.template > "$APP/Contents/Info.plist"

# Icon: the same artwork the app already ships, scaled to every size iconutil expects.
ICONSET="$(mktemp -d)/AppIcon.iconset"; mkdir -p "$ICONSET"
SRC="Sources/ClaudeBar/Resources/claude-icon.png"
for size in 16 32 64 128 256 512 1024; do
  sips -z "$size" "$size" "$SRC" --out "$ICONSET/tmp_$size.png" >/dev/null
done
cp "$ICONSET/tmp_16.png"   "$ICONSET/icon_16x16.png"
cp "$ICONSET/tmp_32.png"   "$ICONSET/icon_16x16@2x.png"
cp "$ICONSET/tmp_32.png"   "$ICONSET/icon_32x32.png"
cp "$ICONSET/tmp_64.png"   "$ICONSET/icon_32x32@2x.png"
cp "$ICONSET/tmp_128.png"  "$ICONSET/icon_128x128.png"
cp "$ICONSET/tmp_256.png"  "$ICONSET/icon_128x128@2x.png"
cp "$ICONSET/tmp_256.png"  "$ICONSET/icon_256x256.png"
cp "$ICONSET/tmp_512.png"  "$ICONSET/icon_256x256@2x.png"
cp "$ICONSET/tmp_512.png"  "$ICONSET/icon_512x512.png"
cp "$ICONSET/tmp_1024.png" "$ICONSET/icon_512x512@2x.png"
rm -f "$ICONSET"/tmp_*.png
iconutil -c icns "$ICONSET" -o "$APP/Contents/Resources/AppIcon.icns"

strip -x "$APP/Contents/MacOS/ClaudeBar"
# Ad-hoc only. Never a personal developer identity: it would embed it in a binary nobody else can validate.
codesign --force --deep --sign - --timestamp=none "$APP"

echo "Built $APP  version $VERSION ($BUILD)  architectures: $(lipo -archs "$APP/Contents/MacOS/ClaudeBar")"
