# iOS Prep Audiobook

Flutter audiobook + reader for Week 1 of the interview prep roadmap. Runs on **iOS** and **Android**.

## Features

- Listen while reading (chapter markdown + spoken script)
- On-device TTS with speed **0.5x–4.0x**
- Section skip, bookmark / resume, progress tracking
- Background playback (lock screen / notification controls)
- Study reminders (add / edit / delete)
- Fully offline — Week 1 content is bundled

## Run

```bash
cd app
./scripts/sync_content.sh   # refresh assets from roadmap/
flutter pub get
flutter run                 # pick an iOS simulator or Android emulator
```

## Regenerate spoken scripts

```bash
python3 app/scripts/generate_scripts.py
./app/scripts/sync_content.sh
```

Day 01 scripts are hand-polished reference narrations; days 02–07 are generated from chapters and can be edited in place under `roadmap/weeks/week-01/`.

## Script format

See [`../roadmap/audio-scripts/README.md`](../roadmap/audio-scripts/README.md).
