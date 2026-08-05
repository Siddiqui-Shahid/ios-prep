# Audio script — Sample 01 — Week 2 synthesis (Q&A)
> Listen-only sample Q&A from `01-week2-synthesis.md`. Spoken answers and follow-ups.

## §0 Q1. What is the Week 2 narrative in one flow?

Next. Q1. What is the Week 2 narrative in one flow? Answer. Day 08: layers / DI / search VM → Day 09: URLSession / refresh / pin / cancel → Day 10: S D U I schema / registry / fallback → Day 11: lifecycle / cells / hybrid / bottom sheet → Day 12: SwiftUI state / identity / Stories S D K → Day 13: stack · queue · LL composure. One senior sentence: clear layers and DI, own networking with cancellation and security, S D U I where content velocity matters with fail-soft schema, UIKit/SwiftUI lifecycle and identity as production contracts. Follow-ups. BMS / District / Raw?: Tie honestly — Verified stories per day, no merged fake project.. Week 1 still relevant?: P O P, A R C, async — Mock #2 assumes Week 1+2 together.. Revision twin?: revision/weeks/week-02/day-14.md.

## §1 Q2. What is the Week 2 one-liner to memorize?

Next. Q2. What is the Week 2 one-liner to memorize? Answer. “I structure features with clear layers and DI, own networking with cancellation and security, use S D U I where content velocity matters with fail-soft schema, and treat UIKit/SwiftUI lifecycle and identity as production contracts — proven on BMS, District, and Raw apps.” Adjust provenance per story — don’t claim every bullet on every employer. Follow-ups. Overclaim risk?: One-liner is synthesis — STAR still per Verified ID.. District piece?: S9 Clean/M V V M + AI judgment — supporting spice.. Raw piece?: S 10 Stories, S13 Grizzlies hybrid..

## §2 Q3. What is single-flight refresh in 30 seconds?

Next. Q3. What is single-flight refresh in 30 seconds? Answer. N concurrent 401s shouldn’t each start refresh. One refresh Task; other callers become waiters that await the same result. Retry once on success path; on failure → logout fan-out. FIFO queue of continuations mental model (Day 13 soft bridge). Verified: S4 URLSession ownership on Ads — not invented stampede metrics. Follow-ups. vs debounce?: Debounce delays intent; single-flight dedupes concurrent same work.. Pin outage same week?: I M O C leadership + backup pins design (S4-A1 Applied).. Mock tricky pool?: Refresh stampede + pin outage — Block 2..

## §3 Q4. What is unknown SDUI handling in 20 seconds?

Next. Q4. What is unknown SDUI handling in 20 seconds? Answer. Unknown component type → skip + metric; never crash the shell. Schema version gate on fetch. Empty root after parse → hard fallback header/splash. Last-known-good cache when network fails. Allowlisted actions only — no arbitrary URL schemes from CMS. S3-A1 emphasizes versioning + fallback as design emphasis. Follow-ups. Skip vs throw?: Skip — fail-soft product contract.. Stable node ids?: ForEach identity — Day 12 crossover.. Native Ads player S D U I?: Weak — keep renderer native (S 1)..

## §4 Q5. What is search cancel discipline in 20 seconds?

Next. Q5. What is search cancel discipline in 20 seconds? Answer. Debounce in view model. Cancel in-flight Task on new query. Cancellation ≠ user-facing error — ignore stale results. M V V M binding for loading/empty/error. Verified S3: backend-driven header + search debounce/state/M V V M. Follow-ups. Debounce VM vs repository?: Mock tricky — pick a side with trade-off.. Race on slow network?: Generation token or task id — apply latest only.. S D U I search field?: Same cancel discipline in observable model..

## §5 Q6. What is SwiftUI identity in 20 seconds for mock warm-ups?

Next. Q6. What is SwiftUI identity in 20 seconds for mock warm-ups? Answer. Stable IDs preserve @State and representables. Never.id(UUID()) in body — text clears, players restart. Stories pages need stable identity across progress ticks (S 10). S D U I leaves use server node ids, not array indices. Follow-ups. Intentional reset?: Logout.id(session) — deliberate.. Hybrid link?: Representable remake — Day 11.. List jump?: Unstable ForEach ids..

## §6 Q7. What is Array-as-queue in 15 seconds?

Next. Q7. What is Array-as-queue in 15 seconds? Answer. Array.removeFirst() is O(n) per dequeue — shifts all elements. Name it or use Deque, two-stack queue, or ring buffer. BFS hot paths need honest queue cost. D S A composure: don’t let basics block architecture talk. Follow-ups. Two-stack?: Amortized O(1) — say amortized.. Mock warm-up?: One D S A composure question in Block 1.. Next topic?: Mock format — 02-mock-format.md.. Next: 02-mock-format.md.
