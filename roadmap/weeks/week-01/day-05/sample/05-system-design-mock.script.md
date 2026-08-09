# Audio script — Sample 05 — System-design mock: Infinite Social Feed (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Infinite Social Feed.” How do you open?

Next. Q1. Interviewer: “Design Infinite Social Feed.” How do you open? Answer. “I’ll take about five minutes clarifying scope and scale. Then a four-layer client high-level design with backend touchpoints and load. Then A P I and data. Two deep dives: structured concurrency for paging, and an optimistic like actor. I’ll close on failures, metrics, and kill switches. Does that plan work? Before I draw: same feed scope as Day 01 — cursor plus offline cache? Rough daily active users and peak? Is structured concurrency for page and image tasks okay? Actor for the like coordinator? I’d like video and ranking out of scope — okay?” Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from minute one. Follow-ups. Skip agenda?: Don’t — they may want different dives.. Clarify 15 min?: “Hard stop at five. Rest becomes labeled assumptions.”. No numbers?: Give labeled daily active users estimates and continue..

## §1 Q2. After clarify — what does the good flow look like?

Next. Q2. After clarify — what does the good flow look like? Answer. “For this mock: full client high level design for the feed, async page tasks, an actor for like single-flight. Out: video and ranking. Good flow: agenda, clarify, confirm, high level design with four layers plus backend plus load, A P I, two deep dives, last five minutes ops. Weak flow: drawing in silence, only happy path, inventing QPS as fact, skipping ops.” Follow-ups. Scope changes mid-high level design?: “Re-confirm in/out in twenty seconds. Adjust dives. Protect ops.”. Full backend deep dive?: “Sketch touchpoints; stay client-owned unless they ask.”. Forgot offline?: “Assumption: online-first plus last-good cache — correct me if wrong.”.

## §2 Q3. Walk the HLD — layers, backend, load

Next. Q3. Walk the HLD — layers, backend, load Answer. “Same four layers as Day 01, but I call out Task trees. Parent screen task cancels when the view disappears. Page fetch is a child. Image loads can be lower priority and cancelled when cells scroll away. LikeActor serializes per-post like mutations. Repository exposes async APIs. U I state lives on MainActor. Backend and load: cursor pages, CDN images, cache TTL around five minutes — labeled estimates from daily active users.” Follow-ups. G C D vs async?: “Structured concurrency for page lifecycle. G C D still fine inside image decode pools.”. Sendable models?: “Value models across actors. No UIKit in the domain layer.”.

## §3 Q4. Data / API

Next. Q4. Data / API Answer. “Same shape: GET /v1/feed with a cursor, POST like. I emphasize cancellation: if a newer pull-to-refresh started, ignore the stale page — generation token or cancel the old Task.” Follow-ups. Two pages racing?: “Generation token and task cancel — Day 05 vocabulary.”. Actor reentrancy on like?: “Keep actor work short; hop out for network; re-validate after await.”.

## §4 Q5. Deep dive 1 — Structured concurrency for paging?

Next. Q5. Deep dive 1 — Structured concurrency for paging? Answer. “When a page arrives, I use async let or a task group to prefetch thumbs for that page in parallel. When the user scrolls away or leaves, I cancel that work with the parent task. I don’t sprinkle unstructured Task { } without tying it to view lifetime — SwiftUI.task is the clean story.” Follow-ups. Priority?: “Match urgency; don’t block main with sync waits.”. Prefetch actor?: “Optional ImagePipeline actor for single-flight URLs.”.

## §5 Q6. Deep dive 2 — Optimistic like actor?

Next. Q6. Deep dive 2 — Optimistic like actor? Answer. “An actor owns the in-flight like set for a post. U I flips optimistically, awaits the result, rolls back on throw. Offline queue can be a separate durable store — the actor coordinates drain. Spam taps: coalesce toggles; last intended state wins to the server.” Follow-ups. Many taps?: “Coalesce; don’t fire one network call per tap.”. MainActor?: “U I state on MainActor; network off main.”.

## §6 Q7. Ops — failures, metrics, kill switch?

Next. Q7. Ops — failures, metrics, kill switch? Answer. “Same feed ops, plus concurrency metrics: cancelled task rate, like-actor wait time. Kill switch: disable parallel thumb prefetch under thermal pressure. Never block main with sync network.” Follow-ups. Hang from await on main?: “Await on MainActor is fine if the awaited work isn’t blocking main. Don’t sync-network on main.”. Later deepen?: “Same spine — more A P I/ops on Day 21.”.

## §7 Q8. Scorecard — did you hit the spine?

Next. Q8. Scorecard — did you hit the spine? Answer. “Pass bar: clarify and agenda in five; high level design shows four layers plus backend plus load; A P I has cursors and cancel/idempotency; two deep dives; ops with metrics and a kill switch. Anti-patterns: offset pagination on a live feed; decode on main; inventing QPS as fact; never reaching ops. Timing: 0–5 clarify, 5–15 high level design, 15–25 A P I, 25–40 dives, 40–45 ops.” Follow-ups. Long on dive 1?: “Park dive 2 as bullets; protect ops five minutes.”. Forgot load?: “One sentence from daily active users → labeled QPS, cursor cost, single-flight.”. Invented crash-free %?: “Forbidden — resume numbers or labeled targets only.”.

## §8 Q9. Where does Day 05 concurrency fit in a social-feed design?

Next. Q9. Where does Day 05 concurrency fit in a social-feed design? Answer. “Image and poster prefetch — TaskGroup with a bound so we don’t stampede. Feed pagination — cancel the in-flight page on pull-to-refresh or a newer request. In-memory metadata maps — an actor or a G C D-safe store, same S 2 / S 2-A1 judgment. That’s architecture judgment for the mock. I don’t invent a specific BookMyShow feed implementation that isn’t in the registry.” Follow-ups. Like button?: “Optimistic U I on MainActor; LikeActor or coordinator for single-flight; re-validate after network await.”. Offline cache?: “Last-good page locally; don’t block U I on network.”.

## §9 Q10. Timeouts and kill switches on the feed?

Next. Q10. Timeouts and kill switches on the feed? Answer. “Page fetch gets a timeout — race against sleep or use A P I timeouts — and I cancel the loser. Under thermal or bad network, kill switch disables parallel thumb prefetch. Metrics: cancelled task rate, like-actor wait time, page success. Same Day 05 lesson: cancel is cooperative; design the stop path.” Follow-ups. Hung spinner?: “Cancel + error or last-good cache — never leave the user stuck.”.
