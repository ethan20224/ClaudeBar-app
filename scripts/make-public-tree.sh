#!/usr/bin/env bash
# Copies only what belongs in the public repository into dist/public-tree and scans it for private data.
# Allowlist by exclusion: internal docs, the iOS prototype, design scratch, launch notes and tool folders stay out.
set -euo pipefail
cd "$(dirname "$0")/.."
OUT="${1:-dist/public-tree}"
rm -rf "$OUT"; mkdir -p "$OUT"

git ls-files --cached --others --exclude-standard \
  | grep -vE '^(iOS/|docs/|PRODUCT\.md$|launch/|\.design-mocks/|\.superpowers/|\.opencode/|\.playwright-mcp/|dist/|\.build/)' \
  | while IFS= read -r f; do
      [ -f "$f" ] || continue
      mkdir -p "$OUT/$(dirname "$f")"
      cp -p "$f" "$OUT/$f"
    done
echo "Copied $(find "$OUT" -type f | wc -l | tr -d ' ') files to $OUT"

# Scan. The local account name comes from $USER, so it is never written into this file.
PAT="/Users/|@gmail\.com|Apple Development|$USER|gh[opsu]_[A-Za-z0-9]{20,}|sk-ant-sid0[0-9]-[A-Za-z0-9_-]{40,}|BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY"
hits=$(grep -rInE --exclude=make-public-tree.sh --exclude=verify-release.sh "$PAT" "$OUT" 2>/dev/null || true)
if [ -n "$hits" ]; then
  echo "PRIVATE DATA FOUND:"; echo "$hits"; exit 1
fi
echo "Scan clean: no username, home path, email, token or key in the public tree."
