# 04 — Questions (two-layer Q&A) — Mock Warm-up + Deep Pool

> **Not skeletons.** Speak from **Answer points**; compare to **Full spoken answer**.  
> This file is self-contained for Mock #1 practice.

---

## Warm-up pool

### W1. Struct vs class? `(45s)`

**Answer points (frame first):**
- Value vs reference semantics
- Shared mutation only with classes
- Prefer struct for models; class for identity/UIKit
- Ads models value-friendly hook

**Agenda opener:** “Semantics → shared mutation → when I pick each.”

**Full spoken answer:**  
> “Structs and enums have value semantics — assignment gives an independent copy, so mutating one variable doesn’t surprise another. Classes have reference semantics — multiple names can share one instance. I default to structs for models and DTOs, and use classes when I need identity, UIKit objects, or Objective-C interop. On BookMyShow ads work, keeping render models value-friendly fits a type-safe pipeline so accidental shared mutation doesn’t corrupt revenue UI.”

**Common wrong answer:** “Structs are always faster / always stack-allocated.”

**Follow-up ladder:**
- **L1:** Struct containing a class?
- **L2:** ViewModel struct or class/`@MainActor`?
- **L3:** Actors vs classes for shared state?

**Provenance:** Verified · S1 · type-safe ads / listing models

---

### W2. What is COW? `(45s)`

**Answer points (frame first):**
- Collections share buffer on assign
- Mutation checks uniqueness
- Unique → in place; else copy then write
- Array/Dictionary/String/Set

**Agenda opener:** “Cheap share until write — then unique copy.”

**Full spoken answer:**  
> “Copy-on-write means value-typed collections like Array can share storage after assignment so the assign is cheap. On mutation, the runtime checks whether the buffer is uniquely referenced. If it is, it mutates in place; if not, it copies first. That preserves value semantics without paying a full element copy on every assignment. Trap: don’t assume two variables always see each other’s mutations.”

**Common wrong answer:** “Assignment always deep-copies every element.”

**Follow-up ladder:**
- **L1:** `isKnownUniquelyReferenced`?
- **L2:** Handmade COW wrapper?
- **L3:** COW thrash on hot path?

**Provenance:** Learning-lab · value semantics

---

### W3. weak vs unowned? `(45s)`

**Answer points (frame first):**
- weak: optional, zeroing
- unowned: non-optional, non-zeroing; crash if dangling
- Prefer weak for escaping async/UI callbacks
- unowned only when lifetimes provably nested

**Agenda opener:** “Both skip retain — they differ when the object dies.”

**Full spoken answer:**  
> “`weak` is an optional reference that doesn’t keep the object alive and becomes nil on deinit — so you guard let self. `unowned` also doesn’t keep it alive, but it isn’t optional and isn’t zeroed; use after free crashes. I use weak for network and UI callbacks where lifetime is uncertain. I only use unowned when a child cannot outlive its parent by construction.”

**Common wrong answer:** “Always unowned — it’s faster.”

**Follow-up ladder:**
- **L1:** Why is weak optional?
- **L2:** Closure cycle fix?
- **L3:** `unowned(unsafe)`?

**Provenance:** Learning-lab · ARC discipline

---

### W4. Serial vs concurrent queue? `(45s)`

**Answer points (frame first):**
- Serial: one at a time
- Concurrent: may overlap
- SafeDict uses private serial
- Main is serial for UI

**Agenda opener:** “One-at-a-time versus overlapping execution.”

**Full spoken answer:**  
> “A serial queue runs one block at a time — mutual exclusion via queue. A concurrent queue may run overlapping blocks. Main is serial and owns UI. For synchronised dictionaries at BookMyShow we used a private serial queue as the exclusion boundary so shared map access couldn’t race.”

**Common wrong answer:** “Concurrent queues make dictionaries safe.”

**Follow-up ladder:**
- **L1:** Barrier purpose?
- **L2:** QoS?
- **L3:** Actor equivalent?

**Provenance:** Verified · S2

---

### W5. async/await vs GCD? `(60s)`

**Answer points (frame first):**
- async/await: suspension points; structured concurrency
- GCD: queues schedule blocks; isolation by convention
- Actors language-isolate state
- S2 was GCD; S2-A1 actors for new code

**Agenda opener:** “Suspension and structure versus queue scheduling.”

**Full spoken answer:**  
> “GCD schedules work on queues — serial or concurrent — and you build thread safety by convention, like a serial queue around a dictionary. async/await models suspension points and pairs with structured concurrency so parent tasks own children and cancellation propagates. Actors add compiler-enforced isolation for mutable state. At BookMyShow we shipped synchronised dictionaries with GCD; for greenfield modules I’d evaluate an actor with the same safe API.”

**Common wrong answer:** “async/await always runs on a background thread” / “actors replace all GCD including timers UI.”

**Follow-up ladder:**
- **L1:** Task vs DispatchQueue.async?
- **L2:** Don’t sync-block from async contexts?
- **L3:** MainActor vs main queue?

**Provenance:** Verified · S2; How I would apply it · S2-A1

---

### W6. Thread-safe dictionary design `(90s)`

**Answer points (frame first):**
- `final class`; private storage; private serial queue
- sync get; sync set for read-after-write
- Hide queue; snapshot returns copy
- RW/barrier if read-heavy; actor coda

**Agenda opener:** “Private serial queue — safe API, no raw storage.”

**Full spoken answer:**  
> “I’d wrap the map in a `final class` with private storage and a private serial queue. Gets use sync so they can return values and respect prior work. Sets I’d sync when callers need read-after-write — async set is fire-and-forget and isn’t a completion handshake for the next line. Snapshots return a copied dictionary under sync. Never expose storage or the queue. At BookMyShow that standardized API removed races on the shared-state path; we used RW locks where read-heavy. Today I’d evaluate an actor for new modules.”

**Common wrong answer:** `Final class` / expose queue / concurrent writes without barrier / invent crash %.

**Follow-up ladder:**
- **L1:** Async write then sync read visibility?
- **L2:** Deadlock on sync re-entry?
- **L3:** Migrate to actor?

**Provenance:** Verified · S2; Learning-lab · Day 04 SafeDict

---

### W7. Actor isolation `(60s)`

**Answer points (frame first):**
- Reference type with isolated mutable state
- Cross-isolation uses await
- Prevents data races at boundary
- Reentrancy: state may change across await

**Agenda opener:** “Isolated reference type — modern serial queue.”

**Full spoken answer:**  
> “An actor is a reference type whose mutable state is isolated. External calls hop with await and the system serializes access so you don’t data-race that state. It’s the language-native version of what we did with a GCD serial queue around dictionaries. Important: after an await inside an actor method, other tasks may have run — reentrancy means you re-validate assumptions.”

**Common wrong answer:** “Actors are value types” / “no reentrancy issues.”

**Follow-up ladder:**
- **L1:** `@MainActor`?
- **L2:** Sendable interaction?
- **L3:** Actor vs class + lock?

**Provenance:** How I would apply it · S2-A1; Day 05 concepts

---

### W8. Sendable? `(45s)`

**Answer points (frame first):**
- Marker for safe sharing across concurrency domains
- Value types Sendable if stored properties are
- Classes need care / unchecked is a smell
- Compiler checks in strict modes

**Agenda opener:** “Safe to cross isolation boundaries.”

**Full spoken answer:**  
> “Sendable means a type can be safely shared across concurrency domains. Many value types are Sendable when all stored properties are. Classes aren’t automatically Sendable because of shared mutation. `@unchecked Sendable` opts out of checking — I’d treat it as a last resort with a documented invariant, not a convenience annotation.”

**Common wrong answer:** “All structs are always Sendable” (nested non-Sendable breaks it).

**Follow-up ladder:**
- **L1:** Why actors are Sendable?
- **L2:** Closures `@Sendable`?
- **L3:** Ethics of unchecked?

**Provenance:** Learning-lab · Swift concurrency

---

### W9. Retain cycle examples `(60s)`

**Answer points (frame first):**
- Object owns escaping closure capturing self strongly
- Strong delegates; Timer targets; nested captures
- Fix: `[weak self]`, weak delegates, invalidate
- Detect: Memory Graph / missing deinit — not only Leaks

**Agenda opener:** “Reachable cycle — counts never hit zero.”

**Full spoken answer:**  
> “Classic cycle: an object stores an escaping completion that strongly captures self — each owns the other. Same shape with strong delegates, repeating timers targeting self, and nested escaping closures. Fix with capture lists, weak delegates, and invalidation. Leaks instrument finds unreachable leaks; retain cycles are still reachable, so Memory Graph / Allocations matter.”

**Common wrong answer:** “Any mention of self in a closure leaks.”

**Follow-up ladder:**
- **L1:** Escaping vs non-escaping?
- **L2:** Task retaining self?
- **L3:** NotificationCenter tokens?

**Provenance:** Learning-lab · Day 03; reliability culture soft · S8

---

### W10. Main-queue deadlock `(45s)`

**Answer points (frame first):**
- main.sync from main waits for itself
- Same for any serial re-entry sync
- UI hops: main.async
- Don’t sync-block casually

**Agenda opener:** “You’re waiting for yourself.”

**Full spoken answer:**  
> “If you’re on the main queue and call `DispatchQueue.main.sync`, main blocks waiting for a block only main can run — deadlock. Any serial queue can deadlock the same way on sync re-entry. After networking I hop to main with async for UI updates rather than syncing onto main from main.”

**Common wrong answer:** “Only main can deadlock.”

**Follow-up ladder:**
- **L1:** Private serial nested sync?
- **L2:** Unlocked internals pattern?
- **L3:** async world + queue.sync danger?

**Provenance:** Learning-lab · Day 04

---

### W11. Task cancellation `(60s)`

**Answer points (frame first):**
- Cooperative: check `Task.isCancelled` / `try Task.checkCancellation`
- Structured parents cancel children
- Search debounce must cancel in-flight
- Unstructured Task needs manual lifecycle

**Agenda opener:** “Cooperative cancel — check or inherit structure.”

**Full spoken answer:**  
> “Swift task cancellation is cooperative — work should check cancellation or use APIs that throw on cancel. With structured concurrency, canceling a parent cancels children. For search-as-you-type, debouncing means cancel the in-flight request when a new keystroke arrives so late responses don’t overwrite fresh results. Fire-and-forget unstructured tasks need explicit cancel on disappear.”

**Common wrong answer:** “Cancel instantly aborts all CPU work without checks.”

**Follow-up ladder:**
- **L1:** `Task.detached` cancel behavior?
- **L2:** URLSession cancel?
- **L3:** S3 search debounce link?

**Provenance:** Verified · S3 soft for debounce product; concurrency mechanics Learning-lab

---

### W12. POP in ads pipeline `(60s)`

**Answer points (frame first):**
- Capability protocols over inheritance trees
- Generics for type-safe install/bind
- HeroWidget lifecycle for video
- No invented fill-rate %

**Agenda opener:** “Protocols and generics on the revenue path.”

**Full spoken answer:**  
> “On BookMyShow’s highest-revenue Ads module we refactored rendering around protocol-oriented contracts and generics so new creatives plugged into a type-safe pipeline instead of forking an inheritance tree. HeroWidget owned video pause and play against visibility and lifecycle. The claim is maintainability and type safety on a revenue path — not an invented fill-rate percentage.”

**Common wrong answer:** Invented metrics; “never use classes.”

**Follow-up ladder:**
- **L1:** Type erasure when?
- **L2:** associatedtype array problem?
- **L3:** Stories SDK boundary (S10)?

**Provenance:** Verified · S1

---

## Deep pool

### D1. Actor reentrancy after await `(120s)`

**Answer points (frame first):**
- Await suspends; other tasks may enter actor
- No data race on isolated storage, but logic bugs
- Re-check state after await
- load-if-missing hardening

**Trap:** “Actors prevent all concurrency bugs.”

**Full spoken answer:**  
> “Actors prevent data races on their isolated state, but they are reentrant across await. If I read a key, await a loader, then write, another task may have entered and changed that key meanwhile. The fix is to re-validate after await — check again, use a generation token, or load outside and apply a short synchronous set. I’d mention that explicitly so we don’t confuse race-freedom with logic-correctness.”

**Follow-up ladder:**
- **L1:** Contrast GCD serial queue without await?
- **L2:** Single-flight patterns?
- **L3:** Nonisolated notes?

**Provenance:** Learning-lab · Day 05 SafeDictActor

---

### D2. sync serial re-entry deadlock `(90s)`

**Answer points (frame first):**
- Nested sync on same serial queue deadlocks
- Not only main
- Unlocked internals / async nested work
- Design API to avoid re-entry

**Trap:** “Only main.sync deadlocks.”

**Full spoken answer:**  
> “Any serial queue can deadlock if you’re already executing on it and call sync again — you’re waiting for yourself. Main is the famous case, but private queues fail the same way when APIs nest. I split public sync wrappers from unlocked internals that assume they’re already on the queue, or I schedule nested work async. Debug asserts with dispatchPrecondition help.”

**Follow-up ladder:**
- **L1:** Sketch `_setUnlocked`.
- **L2:** Delegate callback while holding queue?
- **L3:** Actor contrast?

**Provenance:** Learning-lab · Day 04

---

### D3. Memory Graph cycle vs Leaks `(90s)`

**Answer points (frame first):**
- Leaks: unreachable leaked objects
- Cycles: still reachable → may not show as Leaks
- Graph visualizes ownership
- Abandoned memory still referenced

**Trap:** Treating tools as synonyms.

**Full spoken answer:**  
> “Leaks finds objects with no pointers — true leaks. A retain cycle keeps objects reachable from each other, so they may never appear as classic leaks even though they won’t deallocate. Memory Graph shows those cycles visually; Allocations helps with abandoned growth. At scale we treat that as reliability work alongside Crashlytics culture — without inventing a memory-only metric.”

**Follow-up ladder:**
- **L1:** Abandoned vs leaked?
- **L2:** deinit not called checklist?
- **L3:** Autorelease pools?

**Provenance:** Learning-lab · Day 03; soft S8 reliability

---

### D4. `@unchecked Sendable` ethics `(90s)`

**Answer points (frame first):**
- Opts out of compiler checks
- Requires documented invariant
- Prefer redesign (actor, immutable, value types)
- Code smell in reviews

**Trap:** Sprinkle unchecked to silence errors.

**Full spoken answer:**  
> “`@unchecked Sendable` tells the compiler to trust you without verifying. That’s sometimes needed at boundaries with legacy classes, but it’s an ethics and review issue — you must document the invariant that makes crossing threads safe, or you reintroduce races under a green build. I’d rather wrap mutable legacy state in an actor or expose immutable snapshots than normalize unchecked.”

**Follow-up ladder:**
- **L1:** Example justified case?
- **L2:** How to test the invariant?
- **L3:** Swift 6 strictness?

**Provenance:** Learning-lab · concurrency hygiene

---

### D5. Type erasure cost in renderer `(90s)`

**Answer points (frame first):**
- Allocation + indirection + lost specialization
- Use at heterogeneous boundaries
- Keep generics in hot pipeline
- S1 instinct: POP + generics first

**Trap:** Erase everything for cleaner types.

**Full spoken answer:**  
> “Type erasure boxes disparate conformers into one type — useful for heterogeneous ad lists — but you pay allocation, indirection, and lost generic specialization, and you often collapse associated types to a common denominator like UIView. On a revenue pipeline I’d keep generics inside and erase only at the boundary that needs heterogeneity. That matches the Ads POP + generics approach without claiming we erased every renderer.”

**Follow-up ladder:**
- **L1:** AnyPublisher analogy?
- **L2:** `any` vs hand eraser?
- **L3:** Measure in Instruments?

**Provenance:** Verified · S1 shape; Learning-lab erasure

---

### D6. COW uniqueness traps `(90s)`

**Answer points (frame first):**
- Two vars may share until mutation
- Mutation may or may not copy depending on uniqueness
- Nested class references still shared
- Don’t rely on reference-like sharing for value collections

**Trap:** Always shared or always copied.

**Full spoken answer:**  
> “After `var b = a` on an Array, they may share a buffer. Mutating `b` copies if the buffer isn’t unique — `a` stays old. If something else holds a reference that breaks uniqueness, you pay a copy. Also a struct containing a class still shares that class on ‘copy.’ I explain COW as cheap share until write, then uniqueness decides.”

**Follow-up ladder:**
- **L1:** Handmade COW?
- **L2:** Instruments?
- **L3:** Defensive copy anti-pattern?

**Provenance:** Learning-lab · Day 01

---

### D7. GCD sync inside async contexts `(90s)`

**Answer points (frame first):**
- sync blocks a thread
- Can stall cooperative thread pool
- Prefer async bridges / actors
- Don’t casually mix

**Trap:** “sync is fine everywhere for correctness.”

**Full spoken answer:**  
> “Calling `queue.sync` from an async function blocks a thread until the queue runs the block. In the cooperative concurrency model that can starve other work. Prefer awaiting an actor or using continuation-based async wrappers that schedule with async, not sync. Correctness without blocking the async world is the goal.”

**Follow-up ladder:**
- **L1:** `withCheckedContinuation` sketch?
- **L2:** When is sync still OK?
- **L3:** MainActor.assumeIsolated caveats?

**Provenance:** Learning-lab · Day 04/05 bridge

---

### D8. Migrating SafeDict GCD → actor `(120s)`

**Answer points (frame first):**
- Same API: get/set/snapshot
- Facade or module-by-module
- Call sites gain await
- Dual-run / feature flag optional
- Label Applied · S2-A1

**Trap:** “Big-bang rewrite next sprint” or claiming already done.

**Full spoken answer:**  
> “Production synchronised dictionaries used GCD — that’s Verified. How I’d migrate without big-bang: introduce an actor with the same get/set/snapshot semantics behind a protocol, move one module at a time, and let call sites await. You can keep a GCD façade temporarily that bridges to the actor for stragglers. Validate under concurrency stress like we did originally. I wouldn’t claim the migration already shipped.”

**Follow-up ladder:**
- **L1:** Sync API over actor? (generally avoid)
- **L2:** Sendable values across boundary?
- **L3:** Reentrancy in load-if-missing?

**Provenance:** Verified · S2 → How I would apply it · S2-A1

---

## Timed mock warm-up sets

| Set | Questions |
|---|---|
| A | W1 W2 W3 W4 W6 |
| B | W5 W7 W8 W10 W12 |
| C | W6 W9 W11 + D1 D2 |

Deep set: D1 D2 D3 D8 + one stretch.
