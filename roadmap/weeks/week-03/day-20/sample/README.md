# Day 20 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 20 modules.  
> Use this when you want deeplinks, push, and release trains as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../04-questions.md`](../04-questions.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](../01-foundations.md) |
| Deep dive | [02-deep-dive.md](../02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](../03-production-bridge.md) |
| Questions | [04-questions.md](../04-questions.md) |
| Exercises | [05-exercises.md](../05-exercises.md) |
| Code | [code/DeepLinkQueue.swift](../code/DeepLinkQueue.swift) |

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-deep-links.md](01-deep-links.md) | Universal Links, AASA, router, cold-start queue | Foundations · Deep dive |
| [02-push-notifications.md](02-push-notifications.md) | APNs, Airship, payload routing, token lifecycle | Foundations · Deep dive · Production bridge |
| [03-ci-cd-actions.md](03-ci-cd-actions.md) | GitHub Actions, signing, TestFlight, dSYM | Foundations · Deep dive · Production bridge |
| [04-release-trains.md](04-release-trains.md) | Phased rollout, pause criteria, gates, S8/S9 | Deep dive · Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| One router | Universal Links, custom schemes, and push taps share **one** routing table |
| Cold start | Queue deep links until navigation/DI is ready — then flush |
| **S13** Verified | Grizzlies: SwiftUI↔UIKit; deeplinks; Mixpanel; Airship |
| **BMS CI** | GitHub Actions build/lint → TestFlight — not manual ceremony |
| **S9** | AI PR review **assists** — humans own architecture and security |
| Pause criteria | CFS drop, pin-fail spike, journey p90 cliff → stop phased rollout (S8) |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 20 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
