# Interview recording analysis (not shown in the app)

Audio extracted with ffmpeg from `~/Movies`. Speech parsed with `faster-whisper` (`tiny.en`, CPU, int8). Tiny model garbles names (Shahid → “shy/side”) and Swift → “CERF”; meaning was recovered by listening to classification clips + full transcripts of four interviews.

## Files

| File | Duration | Verdict |
|---|---|---|
| 2026-08-19 16-00-00.mov | ~63 min | **Interview** — intro + stack |
| 2026-08-21 16-25-09.mov | ~48 min | **Interview** — coding / request models |
| 2026-08-24 15-54-59.mov | ~47 min | Unclear (silence at 2:00 sample) — not used |
| 2026-08-25 16-58-22.mov | ~61 min | **KT — ignored** (“we’ll start with the KT part”, joining Monday) |
| 2026-08-26 15-06-23.mov | ~51 min | **Interview** — value vs reference |
| 2026-08-26 17-09-03.mov | ~51 min | **KT — ignored** (unified web checkout walkthrough in code) |
| 2026-08-27 17-01-35.mov | ~38 min | Short / mixed — not in 3–4h set |
| 2026-08-27 18-17-20.mov | ~63 min | **Interview** — UITableView reuse |
| 2026-08-27 19-36-59.mov | ~164 min | **KT-length — ignored** |
| 2026-08-28 15-32-47.mov | ~75 min | **Interview** — DSA, think out loud |
| 2026-09-04 10-31-46.mov | ~55 min | **Interview** — production crash / 1% rollout |

Transcribed in full (audio only, never copied into the app): Aug 21, Aug 26 15:06, Aug 28, Sep 4. Aug 19 intro and Aug 27 table-reuse used 75s sample clips, not full-file transcripts (`tiny.en` CPU).

See `distilled-notes.md` for the useful remainder (questions + gaps). No video or wav is bundled in the Flutter app.
