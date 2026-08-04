# 01 — Foundations: Week 2 Synthesis + Mock Format

> Build the connective tissue, then run Mock #2 with discipline.

## 1. Week 2 map (say as one narrative)

```text
Day 08  Layers / DI / search VM
   ↓
Day 09  URLSession / refresh / pin / cancel
   ↓
Day 10  SDUI schema / registry / fallback
   ↓
Day 11  Lifecycle / cells / hybrid / bottom sheet
   ↓
Day 12  SwiftUI state / identity / Stories SDK
   ↓
Day 13  Stack · Queue · LL composure
```

**One-sentence senior narrative:**

> “I structure features with clear layers and DI, own networking with cancellation and security, use SDUI where content velocity matters with fail-soft schema, and treat UIKit/SwiftUI lifecycle and identity as production contracts — proven on BMS, District, and Raw apps.”

## 2. Glossary for mock day

| Term | Meaning today |
|---|---|
| **Mock #2** | Timed self/peer run: warm-ups → tricky → 5-min architecture → STAR → retro |
| **Track A** | Ads architecture (S1 + S4) |
| **Track B** | SDUI architecture (S3 + S12) |
| **Agenda opener** | First 15–20s that scopes the 5-min talk |
| **Fail-soft** | Unknown SDUI nodes skip; never crash; hard fallback if root empty |
| **HeroWidget contract** | Pause/play tied to visibility + VC lifecycle |
| **Single-flight** | One token refresh shared by waiters |
| **Provenance honesty** | Verified vs Applied vs Learning-lab |

## 3. Mock #2 format (memorize)

| Block | Time | What |
|---|---|---|
| Warm-up Qs | 15–20 min | 4–5 Normal from Week 2 mixed |
| Deep dive | 15–20 min | 2 Tricky (refresh **or** SDUI outage **or** hybrid nav) |
| **Architecture talk** | **5 min timed** | Ads **or** SDUI (one track) |
| STAR | 10 min | S1 or S3/S12 + spice S4/S9 |
| Retro | 10–15 min | Score timing; update gotchas |

Full facilitator script: [02-deep-dive.md](02-deep-dive.md) § Mock script · [code/MockTalkTracks.md](code/MockTalkTracks.md).

## 4. Choose ONE primary track

| If your stronger stories are… | Pick |
|---|---|
| POP, HeroWidget, pinning | **Track A — Ads** |
| Schema, fallback, header/splash | **Track B — SDUI** |

Doing both cold → neither talk is crisp. Skim the other track 20 min **after** your recording.

## 5. Timing muscle (architecture)

| Minute | Content |
|---|---|
| 0:00–0:20 | Agenda + scope |
| 0:20–1:00 | Problem / context |
| 1:00–3:30 | Architecture beats (3–4) |
| 3:30–4:30 | Failure modes / trade-offs |
| 4:30–5:00 | Stop; invite questions |

**Hard rule:** If you hit 5:00 mid-sentence, stop and invite questions. Re-record.

## 6. Checkpoint

1. Can you say the Week 2 one-liner?  
2. Have you picked Ads **or** SDUI?  
3. Do you know the mock block times?  

→ [02-deep-dive.md](02-deep-dive.md)
