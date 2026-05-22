# n8n Workflow Notes — Clipper Factory

Nama workflow:

```text
Clipper Factory - Generate Short Video
```

## Alur Node

| No | Node n8n | Fungsi |
|---:|---|---|
| 1 | Webhook Trigger | menerima perintah dari OpenClaw/manual |
| 2 | Set / Edit Fields | normalisasi input |
| 3 | Execute Command | download video via yt-dlp |
| 4 | Execute Command | extract audio via FFmpeg |
| 5 | Execute Command | transkrip via faster-whisper |
| 6 | Read File | baca transcript |
| 7 | LLM Node / HTTP Request ke LLM | pilih timestamp terbaik |
| 8 | Code Node | parse hasil LLM menjadi JSON clips |
| 9 | Split In Batches | proses tiap clip |
| 10 | Execute Command | cut clip via FFmpeg |
| 11 | Execute Command | render 9:16 |
| 12 | LLM Node | buat caption + hashtags |
| 13 | Save/Upload | simpan final untuk approval |
| 14 | Respond to Webhook | kirim hasil ke OpenClaw |

## Webhook Input

Method:

```text
POST
```

Path:

```text
clipper-start
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

## Execute Command Examples

Download:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/01_download.sh "{{$json.video_url}}" "{{$json.video_id}}"
```

Extract audio:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/02_extract_audio.sh "storage/raw/{{$json.video_id}}.mp4" "{{$json.video_id}}"
```

Transcribe:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/03_transcribe.sh "storage/audio/{{$json.video_id}}.wav" "{{$json.video_id}}" "{{$json.language}}" "small"
```

Cut clip:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/05_cut_clip.sh "storage/raw/{{$json.video_id}}.mp4" "{{$json.start}}" "{{$json.duration}}" "{{$json.clip_id}}"
```

Render vertical:

```bash
cd /home/ubuntu/clipper-factory && ./scripts/06_render_vertical.sh "storage/clips/{{$json.clip_id}}.mp4" "{{$json.clip_id}}_final"
```

## LLM Clip Finder Prompt

Ambil isi dari:

```text
prompts/clip-finder-agent.md
```

Tambahkan variable transcript dari node sebelumnya.

## Response to Webhook

```json
{
  "status": "ready_for_review",
  "video_id": "{{$json.video_id}}",
  "final_path": "/home/ubuntu/clipper-factory/storage/final/",
  "message": "Clip selesai dibuat dan siap direview."
}
```
