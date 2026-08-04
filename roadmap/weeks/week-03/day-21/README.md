# Day 21 — System-Design Mock #3 (45 min)

> Week 3 · Full study (self-contained) · ~5–6 hrs (weekend-style)  
> Revision twin: [revision/weeks/week-03/day-21.md](../../../revision/weeks/week-03/day-21.md)

## Outcomes

By end of day you can:

- Run a **45-min** mobile SD: **clarify → HLD → API → deep dive → ops**
- Deliver a **fully written script** for **either** SDUI **or** Networking+pinning (both scripts are in-chapter — pick one live)
- Ground claims in resume-true proof only (S3/S12/S6 or S4/S5/S2) — **no fabricated metrics**
- Self-score with the **two-layer** rubric (structure + content) and log gaps for Week 4

## How to study

1. [`01-foundations.md`](01-foundations.md) — 45-min spine + agenda openers
2. [`02-deep-dive.md`](02-deep-dive.md) — **full spoken scripts** for Prompt A & B
3. [`03-production-bridge.md`](03-production-bridge.md) — which stories for which prompt
4. [`04-questions.md`](04-questions.md) — warm-up Qs **and** scoring-layer questions
5. [`05-exercises.md`](05-exercises.md) — live mock procedure
6. Optional [`code/`](code/) — tiny schema / client interfaces for whiteboard crutches
7. Revision twin

## Provenance (resume-only metrics)

| Prompt | Verified hooks |
|---|---|
| **A · SDUI** | S3 header/search; S12 splash; optional S6 30%+ flows as UX beat |
| **B · Networking+pin** | S4 URLSession/HTTPS/pin/whitelist; S5 p50/p90; S2 path races if token cache; **S4-A1 rotation as design** |
| **Ops both** | S8 99.95% CFS / IMOC pause; 30L+ DAU scale context |

Do **not**: invent QPS; claim S2 alone caused CFS; claim S4-A1 runbook shipped; claim SecKey bytes are SPKI.

## Agenda opener (memorize)

> “I’ll spend ~5 minutes on scope and scale, then a full architecture pass, then deep-dive X and Y — does that match what you want?”
