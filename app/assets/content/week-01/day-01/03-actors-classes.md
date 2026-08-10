# Sample 03 — Actors and classes (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> Each answer ends with **How can I relate to my case** using named work — never S-codes. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. When is a class the right tool?
**Answer:**

> “Use a class when you need identity — the same service instance shared across the app, UIKit or AppKit objects, triple-equals checks, or ObjC and KVO runtime requirements. Otherwise prefer values plus a single owner — ViewModel, store. ‘One session object everyone must see updates on’ is the rare legitimate class model case.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Shared APIClient? | “Class — one identity, one connection pool or config.” |
| Listing row render data? | “Struct — copy semantics unless you have a proven identity need.” |
| HeroWidget pause/play? | “Class concern — lifecycle and visibility tied to a reference-type surface.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle (for the lifecycle / identity angle)
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. What is an actor in one sentence?
**Answer:**

> “An actor is a reference type whose mutable state is isolated — you talk to it with await, and the runtime serializes access so concurrent tasks cannot data-race on its storage. Enough for Day 01: isolated reference type; await to touch state; prevents data races. Day 05 goes deeper on hops and reentrancy — today, awareness: after await, state may have changed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minimal API shape? | “`await counter.increment` — cross-actor calls suspend until the actor can run.” |
| Do actors replace all classes? | “No — UIKit stays class; actors isolate specific shared mutable cores.” |
| What not to say today? | “‘Every ViewModel should be an actor’ — that’s a trap.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How is an actor different from a plain class?
**Answer:**

> “Both are reference types. A class lets any task mutate shared properties if you forget synchronization — data races are your bug. An actor makes isolation part of the type system: mutable state is only accessible on the actor’s executor, usually via await. Inheritance is limited compared to classes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Call site difference? | “Class: direct calls. Actor: often await on mutating or isolated access.” |
| Same heap identity idea? | “Yes — actors are reference types; you don’t copy them like structs.” |
| If I already use a lock? | “Actor is the language-native version of ‘one serial gate around this state.’” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How does an actor relate to a GCD serial queue?
**Answer:**

> “At BookMyShow, shared mutable maps were protected with GCD serial queues — BookMyShow synchronised dictionaries. Soft interview line: where you serialized dictionary access with a serial queue, a Swift actor is the language-native equivalent you’d evaluate for new code — same API surface idea, compile-time isolation instead of convention. Design: actor SafeDict is greenfield redesign; do not claim you rewrote production unless you did. And don’t migrate a stable queue module just for fashion — strangler at boundaries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Serial queue downside? | “Easy to misuse sync and deadlock; no compile-time isolation.” |
| Actor downside? | “Requires concurrency adoption; await hops; reentrancy across await; learning curve.” |
| When *not* to migrate? | “Stable closed API, proven under load, team still on mixed GCD — leave it; actor for greenfield.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. Why not make every ViewModel an actor?
**Answer:**

> “UI must update on the main actor. Common pattern: `@MainActor final class SearchViewModel` with published state. A custom actor for every VM adds await noise at every bind site. Isolate the shared mutable store — caches, in-flight maps — and keep UI-facing models on MainActor.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What belongs in an actor? | “Shared map of in-flight requests, session cache mutated from background tasks.” |
| What stays on MainActor? | “Screen state, SwiftUI bindings, anything the UI reads directly.” |
| Failure mode? | “Actor on every type → contorted call sites for no gain.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is `@MainActor` vs a custom actor?
**Answer:**

> “MainActor is an isolation domain for main-thread and UI work — related to actors but aimed at UI affinity, not a general-purpose shared store. A custom actor serializes its own state on its executor. Use MainActor for ViewModels and UI types; use a dedicated actor when background tasks share mutable state that must not race.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can a class be MainActor? | “Yes — typical for UI ViewModels.” |
| Heavy work on MainActor VM? | “Don’t block main — offload work, hop back to publish state.” |
| Reentrancy awareness? | “During await, other actor work may run — re-check state after resume. Details deepen on Day 05.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Actor reentrancy — what must you say on Day 01?
**Answer:**

> “Actors prevent data races on isolated storage, but they are reentrant at await. While your method is suspended, another task can enter the same actor and change fields. No data race — still a logic bug if you trust pre-await snapshots blindly. Awareness today; wallet and cache deep dives on Day 05.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One phrase? | “Prevents data races; reentrant at await — re-validate.” |
| Fix mindset? | “Re-read state after await; keep mutations short; single-flight where needed.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What goes wrong with class instances in a Set or Dictionary key?
**Answer:**

> “Prefer stable ID-based Hashable, or identity via ObjectIdentifier. Never mutate fields that participate in hash(into:) while the object sits in a collection — undefined behavior, lost entries, weird lookups. If selection state changes, hash on stable id only, not on isSelected. ObjectIdentifier is ‘same instance’; ID-based is ‘same business key across instances.’”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Seat selection example? | “Hash id; toggle isSelected without changing hash input.” |
| Symptom? | “Object ‘disappears’ from Set after mutation.” |
| ObjectIdentifier vs ID? | “ObjectIdentifier for true identity; ID when logical equality across instances matters.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. What failure modes should you name in an interview?
**Answer:**

> “Class used for DTO → flaky UI after ‘copy.’ Nested class in struct → surprising shared side effects. Assume array assign deep-copies → wrong perf or wrong mental model. Boolean UI state → impossible screens. Actor on every type → contorted APIs. Mutating hashed fields in Set → lost objects. Fix mindset: match type to semantics, audit nested refs, isolate the real concurrent core.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Struct vs class 45s? | “Semantics → mutation → BookMyShow Ads pipeline + HeroWidget: structs for models, classes for UIKit and services.” |
| COW 45s? | “Share → uniqueness check → mutate; trust stdlib in hot paths.” |
| Enum / actor 45s? | “Impossible states out → exhaustiveness → payment design. Race → isolation → serial-queue prior art.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q10. Give the 45-second spoken agenda for actor intro?
**Answer:**

> “Agenda: race → isolation → bridge. An actor is a reference type that serializes access to its state. Call sites await. It’s the modern equivalent of the serial-queue boundary we used around BookMyShow synchronised dictionaries. For greenfield I’d evaluate Design: actor SafeDict — I won’t claim we rewrote production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where next? | [04-production-s1-s7.md](04-production-s1-s7.md) |
| Deepen concurrency? | Day 05 — reentrancy, Sendable, structured cancel. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)

---

## Brain puzzles (cover → think → check)

### Puzzle A — Mutating hashed fields in a Set

```swift
final class Seat: Hashable {
 let id: String
 var isSelected: Bool
 static func == (l: Seat, r: Seat) -> Bool { l.id == r.id }
 func hash(into hasher: inout Hasher) { hasher.combine(id); hasher.combine(isSelected) }
}
var set: Set<Seat> = [Seat(id: "A1")]
let seat = set.first!
seat.isSelected = true
print(set.contains(seat))
```

**Ask yourself:** Is contains reliable? What went wrong?

**Answer:** Broken. You mutated a field that participates in the hash while the object is in the Set. Hash on stable `id` only; keep `isSelected` out of `hash(into:)`.

---

### Puzzle B — Every ViewModel should be an actor

Interviewer: “So you’d make every ViewModel an actor, right?”

**Good reply:** “I’d push back. UI state usually sits on MainActor as a class so binds stay simple. I’d put shared concurrent maps in a dedicated actor — not wrap every screen model in await noise.”

---

### Puzzle C — Actor vs serial queue — when not to migrate

Someone proposes rewriting all BookMyShow synchronised dictionaries to actors next sprint.

**Ask yourself:** What’s the senior reply?

**Answer:** Don’t big-bang. Shipped serial-queue boundary is proven. Actor for greenfield / strangler modules. Train the new pitfall — reentrancy after await — not just “compiler isolation.” No invented crash-free % hung on either story alone.

---

Next: [04-production-s1-s7.md](04-production-s1-s7.md)
