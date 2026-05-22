#!/usr/bin/env bash
set -e

mkdir -p prompts scripts workflows docs
mkdir -p storage/raw storage/audio storage/transcript storage/clips storage/final storage/reports
chmod +x scripts/*.sh || true

echo "Folder Clipper Factory selesai dibuat."
echo "Jangan commit file .env asli. Commit .env.example saja."
