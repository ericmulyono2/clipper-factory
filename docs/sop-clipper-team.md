# SOP Tim Clipper — Clipper Factory

## Role Tim

| Role | Tugas |
|---|---|
| Supervisor | menentukan prioritas video, review hasil, approve posting |
| Trend Scout | mencari topik dan video kandidat |
| Clip Operator | menjalankan workflow, cek hasil transkrip dan timestamp |
| Editor | memperbaiki crop, subtitle, hook, pacing jika AI kurang bagus |
| Caption Writer | finalisasi judul, caption, hashtag |
| Publisher | upload/posting setelah approval |

## Alur Harian

1. Trend Scout masukkan video/topik kandidat.
2. Supervisor pilih video yang boleh diproses.
3. Operator jalankan workflow n8n.
4. LLM/Clip Finder pilih timestamp.
5. Sistem render short 9:16.
6. Editor review kualitas visual/audio/subtitle.
7. Caption Writer finalisasi caption.
8. Supervisor approve.
9. Publisher posting atau jadwalkan.
10. Catat performa video untuk evaluasi.

## Checklist Approval

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

## Catatan Penting

Jangan otomatis posting tanpa approval manusia, kecuali owner sudah jelas mengaktifkan mode auto-posting.
