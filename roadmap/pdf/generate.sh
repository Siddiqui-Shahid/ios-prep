#!/usr/bin/env bash
# Generate full + revision PDFs from Markdown.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROADMAP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_FULL="$SCRIPT_DIR/interview-prep-roadmap.pdf"
OUT_REV="$SCRIPT_DIR/interview-prep-revision.pdf"
COMBINED_FULL="$SCRIPT_DIR/.combined-full.md"
COMBINED_REV="$SCRIPT_DIR/.combined-rev.md"

cd "$ROADMAP_DIR"

assemble_full() {
  {
    echo "% Senior iOS Interview Prep — Full Handbook"
    echo "% Muhammed Shahid Siddiqui"
    echo
    cat README.md
    echo; echo "---"; echo
    cat PHASES.md
    echo; echo "---"; echo
    cat timing/answer-timing-guide.md
    echo; echo "---"; echo
    cat stories/story-bank.md
    echo; echo "---"; echo
    cat provenance/README.md
    echo; echo "---"; echo
    cat coding/dsa-track.md
    echo; echo "---"; echo
    for week in 01 02 03 04; do
      echo "# Week $week"
      for dir in weeks/week-$week/day-*/; do
        [ -d "$dir" ] || continue
        echo
        for f in README.md 01-foundations.md 02-deep-dive.md 03-production-bridge.md 04-questions.md 05-exercises.md; do
          [ -f "$dir$f" ] || continue
          cat "$dir$f"
          echo; echo "---"; echo
        done
      done
    done
  } > "$COMBINED_FULL"
}

assemble_rev() {
  {
    echo "% Senior iOS Interview Prep — Revision"
    echo "% Muhammed Shahid Siddiqui"
    echo
    cat revision/README.md
    echo; echo "---"; echo
    for week in 01 02 03 04; do
      echo "# Revision Week $week"
      for f in revision/weeks/week-$week/day-*.md; do
        [ -f "$f" ] || continue
        cat "$f"
        echo; echo "---"; echo
      done
    done
    for f in flashcards/week-0{1,2,3,4}.md; do
      [ -f "$f" ] || continue
      cat "$f"
      echo; echo "---"; echo
    done
  } > "$COMBINED_REV"
}

md_to_pdf() {
  local src="$1"
  local dest="$2"
  local tmp="${src%.md}-mdpdf.md"
  cp "$src" "$tmp"
  npx --yes md-to-pdf "$tmp" --pdf-options '{"format":"A4","margin":{"top":"16mm","bottom":"16mm","left":"14mm","right":"14mm"}}'
  local built="${tmp%.md}.pdf"
  if [ -f "$built" ]; then
    mv "$built" "$dest"
    rm -f "$tmp"
    return 0
  fi
  return 1
}

echo "==> Assembling full handbook…"
assemble_full
echo "==> Assembling revision handbook…"
assemble_rev

echo "==> Generating PDFs (md-to-pdf)…"
md_to_pdf "$COMBINED_FULL" "$OUT_FULL"
md_to_pdf "$COMBINED_REV" "$OUT_REV"

ls -lh "$OUT_FULL" "$OUT_REV"
rm -f "$COMBINED_FULL" "$COMBINED_REV" "$SCRIPT_DIR"/.combined-*-mdpdf.md 2>/dev/null || true
echo "==> Done"
