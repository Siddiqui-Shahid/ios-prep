# iOS Interview Prep

A Markdown-first Flutter reader with two sections: **Swift Basics** and **System Designs**.

## Features

- 28 structured Swift/iOS study days with 145 Markdown lessons
- 37 long-form mobile system-design case studies
- Searchable libraries and a distraction-free document reader
- Working document contents navigation and previous/next reading
- Listen while reading (chapter Markdown + spoken script)
- On-device TTS with speed **0.5x–4.0x**
- Section skip and bookmark / resume
- Background playback (lock screen / notification controls)
- Fully offline — all study content is bundled

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
