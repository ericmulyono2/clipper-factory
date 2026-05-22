#!/usr/bin/env bash
set -e

VIDEO_ID="$1"

if [ -z "$VIDEO_ID" ]; then
  echo "Usage: ./scripts/07_package_output.sh <video_id>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$BASE_DIR/storage/reports"
FINAL_DIR="$BASE_DIR/storage/final"

mkdir -p "$REPORT_DIR"

cat > "$REPORT_DIR/${VIDEO_ID}_output.json" <<EOF
{
  "video_id": "${VIDEO_ID}",
  "status": "ready_for_review",
  "final_dir": "$FINAL_DIR",
  "notes": "Review manual sebelum posting."
}
EOF

echo "$REPORT_DIR/${VIDEO_ID}_output.json"
