#!/usr/bin/env bash
set -e

VIDEO_ID="$1"

if [ -z "$VIDEO_ID" ]; then
  echo "Usage: ./scripts/04_find_clips_placeholder.sh <video_id>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$BASE_DIR/storage/reports"
mkdir -p "$REPORT_DIR"

cat > "$REPORT_DIR/${VIDEO_ID}_clips.json" <<EOF
{
  "video_id": "${VIDEO_ID}",
  "clips": [
    {
      "clip_id": "${VIDEO_ID}_clip_001",
      "start": "00:00:30",
      "duration": "00:00:45",
      "reason": "Placeholder. Replace with LLM-selected highlight."
    }
  ]
}
EOF

echo "$REPORT_DIR/${VIDEO_ID}_clips.json"
