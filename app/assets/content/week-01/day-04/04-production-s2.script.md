# Audio script — Sample 04 — Production S2 and S2-A1 (Q&A)
> Listen-only sample Q&A from `04-production-s2.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S2?

Next. Q1. What can you claim under Verified · S2? Answer. Shared async state at BookMyShow was hit from multiple queues → data races and intermittent crashes. You introduced synchronised dictionary wrappers gated by G C D serial queues (and read-write locks where access was read-heavy), standardized the access A P I so call sites could not touch raw storage, validated under concurrency stress and Crashlytics watch, and eliminated concurrent-access crashes on that path. Pattern reused for similar shared maps. Follow-ups. ≤20s pitch?: “We gated shared dictionaries behind a serial queue A P I so call sites couldn’t race the storage — crashes went away on that path.”. Timed opener?: “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.”. Provenance label?: Verified · S 2 · BookMyShow · synchronised dictionaries.

## §1 Q2. What must you NOT invent for S2?

Next. Q2. What must you NOT invent for S2? Answer. Do not invent exact crash counts or percentages fixed by this work alone. Do not say “I alone brought the app to 99.95% crash free sessions” — that is S 8 culture, not S 2 attribution. Do not claim every dictionary in the app was converted. Do not claim production used your Learning-lab SafeDict.swift file literally. Follow-ups. Safe result phrasing?: “Eliminated concurrent-access crashes in that shared state path.”. Forbidden breadth?: “Fixed all crashes at BMS.”. Learning-lab label?: SafeDict / BarrierDict demos — not shipped BMS source..

## §2 Q3. What is the full S2 STAR Action (~90s)?

Next. Q3. What is the full S2 STAR Action (~90s)? Answer. “Shared mutable dictionaries were accessed from multiple queues, which produced data races and intermittent crashes. I introduced synchronised dictionary wrappers gated by G C D serial queues — and read-write locking where the access pattern was read-heavy — and standardized the access A P I so call sites could not touch raw storage. We validated under concurrency stress and watched Crashlytics. The races on that path went away, and we reused the pattern wherever shared async maps showed up.” Follow-ups. Lesson line?: “Serialize at the boundary — don’t sprinkle locks ad hoc.”. Result line?: “Eliminated concurrent-access crashes in that shared state path; pattern reused.”. Full STAR budget?: ≤3 minutes including trade-offs if asked..

## §3 Q4. What is How I would apply it · S2-A1?

Next. Q4. What is How I would apply it · S2-A1? Answer. Design direction, not a shipped rewrite: “Production used G C D. How I’d apply it in a new module is an actor SafeDict with get/set/snapshot — callers await, isolation is in the type system, same boundary idea.” Point at Day 05 SafeDictActor.swift as Learning-lab. Say Applied aloud so the interviewer hears honesty. Follow-ups. 20s actor coda?: “Same A P I as an actor for new modules — Applied S 2-A1, not a claim we rewrote production.”. Why mention actors at all?: Shows modern Swift awareness without faking migration history.. Actor A P I cost?: Async surface; reentrancy across await — different traps than G C D sync..

## §4 Q5. How do S2 concepts map to interview questions?

Next. Q5. How do S2 concepts map to interview questions? Answer. Serial vs concurrent → definitions; SafeDict uses serial. Thread-safe dict → private queue A P I (S 2). async vs sync write → visibility caveat; prefer sync for read-after-write. Barrier → RW pattern for read-heavy (S 2 mention). Deadlock → sync re-entry on any serial queue. Actors → S 2-A1 coda. Why hide queue → call sites re-race if they touch storage or queue. Follow-ups. If asked “why not always barrier”?: S 2 honesty: serial default; RW where read-heavy and measured.. If asked visibility?: Teach async-write / sync-read rule; prefer sync set.. If asked modern approach?: S 2-A1 actor — labeled Applied..

## §5 Q6. What are the S2 anti-patterns to avoid?

Next. Q6. What are the S2 anti-patterns to avoid? Answer. “Fixed all crashes at BMS” → path-specific race elimination. Inventing crash % → qualitative intermittent races → eliminated on path. Final class spelling → final class. “Async set always visible on next line” → teach sync set / visibility. Skipping actor coda when asked modern approach → give S 2-A1 with honest label. Follow-ups. Public var storage?: Anti-pattern — private + snapshot.. Exposing queue?: Anti-pattern — standardized A P I was the fix.. Concurrent writes without barrier?: Anti-pattern — barrier or serial..

## §6 Q7. How does S2 relate to S8 without stealing credit?

Next. Q7. How does S2 relate to S8 without stealing credit? Answer. S 2 is the specific fix — synchronised dictionaries, races on that path. S 8 is soft reliability culture — Crashlytics triage, high crash free sessions bar at scale. You may say S 2 validation included watching Crashlytics. You may not attribute app-wide 99.95% crash free sessions solely to S 2 or use S 8 metrics as if they were S 2 results. Follow-ups. Safe Crashlytics mention for S 2?: “Validated under concurrency stress and watched Crashlytics” on that path.. Behavioral question — lead with?: S 2 STAR for concurrency/dictionary question; S 8 for reliability culture question.. Blurring S 2 and S 8?: Interview red flag — keep provenance labels separate..

## §7 Q8. What should you deliver in a timed S2 drill?

Next. Q8. What should you deliver in a timed S2 drill? Answer. ≤20s: serial-queue A P I, races gone on path. ≤3 min STAR: problem (multi-queue shared dicts) → action (serial queue / RW, standardized A P I, stress + Crashlytics) → result (path clean, pattern reused) → lesson (serialize at boundary) → actor coda (S 2-A1, Applied). Flash card: BookMyShow synchronised dictionaries; G C D serial / RW; safe access A P I. Follow-ups. Story bank link?: S 2. After S 2 drill?: Main../04-questions.md for two-layer Q&A timing.. Code aloud?: Tour SafeDict.swift line-by-line — Learning-lab.. Back to: README.md.
