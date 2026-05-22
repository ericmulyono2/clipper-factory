#!/usr/bin/env bash
set -e

AUDIO_FILE="$1"
VIDEO_ID="$2"
LANGUAGE="${3:-id}"
MODEL_SIZE="${4:-small}"

if [ -z "$AUDIO_FILE" ] || [ -z "$VIDEO_ID" ]; then
  echo "Usage: ./scripts/03_transcribe.sh <audio_file> <video_id> [language] [model_size]"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TRANSCRIPT_DIR="$BASE_DIR/storage/transcript/$VIDEO_ID"

mkdir -p "$TRANSCRIPT_DIR"

if [ -f "$BASE_DIR/.venv/bin/activate" ]; then
  source "$BASE_DIR/.venv/bin/activate"
fi

# Jika command faster-whisper tidak tersedia di environment tertentu,
# ganti bagian ini dengan Python wrapper khusus.
faster-whisper \
  "$AUDIO_FILE" \
  --model "$MODEL_SIZE" \
  --language "$LANGUAGE" \
  --output_dir "$TRANSCRIPT_DIR" \
  --output_format json

echo "$TRANSCRIPT_DIR"
