# Day 25 — Machine Round 3hr (Briefs A & B)

> Week 4 · Revision pass ~45–60 min  
> Full study: [weeks/week-04/day-25/](../../../weeks/week-04/day-25/README.md)  
> Sample Q&A (guided): [weeks/week-04/day-25/sample/](../../../weeks/week-04/day-25/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Timebox a **3-hour machine round**: clarify → skeleton → vertical slice → tests → polish — **no perfectionism**
- North star: demoable **tested happy path** + documented cut lines
- Know **Brief A** (pagination + cache + tests) and **Brief B** (SDUI renderer + unknown fallback) pass bars
- Self-grade debrief: rubric avg ≥3.5, correctness ≥4, tests ≥3

## 2. Concept refresh (simple)

### 2.1 Clock discipline

| Block | Rule |
|---|---|
| **0:00–0:15** | Clarify — **don’t code immediately** |
| Early | Skeleton: UI → ViewModel → protocol repository — fake data first |
| Mid | **Vertical slice** — one happy path end-to-end |
| Late | Tests + polish + cut-line doc |

### 2.2 Brief A — Paginated list

Pagination + cache policy + **3+ meaningful unit tests**. Demo: load → data → one secondary behavior → mention test.

### 2.3 Brief B — SDUI renderer

≥3 component types + **unknown fallback** + `schemaVersion`. Unknown components must not crash.

### 2.4 60s demo script

Load → data visible → one secondary behavior → “here’s a test covering X.” Then stop building — document what you cut.

### 2.5 Critical truths (pin)

| Claim | Truth |
|---|---|
| North star | Demoable **tested happy path** + documented cut lines |
| 0:00–0:15 | Clarify — **don’t code immediately** |
| Vertical slice | 60s demo: load → data → one secondary behavior → mention test |
| Brief A | Pagination + cache policy + 3+ meaningful unit tests |
| Brief B | ≥3 component types + unknown fallback + schemaVersion |
| Pass bar | Rubric avg ≥3.5, correctness ≥4, tests ≥3 |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-04/day-25/sample/) | OS + brief specs |
| Must | [02-deep-dive](../../../weeks/week-04/day-25/02-deep-dive.md) | Brief A & B full specs |
| Run | [05-exercises](../../../weeks/week-04/day-25/05-exercises.md) | 3hr timed build |
| Debrief | [07-revision-qna](../../../weeks/week-04/day-25/sample/07-revision-qna.md) | Sample architecture answers |

No `code/` folder — your Xcode project is the artifact.

## 4. Map to your work

**BookMyShow backend-driven header & search:** Search lists + backend-driven header — pagination/debounce and SDUI fallback instincts.  
**District Free Parking + Clean/MVVM + AI tooling:** AI may scaffold tests; **you** own architecture and review.  
**Audio streaming + server-driven splash (Aces):** Server-driven splash — schema flexibility + client resilience.

**Interview line (≤20s):** “In machine rounds I optimize for a tested vertical slice — contracts, fallbacks, and observable state, same bias as shipping SDUI and list UX.”

→ [BookMyShow backend-driven header & search](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow) · [District Free Parking + Clean/MVVM + AI tooling](../../stories/story-bank.md#s9--free-parking--cleanmvvm--ai-tooling-district) · [Audio streaming + server-driven splash (Aces)](../../stories/story-bank.md#s12--audio-streaming--server-driven-splash-raw--las-vegas-aces)

Do **not** claim the 3hr project is BookMyShow production code.

## 5. Flash prompts

1. Proctor opener — clarify before code
2. Vertical slice definition — what ships in 60s demo?
3. Brief A — pagination + cache + 3 tests
4. Brief B — 3 components + unknown fallback + schemaVersion
5. Cut lines — what to document when time runs out
6. Anti-perfectionism — when to stop polishing
7. Debrief structure — trade-offs + what you’d do with 2 more hours
8. Pass bar — rubric avg ≥3.5, correctness ≥4, tests ≥3

## 6. Timed drills

| Drill | Budget |
|---|---|
| 0:15 clarify script | 15s read-aloud |
| 60s demo narration | 60s |
| Brief A vs B pick + rationale | 45s |
| Cut-line doc (3 bullets) | 60s |
| Debrief trade-off answer | 90s |
| Self-grade against rubric | 5 min |

If you haven’t run the full 3hr build yet, do it from [05-exercises](../../../weeks/week-04/day-25/05-exercises.md) — revision day assumes you’ve lived it once.
