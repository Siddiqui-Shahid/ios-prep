# Audio script — Sample 07 — Revision Q&A (day-25) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. How do you approach a 3-hour machine round? `(30–45s)`

Next. Q1. How do you approach a 3-hour machine round? `(30–45s)` Answer. I clarify requirements and assumptions in the first fifteen minutes, say the layer plan aloud, then chase one end-to-end happy path before depth work like cache or a second component. I reserve the last thirty minutes for meaningful unit tests and I document cut lines instead of chasing polish. Graders should see a demoable core. Follow-ups. Probe deeper?: First fifteen minutes: clarify pagination and cache, sketch Network→Repo→VM→View, then ship the list happy path before deepening cache..

## §1 Q2. How do you paginate without duplicates or lost pages? `(45s)`

Next. Q2. How do you paginate without duplicates or lost pages? `(45s)` Answer. I pick cursor or page explicitly. New pages append; refresh replaces. An in-flight flag or Task prevents double fetch. Each request carries a generation token so late responses from an old refresh can’t append onto new state. Failures on page two keep page one visible. Follow-ups. Probe deeper?: Bump a generation on refresh; drop a late page-2 response still tagged with gen 1 so it cannot append under gen-2 results..

## §2 Q3. What cache policy did you pick and why? `(30–45s)`

Next. Q3. What cache policy did you pick and why? `(30–45s)` Answer. I chose stale-while-revalidate: show last-good memory cache immediately, then refresh. On refresh failure I keep stale and surface a non-blocking error. Price-critical fields would use a short TTL in production — I’ll call that out as a hardening step. Follow-ups. Probe deeper?: Show the last-good movie list immediately, refresh in background, and on a 500 keep stale rows with a toast instead of blanking the U I..

## §3 Q4. SDUI unknown component — what should happen? `(30–45s)`

Next. Q4. SDUI unknown component — what should happen? `(30–45s)` Answer. The factory switches on type; default returns a PlaceholderView and emits an analytics stub with the unknown type string. Unsupported schemaVersion shows a full-screen upgrade/fallback state instead of partial corruption. Nested unknown children can be skipped while siblings still render. Follow-ups. Probe deeper?: Unknown type: "PromoCarouselV3" renders a PlaceholderView and logs the type string instead of crashing the whole header..

## §4 Q5. How many tests are enough in 3 hours? `(30–45s)`

Next. Q5. How many tests are enough in 3 hours? `(30–45s)` Answer. Three meaningful tests beat forty flaky ones: happy-path pagination or decode, a failure that preserves prior state, and either a cache hit or unknown-type fallback. If AI scaffolds test code, I still review assertions — District lesson. Follow-ups. Probe deeper?: One test for page append, one for error keeping page 1, one for unknown S D U I type — and still review AI-scaffolded assertions before trusting them..

## §5 Q6. Cursor vs page number pagination — pick one? `(45s)`

Next. Q6. Cursor vs page number pagination — pick one? `(45s)` Answer. For production lists that churn, I prefer opaque cursors so inserts don’t shift pages. In a three-hour stub, page numbers are fine if I say the assumption and still guard in-flight and stale responses. I’ll note cursor migration as a hardening step. Follow-ups. Probe deeper?: Prefer opaque cursors when the feed inserts live; page numbers are fine in a three-hour stub if you still guard in-flight and stale responses..

## §6 Q7. Where does caching live — ViewModel or Repository? `(45s)`

Next. Q7. Where does caching live — ViewModel or Repository? `(45s)` Answer. I keep cache policy in the repository so the ViewModel stays about U I state and pagination intent. That makes repository tests cover SWR without spinning up views, and matches Clean/M V V M seams I used in migrations. Follow-ups. Probe deeper?: Keep SWR memory cache in the repository so ViewModel only calls loadNextPage/refresh and cache tests don’t need SwiftUI..

## §7 Q8. What is the one rule to remember for day-25? `(30–45s)`

Next. Q8. What is the one rule to remember for day-25? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-25, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §8 Q9. What is the one rule to remember for day-25? `(30–45s)`

Next. Q9. What is the one rule to remember for day-25? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-25, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §9 Q10. What is the one rule to remember for day-25? `(30–45s)`

Next. Q10. What is the one rule to remember for day-25? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-25, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §10 I1. A junior asks you in standup: “How do you approach a 3-hour machine round?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “How do you approach a 3-hour machine round?” — how do you answer without jargon? `(60–90s)` Answer. “I clarify requirements and assumptions in the first fifteen minutes, say the layer plan aloud, then chase one end-to-end happy path before depth work like cache or a second component. I reserve the last thirty minutes for meaningful unit tests and I document cut lines instead of chasing polish. Graders should see a demoable core.” Follow-ups. What concept is this really?: How do you approach a 3-hour machine round. How do you prove it?: Give a tiny example or production boundary..

## §11 I2. Production symptom: something related to “How do you paginate without duplicates or lost pages” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “How do you paginate without duplicates or lost pages” just broke under load. What do you check first? `(60–90s)` Answer. “I pick cursor or page explicitly. New pages append; refresh replaces. An in-flight flag or Task prevents double fetch. Each request carries a generation token so late responses from an old refresh can’t append onto new state. Failures on page two keep page one visible.” Follow-ups. What concept is this really?: How do you paginate without duplicates or lost pages. How do you prove it?: Give a tiny example or production boundary..

## §12 I3. Interviewer never names the topic. They describe a mess that maps to “What cache policy did you pick and why”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “What cache policy did you pick and why”. How do you diagnose? `(60–90s)` Answer. “I chose stale-while-revalidate: show last-good memory cache immediately, then refresh. On refresh failure I keep stale and surface a non-blocking error. Price-critical fields would use a short TTL in production — I’ll call that out as a hardening step.” Follow-ups. What concept is this really?: What cache policy did you pick and why. How do you prove it?: Give a tiny example or production boundary..

## §13 I4. Code review: you spot a smell around “SDUI unknown component — what should happen”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “SDUI unknown component — what should happen”. What do you say and what fix do you propose? `(60–90s)` Answer. “The factory switches on type; default returns a PlaceholderView and emits an analytics stub with the unknown type string. Unsupported schemaVersion shows a full-screen upgrade/fallback state instead of partial corruption. Nested unknown children can be skipped while siblings still render.” Follow-ups. What concept is this really?: S D U I unknown component — what should happen. How do you prove it?: Give a tiny example or production boundary..

## §14 I5. What happens if a teammate ignores the rule behind “How many tests are enough in 3 hours”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “How many tests are enough in 3 hours”? `(60–90s)` Answer. “Three meaningful tests beat forty flaky ones: happy-path pagination or decode, a failure that preserves prior state, and either a cache hit or unknown-type fallback. If AI scaffolds test code, I still review assertions — District lesson.” Follow-ups. What concept is this really?: How many tests are enough in 3 hours. How do you prove it?: Give a tiny example or production boundary..

## §15 I6. Walk me through a failed interview answer on “Cursor vs page number pagination — pick one” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Cursor vs page number pagination — pick one” and how you’d correct it? `(60–90s)` Answer. “For production lists that churn, I prefer opaque cursors so inserts don’t shift pages. In a three-hour stub, page numbers are fine if I say the assumption and still guard in-flight and stale responses. I’ll note cursor migration as a hardening step.” Follow-ups. What concept is this really?: Cursor vs page number pagination — pick one. How do you prove it?: Give a tiny example or production boundary..

## §16 I7. A junior asks you in standup: “Where does caching live — ViewModel or Repository?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Where does caching live — ViewModel or Repository?” — how do you answer without jargon? `(60–90s)` Answer. “I keep cache policy in the repository so the ViewModel stays about U I state and pagination intent. That makes repository tests cover SWR without spinning up views, and matches Clean/M V V M seams I used in migrations.” Follow-ups. What concept is this really?: Where does caching live — ViewModel or Repository. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §17 T1. They want a one-tool forever answer? `(90–120s)`

Next. T1. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §18 T2. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T2. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §19 T3. Main-thread rule under pressure? `(90–120s)`

Next. T3. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §20 T4. Cancellation honesty? `(90–120s)`

Next. T4. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T5. Cache invalidation trap? `(90–120s)`

Next. T5. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T6. Security theater vs real pinning? `(90–120s)`

Next. T6. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T7. SDUI unknown component in prod? `(90–120s)`

Next. T7. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T8. DI vs singletons under test? `(90–120s)`

Next. T8. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T9. Prefetch that hurts scrolling? `(90–120s)`

Next. T9. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T10. Actor reentrancy surprise? `(90–120s)`

Next. T10. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
