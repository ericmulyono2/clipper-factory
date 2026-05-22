#!/usr/bin/env bash
set -e

URL="$1"
VIDEO_ID="$2"

if [ -z "$URL" ] || [ -z "$VIDEO_ID" ]; then
  echo "Usage: ./scripts/01_download.sh <url> <video_id>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RAW_DIR="$BASE_DIR/storage/raw"

mkdir -p "$RAW_DIR"

if [ -f "$BASE_DIR/.venv/bin/activate" ]; then
  source "$BASE_DIR/.venv/bin/activate"
fi

yt-dlp \
  -f "bv*+ba/b" \
  --merge-output-format mp4 \
  -o "$RAW_DIR/${VIDEO_ID}.%(ext)s" \
  "$URL"

echo "$RAW_DIR/${VIDEO_ID}.mp4"
