# Day 05 — Deep Dive: Mechanics, Reentrancy, Sendable, Settings

> Senior-depth, still self-contained. Assumes [01-foundations.md](01-foundations.md).

---

## 1. Suspension, resume, and “which thread?”

### 1.1 What `async` actually changes

An `async` function may contain **suspension points**. At each `await`, the function can:

1. Suspend (yield).
2. Allow the runtime to schedule other work.
3. Resume later with the awaited result (or throw).

Important clarifications:

- **Not every `await` suspends.** If the callee can complete synchronously (already satisfied, cached, same actor already available), resume may be immediate. Still treat `await` as a **logical** boundary: state you care about may be stale after it.
- **`await` does not mean “background thread.”** It means “possible suspension.” Where you resume depends on actor isolation and the callee’s executor.
- **Threads ≠ tasks.** Many tasks can multiplex onto a thread pool. Blocking inside async code (e.g. heavy `sync` GCD, long locks) can starve the pool.

### 1.2 Writing async APIs

```swift
func loadShowtimes(for venueID: String) async throws -> [Showtime] {
    let url = makeURL(venueID: venueID)
    let (data, response) = try await URLSession.shared.data(from: url)
    try validate(response)
    return try JSONDecoder().decode([Showtime].self, from: data)
}
```

Linear control flow. Errors use `throws`. Callers write `try await loadShowtimes(for:)`.

Compared to callback style, you gain readability and composition. You still must design **cancellation**, **timeouts**, and **main-actor hops** explicitly for UI.

---

## 2. Structured concurrency in depth

### 2.1 Why structure matters

Unstructured fire-and-forget tasks are easy to start and hard to reason about:

- Who cancels them when the user leaves the screen?
- If one of three fetches fails, do the others keep running?
- If results arrive out of order, which one wins?

Structured APIs answer: **the scope that started the work owns it.**

### 2.2 `async let` — fixed parallel children

```swift
func loadVenuePage(id: String) async throws -> VenuePage {
    async let details = fetchDetails(id)
    async let shows = fetchShowtimes(id)
    async let offers = fetchOffers(id)

    return try await VenuePage(
        details: details,
        showtimes: shows,
        offers: offers
    )
}
```

- Starts children concurrently.
- The enclosing function awaits them (explicitly or at scope exit).
- If the parent is cancelled, children are cancelled.
- Great for a **known small fan-out**.

### 2.3 Task groups — dynamic fan-out

```swift
func prefetchPosters(_ urls: [URL]) async -> [URL: Data] {
    await withTaskGroup(of: (URL, Data?).self) { group in
        for url in urls {
            group.addTask {
                (url, try? await download(url))
            }
        }
        var out: [URL: Data] = [:]
        for await (url, data) in group {
            if let data { out[url] = data }
        }
        return out
    }
}
```

Use when **N is dynamic**. Prefer bounded concurrency patterns if N can be huge (don’t stampede the network). Semaphores are one approach; careful TaskGroup design and chunking is another — interviewers care that you **name the risk**.

### 2.4 Unstructured `Task` and `Task.detached`

```swift
@MainActor
final class SearchViewModel: ObservableObject {
    @Published var results: [Hit] = []
    private var searchTask: Task<Void, Never>?

    func queryChanged(_ text: String) {
        searchTask?.cancel()
        searchTask = Task {
            do {
                try await Task.sleep(for: .milliseconds(300))
                try Task.checkCancellation()
                let hits = try await api.search(text)
                self.results = hits
            } catch is CancellationError {
                // expected under debounce
            } catch {
                // map to UI error state
            }
        }
    }
}
```

Notes:

- `Task { }` from a `@MainActor` context commonly inherits MainActor isolation for the closure body (**behavior can interact with language mode / settings** — see §7). Prefer being explicit about where UI mutations happen.
- Store the `Task` handle so you can **cancel**.
- `Task.detached` does **not** inherit actor isolation the same way; use rarely, and pass Sendable values explicitly.

**Interview line:** Prefer structured concurrency inside async APIs; use unstructured Tasks only at sync boundaries (UI actions), and always plan cancellation.

---

## 3. Task cancellation (cooperative)

### 3.1 Model

Cancellation is **cooperative**, not preemptive thread killing:

1. Something calls `task.cancel()` (or a parent cancels).
2. The task is marked cancelled.
3. Work stops when code:
   - hits a cancellable suspension that throws `CancellationError`, or
   - checks `Task.isCancelled` / `try Task.checkCancellation()`, or
   - otherwise finishes early by convention.

If you run a tight CPU loop with no checks and no cancellable awaits, cancellation may appear “ignored.”

### 3.2 What to say about URLSession

- **Async** URLSession APIs (`data(for:)`, `bytes(for:)`, etc.) participate in Swift Task cancellation — cancelling the Task typically cancels the underlying request.
- **Callback** `dataTask` APIs need **explicit** `URLSessionTask.cancel()` plus stale-response guards if you keep that style.

Don’t overclaim that “all networking magically cancels.” State the API family.

### 3.3 Search debounce (S3 hook)

Debounce without cancellation is a bug:

1. User types `a`, then `av`, then `ave`.
2. Three requests fly.
3. Slow `a` response can overwrite fresh `ave` results.

Fix pattern:

- Cancel the previous Task on each keystroke (after scheduling a new one).
- Optionally track a generation token as belt-and-suspenders.
- Ignore `CancellationError` as success-path noise.

> **Provenance:** Verified · S3 · BookMyShow · search debounce, state, MVVM

---

## 4. Actors — isolation and reentrancy

### 4.1 Isolation basics

```swift
actor Counter {
    private var value = 0

    func increment() -> Int {
        value += 1
        return value
    }
}
```

From outside:

```swift
let c = Counter()
let v = await c.increment()
```

The actor’s serial executor ensures isolated state isn’t accessed concurrently. You do not write locks for `value`.

### 4.2 Reentrancy — the critical senior fact

**Rule:** When an actor method suspends at `await`, **other tasks may enter the same actor** before the suspended method resumes. Therefore, **after `await`, actor state may have changed.**

This is intentional. Actors are reentrant at suspension points so the system doesn’t deadlock waiting for the actor while the actor waits for the world.

#### Broken intuition

```swift
actor Wallet {
    private var balance: Int
    private var isRefreshing = false

    init(balance: Int) { self.balance = balance }

    func spend(_ amount: Int) async throws {
        if balance < amount {
            // BUG intuition: "I'm alone in the actor, so balance stays put
            // while I refresh."
            await refreshFromServer()   // ← suspension: others can interleave
            // balance / flags may have changed here
        }
        guard balance >= amount else { throw WalletError.insufficient }
        balance -= amount
    }

    func refreshFromServer() async {
        // pretend network
    }
}
```

Across `await refreshFromServer()`, another `spend` (or another mutator) may run. Assuming `balance` is unchanged is a **logic race** even though there is no data race on the storage.

#### Hardening patterns

1. **Snapshot into locals** before await when you only need the old value.
2. **Re-validate invariants** after await (re-check balance, generation, flags).
3. **Avoid long awaits while holding “logical locks”** expressed only as boolean flags — flags can be wrong after reentry unless carefully designed.
4. **Perform non-isolated async work outside**, then apply a short, synchronous state update on the actor.
5. Prefer **idempotent** transitions and version tokens for refresh/single-flight designs.

```swift
actor Wallet {
    private var balance: Int
    private var generation = 0

    init(balance: Int) { self.balance = balance }

    func spend(_ amount: Int) async throws {
        if balance < amount {
            let gen = generation
            let remote = await fetchRemoteBalance() // non-isolated async work
            // Re-check: did someone else refresh or spend while we were away?
            if gen == generation {
                balance = remote
                generation += 1
            }
        }
        guard balance >= amount else { throw WalletError.insufficientFunds }
        balance -= amount
    }

    private func fetchRemoteBalance() async -> Int { /* network */ 0 }
}

enum WalletError: Error { case insufficientFunds }
```

**Interview phrase to memorize:**
> “Actors prevent data races on isolated state, but they are reentrant at await points — I always re-validate state after await.”

### 4.3 Actor vs class + lock vs GCD serial queue

| Tool | Enforcement | Reentrancy / pitfalls | Best fit |
|---|---|---|---|
| GCD serial queue | Manual API discipline | `sync` to same queue deadlocks; easy to expose raw storage | Legacy shared maps (S2) |
| Lock (`NSLock`, etc.) | Manual | Priority inversion, forgotten unlock, lock ordering | Tiny critical sections |
| `actor` | Compiler isolation | State may change across `await` | New shared mutable state (S2-A1) |

Actors don’t magically solve every concurrency bug. They move the bug class from “data race on the dictionary” to “logic across suspension points” — still your job.

### 4.4 `@MainActor` vs custom actors

| | `@MainActor` | Custom `actor` |
|---|---|---|
| Purpose | UI-affined state and UIKit/SwiftUI updates | General shared mutable state |
| Executor | Main actor | Actor’s own serial executor |
| Heavy work | Avoid — jank / watchdog risk | OK if work is appropriately chunked / offloaded |
| Typical types | ViewModels, UI coordinators | Caches, session stores, sync engines |

Don’t make “every ViewModel an actor” as a fashion. Prefer `@MainActor` for UI state; use custom actors for **non-UI** shared mutability.

### 4.5 Deadlock myths

GCD: `queue.sync` on the **current** serial queue deadlocks.

Actors: awaiting another actor (or MainActor) from an actor method **suspends** and allows reentrancy — different model. You can still create **logical waits**, priority inversions via bridges, or block thread pools by calling into synchronous locking APIs from async code. Prefer async end-to-end; avoid “sync hop to main” from a context that must stay responsive.

---

## 5. Sendable — precise rules

### 5.1 What Sendable means

A `Sendable` type can be transferred across concurrency domains without introducing data races.

### 5.2 Value types are **not** automatically Sendable forever

**Correct rule:**

> A struct/enum is Sendable when the compiler can prove it — typically when **all stored properties are Sendable** (and nesting obeys the same rule). Generic structs are Sendable when their `Sendable`-constrained parameters are.

```swift
struct Showtime: Sendable {
    let id: String
    let startsAt: Date
}

struct Box<T> {
    var value: T
}
// Box<T>: Sendable where T: Sendable  (when conforming / inferred under checking)
```

Counterexample:

```swift
final class MutableLabel {
    var text: String
    init(_ text: String) { self.text = text }
}

struct Wrapper {
    var label: MutableLabel  // class reference inside a struct
}
```

`Wrapper` is a value type, but copying the struct **shares** the class reference. Concurrent mutation of `label.text` is a race. `Wrapper` is **not** safely Sendable just because it is a struct.

**Trap to kill in interviews:** “All value types are Sendable.”  
**Replace with:** “Value types are Sendable when their stored properties are.”

### 5.3 Classes and `@unchecked Sendable`

Reference types need careful treatment:

- Immutable classes with `let` Sendable stored properties can sometimes be Sendable.
- Mutable classes generally need isolation (actor) or explicit synchronization.
- `@unchecked Sendable` disables compiler proof — use only when you **document and enforce** the synchronization invariant (and prefer actors for new code).

### 5.4 Crossing boundaries

Prefer:

1. Send **values** across tasks/actors.
2. Keep **mutable references** inside an actor.
3. Use `nonisolated` carefully and sparingly for truly immutable or computed pieces.

---

## 6. Mixing GCD and Swift concurrency

Large codebases (BMS-scale) will have both.

Rules of thumb:

- Don’t call `DispatchQueue.main.sync` from async code that may already be on main or from thread-pool threads in ways that deadlock or block.
- Prefer `await MainActor.run { … }` / `@MainActor` functions over sync main hops.
- Blocking the cooperative thread pool with long `sync` work reduces concurrency throughput.
- When wrapping legacy queue-based APIs, expose `async` facades with continuations — and ensure continuation resume-once correctness.

Migration is usually **strangler-fig**: leave stable GCD modules alone; adopt actors/`async` at new boundaries (S2-A1 mindset).

---

## 7. Swift 6.2 / Approachable Concurrency / default MainActor — settings, not universal law

Apple has been evolving **default actor isolation** and **Approachable Concurrency** features so teams can adopt stricter checking with less boilerplate.

**Hard correctness rule for this handbook:**

> Treat Swift 6 language mode, Approachable Concurrency, and “default MainActor isolation” as **project/toolchain settings**. Say **“when enabled”** or **“under Swift 6 checking”**. Do **not** claim they are how every Swift program behaves worldwide.

What you *can* say safely in interviews:

1. Under **complete concurrency checking** / Swift 6 mode (**when enabled**), crossing isolation without Sendable/isolation annotations becomes errors instead of warnings.
2. Some Xcode / Swift settings can default UI-facing code toward MainActor isolation (**when enabled**) — know that your project’s build settings matter.
3. Regardless of settings, the **concepts** remain: isolation domains, Sendable, actor reentrancy, structured cancellation.

If asked “Does Swift 6 put everything on MainActor?”:

> “Not universally. Default isolation behavior depends on language mode and concurrency settings. I verify the target’s settings and write isolation explicitly for shared mutable state and UI boundaries.”

---

## 8. Failure modes checklist (production thinking)

| Failure | Symptom | Mitigation |
|---|---|---|
| Fire-and-forget Task | Work after VC gone; stale UI updates | Store + cancel; `[weak self]` / MainActor VM patterns |
| Debounce without cancel | Out-of-order search results | Cancel previous Task (S3) |
| Reentrancy assumption | Corrupt balances/flags after await | Re-validate; short critical updates |
| `@unchecked Sendable` lie | Intermittent crashes under load | Prefer actor; prove sync |
| Heavy work on `@MainActor` | Scroll jank, hangs | Offload CPU; hop back for UI |
| Blocking GCD sync in async | Pool starvation, ANRs-like hangs | Async facades |
| Big-bang GCD→actor rewrite | Regressions | Strangler migration (S2-A1) |

---

## 9. Decision rules (speak these)

1. **New shared mutable state** → prefer `actor` (or `@MainActor` if UI-only).
2. **Legacy stable GCD isolation that works** → don’t rewrite for fashion; wrap at edges.
3. **UI state** → `@MainActor`; heavy work elsewhere.
4. **Parallel known children** → `async let`; **dynamic N** → TaskGroup (bound if needed).
5. **Any user-driven repeated request** → cancel previous Task.
6. **After every `await` in an actor** → assume state may have changed.
7. **Sendable** → values with Sendable stored props; isolate mutable classes.
8. **Settings claims** → qualify Swift 6 / Approachable Concurrency / default MainActor with “when enabled.”

---

## 10. Optional citations (not required to study)

- Swift Book — Concurrency
- WWDC: Meet async/await in Swift; Protect mutable state with Swift actors; Swift concurrency: Behind the scenes
- Apple docs: `Sendable`, `Task`, `actor`

Studying this chapter + `code/SafeDictActor.swift` is sufficient for Day 05 interview prep.
