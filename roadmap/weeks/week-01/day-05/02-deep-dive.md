# Day 05 — Deep Dive: Mechanics, Reentrancy, Sendable, Settings (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What `async` actually changes? `(45–60s)`
**Answer:**

> “An async function may contain suspension points. At each await, the function can: 1. Suspend (yield). 2. Allow the runtime to schedule other work. 3. Resume later with the awaited result (or throw).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Writing async APIs? `(45–60s)`
**Answer:**

> “swift func loadShowtimes(for venueID: String) async throws -> [Showtime] { let url = makeURL(venueID: venueID) let (data, response) = try await URLSession.shared.data(from: url) try validate(response) return try JSONDecoder.decode([Showtime].self, from: data) } Linear control flow. Errors use throws. Callers write try await loadShowtimes(for:).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Why structure matters? `(45–60s)`
**Answer:**

> “Unstructured fire-and-forget tasks are easy to start and hard to reason about: - Who cancels them when the user leaves the screen? - If one of three fetches fails, do the others keep running? - If results arrive out of order, which one wins?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. `async let` — fixed parallel children? `(45–60s)`
**Answer:**

> “swift func loadVenuePage(id: String) async throws -> VenuePage { async let details = fetchDetails(id) async let shows = fetchShowtimes(id) async let offers = fetchOffers(id) return try await VenuePage( details: details, showtimes: shows, offers: offers ) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Task groups — dynamic fan-out? `(45–60s)`
**Answer:**

> “swift func prefetchPosters(_ urls: [URL]) async -> [URL: Data] { await withTaskGroup(of: (URL, Data?).self) { group in for url in urls { group.addTask { (url, try? await download(url)) } } var out: [URL: Data] = [:] for await (url, data) in group { if let data { out[url] = data } } return out } } Use when N is dynamic. Prefer bounded concurrency patterns if N can be huge (don’t stampede the network). Semaphores are one approach; careful TaskGroup design and chunking is another — interviewers care that you name the risk.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Unstructured `Task` and `Task.detached`? `(45–60s)`
**Answer:**

> “swift @MainActor final class SearchViewModel: ObservableObject { @Published var results: [Hit] = [] private var searchTask: Task<Void, Never>? func queryChanged(_ text: String) { searchTask?.cancel searchTask = Task { do { try await Task.sleep(for: .milliseconds(300)) try Task.checkCancellation let hits = try await api.search(text) self.results = hits } catch is CancellationError { // expected under debounce } catch { // map to UI error state } } } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Model? `(45–60s)`
**Answer:**

> “Cancellation is cooperative, not preemptive thread killing: 1. Something calls task.cancel (or a parent cancels). 2. The task is marked cancelled. 3. Work stops when code: - hits a cancellable suspension that throws CancellationError, or - checks Task.isCancelled / try Task.checkCancellation, or - otherwise finishes early by convention.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. What to say about URLSession? `(45–60s)`
**Answer:**

> “- Async URLSession APIs (data(for:), bytes(for:), etc.) participate in Swift Task cancellation — cancelling the Task typically cancels the underlying request. - Callback dataTask APIs need explicit URLSessionTask.cancel plus stale-response guards if you keep that style. Don’t overclaim that “all networking magically cancels.” State the API family.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Search debounce (S3 hook)? `(45–60s)`
**Answer:**

> “Debounce without cancellation is a bug: 1. User types a, then av, then ave. 2. Three requests fly. 3. Slow a response can overwrite fresh ave results.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. Isolation basics? `(45–60s)`
**Answer:**

> “swift actor Counter { private var value = 0 func increment -> Int { value += 1 return value } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Reentrancy — the critical senior fact? `(45–60s)`
**Answer:**

> “Rule: When an actor method suspends at await, other tasks may enter the same actor before the suspended method resumes. Therefore, after await, actor state may have changed. This is intentional. Actors are reentrant at suspension points so the system doesn’t deadlock waiting for the actor while the actor waits for the world.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Actor vs class + lock vs GCD serial queue? `(45–60s)`
**Answer:**

> “Actors don’t magically solve every concurrency bug. They move the bug class from “data race on the dictionary” to “logic across suspension points” — still your job.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. `@MainActor` vs custom actors? `(45–60s)`
**Answer:**

> “Don’t make “every ViewModel an actor” as a fashion. Prefer @MainActor for UI state; use custom actors for non-UI shared mutability.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Deadlock myths? `(45–60s)`
**Answer:**

> “GCD: queue.sync on the current serial queue deadlocks. Actors: awaiting another actor (or MainActor) from an actor method suspends and allows reentrancy — different model. You can still create logical waits, priority inversions via bridges, or block thread pools by calling into synchronous locking APIs from async code. Prefer async end-to-end; avoid “sync hop to main” from a context that must stay responsive.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. What Sendable means? `(45–60s)`
**Answer:**

> “A Sendable type can be transferred across concurrency domains without introducing data races.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Value types are **not** automatically Sendable forever? `(45–60s)`
**Answer:**

> “Correct rule: > A struct/enum is Sendable when the compiler can prove it — typically when all stored properties are Sendable (and nesting obeys the same rule). Generic structs are Sendable when their Sendable-constrained parameters are.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Classes and `@unchecked Sendable`? `(45–60s)`
**Answer:**

> “Reference types need careful treatment: - Immutable classes with let Sendable stored properties can sometimes be Sendable. - Mutable classes generally need isolation (actor) or explicit synchronization. - @unchecked Sendable disables compiler proof — use only when you document and enforce the synchronization invariant (and prefer actors for new code).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Crossing boundaries? `(45–60s)`
**Answer:**

> “Prefer: 1. Send values across tasks/actors. 2. Keep mutable references inside an actor. 3. Use nonisolated carefully and sparingly for truly immutable or computed pieces.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Mixing GCD and Swift concurrency? `(45–60s)`
**Answer:**

> “Large codebases (BMS-scale) will have both. Rules of thumb:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Swift 6.2 / Approachable Concurrency / default MainActor — settings, not universal law? `(45–60s)`
**Answer:**

> “Apple has been evolving default actor isolation and Approachable Concurrency features so teams can adopt stricter checking with less boilerplate. Hard correctness rule for this handbook:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Failure modes checklist (production thinking)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Decision rules (speak these)? `(45–60s)`
**Answer:**

> “1. New shared mutable state → prefer actor (or @MainActor if UI-only). 2. Legacy stable GCD isolation that works → don’t rewrite for fashion; wrap at edges. 3. UI state → @MainActor; heavy work elsewhere. 4. Parallel known children → async let; dynamic N → TaskGroup (bound if needed). 5. Any user-driven repeated request → cancel previous Task. 6. After every await in an actor → assume state may have changed. 7. Sendable → values with Sendable stored props; isolate mutable classes. 8. Settings claims → qualify Swift 6 / Approachable Concurrency / default MainActor with “when enabled.” ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Optional citations (not required to study)? `(45–60s)`
**Answer:**

> “- Swift Book — Concurrency - WWDC: Meet async/await in Swift; Protect mutable state with Swift actors; Swift concurrency: Behind the scenes - Apple docs: Sendable, Task, actor Studying this chapter + code/SafeDictActor.swift is sufficient for Day 05 interview prep.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
