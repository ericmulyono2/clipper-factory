#!/usr/bin/env bash
set -e

INPUT_FILE="$1"
START="$2"
DURATION="$3"
CLIP_ID="$4"

if [ -z "$INPUT_FILE" ] || [ -z "$START" ] || [ -z "$DURATION" ] || [ -z "$CLIP_ID" ]; then
  echo "Usage: ./scripts/05_cut_clip.sh <input_file> <start> <duration> <clip_id>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLIPS_DIR="$BASE_DIR/storage/clips"
mkdir -p "$CLIPS_DIR"

ffmpeg -y \
  -ss "$START" \
  -i "$INPUT_FILE" \
  -t "$DURATION" \
  -c:v libx264 \
  -c:a aac \
  "$CLIPS_DIR/${CLIP_ID}.mp4"

echo "$CLIPS_DIR/${CLIP_ID}.mp4"
