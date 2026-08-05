# Sample 03 — Actors, reentrancy, and Sendable (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is an actor, in plain words?

**Points to:** [Foundations · §2.4 Actors = a room with one conversation at a time](../01-foundations.md#24-actors--a-room-with-one-conversation-at-a-time) · [Deep dive · §4.1 Isolation basics](../02-deep-dive.md#41-isolation-basics)

**Answer:**

> An **actor** is a reference type that **isolates** its mutable state. Only one task at a time runs on the actor for isolated methods and properties. From outside you usually `await` to call in — you may wait your turn. Inside the actor you touch state without locks. Actors prevent **data races** on that isolated storage — they do not freeze time across `await` inside methods.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do I write locks for actor state? | No for isolated properties — the serial executor handles mutual exclusion. |
| Call from outside? | `await counter.increment()` — hop onto the actor’s executor. |
| vs GCD serial queue? | Same “one writer at a time” idea — compiler-enforced for actors (S2-A1). |

---

### Q2. What is reentrancy, and why do seniors miss it?

**Points to:** [Foundations · §2.4 reentrancy sentence](../01-foundations.md#24-actors--a-room-with-one-conversation-at-a-time) · [Deep dive · §4.2 Reentrancy](../02-deep-dive.md#42-reentrancy--the-critical-senior-fact)

**Answer:**

> When an actor method **suspends at `await`**, **other tasks may enter the same actor** before the suspended method resumes. State may have changed — balances, flags, generation counters. Assuming “I’m alone in the actor so nothing changed while I awaited” is a **logic bug**, even though there is no data race on storage. Actors are reentrant at suspension points **on purpose** — avoids deadlock while the actor waits on the world.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Phrase to memorize? | “Actors prevent data races on isolated state, but are reentrant at await — I re-validate after await.” |
| Wallet `spend` bug? | Refresh at `await` — another `spend` may run in between. |
| Self-check Q3 from foundations? | Yes — another call **can** interleave during `await`. |

---

### Q3. How do I harden actor code across `await`?

**Points to:** [Deep dive · §4.2 Hardening patterns](../02-deep-dive.md#hardening-patterns) · [Deep dive · §9 Decision rules](../02-deep-dive.md#9-decision-rules-speak-these)

**Answer:**

> (1) **Snapshot** into locals before `await` if you only need the old value. (2) **Re-validate invariants** after `await` — balance, flags, generation. (3) Avoid long `await`s while “logical locks” are just booleans without re-check. (4) Do heavy async work **outside**, then apply a short synchronous update on the actor. (5) Use **generation tokens** for single-flight refresh. Rule 6: after every `await` in an actor, assume state may have changed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generation pattern? | Capture `gen` before fetch; after await, apply remote balance only if `gen == generation`. |
| Boolean `isRefreshing` alone? | Fragile — another call may clear/set it during your await. |
| Interview vs “actors fix concurrency”? | They move bugs from data races to **logic across suspension**. |

---

### Q4. When do I use `@MainActor` vs a custom actor?

**Points to:** [Foundations · §2.5 `@MainActor`](../01-foundations.md#25-mainactor--this-belongs-on-the-ui-thread) · [Deep dive · §4.4 `@MainActor` vs custom actors](../02-deep-dive.md#44-mainactor-vs-custom-actors)

**Answer:**

> **`@MainActor`** — UI-affined state: ViewModels, UIKit/SwiftUI updates, main-thread expectations. **Custom `actor`** — general shared mutable state off the UI path: caches, session stores, sync engines. Do **not** run heavy CPU on main “because it’s an actor.” `@MainActor` serializes onto the **UI executor** — jank and watchdog risk if you block it.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Every ViewModel an `actor`? | Fashion, not default — prefer `@MainActor` for UI state. |
| Heavy work location? | Off main; hop back with `await MainActor.run` or `@MainActor` method for UI updates. |
| Call `@MainActor` from background? | Usually requires `await` — hop to main. |

---

### Q5. Actor vs GCD serial queue vs lock?

**Points to:** [Deep dive · §4.3 Actor vs class + lock vs GCD](../02-deep-dive.md#43-actor-vs-class--lock-vs-gcd-serial-queue) · [Foundations · §3](../01-foundations.md#3-asyncawait-vs-gcd-callbacks-first-contrast)

**Answer:**

> **GCD serial queue** — manual API discipline; `sync` on same queue deadlocks; legacy shared maps (Verified · S2). **Lock** — tiny critical sections; easy to forget unlock / ordering. **`actor`** — compiler isolation; pitfall is **reentrancy** not forgotten locks. Actors don’t replace stable GCD that works — strangler migration for new boundaries (S2-A1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Deadlock on actor await? | Different model — await **suspends** and allows reentrancy; not GCD same-queue `sync`. |
| Still deadlock risks? | Blocking pool with sync GCD, logical waits, priority issues — avoid sync main hops from async. |
| New shared mutable map? | Prefer actor (deep dive rule 1). |

---

### Q6. What does Sendable mean?

**Points to:** [Foundations · §2.6 Sendable](../01-foundations.md#26-sendable--safe-to-hand-across-concurrency-domains) · [Deep dive · §5.1 What Sendable means](../02-deep-dive.md#51-what-sendable-means)

**Answer:**

> **Sendable** means a value can cross concurrency domains — between tasks, into actors — **without introducing data races**. Prefer sending **copies (values)** or keeping **mutable references** inside actors. The compiler uses Sendable to ask: “If two tasks hold this, can they race?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crossing into an actor? | Arguments and returns often need Sendable (or isolated access via await). |
| `@unchecked Sendable`? | “Trust me, I synchronized” — compiler stops checking; prefer actor for new code. |
| `nonisolated`? | Sparingly — for truly immutable or computed pieces; know the rules. |

---

### Q7. Are all structs automatically Sendable?

**Points to:** [Deep dive · §5.2 Value types are not automatically Sendable](../02-deep-dive.md#52-value-types-are-not-automatically-sendable-forever) · [Foundations · §7 Self-check](../01-foundations.md#7-self-check-before-deep-dive)

**Answer:**

> **No.** A struct/enum is Sendable when the compiler can prove it — typically when **all stored properties are Sendable**. A struct holding a **mutable class reference** shares that reference across copies — concurrent mutation of the class is a race. **Trap:** “All value types are Sendable.” **Fix:** “Value types are Sendable when their stored properties are.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `Showtime` with `let id: String`? | Fine — Sendable fields. |
| `Wrapper { var label: MutableLabel }`? | **Not** safely Sendable — class mutability escapes. |
| Generic `Box<T>`? | Sendable when `T: Sendable` (under checking). |

---

### Q8. What should I say about Swift 6 / default MainActor settings?

**Points to:** [Deep dive · §7 Swift 6.2 / Approachable Concurrency](../02-deep-dive.md#7-swift-62--approachable-concurrency--default-mainactor--settings-not-universal-law) · [Production bridge · Bridge C](../03-production-bridge.md#bridge-c--settings-humility-swift-6)

**Answer:**

> Treat Swift 6 language mode, Approachable Concurrency, and default MainActor isolation as **project settings — when enabled** — not universal law. Under strict checking, Sendable/isolation violations can become errors. Regardless of settings, **concepts** stay: isolation domains, Sendable, actor reentrancy, structured cancellation. If asked “Does Swift 6 put everything on MainActor?” → verify target settings; write isolation explicitly for UI and shared state.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe interview opener on settings? | “Under Swift 6 checking when enabled…” |
| Universal claim to avoid? | “Every Swift app defaults to MainActor everywhere.” |
| Next sample? | Production S2 — [04-production-s2.md](04-production-s2.md) |

---

Next: [04-production-s2.md](04-production-s2.md)
