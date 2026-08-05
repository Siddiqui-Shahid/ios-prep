# Sample 03 — Actors and classes (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. When is a class the right tool?

**Points to:** [Foundations · §4.1 When a class is the right tool](../01-foundations.md#41-when-a-class-is-the-right-tool) · [Deep dive · §5.2 When a model should be a class](../02-deep-dive.md#52-when-a-model-should-be-a-class)

**Answer:**

> Use a class when you need **identity** — the same service instance shared across the app, UIKit/AppKit objects, `===` checks, or ObjC/KVO runtime requirements. Otherwise prefer values plus a single owner (ViewModel, store). “One session object everyone must see updates on” is the rare legitimate class model case.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Shared `APIClient`? | **Class** — one identity, one connection pool / config. |
| Listing row render data? | **Struct** — copy semantics unless you have a proven identity need. |
| HeroWidget pause/play? | **Class** concern — lifecycle and visibility tied to a reference-type surface. |

---

### Q2. What is an actor in one sentence?

**Points to:** [Foundations · §7 Actors — intro](../01-foundations.md#7-actors--intro-only-day-05-goes-deep) · [Deep dive · §6.1 Actor vs class](../02-deep-dive.md#61-actor-vs-class)

**Answer:**

> An **actor** is a reference type whose mutable state is **isolated** — you talk to it with `await`, and the runtime serializes access so concurrent tasks cannot data-race on its storage. Enough for Day 01: isolated reference type; await to touch state; prevents data races. Day 05 goes deeper on hops and reentrancy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minimal API shape? | `await counter.increment()` — cross-actor calls suspend until the actor can run. |
| Do actors replace all classes? | **No** — UIKit stays class; actors isolate specific shared mutable cores. |
| What not to say today? | “Every ViewModel should be an actor” or deep reentrancy theory. |

---

### Q3. How is an actor different from a plain class?

**Points to:** [Deep dive · §6.1 Actor vs class](../02-deep-dive.md#61-actor-vs-class) · [Foundations · §7.1 What problem actors solve](../01-foundations.md#71-what-problem-actors-solve)

**Answer:**

> Both are reference types. A **class** lets any task mutate shared properties if you forget synchronization — data races are your bug. An **actor** makes isolation part of the type system: mutable state is only accessible on the actor’s executor, usually via `await`. Inheritance is limited compared to classes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Call site difference? | Class: direct calls. Actor: often **`await`** on mutating or isolated access. |
| Same heap identity idea? | Yes — actors are reference types; you don’t copy them like structs. |
| If I already use a lock? | Actor is the language-native version of “one serial gate around this state.” |

---

### Q4. How does an actor relate to a GCD serial queue?

**Points to:** [Foundations · §7.2 Soft bridge from production](../01-foundations.md#72-soft-bridge-from-production) · [Deep dive · §6.2 Actor vs serial queue](../02-deep-dive.md#62-actor-vs-serial-queue-s2-bridge) · [Production bridge · S2](../03-production-bridge.md#5-verified--s2--applied--s2-a1--actors-bridge)

**Answer:**

> At BookMyShow, shared mutable maps were protected with **GCD serial queues** (**Verified · S2**). Soft interview line: where you serialized dictionary access with a serial queue, a Swift **`actor`** is the language-native equivalent you’d evaluate for new code — same API surface idea, compile-time isolation instead of convention. **Applied · S2-A1** is greenfield redesign; do not claim you rewrote production unless you did.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Serial queue downside? | Easy to misuse `sync` and deadlock; no compile-time isolation. |
| Actor downside? | Requires concurrency adoption; await hops; learning curve. |
| 45s actor intro shape? | Race → isolation → bridge to serial queue. |

---

### Q5. Why not make every ViewModel an actor?

**Points to:** [Deep dive · §6.3 Why not every ViewModel is an actor](../02-deep-dive.md#63-why-not-every-viewmodel-is-an-actor) · [Deep dive · §7.1 Type choice](../02-deep-dive.md#71-type-choice)

**Answer:**

> UI must update on the **main actor**. Common pattern: `@MainActor final class SearchViewModel` with `@Published` state. A custom `actor` for every VM adds **await noise** at every bind site. Isolate the **shared mutable store** — caches, in-flight maps — and keep UI-facing models on `@MainActor`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What belongs in an actor? | Shared map of in-flight requests, session cache mutated from background tasks. |
| What stays `@MainActor`? | Screen state, SwiftUI/ObservableObject bindings, anything the UI reads directly. |
| Failure mode? | Actor on every type → contorted call sites for no gain. |

---

### Q6. What is `@MainActor` vs a custom actor?

**Points to:** [Foundations · §8 Glossary](../01-foundations.md#8-glossary-pin) · [Deep dive · §6.3](../02-deep-dive.md#63-why-not-every-viewmodel-is-an-actor)

**Answer:**

> **`@MainActor`** is an **isolation domain** for main-thread / UI work — related to actors but aimed at UI affinity, not a general-purpose shared store. A **custom actor** serializes its own state on its executor. Use `@MainActor` for ViewModels and UI types; use a dedicated actor when background tasks share mutable state that must not race.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can a class be `@MainActor`? | Yes — typical for UI ViewModels. |
| Heavy work on `@MainActor` VM? | Don’t block main — offload work, hop back to publish state. |
| Day 01 depth on reentrancy? | Awareness only: during `await`, other actor work may run — details on Day 05. |

---

### Q7. What goes wrong with class instances in a Set or Dictionary key?

**Points to:** [Deep dive · §5.1 Hashing classes](../02-deep-dive.md#51-hashing-classes)

**Answer:**

> Prefer stable **ID-based** `Hashable` or identity via `ObjectIdentifier`. **Never mutate** fields that participate in `hash(into:)` while the object sits in a collection — undefined behavior, lost entries, weird lookups. If selection state changes, hash on stable `id` only, not on `isSelected`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Seat selection example? | Hash `id`; toggle `isSelected` without changing hash input. |
| Symptom? | Object “disappears” from Set after mutation. |
| Struct in Set? | Value hash — copy semantics, different failure modes. |

---

### Q8. What failure modes should you name in an interview?

**Points to:** [Deep dive · §8 Failure modes checklist](../02-deep-dive.md#8-failure-modes-checklist) · [Deep dive · §9 Spoken templates](../02-deep-dive.md#9-spoken-agenda--answer-templates)

**Answer:**

> Class used for DTO → flaky UI after “copy.” Nested class in struct → surprising shared side effects. Assume array assign deep-copies → wrong perf or wrong mental model. Boolean UI state → impossible screens. Actor on every type → contorted APIs. Mutating hashed fields in Set → lost objects. Fix mindset: match type to semantics, audit nested refs, isolate the real concurrent core.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Struct vs class 45s template? | Semantics → mutation → S1 example: structs for models, classes for UIKit/services. |
| COW 45s template? | Share → uniqueness check → mutate; trust stdlib in hot paths. |
| Enum state 45s template? | Impossible states out → exhaustiveness → payment popup design. |

---

Next: [04-production-s1-s7.md](04-production-s1-s7.md)
