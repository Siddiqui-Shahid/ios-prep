# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. async/await vs GCD callbacks? `(45–60s)`

**Answer:**

> GCD gives you queues and explicit scheduling with closures. async/await lets a function suspend at await points so control flow stays linear, errors use throws, and work composes with structured concurrency and Task cancellation. GCD isn’t obsolete — at BookMyShow our synchronised dictionaries were serial-queue based — but for new asynchronous APIs I prefer async/await for readability and cancellation, and I keep GCD where a stable queue boundary already works.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Migrating a URLSession completion to `try await data(from:)` keeps error paths linear while leaving a stable GCD SafeDict queue alone. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. What is structured concurrency? `(45–60s)`

**Answer:**

> Structured concurrency organizes asynchronous work into a parent/child hierarchy. The parent owns child lifetimes, so cancellation and completion compose naturally. APIs like async let and TaskGroup keep fan-out inside a scope. Unstructured Task braces are still needed to bridge from synchronous UI code, but if everything is detached fire-and-forget you lose that ownership story — which shows up as stale search results or work after a screen disappears.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | `async let details = …; async let showtimes = …` ties both children to the parent scope so cancelling the parent cancels both. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How does Task cancellation work? `(60s)`

**Answer:**

> Calling cancel marks a Task cancelled; it doesn’t forcibly kill a thread. The task stops when it hits a cancellable suspension that throws CancellationError, or when code checks Task.isCancelled or checkCancellation. Tight CPU loops that never check can ignore cancel. In search debounce, I store the Task and cancel the previous one on each keystroke so older in-flight work doesn’t overwrite newer results — that’s the BookMyShow search UX pattern.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | On each search keystroke cancel the prior Task so an older “Avengers” response cannot overwrite a newer query’s results. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. Actor vs class + lock / GCD serial queue? `(60–90s)`

**Answer:**

> A GCD serial queue can protect a dictionary if every access goes through it — that’s what we shipped for synchronised dictionaries at BookMyShow. Locks work for tiny critical sections but are easy to misuse under complexity. An actor gives compiler-checked isolation and an async API from the outside. For greenfield shared maps I’d prefer an actor with the same safe get/set surface; for a stable GCD module I wouldn’t big-bang rewrite. The actor trade-off is reentrancy: after await, state may change, so I re-validate.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Ship a serial-queue SafeDict today; greenfield would expose `actor Cache { func get/set }` with the same get/set surface and re-check after awaits. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. What is actor reentrancy? `(60–90s)`

**Answer:**

> Actors serialize execution on their isolated state, but they are reentrant at await points. If an actor method awaits, another task may enter the actor before the first resumes, so fields may have changed even though you never had a data race. Seniors don’t assume continuity across await — they snapshot what they need, re-check invariants after resume, and keep mutations short. That’s the main trap when people say actors make concurrency bugs impossible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | After `await fetch()`, re-read actor fields before mutating — another task may have cleared the cache while you were suspended. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is `@MainActor` for? `(30–45s)`

**Answer:**

> @MainActor marks code that must run on the main actor — where UIKit and much of SwiftUI expect updates. ViewModels that own UI state often sit on MainActor so published updates are safe. I still offload heavy decoding or image work elsewhere and await back. A custom actor is better for non-UI shared mutable caches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Annotate the ViewModel `@MainActor` so `@Published` updates are main-safe; decode posters off-main and `await` back to apply state. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Sendable in one clear explanation? `(45–60s)`

**Answer:**

> Sendable is the compiler’s contract that a value can be shared across concurrency domains safely. Structs aren’t magically Sendable — they are when all stored properties are Sendable. A struct holding a mutable class reference can still race. Classes usually need immutability, synchronization, or an actor. @unchecked Sendable opts out of checking; I only use it when I’ve proven the invariant, and for new shared mutability I prefer an actor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | A struct wrapping a mutable `NSMutableDictionary` is not safely Sendable across tasks without synchronization or an actor. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. `async let` vs `withTaskGroup`? `(45s)`

**Answer:**

> async let is ideal when I know a small fixed set of parallel children — details, showtimes, offers. TaskGroup is for dynamic N, like prefetching N poster URLs. Both stay structured under the parent. If N can be huge I talk about bounding concurrency so we don’t stampede the network.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Fixed three parallel calls use `async let`; N poster URLs use `withTaskGroup` with a max-concurrency cap to avoid a network stampede. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. When is `Task.detached` appropriate? `(45s)`

**Answer:**

> I use Task.detached rarely — when work must be independent of the caller’s actor isolation and lifetime, and I’m prepared to pass Sendable inputs explicitly. For UI-driven work I prefer Task that inherits context, with an explicit cancel path. Detached everywhere loses structure and makes MainActor hops easy to get wrong.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Detach only for true fire-and-forget work that must not inherit MainActor, and pass Sendable payloads explicitly. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. How do you replace callback URLSession with async? `(45–60s)`

**Answer:**

> I’d use URLSession’s async data APIs with try await, validate the HTTP response, then decode. Errors surface through throws instead of optional error parameters. If this runs inside a Task, cancelling that Task participates in cancelling the async transfer. I still keep stale-response guards for higher-level flows like search where multiple generations exist.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | `let (data, response) = try await URLSession.shared.data(for: request)` then throw on non-2xx before decode, with Task cancel covering the transfer. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q11. Task priority / QoS — what do you say? `(45s)`

**Answer:**

> Tasks carry priority and often inherit from their parent, similar in spirit to caring about GCD QoS. Interactive UI work should stay responsive; bulk prefetch shouldn’t casually run at the highest priority. I set priority deliberately for true background work and avoid assuming the runtime will save me from doing heavy decoding on MainActor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Keep the visible search Task user-initiated and run bulk poster prefetch at a lower priority so UI stays responsive. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. Swift 6 / Approachable Concurrency / default MainActor — how do you phrase it? `(45–60s)`

**Answer:**

> Under Swift 6 language mode and stricter concurrency checking when enabled, isolation and Sendable mistakes become harder to ignore. Approachable Concurrency and default MainActor isolation are also settings that can change defaults for a target — I don’t claim they apply to every codebase worldwide. In interviews I speak in concepts: isolation domains, Sendable, actors, cancellation — and I qualify defaults with ‘when enabled’ after checking build settings.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Say “with Swift 6 / Approachable Concurrency enabled, UI types may default to MainActor” — then confirm the target’s actual build settings. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Timed set suggestions

| Drill | Questions | Focus |
|---|---|---|
| Core 10 min | Q4, Q5, T1, T3 | Actor + cancel |
| Migration 8 min | Q1, T7, Q12 | BookMyShow synchronised dictionaries → Design: actor SafeDict (not shipped) + settings humility |
| Sendable 8 min | Q7, T2, T6 | Exact Sendable rules |
