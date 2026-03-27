#!/usr/bin/env bash
# Rebuilds README.md by replacing marker blocks with contents from docs/
# Usage: ./scripts/rebuild-readme.sh [path-to-repo-root]
set -euo pipefail

ROOT="${1:-.}"
README="$ROOT/README.md"
TMP="$README.tmp"

replace_section() {
  local marker="$1"
  local docs_dir="$2"
  local begin="<!-- BEGIN ${marker} -->"
  local end="<!-- END ${marker} -->"

  if ! grep -q "$begin" "$README"; then
    return
  fi

  if [ ! -d "$docs_dir" ] || [ -z "$(ls "$docs_dir"/*.md 2>/dev/null)" ]; then
    return
  fi

  # Build section content file
  local section_file
  section_file=$(mktemp)
  for f in "$docs_dir"/*.md; do
    cat "$f" >> "$section_file"
    printf '\n\n' >> "$section_file"
  done

  # Use awk to replace between markers
  awk -v begin="$begin" -v end="$end" -v file="$section_file" '
    $0 == begin { print; while ((getline line < file) > 0) print line; skip=1; next }
    $0 == end { skip=0 }
    !skip { print }
  ' "$README" > "$TMP"
  mv "$TMP" "$README"
  rm -f "$section_file"
}

replace_section "IOS" "$ROOT/docs/ios"
replace_section "ANDROID" "$ROOT/docs/android"
replace_section "FLUTTER" "$ROOT/docs/flutter"
replace_section "REACT_NATIVE" "$ROOT/docs/react-native"

echo "README.md rebuilt from docs/"
