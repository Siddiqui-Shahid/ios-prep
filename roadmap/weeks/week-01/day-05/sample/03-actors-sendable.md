# Sample 03 — Actors, reentrancy, and Sendable (Q&A)

> Guided teaching. Say the **Answer** out loud. 
> **Brain puzzles** at the bottom — these are the interview favorites.

---

### Q1. What is an actor, in plain words?
**Answer:**

> “An actor is a reference type that locks its mutable state behind a door. Only one task at a time runs the actor’s isolated methods. From outside you usually `await` to get in — you might wait your turn. Inside, you touch state without writing locks yourself. Actors stop **data races** on that storage. They do **not** freeze time across an `await` inside a method — that’s reentrancy, next question.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Locks for actor state? | “Not for isolated properties — the serial executor handles mutual exclusion.” |
| Call from outside? | “`await counter.increment` — hop onto the actor.” |
| vs GCD serial queue? | “Same ‘one writer at a time’ idea — compiler-enforced for actors. Design: actor SafeDict if asked.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. What is reentrancy, and why do seniors miss it?
**Answer:**

> “When an actor method suspends at `await`, another task may enter that same actor before the first method resumes. So balances, flags, caches may have changed. There’s still no data race on the storage — but your **logic** can be wrong if you assume ‘I was alone, so nothing moved.’ Actors are reentrant at suspension points on purpose, so the actor doesn’t deadlock while waiting on the network.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Phrase to memorize? | “Actors prevent data races on isolated state, but are reentrant at await — I re-validate after await.” |
| Wallet spend bug? | “You await a refresh — another spend may run in between.” |
| Self-check? | “Can another call interleave during await? Yes.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do I harden actor code across `await`?
**Answer:**

> “Snapshot into locals before await if you only need the old value. Re-check invariants after await — balance, flags, generation. Don’t leave long awaits while a boolean ‘lock’ is set without re-checking. Do heavy async work outside, then apply a short sync update on the actor. Use generation tokens for single-flight refresh. Rule: after every await in an actor, assume state may have changed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generation pattern? | “Capture `gen` before fetch; after await, apply only if `gen == generation`.” |
| Boolean `isRefreshing` alone? | “Fragile — another call may flip it during your await.” |
| Interview framing? | “Actors move bugs from data races to logic across suspension.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. When `@MainActor` vs a custom actor?
**Answer:**

> “`@MainActor` for UI-affined state — ViewModels, UIKit/SwiftUI updates. Custom `actor` for shared mutable stuff off the UI path — caches, session stores, sync engines. Don’t run heavy CPU on main ‘because it’s an actor.’ MainActor serializes onto the UI executor — you’ll get jank or watchdogs if you block it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Every VM an `actor`? | “Fashion, not default. Prefer `@MainActor` for UI state.” |
| Heavy work? | “Off main; hop back with `await MainActor.run` or a MainActor method.” |
| Call MainActor from background? | “Usually needs `await` — hop to main.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Actor vs GCD serial queue vs lock?
**Answer:**

> “GCD serial queue — manual discipline; `sync` on the same queue deadlocks; that’s what we shipped for BookMyShow synchronised dictionaries. Locks — fine for tiny critical sections; easy to forget unlock or ordering. Actor — compiler isolation; the pitfall becomes reentrancy, not forgotten locks. Actors don’t mean rewrite every stable GCD module — strangler migration for new boundaries. Design: actor SafeDict if they ask.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Deadlock on actor await? | “Different model — await suspends and allows reentrancy; not same-queue GCD sync.” |
| Still hang risks? | “Blocking the pool with sync GCD, or syncing to main from async.” |
| New shared map? | “Prefer an actor.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. What does Sendable mean?
**Answer:**

> “Sendable means ‘this value can cross concurrency domains without introducing a data race.’ Prefer sending copies — values — or keep mutable references inside actors. The compiler is basically asking: if two tasks hold this, can they race?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crossing into an actor? | “Args and returns often need Sendable, or you only touch them via await.” |
| `@unchecked Sendable`? | “‘Trust me, I synchronized’ — compiler stops checking. Prefer an actor for new code.” |
| `nonisolated`? | “Sparingly — for truly immutable or carefully designed pieces.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Are all structs automatically Sendable?
**Answer:**

> “No. A struct is Sendable when the compiler can prove it — usually when **all stored properties** are Sendable. A struct holding a mutable class still shares that class across copies. Concurrent mutation of the class is a race. Trap phrase: ‘All value types are Sendable.’ Correct phrase: ‘Value types are Sendable when their stored properties are.’”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `Showtime` with `let id: String`? | “Fine — Sendable fields.” |
| Wrapper holding a mutable class? | “Not safely Sendable.” |
| Generic `Box<T>`? | “Sendable when `T: Sendable`.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What about Swift 6 / default MainActor settings?
**Answer:**

> “Treat Swift 6 language mode, Approachable Concurrency, and default MainActor isolation as **project settings when enabled** — not universal law. Under strict checking, Sendable and isolation mistakes become errors. The concepts stay the same either way: isolation domains, Sendable, reentrancy, structured cancellation. If they ask ‘Does Swift 6 put everything on MainActor?’ — I say it depends on target settings, and I write isolation explicitly for UI and shared state.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe opener? | “‘Under Swift 6 checking when enabled…’” |
| Claim to avoid? | “‘Every Swift app defaults to MainActor everywhere.’” |
| Next sample? | [04-production-s2.md](04-production-s2.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q9. Sendable across modules / public classes?
**Answer:**

> “Across modules, Sendable is a design problem. If a public class isn’t Sendable, don’t slap `@unchecked` just to call an actor. Prefer Sendable value DTOs at the boundary, or keep the reference inside an isolated domain and only expose async methods that return values. UIKit types: hop to MainActor — don’t pretend `UIView` is a free Sendable token.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generics? | “Constrain to `Sendable` where values cross tasks.” |
| `@MainActor` public class? | “Callers must await; document isolation.” |
| Trap? | “‘Ignore library types; only my models need Sendable.’” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Does awaiting MainActor from an actor deadlock like GCD?
**Answer:**

> “People map GCD instincts onto actors wrongly. With GCD, syncing onto the queue you’re already on deadlocks. Awaiting MainActor from a custom actor is different — your actor method suspends, reentrancy can happen, and MainActor work can proceed. You can still hang yourself with `DispatchQueue.main.sync` from the pool, or long circular waits. Prefer async hops end-to-end. And while you await MainActor, other tasks may enter your actor — re-validate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When hop? | “Publishing UI state owned on MainActor.” |
| Reverse hop? | “MainActor awaiting a cache actor — fine if you don’t block.” |
| Wrong absolute claim? | “‘Never call MainActor from an actor or you’ll always deadlock.’” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Explain reentrancy with the “private office” story?
**Answer:**

> “Think of an actor as a private office. People knock with await — one person talks at a time. If that person steps out to take a phone call — that’s an await on the network — someone else can enter the office before the first person returns. When the first person comes back, the desk may look different. That’s reentrancy. No two people shout over each other at the desk — no data race — but your notes on the whiteboard may have changed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why allow that? | “So the actor doesn’t deadlock while waiting on the outside world.” |
| What do you do? | “Re-read the desk when you return — re-validate after await.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. What decision rules do you actually speak?
**Answer:**

> “One: new shared mutable state → prefer an actor, or MainActor if it’s UI-only. Two: legacy GCD that works → don’t rewrite for fashion; wrap at edges. Three: UI state on MainActor; heavy work elsewhere. Four: known small parallel kids → async let; dynamic N → TaskGroup, bound if needed. Five: any repeated user request → cancel the previous Task. Six: after every await in an actor → assume state changed. Seven: Sendable means values with Sendable stored props; isolate mutable classes. Eight: Swift 6 / Approachable Concurrency / default MainActor — say ‘when enabled.’”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which one trips juniors most? | “Six — reentrancy — and five — cancel.” |
| Which one trips overclaimers? | “Eight — settings humility — and two — no big-bang.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Design: actor SafeDict (not shipped)

---

### Q13. Prefer `MainActor.run` or `DispatchQueue.main.sync`?
**Answer:**

> “From async code I prefer `await MainActor.run { … }` or calling a `@MainActor` function. Sync hops to main are how you deadlock or stall. Same idea as Day 04: don’t bridge with sync from a context that must stay responsive.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Already on MainActor? | “Then just mutate — no hop needed.” |
| Custom actor awaiting MainActor? | “Fine asynchronously — your actor suspends; re-validate when you resume.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q14. Narrate SafeDictActor like you’re reading the file aloud?
**Answer:**

> “It’s an actor with Sendable Key and Value. get, set, remove, snapshot, merge — snapshot returns a value copy so callers can’t race the interior. There’s a brokenLoadIfMissing teaching method: await a loader, then re-check storage before set, because another task may have filled the key during await. Interview pitch: production maps at BMS used GCD queues; for greenfield I’d expose this actor surface. Learning-lab only — I don’t claim this file shipped.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why Sendable bounds? | “Values cross isolation domains; the compiler needs that proof.” |
| Why snapshot? | “Never hand out the live dictionary reference.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** SafeDictActor.swift — not production source.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Wallet double-spend (classic reentrancy)

```swift
actor Wallet {
 var balance = 100

 func spend(_ amount: Int) async throws {
 guard balance >= amount else { throw Err.insufficient }
 await bank.authorize(amount) // suspension
 balance -= amount // safe?
 }
}
```

Two `spend(80)` calls start nearly together. What can go wrong?

**Answer:** Both can pass `guard` while balance is 100. Each awaits authorize. After resume, both subtract → balance goes negative or inconsistent. **No data race**, but a **logic bug**. Fix: re-check balance after await, or authorize then apply in a short critical section, or use a generation / reservation model.

---

### Puzzle B — Image cache after await

```swift
actor ImageCache {
 var store: [URL: Data] = [:]

 func image(for url: URL) async throws -> Data {
 if let hit = store[url] { return hit }
 let data = try await download(url)
 store[url] = data // always overwrite?
 return data
 }
}
```

Two tasks request the same URL. What happens?

**Answer:** Both miss, both download (wasted work). After await, either may overwrite. Better: re-check `store[url]` after download; if someone else filled it, return that. Single-flight / generation helps too.

---

### Puzzle C — “Sendable struct” that isn’t

```swift
final class Counter { var n = 0 }
struct Box { var counter: Counter }
```

Is `Box` safely Sendable? Can two tasks race?

**Answer:** **Not safely Sendable.** Copies of `Box` share the same `Counter` class. Two tasks mutating `n` race. Value type wrapper ≠ safe crossing.

---

### Puzzle D — Whole class on MainActor

```swift
@MainActor
final class FeedVM {
 func decodeHugeJSON(_ data: Data) { … } // heavy
 func apply(_ items: [Item]) { … } // UI
}
```

What’s wrong?

**Answer:** Heavy decode runs on main → jank. Mark only UI bits MainActor, or decode off-main and hop back for `apply`.

---

Next: [04-production-s2.md](04-production-s2.md)
