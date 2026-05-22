#!/usr/bin/env bash
set -e

INPUT_FILE="$1"
OUTPUT_ID="$2"

if [ -z "$INPUT_FILE" ] || [ -z "$OUTPUT_ID" ]; then
  echo "Usage: ./scripts/06_render_vertical.sh <input_file> <output_id>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FINAL_DIR="$BASE_DIR/storage/final"
mkdir -p "$FINAL_DIR"

ffmpeg -y \
  -i "$INPUT_FILE" \
  -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920" \
  -c:v libx264 \
  -preset medium \
  -crf 20 \
  -c:a aac \
  -b:a 192k \
  "$FINAL_DIR/${OUTPUT_ID}.mp4"

echo "$FINAL_DIR/${OUTPUT_ID}.mp4"
