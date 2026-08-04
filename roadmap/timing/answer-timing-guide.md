# Answer Timing Guide

Practice with a timer every day. Long-winded answers hurt as much as short ones. Senior signal = **agenda + trade-off + number + production example**.

---

## Quick budgets

| Format | Time | Structure |
|---|---|---|
| Definition / “what is X?” | **30–45s** | Definition → one property → one BMS/Raw/District example |
| Conceptual deep dive | **90–120s** | Claim → mechanism → trade-off → production story |
| Coding approach (before typing) | **2–3 min** | Clarify → brute → optimize → complexity → edge cases |
| Architecture / design pattern | **3–5 min** | Problem → options → choice → layers → failure modes |
| Mobile system design | **45 min** | Clarify 5 → HLD 10 → Data/API 10 → Deep dive 15 → Ops 5 |
| Behavioral STAR | **2–3 min** | 20s S/T → 90s Action → 30s Result → 20s lesson |

---

## 1. Definition (30–45 seconds)

**Template:**
> “X is … . The key property is … . In practice at BookMyShow/Raw, I used it when … .”

**Example (ARC, ~35s):**
> “ARC is Swift’s compile-time reference counting for class instances. Strong refs increment the count; when it hits zero, `deinit` runs. At BMS we hunted retain cycles in ad and navigation closures because leaked VCs showed up as memory pressure under peak traffic.”

**Fail if:** You start with history of Objective-C, or never give an example.

---

## 2. Conceptual deep dive (90–120 seconds)

**Template:**
1. Claim (10s)
2. Mechanism (40s)
3. Trade-off / when not (20s)
4. Production proof (30s)

**Example (serial queue vs lock, ~110s):**
> “For shared mutable dictionaries I prefer a GCD serial queue as a mutual exclusion boundary. All writes `async` onto the queue; reads either `sync` for a snapshot or stay on the queue. That eliminates data races without exposing lock ordering bugs. Trade-off: `sync` from the same queue deadlocks, and high read contention may want a reader-writer pattern or an actor. At BMS we introduced synchronised dictionaries this way to stop concurrent-access crashes in async shared state.”

---

## 3. Coding approach (2–3 minutes before code)

**Say this first:**
1. Restate constraints + ask 1–2 clarifying Qs (30s)
2. Brute force + complexity (30s)
3. Optimized approach + why (45s)
4. Edge cases + API shape (30s)
5. “I’ll code the optimized version now” (5s)

**Do not** jump into code silently. Interviewers grade communication.

---

## 4. Architecture walkthrough (3–5 minutes)

**Agenda opener (10s):**
> “I’ll cover the problem, options we considered, the architecture we shipped, and failure modes.”

| Minute | Content |
|---|---|
| 0:00–0:40 | Problem + scale (DAU, revenue, crash) |
| 0:40–1:40 | Options (e.g. MVC vs MVVM vs Clean) + why chosen |
| 1:40–3:30 | Layers: View → VM → Domain/UseCase → Data/Network; key protocols |
| 3:30–4:30 | Failure modes, testing, rollout |
| 4:30–5:00 | Stop; invite questions |

**Use:** Ads module, SDUI header, Stories SDK, District Clean migration.

---

## 5. Mobile system design (45 minutes)

From [ios-system-design cheatsheet](../../ios-system-design/docs/cheatsheet.md):

```
0–5   Clarify:  scope, DAU, offline?, iOS-only?, latency SLO
5–15  HLD:      4-layer client + CDN/API/cache/UI data flow
15–25 Data/API: entities, cursor pagination, payloads, idempotency
25–40 Deep dive: 2–3 hardest subsystems (you choose)
40–45 Ops:      failure modes, metrics, rollout, kill switch
```

**Staff signal opener:**
> “I’ll spend 5 minutes on scope, then full architecture, then deep-dive X and Y. Does that work?”

**4-layer client (always draw):**
1. View (SwiftUI/UIKit — no business logic)
2. ViewModel / Presenter (state, mapping)
3. Domain (use cases, protocols)
4. Data (repositories, network, cache, persistence)

---

## 6. Behavioral STAR (2–3 minutes)

| Segment | Time | Content |
|---|---|---|
| Situation + Task | ~20s | Context + your ownership |
| Action | ~90s | 3–5 concrete steps (design, trade-off, collaboration) |
| Result | ~30s | Metric if you have one (30% nav reduction, 99.95% CFS, etc.) |
| Lesson | ~20s | What you’d do differently / principle |

**Never invent metrics.** Only resume-backed numbers:
- 30+ lakh DAU
- 99.95%+ crash-free sessions
- 30%+ user flows with fewer full-screen navigations (LE Bottom Sheet)
- Portfolio reuse of Stories SDK
- Zero-regression Xcode 15 migration checklist

---

## Anti-patterns

| Anti-pattern | Fix |
|---|---|
| No agenda on long answers | State structure in first 10s |
| No trade-off | Always add “we didn’t choose X because…” |
| No number / no production hook | Attach BMS/District/Raw line |
| Tool worship (Cursor/Claude) | Lead with architecture judgment; AI is accelerator |
| Apologetic filler (“I’m not sure but…”) | State confidence + assumption |
| Overlong STAR (>4 min) | Cut Action to 3 bullets |
| Silent coding | Narrate complexity first |

---

## Self-scoring rubric (after each recording)

| Score | Meaning |
|---|---|
| 5 | On time, clear agenda, trade-off, production proof |
| 4 | On time, missing one of trade-off / proof |
| 3 | Content OK, 30%+ over/under time |
| 2 | Rambling or wrong mechanism |
| 1 | Blank / incorrect |

Target: **≥4** on Normal Qs, **≥3** on Tricky before mocks.

---

## Daily timing drills

1. **Sprint (10 min):** 5× definition Qs at 45s each.
2. **Deep (15 min):** 3× conceptual at 2 min each.
3. **Story (5 min):** 1× STAR at 2:30, then re-cut to 2:00.
4. **SD micro (15 min):** Only Clarify + HLD for one system.
