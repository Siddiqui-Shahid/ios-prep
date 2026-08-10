# Day 03 — ARC, Retain Cycles, weak/unowned, Instruments

> Week 1 · Revision pass ~45–60 min  
> Full study: [weeks/week-01/day-03/](../../../weeks/week-01/day-03/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-03/sample/](../../../weeks/week-01/day-03/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- How ARC works — strong, weak, unowned — and when `deinit` runs
- Classic retain-cycle patterns and the fix for each
- Leak vs abandoned memory vs high watermark — and which tool finds which
- How verified BookMyShow IMOC + crash-free at scale reliability culture fits without inventing a BMS Memory Graph war story

## 2. Concept refresh (simple)

### 2.1 ARC basics

Strong refs increment retain count; at zero, `deinit` runs. `weak` is optional and zeroing; `unowned` is non-optional and non-zeroing — crash if dangling. Value types aren’t ARC’d; nested classes inside them are.

### 2.2 Cycle hotspots

| Pattern | Fix |
|---|---|
| Escaping closure captures `self` | `[weak self]` + guard |
| Strong delegate | `weak var delegate` |
| Timer `target:selector:` | Timer **strongly retains** target until `invalidate` |
| NotificationCenter block API | Store **observer token**; remove on teardown |
| Parent ↔ child | One side weak/unowned |

### 2.3 Tools — don’t conflate them

| Tool | Finds |
|---|---|
| **Leaks** instrument | **Unreachable** memory — not cycles |
| Memory Graph / Allocations | Reachable **abandoned** memory, cycles still referenced |
| Retain cycle | Reachable memory that should have deallocated |

At 30L+ DAU, small leaks in navigation or ad paths become memory pressure and jetsam. 99.95%+ crash-free is the verified reliability bar (BookMyShow IMOC + crash-free at scale).

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Retain cycle | Reachable **abandoned** memory |
| Instruments Leaks | Finds **unreachable** memory — not cycles |
| Timer target-selector | Timer strongly retains target until `invalidate` |
| NotificationCenter block | Store token; remove on teardown |
| Uncertain lifetime (async UI) | Prefer `[weak self]` |
| BookMyShow IMOC + crash-free at scale | Reliability culture — do not invent a BMS Memory Graph war story |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-03/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-03/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-01/day-03/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow IMOC + crash-free at scale:** BookMyShow IMOC / crash-free at scale — 30L+ DAU, 99.95%+ crash-free via structured Crashlytics workflows; memory and race issues were part of reliability culture.  
**Design if asked:** ** Triage playbook (Memory Graph → Allocations → Leaks) — how you would investigate, not a claim you ran Memory Graph on every BMS leak.

**Interview line (≤20s):** “At 30L+ DAU we treated retain cycles and abandoned view controllers as reliability bugs — structured triage and Crashlytics, not guesswork.”

→ [BookMyShow IMOC + crash-free at scale IMOC](../../stories/story-bank.md#s8--imoc--crash-free-at-scale-bookmyshow)

## 5. Flash prompts

1. ARC in 30s — retain count, `deinit`, not GC
2. weak vs unowned — when each, and the crash risk
3. Classic closure cycle — draw the strong edges
4. Timer target-selector retain rule
5. NotificationCenter block observer teardown
6. Leaks instrument vs Memory Graph — what each finds
7. Why `[weak self]` when lifetime is uncertain
8. BookMyShow IMOC + crash-free at scale reliability pitch — 99.95% CFS, no invented war stories

## 6. Timed drills

| Drill | Budget |
|---|---|
| weak vs unowned | 45s |
| Leak vs abandoned vs cycle | 60s |
| Timer + NotificationCenter fixes | 90s |
| BookMyShow IMOC + crash-free at scale reliability ≤90s | 90s |

Expand from [sample cards](../../../weeks/week-01/day-03/sample/) and [07-revision-qna](../../../weeks/week-01/day-03/sample/07-revision-qna.md) answer points.
