#!/usr/bin/env bash
# Syncs docs/ to the GitHub Wiki repo.
# Usage: ./scripts/sync-wiki.sh [path-to-repo-root]
# Requires WIKI_TOKEN env var for authentication.
set -euo pipefail

ROOT="${1:-.}"
DOCS="$ROOT/docs"
WIKI_REPO="https://x-access-token:${WIKI_TOKEN}@github.com/SVUG-Tech/UXRateSDK.wiki.git"
WIKI_DIR=$(mktemp -d)

trap 'rm -rf "$WIKI_DIR"' EXIT

# Clone wiki (master branch)
git clone "$WIKI_REPO" "$WIKI_DIR" 2>/dev/null || {
  git init "$WIKI_DIR"
  git -C "$WIKI_DIR" remote add origin "$WIKI_REPO"
}

# Clean previously generated pages
rm -f "$WIKI_DIR"/iOS-*.md "$WIKI_DIR"/Android-*.md "$WIKI_DIR"/Flutter-*.md \
      "$WIKI_DIR"/React-Native-*.md "$WIKI_DIR"/Tutorial-*.md \
      "$WIKI_DIR"/Home.md "$WIKI_DIR"/_Sidebar.md \
      "$WIKI_DIR"/SDK-Overview.md "$WIKI_DIR"/Event-Tracking.md "$WIKI_DIR"/Session-Replay.md

# --- Helper: strip version comments and H1 headings ---
clean_doc() {
  sed '/^<!-- .* SDK v[0-9].*-->$/d' | sed '/^# /d'
}

# --- Platform display names ---
platform_display() {
  case "$1" in
    ios) echo "iOS" ;;
    android) echo "Android" ;;
    flutter) echo "Flutter" ;;
    react-native) echo "React-Native" ;;
  esac
}

# --- Topic display names ---
topic_display() {
  case "$1" in
    api-reference)  echo "API-Reference" ;;
    event-tracking) echo "Event-Tracking" ;;
    installation)   echo "Installation" ;;
    quick-start)    echo "Quick-Start" ;;
    replay-config)  echo "Session-Replay" ;;
  esac
}

# --- Sync common concept pages ---
for src in "$DOCS"/common/session-replay.md "$DOCS"/common/event-tracking.md "$DOCS"/common/sdk-overview.md; do
  [ -f "$src" ] || continue
  basename=$(basename "$src" .md)
  case "$basename" in
    session-replay) page="Session-Replay" ;;
    event-tracking) page="Event-Tracking" ;;
    sdk-overview)   page="SDK-Overview" ;;
    *) continue ;;
  esac
  clean_doc < "$src" > "$WIKI_DIR/$page.md"
done

# --- Sync platform docs ---
for platform_dir in "$DOCS"/ios "$DOCS"/android "$DOCS"/flutter "$DOCS"/react-native; do
  [ -d "$platform_dir" ] || continue
  platform=$(basename "$platform_dir")
  display=$(platform_display "$platform")

  for f in "$platform_dir"/*.md; do
    [ -f "$f" ] || continue
    topic=$(basename "$f" .md)
    topic_name=$(topic_display "$topic")
    [ -n "$topic_name" ] || continue
    page="${display}-${topic_name}"
    clean_doc < "$f" > "$WIKI_DIR/$page.md"
  done
done

# --- Sync tutorials ---
if [ -d "$DOCS/tutorials" ]; then
  for f in "$DOCS"/tutorials/*.md; do
    [ -f "$f" ] || continue
    basename=$(basename "$f" .md)
    # Convert kebab-case to Title-Case for wiki page name
    page="Tutorial-"
    IFS='-' read -ra PARTS <<< "$basename"
    for i in "${!PARTS[@]}"; do
      part="${PARTS[$i]}"
      # Capitalize known acronyms
      case "$part" in
        ios) part="iOS" ;;
        uikit) part="UIKit" ;;
        swiftui) part="SwiftUI" ;;
        react) part="React" ;;
        native) part="Native" ;;
        *) part="$(echo "${part:0:1}" | tr '[:lower:]' '[:upper:]')${part:1}" ;;
      esac
      [ "$i" -eq 0 ] && page="${page}${part}" || page="${page}-${part}"
    done
    clean_doc < "$f" > "$WIKI_DIR/$page.md"
  done
fi

# --- Generate Home.md ---
{
  # Include common fragments (header, overview, api-keys)
  for frag in "$DOCS"/common/_header.md "$DOCS"/common/_overview.md "$DOCS"/common/_api-keys.md; do
    [ -f "$frag" ] && cat "$frag" && echo ""
  done

  cat <<'NAVIGATION'
---

## Documentation

| Platform | Installation | Quick Start | API Reference | Event Tracking | Session Replay |
|----------|-------------|-------------|---------------|----------------|----------------|
| **iOS** | [Installation](iOS-Installation) | [Quick Start](iOS-Quick-Start) | [API Reference](iOS-API-Reference) | [Event Tracking](iOS-Event-Tracking) | [Session Replay](iOS-Session-Replay) |
| **Android** | [Installation](Android-Installation) | [Quick Start](Android-Quick-Start) | [API Reference](Android-API-Reference) | [Event Tracking](Android-Event-Tracking) | [Session Replay](Android-Session-Replay) |
| **Flutter** | [Installation](Flutter-Installation) | [Quick Start](Flutter-Quick-Start) | [API Reference](Flutter-API-Reference) | [Event Tracking](Flutter-Event-Tracking) | [Session Replay](Flutter-Session-Replay) |
| **React Native** | [Installation](React-Native-Installation) | [Quick Start](React-Native-Quick-Start) | [API Reference](React-Native-API-Reference) | [Event Tracking](React-Native-Event-Tracking) | [Session Replay](React-Native-Session-Replay) |
NAVIGATION
} > "$WIKI_DIR/Home.md"

# --- Generate _Sidebar.md ---
cat > "$WIKI_DIR/_Sidebar.md" <<'SIDEBAR'
**[Home](Home)**

---

### Concepts
- [SDK Overview](SDK-Overview)
- [Event Tracking](Event-Tracking)
- [Session Replay](Session-Replay)

### iOS
- [Installation](iOS-Installation)
- [Quick Start](iOS-Quick-Start)
- [API Reference](iOS-API-Reference)
- [Event Tracking](iOS-Event-Tracking)
- [Session Replay](iOS-Session-Replay)

### Android
- [Installation](Android-Installation)
- [Quick Start](Android-Quick-Start)
- [API Reference](Android-API-Reference)
- [Event Tracking](Android-Event-Tracking)
- [Session Replay](Android-Session-Replay)

### Flutter
- [Installation](Flutter-Installation)
- [Quick Start](Flutter-Quick-Start)
- [API Reference](Flutter-API-Reference)
- [Event Tracking](Flutter-Event-Tracking)
- [Session Replay](Flutter-Session-Replay)

### React Native
- [Installation](React-Native-Installation)
- [Quick Start](React-Native-Quick-Start)
- [API Reference](React-Native-API-Reference)
- [Event Tracking](React-Native-Event-Tracking)
- [Session Replay](React-Native-Session-Replay)

---

### Tutorials
- [iOS SwiftUI](Tutorial-iOS-SwiftUI-Integration)
- [iOS UIKit](Tutorial-iOS-UIKit-Integration)
- [Android Compose](Tutorial-Android-Compose-Integration)
- [Android Activities](Tutorial-Android-Activities-Integration)
- [Flutter](Tutorial-Flutter-Flutter-Integration)
- [React Native](Tutorial-React-Native-React-Navigation-Integration)
SIDEBAR

# --- Push to wiki ---
cd "$WIKI_DIR"
git add -A
if ! git diff --cached --quiet; then
  git config user.name "github-actions[bot]"
  git config user.email "github-actions[bot]@users.noreply.github.com"
  git commit -m "docs: sync wiki from docs/"
  git push origin master
  echo "Wiki updated."
else
  echo "Wiki already up to date."
fi
