# Day 21 — System-Design Mock #3 (45 min)

> Week 3 · Revision twin · Full study: [weeks/week-03/day-21/](../../../weeks/week-03/day-21/)  
> **Do the live 45-min mock from the full chapter scripts.**

## 1. Outcome

- Spine: clarify→HLD→API→deep dive→ops
- Full scripts exist for **SDUI OR networking+pinning** — pick one live
- Two-layer scoring (structure + content honesty)
- Resume-only metrics; no fabricated QPS

## 2. Spine (memorize)

```text
0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dive · 40–45 ops
```

**Opener:** “~5 on scope/scale, architecture pass, deep-dive X and Y — match?”

### Prompt A deep dives
Versioning/unknown fallback · action routing · (cache / perf / allowlist)

### Prompt B deep dives
Single-flight refresh · SPKI+rotation **design (S4-A1)** · (cache / p50/p90)

## 3. Honesty guards

| Guard |
|---|
| S4 shipped pins; S4-A1 rotation = design |
| SPKI = DER hash ≠ SecKey raw bytes |
| S2 ≠ sole CFS cause |
| 30L DAU / 99.95% CFS only where natural |

## 4. Rubric (100) — pass ≥70, ops ≥6, no fake metrics

| Dimension | Pts |
|---|---|
| Agenda & clarify | 15 |
| HLD clarity | 20 |
| API / data | 15 |
| Deep dive quality | 25 |
| Production grounding | 10 |
| Ops / rollout | 10 |
| Communication | 5 |

**Two-layer:** Structure (timebox/diagram/ops) + Content (provenance/SPKI/S2-S8 labels).

## 5. Drill / practice

1. Live 45-min mock (record).  
2. Score harshly with Part II scoring Qs in full `04-questions.md`.  
3. Lightning 20-min on the other prompt.

## 6. Flashcards

| Front | Back |
|---|---|
| 45 spine | 5/10/10/15/5 · Trap: dive first · Prod: cheatsheet |
| SDUI unknown | Placeholder+metric · Trap: crash · Prod: S3-A1 |
| Pin dive | SPKI DER + S4-A1 design · Trap: SecKey/runbook · Prod: S4 |
| Ops closer | Failures+SLIs+pause · Trap: end on boxes · Prod: S8/S5 |
| Pass bar | ≥70 + ops≥6 + no fake metrics · Trap: pretty diagram only |
