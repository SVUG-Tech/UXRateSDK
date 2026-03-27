#!/usr/bin/env bash
# Rebuilds README.md by replacing marker blocks with contents from docs/
# Usage: ./scripts/rebuild-readme.sh [path-to-repo-root]
set -euo pipefail

ROOT="${1:-.}"
README="$ROOT/README.md"
TMP="$README.tmp"

# Replace a marker block with content from a directory of .md files
replace_section_dir() {
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

  local section_file
  section_file=$(mktemp)
  for f in "$docs_dir"/*.md; do
    cat "$f" >> "$section_file"
    printf '\n\n' >> "$section_file"
  done

  awk -v begin="$begin" -v end="$end" -v file="$section_file" '
    $0 == begin { print; while ((getline line < file) > 0) print line; skip=1; next }
    $0 == end { skip=0 }
    !skip { print }
  ' "$README" > "$TMP"
  mv "$TMP" "$README"
  rm -f "$section_file"
}

# Replace a marker block with content from a single .md file
replace_section_file() {
  local marker="$1"
  local src_file="$2"
  local begin="<!-- BEGIN ${marker} -->"
  local end="<!-- END ${marker} -->"

  if ! grep -q "$begin" "$README"; then
    return
  fi

  if [ ! -f "$src_file" ]; then
    return
  fi

  awk -v begin="$begin" -v end="$end" -v file="$src_file" '
    $0 == begin { print; while ((getline line < file) > 0) print line; skip=1; next }
    $0 == end { skip=0 }
    !skip { print }
  ' "$README" > "$TMP"
  mv "$TMP" "$README"
}

# Common sections (single file each)
replace_section_file "HEADER"   "$ROOT/docs/common/_header.md"
replace_section_file "OVERVIEW" "$ROOT/docs/common/_overview.md"
replace_section_file "API_KEYS" "$ROOT/docs/common/_api-keys.md"

# Platform sections (directory of files)
replace_section_dir "IOS"          "$ROOT/docs/ios"
replace_section_dir "ANDROID"      "$ROOT/docs/android"
replace_section_dir "FLUTTER"      "$ROOT/docs/flutter"
replace_section_dir "REACT_NATIVE" "$ROOT/docs/react-native"

echo "README.md rebuilt from docs/"
