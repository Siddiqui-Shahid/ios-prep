# Day 17 — Performance: Instruments, MetricKit, Startup & Scrolling

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-17/](../../../weeks/week-03/day-17/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-17/sample/](../../../weeks/week-03/day-17/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- The senior performance loop: **symptom → hypothesis → lab/field tool → fix → verify p50/p90**
- **Lab** (Instruments) vs **field** (MetricKit, Firebase Performance) truth
- Cold-start phases and scroll hitch budgets (~16 ms @ 60 fps)
- Correct Instruments choice — **retain cycles ≠ Leaks** (use **Memory Graph / Allocations**)
- **BookMyShow Firebase Performance traces:** Firebase Performance journey traces with **p50/p90** at BMS scale

## 2. Concept refresh (simple)

### 2.1 Performance loop

```text
User symptom → hypothesis → instrument → fix → verify p50/p90 in field
```

At **30L+ DAU**, optimize from **field percentiles**, not desk anecdotes or averages.

### 2.2 Lab vs field

| Source | Strength | Weakness |
|---|---|---|
| Instruments | Attribution, repro in lab | Not fleet truth |
| MetricKit | Fleet OS metrics | Weak for product journey SLIs |
| Firebase Performance | Journey p50/p90 | Needs careful trace design |

### 2.3 Instruments matrix (common traps)

- **Leaks** → unreachable memory only
- **Memory Graph / Allocations** → retain cycles, abandoned VCs
- **Time Profiler** on “slow network” → waiting ≠ computing; check Network / backend

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Optimize from desk anecdote | Wrong at 30L+ DAU — use **field percentiles** |
| Average FPS / latency | **Hides tails** — track p50/p90 and hitch rate |
| Leaks finds retain cycles | **False** — use Memory Graph + Allocations |
| MetricKit alone | Fleet OS truth — **weak** for product journey SLIs |
| Time Profiler on “slow network” | Waiting ≠ computing — check Network / backend |
| BookMyShow Firebase Performance traces | Firebase Performance on listing/checkout/search — **no** fake ms SLAs |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-17/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-03/day-17/01-foundations.md) | Gaps |
| Deepen | [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) — perf snippets | Tool vocabulary |
| Drill | [07-revision-qna](../../../weeks/week-03/day-17/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow Firebase Performance traces:** BookMyShow — Firebase Performance journey traces on listing, checkout, and search with **p50/p90** at scale.  
**Soft:** BookMyShow LE Bottom Sheet — **30%+** fewer full-screen navigations as UX performance; Audio streaming + server-driven splash (Aces) cold-start product surface; BookMyShow backend-driven header & search search debounce/cancel when search feels laggy.

**Interview line (≤20s):** “I separate lab attribution from field percentiles — Graph for cycles, not Leaks — and verify fixes on journey p50/p90, not averages.”

→ [BookMyShow Firebase Performance traces Performance](../../stories/story-bank.md#s5--firebase-performance--p50p90-bookmyshow)

## 5. Flash prompts

1. Performance loop — five steps aloud
2. Why p90 beats average for user pain
3. Leaks vs Memory Graph — what each finds
4. MetricKit strength and limitation
5. Cold start phases — pre-main through TTI
6. Scroll hitches vs hangs — budget at 60 fps
7. Time Profiler on slow API — what to check instead
8. Journey SLI vs per-request span
9. BookMyShow Firebase Performance traces ≤20s — no fake ms SLAs
10. Lab fix that doesn’t move field p90 — what went wrong?

## 6. Timed drills

| Drill | Budget |
|---|---|
| Perf loop end-to-end | 60s |
| Leaks vs Graph vs Allocations | 45s |
| Lab vs field trade-off | 45s |
| Cold start + scroll hitch budget | 60s |
| Journey p50/p90 pitch (BookMyShow Firebase Performance traces) | 60s |
| BookMyShow Firebase Performance traces ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-03/day-17/sample/) and [07-revision-qna](../../../weeks/week-03/day-17/sample/07-revision-qna.md) answer points.
