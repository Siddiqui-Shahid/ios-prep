# Day 20 — Deep Links, Push Notifications & CI/CD Release Trains

> Week 3 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-03/day-20.md](../../../revision/weeks/week-03/day-20.md)

## Outcomes

By end of day, without notes, you can:

- Contrast **Universal Links vs custom schemes**, explain **AASA**, cold-start **queue-until-ready**, deferred links
- Walk push: permission → APNs token → provider (**Airship**) → payload → **same DeepLinkRouter**
- Outline **GitHub Actions → build/lint → TestFlight** and release-train **pause** criteria (CFS/perf)
- Deliver **Verified · S13**: Grizzlies **SwiftUI↔UIKit**, **deeplinks**, **Mixpanel**, **Airship**
- Deliver BMS **CI/CD** automation honestly (Actions → TestFlight; AI PR review as assist — S9 judgment)

## How to study

1. [`01-foundations.md`](01-foundations.md)
2. [`02-deep-dive.md`](02-deep-dive.md)
3. [`03-production-bridge.md`](03-production-bridge.md) — S13 + BMS CI
4. [`code/`](code/) — router queue sketch
5. [`sample/07-revision-qna.md`](sample/07-revision-qna.md)
6. [`05-exercises.md`](05-exercises.md)
7. Revision twin

## Provenance

| Label | Use |
|---|---|
| **Verified · S13** | Grizzlies: SwiftUI+UIKit interop; deeplinks; Mixpanel; Airship |
| **BMS CI** | GitHub Actions build/lint → TestFlight (resume automation) |
| **Verified · S9** | AI-assisted review judgment — assist, don’t own architecture |
| **Verified · S8** | Soft bridge: pause rollout on CFS |

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/DeepLinkQueue.swift](code/DeepLinkQueue.swift) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Agenda opener

> “I’ll unify Universal Links and push as entrypoints into one router, cover cold-start queuing, then walk GitHub Actions → TestFlight with rollout gates.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations + deep dive | 90–110 |
| Production bridge + code | 35–45 |
| Questions | 45–60 |
| Exercises + revision | 30–40 |
