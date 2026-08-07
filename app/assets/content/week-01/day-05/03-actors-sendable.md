# Sample 03 — Actors, reentrancy, and Sendable (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is an actor, in plain words?

**Answer:**

> An **actor** is a reference type that **isolates** its mutable state. Only one task at a time runs on the actor for isolated methods and properties. From outside you usually `await` to call in — you may wait your turn. Inside the actor you touch state without locks. Actors prevent **data races** on that isolated storage — they do not freeze time across `await` inside methods.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do I write locks for actor state? | No for isolated properties — the serial executor handles mutual exclusion. |
| Call from outside? | `await counter.increment()` — hop onto the actor’s executor. |
| vs GCD serial queue? | Same “one writer at a time” idea — compiler-enforced for actors (Design: actor SafeDict (not shipped)). |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. What is reentrancy, and why do seniors miss it?

**Answer:**

> When an actor method **suspends at `await`**, **other tasks may enter the same actor** before the suspended method resumes. State may have changed — balances, flags, generation counters. Assuming “I’m alone in the actor so nothing changed while I awaited” is a **logic bug**, even though there is no data race on storage. Actors are reentrant at suspension points **on purpose** — avoids deadlock while the actor waits on the world.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Phrase to memorize? | “Actors prevent data races on isolated state, but are reentrant at await — I re-validate after await.” |
| Wallet `spend` bug? | Refresh at `await` — another `spend` may run in between. |
| Self-check Q3 from foundations? | Yes — another call **can** interleave during `await`. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do I harden actor code across `await`?

**Answer:**

> (1) **Snapshot** into locals before `await` if you only need the old value. (2) **Re-validate invariants** after `await` — balance, flags, generation. (3) Avoid long `await`s while “logical locks” are just booleans without re-check. (4) Do heavy async work **outside**, then apply a short synchronous update on the actor. (5) Use **generation tokens** for single-flight refresh. Rule 6: after every `await` in an actor, assume state may have changed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generation pattern? | Capture `gen` before fetch; after await, apply remote balance only if `gen == generation`. |
| Boolean `isRefreshing` alone? | Fragile — another call may clear/set it during your await. |
| Interview vs “actors fix concurrency”? | They move bugs from data races to **logic across suspension**. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. When do I use `@MainActor` vs a custom actor?

**Answer:**

> **`@MainActor`** — UI-affined state: ViewModels, UIKit/SwiftUI updates, main-thread expectations. **Custom `actor`** — general shared mutable state off the UI path: caches, session stores, sync engines. Do **not** run heavy CPU on main “because it’s an actor.” `@MainActor` serializes onto the **UI executor** — jank and watchdog risk if you block it.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Every ViewModel an `actor`? | Fashion, not default — prefer `@MainActor` for UI state. |
| Heavy work location? | Off main; hop back with `await MainActor.run` or `@MainActor` method for UI updates. |
| Call `@MainActor` from background? | Usually requires `await` — hop to main. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Actor vs GCD serial queue vs lock?

**Answer:**

> **GCD serial queue** — manual API discipline; `sync` on same queue deadlocks; legacy shared maps (BookMyShow synchronised dictionaries). **Lock** — tiny critical sections; easy to forget unlock / ordering. **`actor`** — compiler isolation; pitfall is **reentrancy** not forgotten locks. Actors don’t replace stable GCD that works — strangler migration for new boundaries (Design: actor SafeDict (not shipped)).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Deadlock on actor await? | Different model — await **suspends** and allows reentrancy; not GCD same-queue `sync`. |
| Still deadlock risks? | Blocking pool with sync GCD, logical waits, priority issues — avoid sync main hops from async. |
| New shared mutable map? | Prefer actor (deep dive rule 1). |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. What does Sendable mean?

**Answer:**

> **Sendable** means a value can cross concurrency domains — between tasks, into actors — **without introducing data races**. Prefer sending **copies (values)** or keeping **mutable references** inside actors. The compiler uses Sendable to ask: “If two tasks hold this, can they race?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crossing into an actor? | Arguments and returns often need Sendable (or isolated access via await). |
| `@unchecked Sendable`? | “Trust me, I synchronized” — compiler stops checking; prefer actor for new code. |
| `nonisolated`? | Sparingly — for truly immutable or computed pieces; know the rules. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Are all structs automatically Sendable?

**Answer:**

> **No.** A struct/enum is Sendable when the compiler can prove it — typically when **all stored properties are Sendable**. A struct holding a **mutable class reference** shares that reference across copies — concurrent mutation of the class is a race. **Trap:** “All value types are Sendable.” **Fix:** “Value types are Sendable when their stored properties are.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `Showtime` with `let id: String`? | Fine — Sendable fields. |
| `Wrapper { var label: MutableLabel }`? | **Not** safely Sendable — class mutability escapes. |
| Generic `Box<T>`? | Sendable when `T: Sendable` (under checking). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What should I say about Swift 6 / default MainActor settings?

**Answer:**

> Treat Swift 6 language mode, Approachable Concurrency, and default MainActor isolation as **project settings — when enabled** — not universal law. Under strict checking, Sendable/isolation violations can become errors. Regardless of settings, **concepts** stay: isolation domains, Sendable, actor reentrancy, structured cancellation. If asked “Does Swift 6 put everything on MainActor?” → verify target settings; write isolation explicitly for UI and shared state.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe interview opener on settings? | “Under Swift 6 checking when enabled…” |
| Universal claim to avoid? | “Every Swift app defaults to MainActor everywhere.” |
| Next sample? | Production BookMyShow synchronised dictionaries — [04-production-s2.md](04-production-s2.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q9. How do you handle Sendable across modules / public classes?

**Answer:**

> Module boundaries make Sendable a **design** problem, not a checkbox. If a public class from another module isn’t Sendable, don’t paper over it with `@unchecked` just to call an actor. Prefer **Sendable value DTOs** at the boundary, or keep the reference inside an isolated domain and only expose async methods that return values. Under Swift 6 checking when enabled, crossings surface as errors — good pressure. UIKit types: hop to `@MainActor` rather than pretending `UIView` is a free Sendable token.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generic APIs? | Constrain to `Sendable` where values cross tasks. |
| `@MainActor` public class? | Callers must `await`; document isolation. |
| Trap answer? | “Ignore library types; only my models need Sendable.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Does awaiting MainActor from an actor deadlock like GCD?

**Answer:**

> People map GCD deadlock instincts onto actors incorrectly. With GCD, **syncing onto the queue you’re already on** deadlocks. Awaiting `@MainActor` from a custom actor is different — your actor method **suspends**, which allows reentrancy, and MainActor work can proceed. You can still create poor designs: blocking with `DispatchQueue.main.sync` from thread-pool async code, or long circular waits. Prefer async hops end-to-end; keep actor mutations short after returning from MainActor work. While awaiting MainActor, other tasks may enter your actor — re-validate state.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When hop needed? | Publishing UI state owned on MainActor. |
| Reverse hop? | MainActor awaiting custom actor for cache — fine if not blocking. |
| Wrong absolute claim? | “Never call MainActor from an actor or you’ll always deadlock.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [04-production-s2.md](04-production-s2.md)

---

