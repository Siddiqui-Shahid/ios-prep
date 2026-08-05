# Sample 02 — Structured concurrency and cancellation (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is structured concurrency?

**Points to:** [Foundations · §2.3 Structured concurrency = parent owns children](../01-foundations.md#23-structured-concurrency--parent-owns-children) · [Deep dive · §2.1 Why structure matters](../02-deep-dive.md#21-why-structure-matters)

**Answer:**

> Async work forms a **tree**: a parent starts children and does not finish until they finish or are cancelled. Cancellation and errors can propagate along that tree. The scope that started the work **owns** it — so when the user leaves a screen, you know what to cancel. Unstructured fire-and-forget Tasks escape that tree; you manage lifetime yourself.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Plain analogy? | Like a function waiting for two helpers before returning — but for async children. |
| What goes wrong without structure? | Work outlives the screen; stale results win; failures leave orphans running. |
| Interview one-liner? | “Parent owns children — cancellation propagates.” |

---

### Q2. When do I use `async let` vs TaskGroup?

**Points to:** [Deep dive · §2.2 `async let`](../02-deep-dive.md#22-async-let--fixed-parallel-children) · [Deep dive · §2.3 Task groups](../02-deep-dive.md#23-task-groups--dynamic-fan-out)

**Answer:**

> **`async let`** — fixed, small fan-out (e.g. load details, showtimes, and offers together). Children start concurrently; parent awaits them at scope exit. **`withTaskGroup`** — dynamic **N** items (prefetch N poster URLs). Prefer bounding concurrency when N is huge — don’t stampede the network. Both are structured: parent cancel hits children.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `async let` error handling? | If a child throws, parent `try await` surfaces it — structure keeps errors in one place. |
| TaskGroup collection pattern? | `for await` over group results into a dictionary or array. |
| Interview risk to name? | Unbounded TaskGroup on thousands of URLs — say you’d chunk or cap. |

---

### Q3. What is unstructured concurrency, and when is it OK?

**Points to:** [Foundations · §2.2](../01-foundations.md#22-tasks-are-units-of-asynchronous-work) · [Deep dive · §2.4 Unstructured `Task`](../02-deep-dive.md#24-unstructured-task-and-taskdetached)

**Answer:**

> **`Task { … }`** and **`Task.detached`** start work outside a strict parent/child scope. You must store handles, plan cancellation, and decide isolation yourself. **OK at sync boundaries** — button taps, legacy UIKit entry. **Avoid** deep inside reusable async APIs where `async let` or TaskGroup express ownership clearly. Search typing that forgets cancel is the classic bug.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `Task.detached` default? | **No** — rare, truly independent background work; pass Sendable values explicitly. |
| MainActor inheritance? | `Task { }` from `@MainActor` often runs closure on main — behavior can interact with language settings; be explicit for UI mutations. |
| Prefer inside async APIs? | Structured concurrency — not naked `Task { }` buried in helpers. |

---

### Q4. How does Task cancellation work?

**Points to:** [Deep dive · §3.1 Model](../02-deep-dive.md#31-model) · [Foundations · §5 Glossary · Cooperative cancellation](../01-foundations.md#5-glossary-study-until-these-feel-boring)

**Answer:**

> Cancellation is **cooperative**, not preemptive. Something calls `task.cancel()` (or a parent cancels). The task is **marked** cancelled. Work stops when code hits a cancellable `await` that throws `CancellationError`, or checks `Task.isCancelled` / `try Task.checkCancellation()`, or exits early by convention. A tight CPU loop with no checks may ignore cancel.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Preemptive like `pthread_cancel`? | **No** — Swift concurrency does not kill threads mid-instruction. |
| `CancellationError` in debounce? | Often **expected** — ignore or catch separately from real errors. |
| Parent cancelled — children? | Structured children receive cancellation too — they must cooperate. |

---

### Q5. Why must search debounce cancel in-flight work?

**Points to:** [Deep dive · §3.3 Search debounce](../02-deep-dive.md#33-search-debounce-s3-hook) · [Production bridge · §3 Verified · S3](../03-production-bridge.md#3-verified--s3--search-debounce-and-task-cancellation)

**Answer:**

> User types `a`, then `av`, then `ave` — three requests fly. A slow `a` response can **overwrite** fresh `ave` results if you only delay with sleep. Fix: on each keystroke **cancel the previous Task**, start a new one (debounce sleep + fetch), optionally track a generation token. Verified · S3 at BookMyShow: debounce **plus** explicit loading/empty/error state and MVVM — cancellation is part of the product behavior.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debounce = only `sleep(300ms)`? | **No** — senior piece is cancel + ignore stale responses. |
| Store Task where? | ViewModel property — `searchTask?.cancel()` before creating the next. |
| ≤20s interview line? | “Debounced and cancelled the previous in-flight Task so older responses couldn’t win.” |

---

### Q6. What about URLSession and cancellation?

**Points to:** [Deep dive · §3.2 What to say about URLSession](../02-deep-dive.md#32-what-to-say-about-urlsession)

**Answer:**

> **Async** URLSession APIs (`data(for:)`, etc.) participate in Swift Task cancellation — cancelling the Task typically cancels the underlying request. **Callback** `dataTask` APIs need explicit `URLSessionTask.cancel()` plus stale-response guards if you keep that style. Do not overclaim “all networking magically cancels” — state the API family you use.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Belt-and-suspenders for search? | Generation token or “only apply if query still matches” after await. |
| Async vs callback migration? | Async path composes with structured cancel; callbacks need manual wiring. |
| Stale guard without cancel? | Possible but fragile — cancel is the primary fix. |

---

### Q7. What failure modes should I name?

**Points to:** [Deep dive · §8 Failure modes checklist](../02-deep-dive.md#8-failure-modes-checklist-production-thinking) · [Deep dive · §9 Decision rules](../02-deep-dive.md#9-decision-rules-speak-these)

**Answer:**

> **Fire-and-forget Task** — work after VC gone; stale UI. **Debounce without cancel** — out-of-order search. **Blocking GCD sync in async** — pool starvation. Mitigations: store + cancel Task; `[weak self]` / `@MainActor` VM patterns; async facades instead of sync hops. Rule 5 from deep dive: any user-driven repeated request → cancel previous Task.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| VC dismissed while Task runs? | Cancel in `deinit` or on disappear; weak self if closure captures UI. |
| Parallel known children? | `async let`; dynamic N → TaskGroup (bounded). |
| After this sample topic? | Actors and Sendable — [03-actors-sendable.md](03-actors-sendable.md). |

---

### Q8. Structured vs unstructured — how do I choose in an interview?

**Points to:** [Deep dive · §2.4 interview line](../02-deep-dive.md#24-unstructured-task-and-taskdetached) · [Production bridge · §3 Tie-back](../03-production-bridge.md#tie-back-to-day-05-vocabulary)

**Answer:**

> “Prefer structured concurrency inside async APIs — `async let` or TaskGroup so the parent owns children and cancel propagates. Use unstructured `Task` only at sync boundaries like UI actions, and **always** plan cancellation when the user can repeat the action quickly — search is the textbook case.” Tie S3: unstructured Task at VM boundary + cooperative cancel on each query change.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Inside `loadVenuePage`? | Structured — `async let` for parallel fetches. |
| Button tap? | Unstructured bridge — `Task { await … }`. |
| Next sample file? | [03-actors-sendable.md](03-actors-sendable.md) |

---

Next: [03-actors-sendable.md](03-actors-sendable.md)
