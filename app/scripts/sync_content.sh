#!/usr/bin/env bash
# Sync sample Q&A from all roadmap weeks into Flutter assets.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
WEEKS_SRC="$ROOT/roadmap/weeks"
DEST_ROOT="$ROOT/app/assets/content"

rm -rf "$DEST_ROOT"/week-*
mkdir -p "$DEST_ROOT"

for week in "$WEEKS_SRC"/week-*; do
  [[ -d "$week" ]] || continue
  week_name="$(basename "$week")"
  dest="$DEST_ROOT/$week_name"
  mkdir -p "$dest"

  for day in "$week"/day-*; do
    [[ -d "$day" ]] || continue
    day_name="$(basename "$day")"
    sample="$day/sample"
    if [[ ! -d "$sample" ]]; then
      echo "warn: missing sample for $week_name/$day_name — skip" >&2
      continue
    fi
    mkdir -p "$dest/$day_name"
    for f in "$sample"/*.md; do
      [[ -f "$f" ]] || continue
      base="$(basename "$f")"
      [[ "$base" == "README.md" ]] && continue
      cp "$f" "$dest/$day_name/$base"
    done
    echo "synced $week_name/$day_name ($(ls "$dest/$day_name" | wc -l | tr -d ' ') files)"
  done
done

echo "Synced sample content to $DEST_ROOT"
find "$DEST_ROOT" -type f -name '*.md' | wc -l | xargs echo "md files:"
