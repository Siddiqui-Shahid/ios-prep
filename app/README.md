# iOS Interview Handbook

Flutter reader. **Primary:** 60–90 minute Mumbai–Pune ride plan + 30 machine design questions. The old 4-week sample Q&A is **archived** in Library.

## Features

- Listen while reading (chapter markdown + spoken script)
- On-device TTS with speed **0.5x–4.0x**
- Section skip, bookmark / resume, progress tracking
- Background playback (lock screen / notification controls)
- Study reminders (add / edit / delete)
- Fully offline — Week 1 content is bundled
- System Design Lab with a guided learning path, search, topic filters, and 37 long-form mobile case studies

## Run

```bash
cd app
./scripts/sync_content.sh   # refresh assets from roadmap/
flutter pub get
flutter run                 # pick an iOS simulator or Android emulator
flutter run -d chrome       # web viewer (same content)
```

## Regenerate spoken scripts

```bash
python3 app/scripts/generate_scripts.py
./app/scripts/sync_content.sh
```

Day 01 scripts are hand-polished reference narrations; days 02–07 are generated from chapters and can be edited in place under `roadmap/weeks/week-01/`.

## Script format

See [`../roadmap/audio-scripts/README.md`](../roadmap/audio-scripts/README.md).
