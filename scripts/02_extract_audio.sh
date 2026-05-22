#!/usr/bin/env bash
set -e

INPUT_FILE="$1"
VIDEO_ID="$2"

if [ -z "$INPUT_FILE" ] || [ -z "$VIDEO_ID" ]; then
  echo "Usage: ./scripts/02_extract_audio.sh <input_file> <video_id>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AUDIO_DIR="$BASE_DIR/storage/audio"

mkdir -p "$AUDIO_DIR"

ffmpeg -y \
  -i "$INPUT_FILE" \
  -vn \
  -acodec pcm_s16le \
  -ar 16000 \
  -ac 1 \
  "$AUDIO_DIR/${VIDEO_ID}.wav"

echo "$AUDIO_DIR/${VIDEO_ID}.wav"
