# Day 18 — Crash Reporting, Observability & Incident Response (IMOC)

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-18/](../../../weeks/week-03/day-18/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-18/sample/](../../../weeks/week-03/day-18/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Crash SDK pipeline: capture → **async-signal-safe** persist → next-launch upload → **dSYM** symbolication
- **Crash vs OOM vs hang** — and why CFS can look fine while users report freezes
- **BookMyShow IMOC + crash-free at scale:** **30L+ DAU**, **99.95%+ CFS**, Crashlytics triage, **IMOC** on P0/P1
- **BookMyShow synchronised dictionaries** as a **path-scoped** concurrency fix that contributed to reliability — never “BookMyShow synchronised dictionaries alone caused 99.95% CFS”
- Incident script: owner, blast radius, mitigate first, communicate, postmortem

## 2. Concept refresh (simple)

### 2.1 Crash pipeline

```text
Signal/exception → async-signal-safe persist (ring buffer)
  → next launch upload → symbolicate with dSYM → Crashlytics triage
```

**Never** upload, malloc, or take Obj-C locks inside a signal handler.

### 2.2 Failure modes beyond crashes

| Type | CFS impact | Detection |
|---|---|---|
| Crash (SEGV, etc.) | Moves CFS | Crash SDK |
| OOM / jetsam | May not symbolicate cleanly | Memory warnings, MetricKit |
| Hang / freeze | Often **doesn’t** move CFS | Watchdog, user reports |

### 2.3 IMOC triage

Mitigate first (feature flag, rollback, hotfix path) → communicate → root-cause → postmortem. Concurrency fixes are **one contributor**, not the whole CFS story.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| BookMyShow synchronised dictionaries alone caused 99.95% CFS | **Forbidden** — BookMyShow synchronised dictionaries ⊂ reliability; BookMyShow IMOC + crash-free at scale = system |
| try/catch catches SEGV | **No** — signals need handlers + discipline |
| Upload in signal handler | **Never** — persist async-signal-safe; upload next launch |
| CFS fine ⇒ no freezes | **False** — hangs/OOM may not move CFS |
| Leaks for retain cycles | **Wrong tool** — Graph + Allocations |
| BookMyShow IMOC + crash-free at scale | 30L+ DAU, 99.95%+ CFS, Crashlytics triage, IMOC |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-18/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-03/day-18/01-foundations.md) | Gaps |
| Deepen | [crash-reporting-sdk.md](../../../ios-system-design/docs/crash-reporting-sdk.md) | Pipeline HLD |
| Drill | [07-revision-qna](../../../weeks/week-03/day-18/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow IMOC + crash-free at scale:** BookMyShow — **30L+ DAU**, sustained **99.95%+ CFS** via Crashlytics workflows and IMOC on P0/P1 incidents.  
**BookMyShow synchronised dictionaries:** GCD serial-queue / RW sync dictionaries eliminated **path-scoped** race crashes — contributes to reliability, does **not** solely own CFS.

**Interview line (≤20s):** “At 30L+ DAU we ran IMOC on crash spikes — mitigate first, symbolicate with dSYM, and treat concurrency fixes as one path among many toward 99.95% CFS.”

→ [BookMyShow IMOC + crash-free at scale IMOC](../../stories/story-bank.md#s8--imoc--crash-free-at-scale-bookmyshow) · [BookMyShow synchronised dictionaries Concurrency](../../stories/story-bank.md#s2--gcd-serial-queues--readwrite-sync-dictionaries-bookmyshow)

## 5. Flash prompts

1. Crash capture → persist → upload → symbolicate — say it in order
2. What is async-signal-safe in a handler?
3. try/catch vs signal crash — why different
4. OOM vs crash — CFS and detection differences
5. Hang vs crash — does CFS move?
6. Breadcrumbs — when to write, when not in handler
7. dSYM — why uploads fail without it
8. IMOC first 15 minutes — owner, mitigate, comms
9. BookMyShow synchronised dictionaries’s honest role vs BookMyShow IMOC + crash-free at scale system story
10. BookMyShow IMOC + crash-free at scale ≤20s — 30L+ DAU, 99.95%+ CFS, IMOC

## 6. Timed drills

| Drill | Budget |
|---|---|
| Crash pipeline diagram | 60s |
| Signal handler rules | 45s |
| Crash vs OOM vs hang | 60s |
| IMOC incident script | 90s |
| BookMyShow synchronised dictionaries honesty bound (≠ sole CFS) | 45s |
| BookMyShow IMOC + crash-free at scale ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-03/day-18/sample/) and [07-revision-qna](../../../weeks/week-03/day-18/sample/07-revision-qna.md) answer points.
