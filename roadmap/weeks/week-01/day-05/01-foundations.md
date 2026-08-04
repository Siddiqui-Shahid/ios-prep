# Day 05 — Foundations: async/await, Tasks, Actors, Sendable

> Read this first. Intern-friendly mental models, then a short bridge to senior vocabulary.  
> Deep mechanics live in [02-deep-dive.md](02-deep-dive.md).

---

## 1. Why this day exists

Yesterday (Day 04) you learned **GCD**: queues, `sync`/`async`, and how a serial queue can protect a shared dictionary. That pattern shipped at BookMyShow as **synchronised dictionaries** (Verified · S2).

Today is the **modern language-native** half of the same problem:

- How do you write asynchronous work without callback pyramids?
- How do you keep parent/child work structured so cancellation and errors make sense?
- How do you protect shared mutable state with an `actor` instead of (or after) a GCD serial queue?
- How does the compiler help you avoid data races with `Sendable`?

You do **not** throw GCD away. Large apps mix both. The senior skill is knowing which tool for which boundary — and how to migrate safely.

---

## 2. Plain-English mental model

### 2.1 “Async” means “I might pause here”

An `async` function can **suspend**. Suspension is not the same as blocking a thread.

| Idea | What it means |
|---|---|
| **Blocking** | A thread sits idle waiting (e.g. `DispatchQueue.sync` waiting, or a lock held). That thread can’t do other useful work. |
| **Suspending** | The async function yields. The runtime may reuse the thread for other work. Later, the function **resumes** where it left off. |

When you write:

```swift
let (data, response) = try await URLSession.shared.data(from: url)
```

you are saying: “Fetch this URL. While waiting for the network, don’t hold a thread hostage. When the response is ready, continue.”

**Intern takeaway:** `await` marks a **possible pause point**. Code after `await` may run later — possibly on a different executor/thread — and other concurrent work may have progressed in between.

### 2.2 Tasks are units of asynchronous work

A **Task** is “a piece of async work the system can schedule.”

You will see three common shapes:

| Shape | Plain meaning | When to reach for it |
|---|---|---|
| `async` function + `await` | Call async work from another async context | Inside structured async code |
| `Task { … }` | Bridge from **synchronous** code (e.g. a button handler) into async | UI entry points, “start this work” |
| `Task.detached { … }` | Start work that does **not** inherit the parent’s actor/priority/task-local context the same way | Rare — truly independent background work |

**Intern takeaway:** Prefer staying inside structured async calls. Use `Task { }` when you must leave the sync world. Treat `Task.detached` as a sharp tool, not a default.

### 2.3 Structured concurrency = parent owns children

**Structured concurrency** means asynchronous work forms a **tree**:

- A parent starts children.
- The parent does not finish until children finish (or are cancelled).
- Cancellation and error handling can propagate along that tree.

Analogy: a function that calls two helpers waits for both before returning. Structured concurrency is that idea for async work.

| API | Role |
|---|---|
| `async let` | Fixed, small number of parallel children |
| `withTaskGroup` / `withThrowingTaskGroup` | Dynamic fan-out (N items) |
| Unstructured `Task { }` | Escapes the tree — you own lifetime and cancellation yourself |

**Intern takeaway:** If you start work with plain `Task { }` and forget to cancel it, that work can outlive the screen that started it. Search typing is the classic interview example (Verified · S3 debounce).

### 2.4 Actors = a room with one conversation at a time

An **actor** is a reference type that **isolates** its mutable state.

- Only one task at a time executes on the actor (for its isolated methods/properties).
- From **outside**, calling into an actor usually requires `await` (you may need to wait your turn).
- From **inside**, you can touch the actor’s state without locks.

Analogy: a private office. People knock (`await`). One person talks at a time. When that person steps out to wait for a phone call (`await` something else), **someone else can enter the office** before the first person returns. That last sentence is **reentrancy** — the single most-missed senior interview point. Deep dive covers it fully.

**Intern takeaway:** Actors prevent *data races on the actor’s isolated state*. They do **not** freeze time across `await` points inside actor methods.

### 2.5 `@MainActor` = “this belongs on the UI thread”

UIKit and much of SwiftUI expect UI updates on the **main** actor/thread.

`@MainActor` marks types or functions as isolated to the main actor. Calling them from elsewhere typically requires `await` (a hop to main).

**Intern takeaway:** Put UI-facing ViewModel state on `@MainActor`. Do **not** put heavy CPU work on main “because it’s an actor.” Actors serialize access; `@MainActor` specifically serializes onto the UI executor.

### 2.6 Sendable = “safe to hand across concurrency domains”

`Sendable` means a value can safely cross isolation boundaries (e.g. into an actor, or between tasks) without creating data races.

Rough beginner rule (refined in the deep dive):

- Immutable value types whose **stored properties are all Sendable** can be Sendable.
- Classes are harder: mutable shared classes are usually **not** Sendable unless carefully synchronized or made into actors.
- `@unchecked Sendable` means “trust me, I synchronized this” — the compiler stops checking.

**Intern takeaway:** Sendable is the compiler’s way of asking, “If two tasks hold this, can they race?” Prefer sending **values** (copies) or isolating **references** inside actors.

---

## 3. async/await vs GCD callbacks (first contrast)

| Concern | GCD / callbacks | async/await |
|---|---|---|
| Control flow | Nested closures, “pyramid of doom” | Linear `try await` |
| Errors | Error params / Result in each callback | `throws` / `try` |
| Cancellation | Manual (`URLSessionTask.cancel`, flags) | Cooperative Task cancellation (plus API participation) |
| Shared state | Queues, locks, barriers | Actors + Sendable (and still GCD where legacy) |
| Mental model | “Which queue am I on?” | “Which isolation domain am I in?” |

Both schedule work. Async/await is not automatically faster. It is usually **clearer** and **composable** with structured concurrency.

Day 04 serial-queue dictionaries remain valid. Day 05 asks: for **new** shared mutable maps, would an `actor` be a cleaner API? (How I would apply it · S2-A1.)

---

## 4. A tiny end-to-end picture

```text
[Button tap — sync world]
        │
        ▼
   Task { @MainActor in          ← unstructured bridge from UI
        await viewModel.search(query)
   }

[ViewModel @MainActor]
   cancel previous search Task   ← cooperative cancel (S3-style debounce)
   store new Task {
        try await Task.sleep(...)  ← debounce delay
        let results = try await api.search(query)
        self.results = results     ← still on MainActor if VM is
   }

[API / actor SafeDict]
   await safeDict.set(key, value)  ← isolated mutation
```

You do not need to memorize this diagram. You need to **narrate** it: UI entry → Task bridge → cancel previous work → await network → hop back to main for UI state → isolate shared caches in actors if needed.

---

## 5. Glossary (study until these feel boring)

| Term | Definition |
|---|---|
| **Suspension** | Async function pauses at `await`; may resume later without blocking a thread the whole time |
| **Executor** | Runtime component that runs jobs (e.g. main actor executor, actor’s serial executor) |
| **Isolation** | Compiler/runtime rule: which code may touch which mutable state |
| **Actor** | Reference type with isolated mutable state; serialized access |
| **Reentrancy** | After `await` inside an actor method, other work may have run on that actor; state may have changed |
| **Structured concurrency** | Parent/child task hierarchy with scoped lifetimes |
| **Unstructured Task** | `Task { }` / detached work you must manage yourself |
| **Cooperative cancellation** | Cancelled tasks keep running until they check cancellation or hit a cancellable `await` |
| **Sendable** | Type safe to share across concurrency domains |
| **`@MainActor`** | Isolation to the main actor (UI affinity) |
| **Approachable Concurrency** | Optional/compiler-settings direction that can change default isolation behavior — treat as **settings**, not always-on language law |
| **Data race** | Concurrent unsynchronized read/write (or write/write) of shared mutable state — undefined/bad behavior |
| **Race condition** | Broader logic bug from ordering; may exist even without a data race |

---

## 6. What “good” sounds like in an interview (preview)

**30s definition:**
> “async/await lets a function suspend at await points instead of nesting callbacks. Structured concurrency keeps child tasks under a parent so cancellation propagates. Actors isolate shared mutable state; after an await inside an actor, I re-check state because of reentrancy.”

**90s production bridge:**
> “At BookMyShow we fixed shared-dictionary races with GCD serial queues and a closed API — Verified S2. For greenfield modules I’d expose the same get/set surface on a Swift actor — S2-A1. For search, debounce isn’t just a timer; you cancel the previous Task so stale responses can’t win — S3.”

Full spoken answers are in [04-questions.md](04-questions.md).

---

## 7. Self-check before deep dive

Answer these aloud in one sentence each:

1. Does `await` always mean “jump to a background thread”?
2. What happens to child work when a structured parent is cancelled?
3. Can another call interleave on an actor while one method is suspended at `await`?
4. Are all structs automatically `Sendable`?
5. Is “Swift 6 defaults everything to MainActor” a safe universal claim?

Expected answers (short):

1. No — it means a suspension point; resume executor depends on context.
2. Cancellation propagates; children should stop cooperatively.
3. Yes — that is reentrancy; state may change.
4. No — only if all stored properties are Sendable (and other Sendable rules apply).
5. No — default MainActor isolation / Approachable Concurrency are **settings when enabled**.

If any answer felt fuzzy, keep that question in mind while reading [02-deep-dive.md](02-deep-dive.md).
