# Sample 07 — Revision Q&A (day-05) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. async/await vs GCD callbacks? `(45–60s)`
**Answer:**

> “With callbacks, work nests and every closure repeats error handling. Async/await lets me write it top to bottom with try await, and one throws path. Cancellation becomes cooperative Task cancel when the APIs participate. GCD isn’t dead — at BookMyShow our synchronised dictionaries were serial-queue based — but for new async APIs I prefer async/await for clarity, and I keep GCD where a stable queue boundary already works.”

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

> “Async work forms a tree. The parent owns the kids — it doesn’t finish until they finish or cancel — so cancel and errors can travel down. async let and TaskGroup keep fan-out inside a scope. I still need unstructured Task at UI sync boundaries, but if everything is fire-and-forget I lose ownership — stale search results, work after the screen is gone.”

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

> “Cancel is a request, not a kill. The task is marked cancelled. It actually stops when it hits a cancellable await that throws CancellationError, or when code checks isCancelled / checkCancellation. A tight CPU loop with no checks can ignore you completely. In search debounce I store the Task and cancel the previous one on each keystroke so an older response can’t overwrite a newer query — BookMyShow search UX pattern.”

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

> “Actors serialize access to their state, but at await another task can walk in before you resume. Fields may have changed — no data race, but your logic can still be wrong. I don’t assume continuity across await. I snapshot what I need, re-check after resume, and keep mutations short. That’s the trap when people say actors make concurrency bugs impossible.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | After `await fetch`, re-read actor fields before mutating — another task may have cleared the cache while you were suspended. |

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


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “async/await vs GCD callbacks?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “With callbacks, work nests and every closure repeats error handling. Async/await lets me write it top to bottom with try await, and one throws path. Cancellation becomes cooperative Task cancel when the APIs participate. GCD isn’t dead — at BookMyShow our synchronised dictionaries were serial-queue based — but for new async APIs I prefer async/await for clarity, and I keep GCD where a stable queue boundary already works.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | async/await vs GCD callbacks |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “What is structured concurrency” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Async work forms a tree. The parent owns the kids — it doesn’t finish until they finish or cancel — so cancel and errors can travel down. async let and TaskGroup keep fan-out inside a scope. I still need unstructured Task at UI sync boundaries, but if everything is fire-and-forget I lose ownership — stale search results, work after the screen is gone.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is structured concurrency |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “How does Task cancellation work”. How do you diagnose? `(60–90s)`
**Answer:**

> “Cancel is a request, not a kill. The task is marked cancelled. It actually stops when it hits a cancellable await that throws CancellationError, or when code checks isCancelled / checkCancellation. A tight CPU loop with no checks can ignore you completely. In search debounce I store the Task and cancel the previous one on each keystroke so an older response can’t overwrite a newer query — BookMyShow search UX pattern.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How does Task cancellation work |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Actor vs class + lock / GCD serial queue”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “A GCD serial queue can protect a dictionary if every access goes through it — that’s what we shipped for synchronised dictionaries at BookMyShow. Locks work for tiny critical sections but are easy to misuse under complexity. An actor gives compiler-checked isolation and an async API from the outside. For greenfield shared maps I’d prefer an actor with the same safe get/set surface; for a stable GCD module I wouldn’t big-bang rewrite. The actor trade-off is reentrancy: after await, state may change, so I re-validate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Actor vs class + lock / GCD serial queue |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “What is actor reentrancy”? `(60–90s)`
**Answer:**

> “Actors serialize access to their state, but at await another task can walk in before you resume. Fields may have changed — no data race, but your logic can still be wrong. I don’t assume continuity across await. I snapshot what I need, re-check after resume, and keep mutations short. That’s the trap when people say actors make concurrency bugs impossible.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is actor reentrancy |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “What is `@MainActor` for” and how you’d correct it? `(60–90s)`
**Answer:**

> “@MainActor marks code that must run on the main actor — where UIKit and much of SwiftUI expect updates. ViewModels that own UI state often sit on MainActor so published updates are safe. I still offload heavy decoding or image work elsewhere and await back. A custom actor is better for non-UI shared mutable caches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is @MainActor for |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Sendable in one clear explanation?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Sendable is the compiler’s contract that a value can be shared across concurrency domains safely. Structs aren’t magically Sendable — they are when all stored properties are Sendable. A struct holding a mutable class reference can still race. Classes usually need immutability, synchronization, or an actor. @unchecked Sendable opts out of checking; I only use it when I’ve proven the invariant, and for new shared mutability I prefer an actor.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Sendable in one clear explanation |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “`async let` vs `withTaskGroup`” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “async let is ideal when I know a small fixed set of parallel children — details, showtimes, offers. TaskGroup is for dynamic N, like prefetching N poster URLs. Both stay structured under the parent. If N can be huge I talk about bounding concurrency so we don’t stampede the network.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | async let vs withTaskGroup |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Cancel is called — why is work still running? `(90s)`
**Answer:**

> “Cancel is a request, not a kill switch. The task is marked cancelled, but a tight CPU loop that never awaits and never checks `Task.isCancelled` will keep going. URLSession’s async APIs usually throw CancellationError for you. Your own thumbnail render loop won’t, unless you add `Task.checkCancellation` each iteration. In search debounce I store the Task and cancel it — and I still treat CancellationError as normal.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Any loop or heavy sync work inside async needs an explicit cancel check. ‘The network call throws’ only covers the network call.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Concept:** Cooperative cancellation — not preemptive.

---

### T2. Is this struct Sendable? `(90s)`
```swift
final class Counter { var n = 0 }
struct Box { var counter: Counter }
```

**Answer:**

> “No — not safely. `Box` is a value type, but it holds a class. Copies share the same Counter. Two tasks mutating `n` race. Sendable isn’t ‘structs are fine.’ It’s ‘can this cross domains without a race?’ Value types are Sendable when their stored properties are. Fix: keep Counter inside an actor, or make the data a Sendable value.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Same trap with NSMutableDictionary wrapped in a struct — classic false confidence.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T3. Actor wallet — two spends of 80 on balance 100? `(90–120s)`
```swift
actor Wallet {
 var balance = 100
 func spend(_ amount: Int) async throws {
 guard balance >= amount else { throw Err.insufficient }
 await bank.authorize(amount)
 balance -= amount
 }
}
```

**Answer:**

> “Both calls can pass the guard. Both await authorize. Both subtract. You can go negative or inconsistent — no data race, but a logic bug from reentrancy. After await I re-check balance, or I reserve funds before await, or I keep the mutation in a short section after network returns and validate again. Actors stop races on storage; they don’t freeze your business rules across suspension.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Phrase: prevent data races, reentrant at await — re-validate.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T4. `onAppear { Task { } }` vs `.task { }`? `(90s)`
**Answer:**

> “Bare onAppear plus Task is easy to orphan — screen goes away, work keeps running, stale UI updates. SwiftUI `.task` ties the work to the view lifetime: appear starts it, disappear cancels it, and cancel can propagate if the code cooperates. For search I’d also cancel on query change with `.task(id: query)`.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Reviewer question: where did the Task handle go, and why isn’t this `.task`?” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T5. Does `await` always mean background thread? `(60–90s)`
**Answer:**

> “No. Await means possible suspension. Where you resume depends on actor isolation — MainActor stays on main. Thinking await equals background is how people put Thread.sleep on main ‘for debounce’ and freeze scrolling. Use Task.sleep to suspend. Hop explicitly when you need off-main work.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “After await in a @MainActor function, you’re still on MainActor unless you hopped away.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T6. `@unchecked Sendable` — when is it honest? `(90s)`
**Answer:**

> “It’s ‘trust me, I synchronized.’ The compiler stops checking. I’ll use it only when I’ve proven thread safety — for example wrapping a legacy type that is already confined to a serial queue — and I’d rather put new mutable state in an actor. Using unchecked just to silence Swift 6 warnings is how races sneak back in.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Prefer Sendable DTOs at boundaries over unchecked class tokens.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries (manual sync — same honesty bar as unchecked)
- **Design if asked:** Design: actor SafeDict (not shipped)

---

### T7. “We should rewrite all BMS dictionaries to actors” — your reply? `(90–120s)`
**Answer:**

> “I’d push back on big-bang. Shipped fix was GCD synchronised dictionaries with a closed API — that path is proven. For greenfield shared maps I’d use an actor with the same get/set surface — design judgment, not a claim we rewrote the org. Strangler at module boundaries. New pitfall to train: reentrancy after await, not queue.sync deadlock. And I won’t hang app-wide crash-free percent on either story alone.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Same boundary idea — hide storage, one writer path — different enforcement.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Don’t claim:** Org-wide actor rewrite or CFS ownership from dictionaries alone.

---

### T8. Image cache actor downloads twice for one URL? `(90s)`
**Answer:**

> “Two tasks miss the cache, both await download, both write. Wasted network, possible overwrite. After await I re-check the store; if another task filled it, return that. Or single-flight: one in-flight Task per URL. Classic reentrancy-aware cache design.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Same pattern as generation tokens for single-flight refresh.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T9. GCD `sync` from async code — what fails? `(90s)`
**Answer:**

> “The cooperative thread pool can starve if async tasks block on DispatchQueue.sync. Sync to main is especially nasty — deadlock or long stalls. Prefer async façades with continuations, resume exactly once. At BMS we still serialize dictionaries on GCD — the rule is don’t bridge with sync from the middle of async/await paths.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Symptom: ‘everything is async’ but the app hangs under load.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Concept:** Serialize at the boundary without blocking the pool.

---

### T10. Whole ViewModel marked `@MainActor` with heavy decode? `(90s)`
**Answer:**

> “Then decode runs on main and the UI janks. MainActor is for UI-affined state, not ‘make the whole class safe by default.’ Decode off-main, await back to apply published state. Custom actor for non-UI caches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Annotate the smallest surface that must touch UI.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T11. After (2), are you still on the main actor? Could (3) ever run off-main? `(90–120s)`
**Answer:**

> “You’re still on @MainActor because the function is MainActor-isolated — resume stays on that actor unless you hopped elsewhere. The trap is thinking “await always jumps to background.” It doesn’t. Network work inside fetch can run elsewhere; your function resumes on MainActor. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T12. What happens to scrolling? `(90–120s)`
**Answer:**

> “You blocked the main thread. Use try await Task.sleep(nanoseconds: …) so you suspend instead. Same “wait 300ms” intent, totally different cost. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T13. Fire-and-forget leak? `(90–120s)`
**Answer:**

> “The Task keeps running. It may update self after the screen is gone (stale UI / retain). Prefer SwiftUI .task { } (cancels on disappear), or store the Task and cancel on disappear, and use [weak self] if you’re in a class that shouldn’t be kept alive. --- Next: 02-structured-concurrency.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T14. Cancel that does nothing? `(90–120s)`
**Answer:**

> “Not necessarily. Cancel only sets a flag. This loop never awaits and never checks Task.isCancelled, so it can grind through all 4000. Fix: try Task.checkCancellation each iteration (or guard !Task.isCancelled). ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
