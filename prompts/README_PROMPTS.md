# Clipper Factory — All Agent Prompts

Folder ini berisi semua prompt agent untuk sistem Clipper Factory.

## Daftar Prompt

| File | Fungsi |
|---|---|
| `openclaw-supervisor.md` | Supervisor utama yang mengatur workflow |
| `trend-scout-agent.md` | Mencari kandidat topik/video yang berpotensi viral |
| `viral-scoring-agent.md` | Memberi skor viral dan risiko |
| `content-safety-agent.md` | Mengecek copyright, safety, konteks, brand risk |
| `clip-finder-agent.md` | Memilih timestamp terbaik dari transkrip |
| `edit-director-agent.md` | Memberi arahan editing, hook, subtitle, crop |
| `caption-writer-agent.md` | Membuat caption, title, hashtag |
| `publisher-agent.md` | Menyiapkan posting setelah approval |
| `performance-analyst-agent.md` | Menganalisis performa konten setelah diposting |

## Urutan Agent

```text
OpenClaw Supervisor
        ↓
Trend Scout Agent
        ↓
Viral Scoring Agent
        ↓
Content Safety Agent
        ↓
Supervisor Approval
        ↓
Clip Finder Agent
        ↓
Edit Director Agent
        ↓
Caption Writer Agent
        ↓
Publisher Agent
        ↓
Performance Analyst Agent
```

## Lokasi di GitHub

Letakkan semua file ini di:

```text
clipper-factory/prompts/
```

GitHub berfungsi sebagai master prompt. OpenClaw/n8n membaca atau menyalin prompt dari folder ini.
