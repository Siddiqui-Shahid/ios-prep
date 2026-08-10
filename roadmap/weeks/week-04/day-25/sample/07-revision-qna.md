# Sample 07 — Revision Q&A (day-25) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. How do you approach a 3-hour machine round? `(30–45s)`
**Answer:**

> I clarify requirements and assumptions in the first fifteen minutes, say the layer plan aloud, then chase one end-to-end happy path before depth work like cache or a second component. I reserve the last thirty minutes for meaningful unit tests and I document cut lines instead of chasing polish. Graders should see a demoable core.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | First fifteen minutes: clarify pagination and cache, sketch Network→Repo→VM→View, then ship the list happy path before deepening cache. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do you paginate without duplicates or lost pages? `(45s)`
**Answer:**

> I pick cursor or page explicitly. New pages append; refresh replaces. An in-flight flag or Task prevents double fetch. Each request carries a generation token so late responses from an old refresh can’t append onto new state. Failures on page two keep page one visible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Bump a generation on refresh; drop a late page-2 response still tagged with gen 1 so it cannot append under gen-2 results. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What cache policy did you pick and why? `(30–45s)`
**Answer:**

> I chose stale-while-revalidate: show last-good memory cache immediately, then refresh. On refresh failure I keep stale and surface a non-blocking error. Price-critical fields would use a short TTL in production — I’ll call that out as a hardening step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Show the last-good movie list immediately, refresh in background, and on a 500 keep stale rows with a toast instead of blanking the UI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. SDUI unknown component — what should happen? `(30–45s)`
**Answer:**

> The factory switches on type; default returns a PlaceholderView and emits an analytics stub with the unknown type string. Unsupported schemaVersion shows a full-screen upgrade/fallback state instead of partial corruption. Nested unknown children can be skipped while siblings still render.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Unknown `type: "PromoCarouselV3"` renders a PlaceholderView and logs the type string instead of crashing the whole header. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How many tests are enough in 3 hours? `(30–45s)`
**Answer:**

> Three meaningful tests beat forty flaky ones: happy-path pagination or decode, a failure that preserves prior state, and either a cache hit or unknown-type fallback. If AI scaffolds test code, I still review assertions — District lesson.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | One test for page append, one for error keeping page 1, one for unknown SDUI type — and still review AI-scaffolded assertions before trusting them. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Cursor vs page number pagination — pick one? `(45s)`
**Answer:**

> For production lists that churn, I prefer opaque cursors so inserts don’t shift pages. In a three-hour stub, page numbers are fine if I say the assumption and still guard in-flight and stale responses. I’ll note cursor migration as a hardening step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Prefer opaque cursors when the feed inserts live; page numbers are fine in a three-hour stub if you still guard in-flight and stale responses. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Where does caching live — ViewModel or Repository? `(45s)`
**Answer:**

> I keep cache policy in the repository so the ViewModel stays about UI state and pagination intent. That makes repository tests cover SWR without spinning up views, and matches Clean/MVVM seams I used in migrations.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Keep SWR memory cache in the repository so ViewModel only calls `loadNextPage`/`refresh` and cache tests don’t need SwiftUI. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q8. What is the one rule to remember for day-25? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-25, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q9. What is the one rule to remember for day-25? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-25, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q10. What is the one rule to remember for day-25? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-25, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “How do you approach a 3-hour machine round?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I clarify requirements and assumptions in the first fifteen minutes, say the layer plan aloud, then chase one end-to-end happy path before depth work like cache or a second component. I reserve the last thirty minutes for meaningful unit tests and I document cut lines instead of chasing polish. Graders should see a demoable core.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you approach a 3-hour machine round |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “How do you paginate without duplicates or lost pages” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “I pick cursor or page explicitly. New pages append; refresh replaces. An in-flight flag or Task prevents double fetch. Each request carries a generation token so late responses from an old refresh can’t append onto new state. Failures on page two keep page one visible.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you paginate without duplicates or lost pages |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “What cache policy did you pick and why”. How do you diagnose? `(60–90s)`
**Answer:**

> “I chose stale-while-revalidate: show last-good memory cache immediately, then refresh. On refresh failure I keep stale and surface a non-blocking error. Price-critical fields would use a short TTL in production — I’ll call that out as a hardening step.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What cache policy did you pick and why |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “SDUI unknown component — what should happen”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “The factory switches on type; default returns a PlaceholderView and emits an analytics stub with the unknown type string. Unsupported schemaVersion shows a full-screen upgrade/fallback state instead of partial corruption. Nested unknown children can be skipped while siblings still render.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | SDUI unknown component — what should happen |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “How many tests are enough in 3 hours”? `(60–90s)`
**Answer:**

> “Three meaningful tests beat forty flaky ones: happy-path pagination or decode, a failure that preserves prior state, and either a cache hit or unknown-type fallback. If AI scaffolds test code, I still review assertions — District lesson.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How many tests are enough in 3 hours |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “Cursor vs page number pagination — pick one” and how you’d correct it? `(60–90s)`
**Answer:**

> “For production lists that churn, I prefer opaque cursors so inserts don’t shift pages. In a three-hour stub, page numbers are fine if I say the assumption and still guard in-flight and stale responses. I’ll note cursor migration as a hardening step.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Cursor vs page number pagination — pick one |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Where does caching live — ViewModel or Repository?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I keep cache policy in the repository so the ViewModel stays about UI state and pagination intent. That makes repository tests cover SWR without spinning up views, and matches Clean/MVVM seams I used in migrations.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Where does caching live — ViewModel or Repository |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
