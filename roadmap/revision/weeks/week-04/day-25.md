# Day 25 — Machine-Round Practice (3 Hours)

> Week 4 · Phase: Implementation under timebox · Time budget today: **~3 hrs machine + 1 hr debrief** (cap ~4–5 hrs total)

## 1. Outcome

By end of day you can explain aloud (no notes):

- How you **timebox** a 3-hour machine round: clarify → skeleton → vertical slice → tests → polish — **no perfectionism**.
- Deliver a **working vertical slice** for either brief **(A) paginated list + cache + tests** or **(B) SDUI component renderer**, with explicit cut lines for what you skip.
- Self-grade against the rubrics below (correctness, architecture, tests, communication, honesty about gaps).
- Narrate trade-offs the way you would with a proctor watching (same “say this first” discipline as DSA).

**Rule of the day:** Ship a demoable core. A polished unfinished cathedral scores worse than a tested happy path + listed TODOs.

## 2. Concept deep dive

### 2.1 Machine-round operating system (memorize)

| Phase | Clock | Do | Don’t |
|---|---|---|---|
| 0. Clarify | 0:00–0:15 | Restate brief, ask API shape, offline?, UIKit/SwiftUI, test framework | Code immediately |
| 1. Agenda | 0:15–0:20 | Say layers + milestone plan out loud | Silent architecture |
| 2. Skeleton | 0:20–0:45 | Types, protocols, empty UI, fake repository | Pixel-perfect UI |
| 3. Vertical slice | 0:45–2:00 | One happy path end-to-end | All edge cases first |
| 4. Cache / SDUI depth | 2:00–2:30 | Second requirement (cache **or** 2nd component) | Refactor aesthetics |
| 5. Tests | 2:30–2:50 | 3–6 meaningful unit tests | 100% coverage chase |
| 6. Buffer | 2:50–3:00 | README of trade-offs + known gaps | New features |

**Proctor script at 0:15:**

> “I’ll clarify for 10 more minutes max, then build a vertical slice: UI → ViewModel → repository with protocol — fake data first, then networking/cache. I’ll leave time for tests. If truncated, I’ll document cut lines.”

### 2.2 Brief A — Paginated list + cache + tests

**Prompt (use as-is):**

> Build a mobile screen that loads a **paginated** remote list (cursor or page number). Show loading / empty / error. Support **pull-to-refresh** and next-page on scroll. Add a **cache** so revisiting shows last-good data quickly, then refresh. Include **unit tests** for pagination and cache policy.

**Suggested architecture:**

```text
ListView (SwiftUI or UIKit)
  → ListViewModel (state: items, page/cursor, isLoading, error)
    → ListRepository protocol
        → RemoteDataSource (URLSession)
        → CacheDataSource (memory + optional disk)
```

**Must-have acceptance:**

1. First page renders from network (or stub).
2. Next page appends without wiping.
3. Failure on page 2 keeps page 1 visible.
4. Cache: cold open can show stale then refresh (define policy aloud).
5. Tests: pagination reducer / repository with mock — **not** only UI snapshots.

**Cache policy options (pick one, say why):**

| Policy | When | Cost |
|---|---|---|
| Memory LRU only | Fast interview slice | Lost on kill |
| Memory + disk (Codable) | Stronger “senior” | Serialization time |
| Stale-while-revalidate | Best UX story | Need version/TTL field |

**Cut lines (explicitly OK):** fancy skeletons, DiffableDataSource animations, image pipeline, auth refresh, Perfect offline merge.

**BMS hook (≤20s if asked why you know this):** Search/listings at scale; debounce + state; Firebase p50/p90 mindset for list latency — don’t overclaim machine-round code is production BMS.

### 2.3 Brief B — SDUI component renderer

**Prompt (use as-is):**

> Build a **server-driven UI** renderer: given a JSON document of components (`type`, `props`, optional `children`), map to native views. Support at least **3 component types** (e.g. `text`, `image`, `button` or `vstack`). Unknown `type` → safe fallback view. Include a **version/schema** comment or simple `schemaVersion` check. Unit-test decoding + unknown-type fallback.

**Suggested architecture:**

```text
JSON Data
  → SDUIDocument (Codable, schemaVersion)
  → ComponentNode enum / protocol + factory
  → SDUIRenderer → AnyView / UIView
  → Feature flag / default fallback leaf
```

**Must-have acceptance:**

1. Decode sample JSON into model.
2. Render ≥3 types.
3. Unknown type does **not** crash — placeholder + analytics hook stub.
4. Nested children for one container type.
5. Tests: decoder + factory fallback.

**Cut lines:** full CMS tooling, live reload, expression language, actions beyond `print`/`callback` stub, pixel parity with Figma.

**Production hook:** BMS backend-driven header / Aces splash / Stories — [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md); STAR [story-bank.md](../../stories/story-bank.md)#S3 · #S12.

### 2.4 Rubrics (score yourself 1–5 each)

| Dimension | 5 | 3 | 1 |
|---|---|---|---|
| **Correctness** | Happy path + key failure solid | Happy path only | Doesn’t run |
| **Architecture** | Clear layers + protocols | Mixed but navigable | Massive VC / God ViewModel |
| **Caching or SDUI depth** | Policy explained + coded | Partial | Missing second requirement |
| **Tests** | 3+ meaningful, fast | 1 weak test | None |
| **Communication** | Agenda + trade-offs spoken | Occasional notes | Silent grind |
| **Time honesty** | Cut lines documented | Ran over chasing polish | Perfectionism, unfinished core |

**Pass bar for Day 25:** average **≥3.5**, correctness ≥4, tests ≥3.

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| SwiftUI list | Faster slice | Hybrid apps may want UIKit — say assumption |
| UIKit + Diffable | Matches many codebases | More boilerplate in 3 hrs |
| Protocol + fake repo first | Tests & progress | Must swap to real URLSession later |
| Real network in round | Impressive if stable | Flaky Wi‑Fi kills demo — prefer stub + one live call |
| Snapshot tests | UI confidence | Slow setup — skip unless already scaffolded |
| Perfect Clean Architecture | Rarely fits 3 hrs | Prefer pragmatic MVVM + protocols |

### 2.6 Anti-perfectionism checklist (print mentally)

- [ ] Am I styling fonts while pagination is broken? → stop
- [ ] Can I demo in 60s right now? → if no, vertical slice
- [ ] Do I have ≥1 test? → if no after 2:30, write two now
- [ ] Did I narrate cache/SDUI policy? → if no, say it in buffer
- [ ] Am I rewriting names for beauty? → stop

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [coding/dsa-track.md](../../coding/dsa-track.md) — Machine round section | Any stubs / prior notes |
| Must | This day’s rubrics + timebox | Operating system |
| Deepen | [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) | Pagination / interceptors ideas for A |
| Deepen | [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) | Schema, fallbacks for B |
| Repo | [search-autocomplete.md](../../../ios-system-design/docs/search-autocomplete.md) | Optional list UX inspiration — don’t expand scope |

## 4. Map to your work

**Company / feature:** BMS search & listings; SDUI header; District Clean/MVVM; Raw server-driven splash.  
**What you did:** Debounced search MVVM; generalised header; production SDUI awareness; AI-assisted tests at District (**judgment** on generated tests — not blind accept).  
**Interview line (≤20s):**  
> “In machine rounds I optimize for a tested vertical slice — same bias I use shipping SDUI and list UX: contracts, fallbacks, and observable state.”

→ STAR: [story-bank.md](../../stories/story-bank.md)#S3 · #S9 · #S12

## 5. Normal questions

*(Proctor / debrief style — answer aloud.)*

### Q1. How do you approach a 3-hour take-home or onsite machine round? `(30–45s)`
**Skeleton:** Clarify → agenda → vertical slice → second requirement → tests → known gaps. Optimize demoability.  
**Follow-up:** What do you cut first?  
**Story:** —

### Q2. How do you paginate without duplicates or lost pages? `(45s)`
**Skeleton:** Cursor vs page; append-only; in-flight guard; ignore stale responses (token/id).  
**Follow-up:**  
**Story:** Search lists.

### Q3. What cache policy did you pick and why? `(30–45s)`
**Skeleton:** Name policy (SWR / TTL / memory-only); stale shown; refresh error keeps stale.  
**Follow-up:** Invalidation on logout?  
**Story:** —

### Q4. SDUI unknown component — what should happen? `(30–45s)`
**Skeleton:** Fallback view; don’t crash; log type; optional skip children; schema version gate.  
**Follow-up:**  
**Story:** S3 header.

### Q5. How many tests are “enough” in 3 hours? `(30–45s)`
**Skeleton:** Happy path pagination or decode; one failure; one unknown type / cache hit — quality over count.  
**Follow-up:** District AI tests judgment.  
**Story:** S9.

## 6. Tricky questions

### T1. “Your cache served stale event prices — defend the design.” `(90–120s)`
**Trap:** “Cache is always good.”  
**Senior answer:** TTL + SWR; price-critical rows bypass or short TTL; pull-to-refresh; show last-updated; never cache across users. For machine round, state what you’d harden in prod at 30L DAU.  
**Follow-up:** —

### T2. “Why not generate the whole app with AI in the machine round?” `(90–120s)`
**Trap:** Tool-worship or total ban.  
**Senior answer:** AI can scaffold boilerplate; you own architecture, edge cases, tests, and can explain every line. Same District lesson — accelerator, not author of record.  
**Follow-up:** Day 26.

### T3. “You didn’t finish image loading — is that a fail?” `(90–120s)`
**Trap:** Apologize spiraling.  
**Senior answer:** Pre-declared cut line; core pagination/SDUI works; placeholders documented; production would use shared image pipeline (HeroWidget experience). Graders prefer honesty + working core.  
**Follow-up:** —

### T4. “Show me concurrency bugs in your pager.” `(90–120s)`
**Trap:** No cancellation story.  
**Senior answer:** Task/id for request generation; cancel in-flight on refresh; main-actor state updates; don’t append out-of-order pages. Tie to synchronised-state lessons (S2) at a high level.  
**Follow-up:** —

## 7. Flashcards for today

| Front | Back |
|---|---|
| 3-hr phases | Clarify 15 → slice → depth → tests → buffer · Trap: polish first · Prod: shipping bias |
| Vertical slice | One E2E happy path · Trap: all layers half-done · Prod: — |
| Pagination guard | In-flight + stale token · Trap: double append · Prod: search lists |
| Cache SWR | Show stale then refresh · Trap: empty until network · Prod: perceived perf |
| SDUI unknown type | Fallback not crash · Trap: force unwrap · Prod: S3/S12 |
| Tests enough | 3 meaningful · Trap: 0 or 40 flaky · Prod: District AI judgment |
| Cut line | Say what you skip · Trap: hide gaps · Prod: senior honesty |
| Protocol repo | Fake first then live · Trap: URLSession in VM · Prod: Clean/MVVM |
| Proctor agenda | Speak plan at 0:15 · Trap: silent · Prod: timing guide |
| Perfectionism flag | Styling while core broken · Trap: rename churn · Prod: — |

## 8. Practice

- **Coding / SD:** Pick **one** brief — **A or B** (if time surplus, outline the other in 20 min notes only).

  **Recommended:**  
  - If weaker on networking/state → **A**.  
  - If weaker on SDUI → **B** (high ROI before Day 27).

- **Setup (before timer):** Xcode project or playground; sample JSON/API stub ready; timer visible.

- **Complexity / agenda to say first:** Record first 3 minutes of your clarifying + plan — treat as graded.

- **Debrief (60 min after):** Score rubric; write 5 bullets “keep / fix”; add gotchas; do **not** rebuild from scratch tonight.

## 9. Timed drill

1. Full **3:00:00** machine session — single brief.
2. Afterward: **3 Normal + 1 Tricky** from §§5–6 about *your* implementation (not generic).
3. Score machine rubrics + Qs vs [answer-timing-guide.md](../../timing/answer-timing-guide.md).
4. Log misses; park improvements for after Mock #4 — **no all-night rewrite**.
