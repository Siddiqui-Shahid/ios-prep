# Sample 05 — System-design mock: Infinite Social Feed (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.  
> **Source:** [`ios-system-design/docs/social-feed.md`](../../../../ios-system-design/docs/social-feed.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)  
> **Angle:** Day 05 — feed HLD with async/await & actors.  
> **Brain puzzles** at the bottom — concurrency twists interviewers love.

---

### Q1. Interviewer: “Design Infinite Social Feed.” How do you open?

**Answer:**

> “I’ll take about five minutes clarifying scope and scale. Then a four-layer client high-level design with backend touchpoints and load. Then API and data. Two deep dives: structured concurrency for paging, and an optimistic like actor. I’ll close on failures, metrics, and kill switches. Does that plan work?
>
> Before I draw: same feed scope as Day 01 — cursor plus offline cache? Rough DAU and peak? Is structured concurrency for page and image tasks okay? Actor for the like coordinator? I’d like video and ranking out of scope — okay?”

Do **not** draw until they answer or you state labeled assumptions. Keep backend load in mind from minute one.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Don’t — they may want different dives. |
| Clarify 15 min? | “Hard stop at five. Rest becomes labeled assumptions.” |
| No numbers? | Give labeled DAU estimates and continue. |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q2. After clarify — what does the good flow look like?

**Answer:**

> “For this mock: full client HLD for the feed, async page tasks, an actor for like single-flight. Out: video and ranking.
>
> Good flow: agenda, clarify, confirm, HLD with four layers plus backend plus load, API, two deep dives, last five minutes ops.
>
> Weak flow: drawing in silence, only happy path, inventing QPS as fact, skipping ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scope changes mid-HLD? | “Re-confirm in/out in twenty seconds. Adjust dives. Protect ops.” |
| Full backend deep dive? | “Sketch touchpoints; stay client-owned unless they ask.” |
| Forgot offline? | “Assumption: online-first plus last-good cache — correct me if wrong.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q3. Walk the HLD — layers, backend, load

**Answer:**

> “Same four layers as Day 01, but I call out Task trees. Parent screen task cancels when the view disappears. Page fetch is a child. Image loads can be lower priority and cancelled when cells scroll away.
>
> LikeActor serializes per-post like mutations. Repository exposes async APIs. UI state lives on MainActor.
>
> Backend and load: cursor pages, CDN images, cache TTL around five minutes — labeled estimates from DAU.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| GCD vs async? | “Structured concurrency for page lifecycle. GCD still fine inside image decode pools.” |
| Sendable models? | “Value models across actors. No UIKit in the domain layer.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q4. Data / API

**Answer:**

> “Same shape: `GET /v1/feed` with a cursor, `POST` like. I emphasize cancellation: if a newer pull-to-refresh started, ignore the stale page — generation token or cancel the old Task.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two pages racing? | “Generation token and task cancel — Day 05 vocabulary.” |
| Actor reentrancy on like? | “Keep actor work short; hop out for network; re-validate after await.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q5. Deep dive 1 — Structured concurrency for paging?

**Answer:**

> “When a page arrives, I use async let or a task group to prefetch thumbs for that page in parallel. When the user scrolls away or leaves, I cancel that work with the parent task. I don’t sprinkle unstructured `Task { }` without tying it to view lifetime — SwiftUI `.task` is the clean story.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Priority? | “Match urgency; don’t block main with sync waits.” |
| Prefetch actor? | “Optional ImagePipeline actor for single-flight URLs.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q6. Deep dive 2 — Optimistic like actor?

**Answer:**

> “An actor owns the in-flight like set for a post. UI flips optimistically, awaits the result, rolls back on throw. Offline queue can be a separate durable store — the actor coordinates drain. Spam taps: coalesce toggles; last intended state wins to the server.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Many taps? | “Coalesce; don’t fire one network call per tap.” |
| MainActor? | “UI state on MainActor; network off main.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q7. Ops — failures, metrics, kill switch?

**Answer:**

> “Same feed ops, plus concurrency metrics: cancelled task rate, like-actor wait time. Kill switch: disable parallel thumb prefetch under thermal pressure. Never block main with sync network.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hang from await on main? | “Await on MainActor is fine if the awaited work isn’t blocking main. Don’t sync-network on main.” |
| Later deepen? | “Same spine — more API/ops on Day 21.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q8. Scorecard — did you hit the spine?

**Answer:**

> “Pass bar: clarify and agenda in five; HLD shows four layers plus backend plus load; API has cursors and cancel/idempotency; two deep dives; ops with metrics and a kill switch.
>
> Anti-patterns: offset pagination on a live feed; decode on main; inventing QPS as fact; never reaching ops.
>
> Timing: 0–5 clarify, 5–15 HLD, 15–25 API, 25–40 dives, 40–45 ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Long on dive 1? | “Park dive 2 as bullets; protect ops five minutes.” |
| Forgot load? | “One sentence from DAU → labeled QPS, cursor cost, single-flight.” |
| Invented crash-free %? | “Forbidden — resume numbers or labeled targets only.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

---

### Q9. Where does Day 05 concurrency fit in a social-feed design?

**Answer:**

> “Image and poster prefetch — TaskGroup with a bound so we don’t stampede. Feed pagination — cancel the in-flight page on pull-to-refresh or a newer request. In-memory metadata maps — an actor or a GCD-safe store, same S2 / S2-A1 judgment. That’s architecture judgment for the mock. I don’t invent a specific BookMyShow feed implementation that isn’t in the registry.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Like button? | “Optimistic UI on MainActor; LikeActor or coordinator for single-flight; re-validate after network await.” |
| Offline cache? | “Last-good page locally; don’t block UI on network.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q10. Timeouts and kill switches on the feed?

**Answer:**

> “Page fetch gets a timeout — race against sleep or use API timeouts — and I cancel the loser. Under thermal or bad network, kill switch disables parallel thumb prefetch. Metrics: cancelled task rate, like-actor wait time, page success. Same Day 05 lesson: cancel is cooperative; design the stop path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hung spinner? | “Cancel + error or last-good cache — never leave the user stuck.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Stale page wins

User pull-to-refreshes twice fast. First response is slow and arrives last. Feed jumps backward.

**Fix you’d say:** Cancel the first Task (or bump a generation token). Only apply results if generation still matches.

---

### Puzzle B — Like actor + network await

```swift
actor LikeCoordinator {
    var inFlight: Set<PostID> = []
    func toggle(_ id: PostID) async throws {
        inFlight.insert(id)
        try await api.like(id)      // await
        inFlight.remove(id)
    }
}
```

User taps unlike while like is in flight. What’s the reentrancy worry?

**Answer:** Another `toggle` can enter during await. `inFlight` and UI optimistic state can disagree. Coalesce intended final state; re-check after await; don’t assume you still “own” the post’s like state.

---

### Puzzle C — Prefetch stampede

TaskGroup adds one child per image URL on a 50-item page with no cap.

**Ask:** What hits the network / battery?

**Answer:** Up to 50 parallel downloads. Cap concurrency (e.g. 4–6), cancel on scroll away, lower priority than the visible page fetch.

---

Next: [06-module-drills.md](06-module-drills.md)
