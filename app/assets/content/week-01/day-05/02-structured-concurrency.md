# Sample 02 — Structured concurrency and cancellation (Q&A)

> Guided teaching. Say the **Answer** out loud.  
> **Brain puzzles** at the bottom — cover → think → check.

---

### Q1. What is structured concurrency?

**Answer:**

> “Think of async work as a tree. A parent starts children and doesn’t finish until those children finish or get cancelled. Cancel and errors can travel down that tree. The scope that started the work owns it — so when the user leaves a screen, you know what to cancel. Unstructured fire-and-forget Tasks escape that tree. Then you’re on your own for lifetime.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Plain analogy? | “Like a function waiting for two helpers before returning — but for async children.” |
| Without structure? | “Work outlives the screen. Stale results win. Orphans keep running.” |
| One-liner? | “Parent owns children — cancellation propagates.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. When do I use `async let` vs TaskGroup?

**Answer:**

> “`async let` when I know a small fixed set — load details, showtimes, and offers together. Kids start together; I await them when the scope ends. `withTaskGroup` when N is dynamic — prefetch N poster URLs. If N can be huge, I say I’d cap concurrency so we don’t stampede the network. Both are structured: cancel the parent and the kids get the cancel signal.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Errors with `async let`? | “If a child throws, the parent’s `try await` surfaces it — one place for errors.” |
| Collecting TaskGroup results? | “`for await` over the group into an array or dictionary.” |
| Interview risk? | “Unbounded group on thousands of URLs — say you’d chunk or cap.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is unstructured concurrency, and when is it OK?

**Answer:**

> “`Task { … }` and `Task.detached` start work outside a strict parent/child scope. You store the handle, plan cancel, and decide isolation yourself. That’s fine at sync boundaries — button taps, old UIKit entry points. Avoid burying naked `Task { }` deep inside reusable async APIs where `async let` or TaskGroup already say who owns the work. Search typing that forgets cancel is the classic bug.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Detached by default? | “No. Rare. Truly independent background work. Pass Sendable values explicitly.” |
| MainActor inheritance? | “`Task { }` from MainActor often runs on main — be explicit for UI mutations.” |
| Prefer inside async APIs? | “Structured — not fire-and-forget helpers.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How does Task cancellation work?

**Answer:**

> “Cancellation is cooperative — not ‘kill the thread now.’ Something calls `task.cancel()`, or a parent cancels. The task gets marked cancelled. Work actually stops when you hit a cancellable `await` that throws `CancellationError`, or you check `Task.isCancelled` / `try Task.checkCancellation()`, or you exit early on purpose. A tight CPU loop with no checks can ignore cancel completely.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Like pthread kill? | “No. Swift concurrency doesn’t yank the thread mid-instruction.” |
| `CancellationError` in debounce? | “Often expected — don’t treat it like a real failure.” |
| Parent cancelled — children? | “Structured kids get the signal too — they still have to cooperate.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Why must search debounce cancel in-flight work?

**Answer:**

> “User types `a`, then `av`, then `ave`. Three requests fly. If the slow `a` comes back last, it can overwrite the fresh `ave` results. Sleep alone doesn’t fix that. On each keystroke I cancel the previous Task, start a new one — debounce sleep plus fetch — and sometimes I also keep a generation token. At BookMyShow, backend-driven header & search: debounce plus clear loading/empty/error state in MVVM. Cancellation is part of the product behavior, not a nice-to-have.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debounce = only sleep? | “No. The senior piece is cancel + ignore stale responses.” |
| Where store Task? | “ViewModel property — cancel before starting the next.” |
| ≤20s line? | “Debounced and cancelled the previous in-flight Task so older responses couldn’t win.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What about URLSession and cancellation?

**Answer:**

> “Async URLSession APIs like `data(for:)` participate in Task cancellation — cancel the Task and the request usually cancels too. Old callback `dataTask` style needs explicit `URLSessionTask.cancel()` and stale-response guards. I don’t claim ‘all networking magically cancels’ — I say which API family I’m on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Belt-and-suspenders? | “Generation token, or only apply if the query still matches after await.” |
| Migrating callbacks? | “Async path composes with structured cancel. Callbacks need manual wiring.” |
| Stale guard without cancel? | “Possible but fragile. Cancel is the primary fix.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What failure modes should I name?

**Answer:**

> “Fire-and-forget Task — work after the VC is gone, stale UI. Debounce without cancel — out-of-order search. Blocking GCD sync inside async — pool starvation. Fixes: store and cancel the Task; weak self / MainActor VM patterns; async façades instead of sync hops. Rule I use: any user-driven repeated request → cancel the previous Task.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| VC dismissed mid-Task? | “Cancel on disappear or deinit; weak self if the closure captures UI.” |
| Parallel known children? | “`async let`. Dynamic N → TaskGroup, preferably bounded.” |
| Next sample? | Actors — [03-actors-sendable.md](03-actors-sendable.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Structured vs unstructured — how do I choose?

**Answer:**

> “Prefer structured concurrency inside async APIs — `async let` or TaskGroup — so the parent owns the kids and cancel propagates. Use unstructured `Task` only at sync boundaries like UI actions. And when the user can repeat the action quickly — search — always plan cancellation. That’s the BookMyShow search story: unstructured Task at the VM boundary, cooperative cancel on every query change.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Inside `loadVenuePage`? | “Structured — `async let` for parallel fetches.” |
| Button tap? | “Unstructured bridge — `Task { await … }`.” |
| Next file? | [03-actors-sendable.md](03-actors-sendable.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q9. What do you say about Task priority / QoS?

**Answer:**

> “Tasks carry priority and often inherit from the parent — same spirit as caring about GCD QoS, different knobs. Keep interactive UI work responsive. Don’t casually run bulk prefetch at the highest priority. Set priority on purpose for true background work, and don’t assume the runtime will save you from heavy decoding on MainActor.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Detached priority? | “You can set it — still don’t starve UI.” |
| Inherit? | “Usually yes for `Task { }`. Detached is independent.” |
| Bridge from GCD QoS? | “Same judgment: urgency vs battery — different APIs.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Why is GCD `sync` inside async risky?

**Answer:**

> “Swift concurrency multiplexes many tasks onto a thread pool. If async code calls `DispatchQueue.sync` and blocks, you can starve that pool and hang. Sync onto main is especially sharp — deadlock or long stalls. In mixed codebases I wrap legacy queue APIs with async façades using continuations, resume exactly once, and avoid sync bridges from async paths. At BMS we still have GCD dictionary isolation — the lesson is serialize at the boundary without blocking the world.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is sync OK? | “Tiny known sync contexts — not as the spine of your async design.” |
| Prefer instead? | “Continuations, actors, async methods end-to-end.” |
| Symptom? | “Hang, watchdog, or ‘async but everything stalled.’” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Walk a real search ViewModel like you’d code it

**Answer:**

> “I’d keep a `@MainActor` ViewModel with a stored `searchTask`. On each query change I cancel the old task, then start a new one. Inside: sleep for debounce, `try Task.checkCancellation()`, await the API, assign results. I catch `CancellationError` as normal — not an error banner. Other errors map to UI error state. That’s the BookMyShow search shape: unstructured Task at the UI boundary, cooperative cancel on every keystroke.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why MainActor VM? | “Published UI state stays on main while the Task cancels and restarts.” |
| Generation token? | “Optional belt-and-suspenders — only apply if the query still matches.” |
| Invent 300ms from prod? | “No. I may demo 300ms in a lab; I don’t claim a production constant.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Don’t claim:** Invented debounce milliseconds from production.

---

### Q12. What failure modes should I name in production thinking?

**Answer:**

> “Fire-and-forget Task — work after the screen is gone, stale UI. Debounce without cancel — out-of-order search. Reentrancy assumption — balances or flags wrong after await. Unchecked Sendable lie — intermittent crashes. Heavy work on MainActor — jank. Blocking GCD sync inside async — pool starvation. Big-bang GCD-to-actor rewrite — regressions. Mitigations: store and cancel; re-validate after await; prefer actors for new mutability; offload CPU; async façades; strangler migration.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One rule that covers search? | “Any user-driven repeated request → cancel the previous Task.” |
| One rule for actors? | “After every await in an actor → assume state may have changed.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped) — strangler, not big-bang.

---

### Q13. How do you wrap a legacy GCD API into async?

**Answer:**

> “I expose an async façade with a continuation. The GCD callback resumes the continuation — and I resume exactly once. No double-resume, no forget-to-resume. From async code I await that façade. I avoid calling `DispatchQueue.sync` from the middle of async/await paths, especially sync to main. Prefer `await MainActor.run` or a MainActor method for UI hops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why resume-once? | “Double resume crashes; never resume leaves the await hung forever.” |
| Still use GCD underneath? | “Yes — strangler. Stable queue stays; new callers see async.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Concept:** Serialize at the boundary without blocking the cooperative pool.

---

### Q14. `async let` venue page — say it like a story

**Answer:**

> “Loading a venue page I need details, showtimes, and offers — fixed three. I write three `async let`s so they start together, then `try await` them into one page model. If the parent is cancelled — user left — the children get cancelled too. That’s structured fan-out for a known small set. If I’m prefetching N poster URLs, that’s TaskGroup, and I name the stampede risk and cap concurrency.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One child throws? | “The parent’s try await surfaces it; structure keeps errors in one place.” |
| Cap how? | “Chunk URLs, or limit in-flight adds — interviewers care that you name the risk.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q15. Timeouts — what do you say?

**Answer:**

> “Async/await doesn’t magically give you timeouts. I design them — race the work against `Task.sleep` in a group or use API-level timeouts — and cancel the loser. Same cooperative story: cancel must actually stop the work.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Search timeout? | “Cancel the search Task; show error or empty; don’t leave a hung spinner.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Cancel that does nothing

```swift
Task {
    for photo in hugeLibrary {          // 4000 items
        renderThumbnail(photo)          // pure CPU, no await
    }
}
// later:
task.cancel()
```

User left the screen. Does work stop?

**Answer:** **Not necessarily.** Cancel only sets a flag. This loop never awaits and never checks `Task.isCancelled`, so it can grind through all 4000. Fix: `try Task.checkCancellation()` each iteration (or `guard !Task.isCancelled`).

---

### Puzzle B — Debounce sleep only

```swift
searchTask = Task {
    try await Task.sleep(for: .milliseconds(300))
    let results = try await api.search(q)
    self.results = results
}
// next keystroke starts another Task but never cancels the old one
```

What goes wrong?

**Answer:** Older searches still finish and can overwrite newer results. **Cancel the previous Task** on each keystroke. Sleep alone is not debounce.

---

### Puzzle C — Child that outlives the parent?

```swift
func load() async {
    Task { await prefetchAllPosters() }  // unstructured inside async
    await loadPage()
}
```

Parent `load` returns. Prefetch?

**Answer:** Prefetch keeps running — unstructured. Prefer `async let` / TaskGroup so prefetch is a child and cancels with the parent, or deliberately store/cancel that Task if you really want it independent.

---

### Puzzle D — `.task` vs `onAppear + Task`

Why do reviewers prefer SwiftUI `.task { }` over `onAppear { Task { } }`?

**Answer:** `.task` ties lifetime to the view — appear starts, disappear cancels, and cancel can propagate. Bare `onAppear` Tasks are easy to orphan.

---

Next: [03-actors-sendable.md](03-actors-sendable.md)
