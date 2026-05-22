# Clipper Factory

Repository pusat untuk workflow produksi video pendek berbasis AI: riset video, download, transkrip, pencarian momen menarik, potong clip, render 9:16, caption, approval, dan posting.

Project ini **bukan tempat menggabungkan semua kode tool menjadi satu file**. Project ini adalah **repo induk / pusat instruksi** yang mengatur tool-tool GitHub sebagai module/service.

---

## 1. Tujuan Project

Tujuan `clipper-factory` adalah membuat sistem kerja untuk tim clipper video.

Alur besarnya:

```text
OpenClaw / Supervisor Agent
        ↓
n8n Workflow
        ↓
Tools lokal di Linux
        ├── yt-dlp
        ├── faster-whisper / WhisperX
        ├── auto-editor
        ├── FFmpeg
        ├── AI-Youtube-Shorts-Generator / yt-short-clipper
        ├── Remotion
        └── uploader / API posting
        ↓
Folder approval / Google Drive / storage
```

Target hasil:

```text
Video panjang / link video
        ↓
Transkrip
        ↓
Timestamp momen terbaik
        ↓
Clip pendek 9:16
        ↓
Subtitle + hook + caption
        ↓
Final video siap approval/posting
```

---

## 2. Catatan Legal dan Etika Konten

Gunakan workflow ini hanya untuk konten yang aman secara hak cipta, misalnya:

* video milik sendiri;
* video milik klien;
* footage berlisensi;
* konten public domain;
* konten yang memang diberi izin untuk dipakai ulang;
* konten yang digunakan sebagai bahan riset internal, bukan dipublikasikan ulang tanpa izin.

Jangan otomatis mengambil, memotong, dan memposting ulang video orang lain tanpa izin. Untuk produksi brand/client, gunakan aset legal supaya akun tidak terkena copyright strike, takedown, atau masalah platform.

---

## 3. Struktur Folder Repo

Buat struktur seperti ini di Linux server/tim:

```text
clipper-factory/
├── README.md
├── .env.example
├── docker-compose.yml
├── workflows/
│   ├── n8n-clipper-workflow-notes.md
│   └── n8n-clipper-workflow.json
├── prompts/
│   ├── openclaw-supervisor.md
│   ├── trend-scout-agent.md
│   ├── clip-finder-agent.md
│   ├── edit-director-agent.md
│   ├── caption-writer-agent.md
│   └── publisher-agent.md
├── scripts/
│   ├── 01_download.sh
│   ├── 02_extract_audio.sh
│   ├── 03_transcribe.sh
│   ├── 04_find_clips_placeholder.sh
│   ├── 05_cut_clip.sh
│   ├── 06_render_vertical.sh
│   └── 07_package_output.sh
├── tools/
│   ├── yt-dlp/
│   ├── faster-whisper/
│   ├── whisperX/
│   ├── auto-editor/
│   ├── ai-youtube-shorts/
│   ├── yt-short-clipper/
│   ├── remotion/
│   └── openshorts/
├── storage/
│   ├── raw/
│   ├── audio/
│   ├── transcript/
│   ├── clips/
│   ├── final/
│   └── reports/
└── docs/
    ├── architecture.md
    ├── sop-clipper-team.md
    └── troubleshooting.md
```

Minimal awal yang wajib ada:

```text
clipper-factory/
├── README.md
├── .env.example
├── prompts/
├── scripts/
├── workflows/
└── storage/
```

Folder `tools/` boleh diisi submodule GitHub atau clone manual.

---

## 4. Daftar Tools

### 4.1 Core Tools

| Tool                          | Fungsi                                                        |                          Prioritas |
| ----------------------------- | ------------------------------------------------------------- | ---------------------------------: |
| `yt-dlp`                      | Download video/audio dari URL yang diizinkan                  |                              Wajib |
| `FFmpeg`                      | Extract audio, cut video, resize 9:16, render dasar           |                              Wajib |
| `faster-whisper`              | Transkrip audio/video lebih cepat                             |                              Wajib |
| `WhisperX`                    | Transkrip presisi dengan word-level timestamp dan diarization |                           Opsional |
| `auto-editor`                 | Potong silence/jeda kosong otomatis                           |                           Opsional |
| `AI-Youtube-Shorts-Generator` | Cari highlight dan buat shorts otomatis                       |           Opsional tapi disarankan |
| `yt-short-clipper`            | Pipeline YouTube long-form ke short-form                      |                           Opsional |
| `Remotion`                    | Render video template dengan React                            | Opsional untuk hasil lebih premium |
| `OpenShorts`                  | Platform self-hosted AI short video                           |   Opsional untuk dashboard lengkap |
| `n8n`                         | Orkestrasi workflow                                           |                              Wajib |
| `OpenClaw`                    | Supervisor/agent pengarah workflow                            |             Wajib jika pakai agent |

### 4.2 Repo Fork yang Dipakai

Ganti link jika nama repo berubah.

```text
https://github.com/ericmulyono2/yt-dlp
https://github.com/ericmulyono2/faster-whisper
https://github.com/ericmulyono2/whisperX
https://github.com/ericmulyono2/auto-editor
https://github.com/ericmulyono2/AI-Youtube-Shorts-Generator
https://github.com/ericmulyono2/yt-short-clipper
https://github.com/ericmulyono2/remotion
https://github.com/ericmulyono2/openshorts
https://github.com/ericmulyono2/crewAI
```

---

## 5. Cara Clone Repo dari GitHub

### 5.1 Clone Repo Induk

Di Linux:

```bash
git clone https://github.com/ericmulyono2/clipper-factory.git
cd clipper-factory
```

Kalau repo belum dibuat, buat dulu di GitHub:

```text
GitHub → New Repository → clipper-factory → Public/Private → Create
```

Lalu dari lokal:

```bash
mkdir clipper-factory
cd clipper-factory
git init
git remote add origin https://github.com/ericmulyono2/clipper-factory.git
```

---

## 6. Cara Menjadikan Tools sebagai Module

Ada 2 cara.

### Cara A — Clone Manual ke Folder `tools/`

Cara ini paling mudah dipahami.

```bash
mkdir -p tools
cd tools

git clone https://github.com/ericmulyono2/yt-dlp.git
git clone https://github.com/ericmulyono2/faster-whisper.git
git clone https://github.com/ericmulyono2/whisperX.git
git clone https://github.com/ericmulyono2/auto-editor.git
git clone https://github.com/ericmulyono2/AI-Youtube-Shorts-Generator.git ai-youtube-shorts
git clone https://github.com/ericmulyono2/yt-short-clipper.git
git clone https://github.com/ericmulyono2/remotion.git
git clone https://github.com/ericmulyono2/openshorts.git

cd ..
```

Kelebihan:

* mudah dipahami tim;
* tidak perlu paham submodule;
* cocok untuk setup awal.

Kekurangan:

* folder `tools/` bisa besar;
* update tiap tool dilakukan manual.

### Cara B — Git Submodule

Cara ini lebih rapi untuk repo induk.

```bash
mkdir -p tools

git submodule add https://github.com/ericmulyono2/yt-dlp.git tools/yt-dlp
git submodule add https://github.com/ericmulyono2/faster-whisper.git tools/faster-whisper
git submodule add https://github.com/ericmulyono2/whisperX.git tools/whisperX
git submodule add https://github.com/ericmulyono2/auto-editor.git tools/auto-editor
git submodule add https://github.com/ericmulyono2/AI-Youtube-Shorts-Generator.git tools/ai-youtube-shorts
git submodule add https://github.com/ericmulyono2/yt-short-clipper.git tools/yt-short-clipper
git submodule add https://github.com/ericmulyono2/remotion.git tools/remotion
git submodule add https://github.com/ericmulyono2/openshorts.git tools/openshorts

git add .
git commit -m "Add clipper tools as submodules"
git push
```

Tim Linux nanti clone repo induk dengan:

```bash
git clone --recurse-submodules https://github.com/ericmulyono2/clipper-factory.git
```

Jika sudah terlanjur clone biasa:

```bash
cd clipper-factory
git submodule update --init --recursive
```

Rekomendasi awal: **pakai cara A dulu**. Setelah tim paham, baru pakai submodule.

---

## 7. Instalasi di Linux

### 7.1 Update Server

```bash
sudo apt update && sudo apt upgrade -y
```

### 7.2 Install Dependency Dasar

```bash
sudo apt install -y \
  git \
  curl \
  wget \
  unzip \
  build-essential \
  python3 \
  python3-pip \
  python3-venv \
  ffmpeg
```

Cek:

```bash
git --version
python3 --version
pip3 --version
ffmpeg -version
```

### 7.3 Install Node.js dan npm

Jika belum ada Node.js:

```bash
sudo apt install -y nodejs npm
```

Cek:

```bash
node --version
npm --version
```

Untuk production, boleh gunakan `nvm` agar versi Node lebih mudah diatur.

### 7.4 Buat Python Virtual Environment

Di folder `clipper-factory`:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
```

### 7.5 Install Python Tools

Minimal:

```bash
pip install yt-dlp
pip install faster-whisper
pip install auto-editor
```

Alternatif jika ingin install dari folder fork lokal:

```bash
pip install -e ./tools/yt-dlp
pip install -e ./tools/faster-whisper
pip install -e ./tools/auto-editor
```

WhisperX opsional:

```bash
pip install -e ./tools/whisperX
```

Jika error di WhisperX, jangan berhenti. Pakai `faster-whisper` dulu untuk MVP.

### 7.6 Install n8n

Opsi cepat:

```bash
npm install -g n8n
```

Jalankan:

```bash
n8n
```

Default UI:

```text
http://localhost:5678
```

Untuk server Linux jarak jauh, akses bisa lewat domain, reverse proxy, Cloudflare Tunnel, atau SSH tunnel.

---

## 8. File `.env.example`

Buat file `.env.example`:

```env
# App
APP_NAME=clipper-factory
APP_ENV=local
BASE_DIR=/home/ubuntu/clipper-factory

# Storage
RAW_DIR=/home/ubuntu/clipper-factory/storage/raw
AUDIO_DIR=/home/ubuntu/clipper-factory/storage/audio
TRANSCRIPT_DIR=/home/ubuntu/clipper-factory/storage/transcript
CLIPS_DIR=/home/ubuntu/clipper-factory/storage/clips
FINAL_DIR=/home/ubuntu/clipper-factory/storage/final
REPORTS_DIR=/home/ubuntu/clipper-factory/storage/reports

# OpenClaw / LLM
LLM_PROVIDER=deepseek
DEEPSEEK_API_KEY=isi_sendiri
OPENAI_API_KEY=isi_jika_dipakai
GEMINI_API_KEY=isi_jika_dipakai

# YouTube / Platform API
YOUTUBE_API_KEY=isi_jika_dipakai
META_APP_ID=isi_jika_dipakai
META_APP_SECRET=isi_jika_dipakai
META_ACCESS_TOKEN=isi_jika_dipakai

# n8n
N8N_BASE_URL=http://localhost:5678
N8N_WEBHOOK_CLIPPER=http://localhost:5678/webhook/clipper-start

# Output defaults
DEFAULT_LANGUAGE=id
DEFAULT_PLATFORM=youtube_shorts
DEFAULT_ASPECT_RATIO=9:16
DEFAULT_VIDEO_WIDTH=1080
DEFAULT_VIDEO_HEIGHT=1920
```

Lalu copy ke `.env`:

```bash
cp .env.example .env
```

Edit:

```bash
nano .env
```

---

## 9. Scripts

Buat folder:

```bash
mkdir -p scripts storage/raw storage/audio storage/transcript storage/clips storage/final storage/reports
chmod +x scripts/*.sh
```

### 9.1 `scripts/01_download.sh`

```bash
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

source "$BASE_DIR/.venv/bin/activate"

yt-dlp \
  -f "bv*+ba/b" \
  --merge-output-format mp4 \
  -o "$RAW_DIR/${VIDEO_ID}.%(ext)s" \
  "$URL"

echo "$RAW_DIR/${VIDEO_ID}.mp4"
```

### 9.2 `scripts/02_extract_audio.sh`

```bash
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
```

### 9.3 `scripts/03_transcribe.sh`

```bash
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

source "$BASE_DIR/.venv/bin/activate"

# Catatan:
# faster-whisper CLI bisa berbeda tergantung cara install.
# Jika command ini error, gunakan script Python wrapper khusus.
faster-whisper \
  "$AUDIO_FILE" \
  --model "$MODEL_SIZE" \
  --language "$LANGUAGE" \
  --output_dir "$TRANSCRIPT_DIR" \
  --output_format json

echo "$TRANSCRIPT_DIR"
```

### 9.4 `scripts/04_find_clips_placeholder.sh`

Script ini placeholder. Nantinya timestamp terbaik dipilih oleh LLM melalui n8n/OpenClaw.

```bash
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
```

### 9.5 `scripts/05_cut_clip.sh`

```bash
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
```

### 9.6 `scripts/06_render_vertical.sh`

Render sederhana 9:16 memakai FFmpeg.

```bash
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
```

### 9.7 `scripts/07_package_output.sh`

```bash
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
```

Aktifkan executable:

```bash
chmod +x scripts/*.sh
```

---

## 10. Test Manual Tanpa n8n

Sebelum disambungkan ke n8n, test manual dulu.

```bash
cd ~/clipper-factory
source .venv/bin/activate
```

Contoh:

```bash
VIDEO_URL="https://www.youtube.com/watch?v=ISI_VIDEO_ID"
VIDEO_ID="test_001"

./scripts/01_download.sh "$VIDEO_URL" "$VIDEO_ID"
./scripts/02_extract_audio.sh "storage/raw/${VIDEO_ID}.mp4" "$VIDEO_ID"
./scripts/03_transcribe.sh "storage/audio/${VIDEO_ID}.wav" "$VIDEO_ID" "id" "small"
./scripts/04_find_clips_placeholder.sh "$VIDEO_ID"
./scripts/05_cut_clip.sh "storage/raw/${VIDEO_ID}.mp4" "00:00:30" "00:00:45" "${VIDEO_ID}_clip_001"
./scripts/06_render_vertical.sh "storage/clips/${VIDEO_ID}_clip_001.mp4" "${VIDEO_ID}_final_001"
./scripts/07_package_output.sh "$VIDEO_ID"
```

Hasil final ada di:

```text
storage/final/
```

---

## 11. Workflow n8n Node-by-Node

### 11.1 Alur Utama

Nama workflow:

```text
Clipper Factory - Generate Short Video
```

Node:

| No | Node n8n                       | Fungsi                                 |
| -: | ------------------------------ | -------------------------------------- |
|  1 | Webhook Trigger                | menerima perintah dari OpenClaw/manual |
|  2 | Set / Edit Fields              | normalisasi input                      |
|  3 | Execute Command                | download video via yt-dlp              |
|  4 | Execute Command                | extract audio via FFmpeg               |
|  5 | Execute Command                | transkrip via faster-whisper           |
|  6 | Read Binary / Read File        | baca transcript JSON/TXT               |
|  7 | LLM Node / HTTP Request ke LLM | pilih timestamp terbaik                |
|  8 | Code Node                      | parse hasil LLM menjadi JSON clips     |
|  9 | Split In Batches               | proses tiap clip satu per satu         |
| 10 | Execute Command                | cut clip via FFmpeg                    |
| 11 | Execute Command                | render 9:16                            |
| 12 | LLM Node                       | buat caption + hashtags                |
| 13 | Write File / Google Drive      | simpan final untuk approval            |
| 14 | Respond to Webhook             | kirim hasil ke OpenClaw                |

### 11.2 Input Webhook

Method:

```text
POST
```

Path:

```text
/webhook/clipper-start
```

Body JSON:

```json
{
  "video_url": "https://www.youtube.com/watch?v=ISI_VIDEO_ID",
  "video_id": "clientA_2026_001",
  "niche": "bisnis online",
  "language": "id",
  "target_platform": "youtube_shorts",
  "style": "edukatif, cepat, hook kuat, subtitle besar",
  "max_clips": 3,
  "clip_duration_min": 25,
  "clip_duration_max": 60,
  "approval_required": true
}
```

### 11.3 Node 1 — Webhook Trigger

Konfigurasi:

```text
HTTP Method: POST
Path: clipper-start
Response Mode: Last Node
```

### 11.4 Node 2 — Set / Edit Fields

Fields:

```json
{
  "video_url": "={{$json.body.video_url}}",
  "video_id": "={{$json.body.video_id}}",
  "niche": "={{$json.body.niche}}",
  "language": "={{$json.body.language || 'id'}}",
  "target_platform": "={{$json.body.target_platform || 'youtube_shorts'}}",
  "style": "={{$json.body.style || 'short edukatif'}}",
  "max_clips": "={{$json.body.max_clips || 3}}"
}
```

### 11.5 Node 3 — Execute Command: Download

Command:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/01_download.sh "{{$json.video_url}}" "{{$json.video_id}}"
```

Output path yang diharapkan:

```text
/home/ubuntu/clipper-factory/storage/raw/<video_id>.mp4
```

### 11.6 Node 4 — Execute Command: Extract Audio

Command:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/02_extract_audio.sh "storage/raw/{{$json.video_id}}.mp4" "{{$json.video_id}}"
```

### 11.7 Node 5 — Execute Command: Transcribe

Command:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/03_transcribe.sh "storage/audio/{{$json.video_id}}.wav" "{{$json.video_id}}" "{{$json.language}}" "small"
```

### 11.8 Node 6 — Read Transcript

Jika transcript berupa JSON, baca file dari:

```text
/home/ubuntu/clipper-factory/storage/transcript/{{$json.video_id}}
```

Jika nama file berbeda, sesuaikan dengan output actual `faster-whisper`.

### 11.9 Node 7 — LLM: Clip Finder

Prompt untuk node LLM:

```text
Kamu adalah Clip Finder Agent.

Tugasmu memilih momen terbaik dari transkrip video untuk dijadikan short-form video.

Input:
- niche: {{$json.niche}}
- target platform: {{$json.target_platform}}
- style: {{$json.style}}
- max clips: {{$json.max_clips}}
- transcript: {{$json.transcript}}

Kriteria clip bagus:
1. Ada hook kuat dalam 3 detik pertama.
2. Bisa dipahami tanpa konteks panjang.
3. Ada emosi, insight, kontroversi sehat, tutorial, cerita, atau punchline.
4. Durasi ideal 25–60 detik.
5. Jangan pilih bagian yang membosankan, intro panjang, atau terlalu bergantung konteks.
6. Cocok untuk penonton Indonesia.

Output wajib JSON valid:
{
  "clips": [
    {
      "clip_id": "string",
      "start": "HH:MM:SS",
      "duration": "HH:MM:SS",
      "hook_text": "string",
      "reason": "string",
      "caption_angle": "string"
    }
  ]
}
```

### 11.10 Node 8 — Code Node: Parse Clips

Contoh JavaScript:

```javascript
const raw = $json.text || $json.output || $json.response || JSON.stringify($json);
let parsed;

try {
  parsed = JSON.parse(raw);
} catch (e) {
  const match = raw.match(/\{[\s\S]*\}/);
  if (!match) throw new Error('No JSON found in LLM output');
  parsed = JSON.parse(match[0]);
}

return parsed.clips.map((clip, index) => ({
  json: {
    ...$json,
    clip_index: index + 1,
    clip_id: clip.clip_id || `${$json.video_id}_clip_${index + 1}`,
    start: clip.start,
    duration: clip.duration,
    hook_text: clip.hook_text,
    reason: clip.reason,
    caption_angle: clip.caption_angle
  }
}));
```

### 11.11 Node 9 — Execute Command: Cut Clip

Command:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/05_cut_clip.sh "storage/raw/{{$json.video_id}}.mp4" "{{$json.start}}" "{{$json.duration}}" "{{$json.clip_id}}"
```

### 11.12 Node 10 — Execute Command: Render Vertical

Command:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/06_render_vertical.sh "storage/clips/{{$json.clip_id}}.mp4" "{{$json.clip_id}}_final"
```

### 11.13 Node 11 — LLM: Caption Writer

Prompt:

```text
Kamu adalah Caption Writer Agent untuk short video Indonesia.

Buat caption untuk platform {{$json.target_platform}}.

Data:
- niche: {{$json.niche}}
- style: {{$json.style}}
- hook: {{$json.hook_text}}
- alasan clip dipilih: {{$json.reason}}
- angle caption: {{$json.caption_angle}}

Tugas:
1. Buat 3 opsi caption pendek.
2. Buat 10 hashtag relevan.
3. Buat 1 judul pendek maksimal 70 karakter.
4. Jangan klaim berlebihan.
5. Jangan gunakan clickbait berbahaya.

Output JSON valid:
{
  "title": "string",
  "captions": ["string", "string", "string"],
  "hashtags": ["string"]
}
```

### 11.14 Node 12 — Save/Approval

Simpan output ke:

```text
storage/final/
storage/reports/
```

Opsional kirim ke:

* Google Drive;
* Dropbox;
* S3;
* Telegram group approval;
* Slack/Discord;
* Notion/Airtable.

### 11.15 Node 13 — Respond to Webhook

Response JSON:

```json
{
  "status": "ready_for_review",
  "video_id": "{{$json.video_id}}",
  "final_path": "/home/ubuntu/clipper-factory/storage/final/",
  "message": "Clip selesai dibuat dan siap direview."
}
```

---

## 12. Prompt OpenClaw

Simpan sebagai:

```text
prompts/openclaw-supervisor.md
```

Isi:

```text
# OpenClaw Supervisor Prompt — Clipper Factory

Kamu adalah Supervisor Agent untuk sistem Clipper Factory.

Peranmu:
- menerima instruksi produksi video pendek;
- menilai apakah input sudah cukup;
- mengirim task ke workflow n8n;
- memantau hasil;
- memberikan keputusan: perlu revisi, siap approval, atau siap posting.

Kamu tidak mengedit video secara langsung.
Kamu mengatur workflow dan agent lain.

## Prinsip kerja

1. Jangan memproses konten yang tidak jelas izin penggunaannya untuk repost publik.
2. Jangan membuat klaim palsu di caption.
3. Jangan memilih clip yang konteksnya menyesatkan.
4. Prioritaskan hook kuat, edukasi, emosi, dan retensi.
5. Semua output final harus melewati approval manusia jika `approval_required=true`.
6. Jangan langsung posting kecuali user jelas meminta auto-posting.

## Input standar

- video_url
- video_id
- niche
- language
- target_platform
- style
- max_clips
- clip_duration_min
- clip_duration_max
- approval_required

## Output standar

Berikan ringkasan:
- status workflow;
- jumlah clip dibuat;
- lokasi file final;
- caption/judul yang disarankan;
- catatan review;
- tindakan berikutnya.

## Tool utama

Gunakan skill `start_clipper_workflow` untuk mengirim task ke n8n.

## Format task ke n8n

{
  "video_url": "...",
  "video_id": "...",
  "niche": "...",
  "language": "id",
  "target_platform": "youtube_shorts",
  "style": "edukatif, subtitle besar, hook kuat",
  "max_clips": 3,
  "clip_duration_min": 25,
  "clip_duration_max": 60,
  "approval_required": true
}

## Saat menerima hasil dari n8n

Periksa:
1. Apakah file final tersedia?
2. Apakah durasi sesuai?
3. Apakah caption cocok?
4. Apakah butuh revisi hook/subtitle/crop?
5. Apakah aman untuk approval?

Jika aman, statuskan:
`READY_FOR_HUMAN_REVIEW`

Jika perlu revisi, statuskan:
`NEEDS_REVISION`

Jika gagal, statuskan:
`FAILED_WITH_REASON`
```

---

## 13. Prompt Agent Tambahan

### 13.1 Trend Scout Agent

Simpan sebagai:

```text
prompts/trend-scout-agent.md
```

```text
Kamu adalah Trend Scout Agent.

Tugasmu mencari angle konten yang berpotensi viral/menarik untuk niche tertentu.

Input:
- niche
- target audience
- platform
- daftar video kandidat / metadata / topik

Tugas:
1. Pilih topik yang paling layak dijadikan short.
2. Jelaskan alasan pemilihan.
3. Beri skor potensi: 1–10.
4. Buat rekomendasi hook.
5. Hindari konten yang melanggar hak cipta atau menyesatkan.

Output JSON valid:
{
  "recommended_topics": [
    {
      "topic": "string",
      "viral_score": 1,
      "reason": "string",
      "hook_suggestion": "string",
      "risk_note": "string"
    }
  ]
}
```

### 13.2 Clip Finder Agent

Simpan sebagai:

```text
prompts/clip-finder-agent.md
```

```text
Kamu adalah Clip Finder Agent.

Tugasmu membaca transkrip video dan memilih bagian terbaik untuk video pendek.

Kriteria clip:
- hook cepat;
- tidak perlu konteks terlalu panjang;
- punya value, emosi, insight, tutorial, cerita, atau punchline;
- durasi 25–60 detik;
- cocok untuk Shorts/Reels/TikTok;
- tidak memelintir konteks pembicara.

Output JSON valid:
{
  "clips": [
    {
      "clip_id": "string",
      "start": "HH:MM:SS",
      "duration": "HH:MM:SS",
      "hook_text": "string",
      "reason": "string",
      "caption_angle": "string",
      "risk_note": "string"
    }
  ]
}
```

### 13.3 Edit Director Agent

Simpan sebagai:

```text
prompts/edit-director-agent.md
```

```text
Kamu adalah Edit Director Agent.

Tugasmu memberi arahan editing untuk short video.

Input:
- clip timestamp
- transcript clip
- niche
- platform
- style brand

Tugas:
1. Tentukan hook text di 3 detik pertama.
2. Tentukan gaya subtitle.
3. Tentukan crop/framing.
4. Tentukan bagian yang perlu zoom-in, cut, atau emphasis.
5. Tentukan CTA ringan.

Output JSON valid:
{
  "edit_plan": {
    "hook_text": "string",
    "subtitle_style": "string",
    "crop_note": "string",
    "emphasis_points": ["string"],
    "cta": "string"
  }
}
```

### 13.4 Caption Writer Agent

Simpan sebagai:

```text
prompts/caption-writer-agent.md
```

```text
Kamu adalah Caption Writer Agent.

Tugasmu membuat caption pendek untuk short-form video Indonesia.

Aturan:
- jangan clickbait berlebihan;
- jangan klaim palsu;
- gunakan bahasa natural;
- buat caption yang mendorong komentar/simpan/share;
- sesuaikan dengan platform.

Output JSON valid:
{
  "title": "string",
  "captions": ["string", "string", "string"],
  "hashtags": ["string"],
  "comment_prompt": "string"
}
```

### 13.5 Publisher Agent

Simpan sebagai:

```text
prompts/publisher-agent.md
```

```text
Kamu adalah Publisher Agent.

Tugasmu menyiapkan output untuk diposting, tetapi tidak boleh posting tanpa approval manusia.

Periksa:
1. File final tersedia.
2. Caption sudah ada.
3. Platform target jelas.
4. Tidak ada catatan risiko besar.
5. Status approval sudah disetujui.

Output JSON valid:
{
  "publish_ready": true,
  "platforms": ["youtube_shorts", "instagram_reels", "facebook_reels"],
  "title": "string",
  "caption": "string",
  "hashtags": ["string"],
  "file_path": "string",
  "approval_status": "waiting|approved|rejected"
}
```

---

## 14. Skill OpenClaw ke n8n

Nama skill:

```text
start_clipper_workflow
```

Deskripsi:

```text
Mengirim task produksi video pendek ke n8n webhook Clipper Factory.
```

Input schema:

```json
{
  "video_url": "string",
  "video_id": "string",
  "niche": "string",
  "language": "string",
  "target_platform": "string",
  "style": "string",
  "max_clips": "number",
  "clip_duration_min": "number",
  "clip_duration_max": "number",
  "approval_required": "boolean"
}
```

Action:

```text
HTTP POST ke N8N_WEBHOOK_CLIPPER
```

Body:

```json
{
  "video_url": "{{video_url}}",
  "video_id": "{{video_id}}",
  "niche": "{{niche}}",
  "language": "{{language}}",
  "target_platform": "{{target_platform}}",
  "style": "{{style}}",
  "max_clips": {{max_clips}},
  "clip_duration_min": {{clip_duration_min}},
  "clip_duration_max": {{clip_duration_max}},
  "approval_required": {{approval_required}}
}
```

Expected response:

```json
{
  "status": "ready_for_review",
  "video_id": "string",
  "final_path": "string",
  "message": "string"
}
```

---

## 15. Cara Menjalankan Workflow

### 15.1 Jalankan n8n

```bash
n8n
```

Buka:

```text
http://localhost:5678
```

Import atau buat workflow manual sesuai bagian `Workflow n8n Node-by-Node`.

### 15.2 Test Webhook dengan curl

```bash
curl -X POST http://localhost:5678/webhook/clipper-start \
  -H "Content-Type: application/json" \
  -d '{
    "video_url": "https://www.youtube.com/watch?v=ISI_VIDEO_ID",
    "video_id": "test_001",
    "niche": "bisnis online",
    "language": "id",
    "target_platform": "youtube_shorts",
    "style": "edukatif, cepat, subtitle besar, hook kuat",
    "max_clips": 3,
    "clip_duration_min": 25,
    "clip_duration_max": 60,
    "approval_required": true
  }'
```

### 15.3 Test dari OpenClaw

Kirim task:

```json
{
  "video_url": "https://www.youtube.com/watch?v=ISI_VIDEO_ID",
  "video_id": "clientA_001",
  "niche": "bisnis online",
  "language": "id",
  "target_platform": "youtube_shorts",
  "style": "edukatif, cepat, subtitle besar, hook kuat",
  "max_clips": 3,
  "clip_duration_min": 25,
  "clip_duration_max": 60,
  "approval_required": true
}
```

OpenClaw harus memanggil skill `start_clipper_workflow`.

---

## 16. SOP Tim Clipper

### 16.1 Role Tim

| Role           | Tugas                                                               |
| -------------- | ------------------------------------------------------------------- |
| Supervisor     | menentukan prioritas video, review hasil, approve posting           |
| Trend Scout    | mencari topik dan video kandidat                                    |
| Clip Operator  | menjalankan workflow, cek hasil transkrip dan timestamp             |
| Editor         | memperbaiki crop, subtitle, hook, pacing jika hasil AI kurang bagus |
| Caption Writer | finalisasi judul, caption, hashtag                                  |
| Publisher      | upload/posting setelah approval                                     |

### 16.2 Alur Harian

1. Trend Scout masukkan video/topik kandidat.
2. Supervisor pilih video yang boleh diproses.
3. Operator jalankan workflow n8n.
4. LLM/Clip Finder pilih timestamp.
5. Sistem render short 9:16.
6. Editor review kualitas visual/audio/subtitle.
7. Caption Writer finalisasi caption.
8. Supervisor approve.
9. Publisher posting atau jadwalkan.
10. Catat performa video untuk bahan evaluasi.

### 16.3 Checklist Approval

Sebelum posting, cek:

```text
[ ] Konten aman secara izin/copyright
[ ] Video tidak menyesatkan konteks
[ ] Hook jelas dalam 3 detik pertama
[ ] Subtitle terbaca di HP
[ ] Crop wajah/objek tidak terpotong aneh
[ ] Audio jelas
[ ] Durasi sesuai platform
[ ] Caption tidak klaim palsu
[ ] Hashtag relevan
[ ] Sudah disetujui supervisor
```

---

## 17. Roadmap Implementasi

### Fase 1 — MVP Lokal

Target:

```text
URL video → download → transkrip → pilih timestamp manual → cut → render 9:16
```

Tools:

```text
yt-dlp + FFmpeg + faster-whisper + n8n
```

### Fase 2 — AI Clip Finder

Target:

```text
Transkrip → LLM pilih momen terbaik → render otomatis
```

Tambahan:

```text
OpenClaw + LLM + Clip Finder prompt
```

### Fase 3 — Template Premium

Target:

```text
Subtitle cantik + hook text + branding + progress bar
```

Tambahan:

```text
Remotion / WhisperX
```

### Fase 4 — Approval System

Target:

```text
Hasil masuk Google Drive/Notion/Airtable/Telegram untuk review
```

Tambahan:

```text
Google Drive node / Notion / Airtable / Telegram
```

### Fase 5 — Posting Otomatis

Target:

```text
Setelah approved → posting ke YouTube Shorts / IG Reels / Facebook Reels
```

Tambahan:

```text
YouTube API / Meta API / Upload service
```

---

## 18. Troubleshooting

### 18.1 `ffmpeg: command not found`

Install:

```bash
sudo apt install -y ffmpeg
```

Cek:

```bash
ffmpeg -version
```

### 18.2 `yt-dlp: command not found`

Aktifkan venv:

```bash
source .venv/bin/activate
```

Install:

```bash
pip install yt-dlp
```

Cek:

```bash
yt-dlp --version
```

### 18.3 n8n tidak bisa jalankan Execute Command

Cek:

* path script benar;
* permission executable sudah benar;
* user yang menjalankan n8n punya akses folder;
* command bisa jalan manual di terminal.

Aktifkan executable:

```bash
chmod +x scripts/*.sh
```

### 18.4 Transcript tidak keluar

Cek:

* file audio ada di `storage/audio/`;
* `faster-whisper` terinstall;
* model size jangan terlalu besar untuk server kecil;
* coba `small` dulu, jangan langsung `large`.

### 18.5 Render lambat

Solusi:

* pakai clip lebih pendek;
* gunakan `-preset veryfast` di FFmpeg;
* turunkan resolusi test ke 720x1280;
* gunakan GPU jika tersedia;
* jalankan batch di luar jam sibuk.

---

## 19. Perintah Git untuk Update

### 19.1 Pull Repo Induk

```bash
git pull origin main
```

### 19.2 Update Tool Manual

```bash
cd tools/yt-dlp
git pull

cd ../faster-whisper
git pull

cd ../remotion
git pull
```

### 19.3 Update Submodule

Jika pakai submodule:

```bash
git submodule update --remote --merge
```

Commit perubahan pointer submodule:

```bash
git add .
git commit -m "Update tool submodules"
git push
```

---

## 20. Cara Kerja untuk Tim Linux

Instruksi singkat untuk tim:

```bash
git clone https://github.com/ericmulyono2/clipper-factory.git
cd clipper-factory

sudo apt update && sudo apt install -y git python3 python3-pip python3-venv ffmpeg nodejs npm

python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip setuptools wheel
pip install yt-dlp faster-whisper auto-editor

mkdir -p storage/raw storage/audio storage/transcript storage/clips storage/final storage/reports
chmod +x scripts/*.sh

npm install -g n8n
n8n
```

Test manual:

```bash
VIDEO_URL="https://www.youtube.com/watch?v=ISI_VIDEO_ID"
VIDEO_ID="test_001"

./scripts/01_download.sh "$VIDEO_URL" "$VIDEO_ID"
./scripts/02_extract_audio.sh "storage/raw/${VIDEO_ID}.mp4" "$VIDEO_ID"
./scripts/03_transcribe.sh "storage/audio/${VIDEO_ID}.wav" "$VIDEO_ID" "id" "small"
./scripts/05_cut_clip.sh "storage/raw/${VIDEO_ID}.mp4" "00:00:30" "00:00:45" "${VIDEO_ID}_clip_001"
./scripts/06_render_vertical.sh "storage/clips/${VIDEO_ID}_clip_001.mp4" "${VIDEO_ID}_final_001"
```

---

## 21. Catatan Penting

Mulai dari versi sederhana dulu:

```text
yt-dlp → FFmpeg → faster-whisper → n8n
```

Jangan langsung menyalakan semua tools:

```text
OpenShorts + Remotion + WhisperX + CrewAI + Auto-posting
```

Urutan paling aman:

1. Manual script jalan.
2. n8n bisa panggil script.
3. LLM bisa pilih timestamp.
4. Render final stabil.
5. Approval system jalan.
6. Baru auto-posting.

---

## 22. Status Implementasi

| Fitur             | Status                            |
| ----------------- | --------------------------------- |
| Download video    | Ready                             |
| Extract audio     | Ready                             |
| Transkrip         | Ready basic                       |
| Clip finder AI    | Prompt ready, perlu integrasi LLM |
| Cut clip          | Ready                             |
| Render vertical   | Ready basic                       |
| Subtitle premium  | Next                              |
| Remotion template | Next                              |
| Approval system   | Next                              |
| Auto posting      | Next                              |

---

## 23. Ringkasan untuk Tim

Project ini adalah sistem produksi video pendek berbasis AI.

Jangan gabungkan semua repo GitHub menjadi satu file. Gunakan `clipper-factory` sebagai repo pusat, lalu tools seperti `yt-dlp`, `faster-whisper`, `WhisperX`, `auto-editor`, `Remotion`, dan lainnya dipakai sebagai module/service.

n8n bertugas menjalankan workflow teknis. OpenClaw bertugas menjadi supervisor/agent yang memberi instruksi ke n8n. Semua output final tetap harus melalui approval manusia sebelum posting.
