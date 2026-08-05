# Sample 04 — Production S2 and S2-A1 (Q&A)

> Guided teaching. Separates **Verified · S2** resume facts from **How I would apply it · S2-A1** so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S2?

**Points to:** [Production bridge · §1 Story map](../03-production-bridge.md#1-story-map) · [Production bridge · §2 Verified · S2](../03-production-bridge.md#2-verified--s2--synchronised-dictionaries)

**Answer:**

> Shared async state at BookMyShow was hit from **multiple queues** → **data races** and **intermittent crashes**. You introduced **synchronised dictionary wrappers** gated by **GCD serial queues** (and **read-write locks** where access was read-heavy), standardized the **access API** so call sites could not touch raw storage, validated under concurrency stress and **Crashlytics** watch, and **eliminated concurrent-access crashes on that path**. Pattern reused for similar shared maps.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” |
| Timed opener? | “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.” |
| Provenance label? | Verified · S2 · BookMyShow · synchronised dictionaries |

---

### Q2. What must you NOT invent for S2?

**Points to:** [Production bridge · §2 What you must not invent](../03-production-bridge.md#2-verified--s2--synchronised-dictionaries) · [Production bridge · §5 Anti-patterns](../03-production-bridge.md#5-anti-patterns)

**Answer:**

> Do **not** invent exact crash counts or percentages fixed by this work alone. Do **not** say “I alone brought the app to 99.95% CFS” — that is **S8 culture**, not S2 attribution. Do **not** claim every dictionary in the app was converted. Do **not** claim production used your Learning-lab [`SafeDict.swift`](../code/SafeDict.swift) file literally.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe result phrasing? | “Eliminated concurrent-access crashes **in that shared state path**.” |
| Forbidden breadth? | “Fixed all crashes at BMS.” |
| Learning-lab label? | SafeDict / BarrierDict demos — not shipped BMS source. |

---

### Q3. What is the full S2 STAR Action (~90s)?

**Points to:** [Production bridge · §2 STAR Action](../03-production-bridge.md#2-verified--s2--synchronised-dictionaries) · [Production bridge · §7 Timed drills](../03-production-bridge.md#7-timed-drills)

**Answer:**

> “Shared mutable dictionaries were accessed from multiple queues, which produced data races and intermittent crashes. I introduced synchronised dictionary wrappers gated by GCD serial queues — and read-write locking where the access pattern was read-heavy — and standardized the access API so call sites could not touch raw storage. We validated under concurrency stress and watched Crashlytics. The races on that path went away, and we reused the pattern wherever shared async maps showed up.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lesson line? | “Serialize at the boundary — don’t sprinkle locks ad hoc.” |
| Result line? | “Eliminated concurrent-access crashes in that shared state path; pattern reused.” |
| Full STAR budget? | ≤3 minutes including trade-offs if asked. |

---

### Q4. What is How I would apply it · S2-A1?

**Points to:** [Production bridge · §3 S2-A1](../03-production-bridge.md#3-how-i-would-apply-it--s2-a1) · [Deep dive · §7 Locks vs queues vs actors](../02-deep-dive.md#7-locks-vs-queues-vs-actors)

**Answer:**

> **Design direction**, not a shipped rewrite: “Production used GCD. How I’d apply it in a new module is an **`actor SafeDict`** with get/set/snapshot — callers **await**, isolation is in the type system, same boundary idea.” Point at Day 05 [`SafeDictActor.swift`](../day-05/code/SafeDictActor.swift) as Learning-lab. Say **Applied** aloud so the interviewer hears honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20s actor coda? | “Same API as an actor for new modules — Applied S2-A1, not a claim we rewrote production.” |
| Why mention actors at all? | Shows modern Swift awareness without faking migration history. |
| Actor API cost? | Async surface; reentrancy across `await` — different traps than GCD sync. |

---

### Q5. How do S2 concepts map to interview questions?

**Points to:** [Production bridge · §4 Mapping concepts → lines](../03-production-bridge.md#4-mapping-concepts--lines) · [Foundations · §11 First production bridge](../01-foundations.md#11-first-production-bridge-short)

**Answer:**

> **Serial vs concurrent** → definitions; SafeDict uses serial. **Thread-safe dict** → private queue API (S2). **async vs sync write** → visibility caveat; prefer sync for read-after-write. **Barrier** → RW pattern for read-heavy (S2 mention). **Deadlock** → sync re-entry on any serial queue. **Actors** → S2-A1 coda. **Why hide queue** → call sites re-race if they touch storage or queue.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| If asked “why not always barrier”? | S2 honesty: serial default; RW where read-heavy and measured. |
| If asked visibility? | Teach async-write / sync-read rule; prefer sync set. |
| If asked modern approach? | S2-A1 actor — labeled Applied. |

---

### Q6. What are the S2 anti-patterns to avoid?

**Points to:** [Production bridge · §5 Anti-patterns](../03-production-bridge.md#5-anti-patterns) · [Deep dive · §12 Anti-patterns](../02-deep-dive.md#12-anti-patterns)

**Answer:**

> **“Fixed all crashes at BMS”** → path-specific race elimination. **Inventing crash %** → qualitative intermittent races → eliminated on path. **`Final class` spelling** → **`final class`**. **“Async set always visible on next line”** → teach sync set / visibility. **Skipping actor coda** when asked modern approach → give S2-A1 with honest label.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public `var storage`? | Anti-pattern — private + snapshot. |
| Exposing queue? | Anti-pattern — standardized API was the fix. |
| Concurrent writes without barrier? | Anti-pattern — barrier or serial. |

---

### Q7. How does S2 relate to S8 without stealing credit?

**Points to:** [Production bridge · §1 Story map](../03-production-bridge.md#1-story-map) · [Day 04 README · Provenance](../README.md#provenance-reminder)

**Answer:**

> **S2** is the **specific fix** — synchronised dictionaries, races on that path. **S8** is soft **reliability culture** — Crashlytics triage, high CFS bar at scale. You may say S2 validation included watching Crashlytics. You may **not** attribute app-wide 99.95% CFS solely to S2 or use S8 metrics as if they were S2 results.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe Crashlytics mention for S2? | “Validated under concurrency stress and watched Crashlytics” on **that path**. |
| Behavioral question — lead with? | S2 STAR for concurrency/dictionary question; S8 for reliability culture question. |
| Blurring S2 and S8? | Interview red flag — keep provenance labels separate. |

---

### Q8. What should you deliver in a timed S2 drill?

**Points to:** [Production bridge · §6 Flash map card](../03-production-bridge.md#6-flash-map-card) · [Production bridge · §7 Timed drills](../03-production-bridge.md#7-timed-drills)

**Answer:**

> **≤20s:** serial-queue API, races gone on path. **≤3 min STAR:** problem (multi-queue shared dicts) → action (serial queue / RW, standardized API, stress + Crashlytics) → result (path clean, pattern reused) → lesson (serialize at boundary) → **actor coda** (S2-A1, Applied). Flash card: BookMyShow synchronised dictionaries; GCD serial / RW; safe access API.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Story bank link? | [S2](../../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow) |
| After S2 drill? | Main [`../04-questions.md`](../04-questions.md) for two-layer Q&A timing. |
| Code aloud? | Tour [`SafeDict.swift`](../code/SafeDict.swift) line-by-line — Learning-lab. |

---

Back to: [README.md](README.md)
