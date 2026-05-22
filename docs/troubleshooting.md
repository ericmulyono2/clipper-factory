# Troubleshooting — Clipper Factory

## `ffmpeg: command not found`

Install:

```bash
sudo apt install -y ffmpeg
```

Cek:

```bash
ffmpeg -version
```

## `yt-dlp: command not found`

Aktifkan virtual environment:

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

## Script tidak bisa dijalankan

Beri permission:

```bash
chmod +x scripts/*.sh
```

## n8n Execute Command gagal

Cek:

- path script benar;
- permission executable sudah benar;
- user yang menjalankan n8n punya akses folder;
- command bisa jalan manual di terminal.

## Transcript tidak keluar

Cek:

- file audio ada di `storage/audio/`;
- `faster-whisper` terinstall;
- model size jangan terlalu besar untuk server kecil;
- coba `small` dulu.

## Render lambat

Solusi:

- pakai clip lebih pendek;
- gunakan `-preset veryfast` di FFmpeg;
- turunkan resolusi test ke 720x1280;
- gunakan GPU jika tersedia;
- jalankan batch di luar jam sibuk.

## File output tidak ada

Cek folder:

```text
storage/raw
storage/audio
storage/transcript
storage/clips
storage/final
storage/reports
```

Pastikan nama `video_id` sama dari awal sampai akhir.
