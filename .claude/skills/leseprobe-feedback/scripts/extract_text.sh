#!/usr/bin/env bash
# Extract plain text from a Leseprobe (PDF, DOCX, DOC, ODT, TXT) to stdout.
# Usage: extract_text.sh <file>
set -euo pipefail
f="$1"
case "${f,,}" in
  *.pdf)        pdftotext -layout "$f" - ;;
  *.docx|*.odt) pandoc --wrap=none -t plain "$f" ;;
  *.doc)        if command -v antiword >/dev/null; then antiword "$f";
                else soffice --headless --convert-to txt:Text --outdir /tmp "$f" >/dev/null && cat "/tmp/$(basename "${f%.*}").txt"; fi ;;
  *.txt|*.md)   cat "$f" ;;
  *) echo "Unsupported file type: $f" >&2; exit 1 ;;
esac
