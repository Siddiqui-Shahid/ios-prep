# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Struct vs class — when do you choose each? `(30–45s)`

**Answer:**

> Structs and enums have value semantics — assignment gives you an independent copy, so mutating one variable doesn’t surprise another. Classes have reference semantics — multiple names can point at the same instance, so mutation is shared. I default to structs for models and DTOs, and reach for classes when I need identity, UIKit objects, or Objective-C interop. On the BookMyShow ads side, keeping render models value-friendly fits a type-safe pipeline so accidental shared mutation doesn’t corrupt revenue UI.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is a class mandatory? | UIKit/AppKit objects, Objective-C interop, or intentional shared identity that value types can’t express. |
| What if a struct contains a class property? | Assigning the struct copies the reference, so both copies share the same class instance and its mutations. |
| Would you make a ViewModel a struct or a class/`@MainActor` type — why? | Usually a class or `@MainActor` reference type so screens share one identity and observation stays stable under mutation. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. What is copy-on-write? `(30–45s)`

**Answer:**

> Copy-on-write means value-typed collections like Array can share their storage after assignment so the assign is cheap. When you mutate, the runtime checks whether that buffer is uniquely referenced. If it is, it mutates in place; if not, it copies the buffer first and then mutates. That preserves value semantics without paying a full element copy on every assignment.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Does `let a = b` on arrays copy elements immediately? | No — arrays share storage until a mutation forces a copy when the buffer isn’t uniquely referenced. |
| How would you implement COW on your own type? | Store data in a reference box and call `isKnownUniquelyReferenced` before mutating; copy the box if shared. |
| What does Instruments look like when COW thrash happens on a hot path? | Allocations/Time Profiler show repeated large buffer copies and spikes on mutate-heavy loops that keep sharing. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. Why prefer enums over booleans for UI state? `(30–45s)`

**Answer:**

> Boolean flags like `isLoading` plus optional `data` and `error` can represent illegal combinations — loading and failed at once, for example. An associated-value enum makes each mode explicit and attaches only the data that mode needs. Switches stay exhaustive when you add cases. For the payment processing popup, I’d model processing, success, failure, and timeout as cases so the UI can’t enter a nonsense state.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do you map `Result` into UI state? | Map `.success`/`.failure` into enum cases like `.loaded(value)` / `.failed(error)`, never parallel booleans. |
| How do you version new cases if the backend adds modes? | Add an exhaustive enum case (or unknown fallback), update switches, and ship UI for the new mode intentionally. |
| Show a transition function vs scattering `if` updates. | Centralize `reduce(state, event) -> State` so illegal combinations can’t be set via scattered `isLoading = true` flips. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q4. What is an actor at a high level? `(30–45s)`

**Answer:**

> An actor is a reference type whose mutable state is isolated. You interact with it asynchronously — typically with await — and the system serializes access so you don’t get data races on that state. At BookMyShow we used GCD serial queues around shared dictionaries for the same kind of problem; for greenfield code I’d evaluate a Swift actor as the language-native equivalent.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Are actors value or reference types? | Reference types with isolated mutable state — assignment shares the instance, access is serialized. |
| Actor vs `@MainActor` ViewModel? | A general actor isolates its own state; `@MainActor` pins work to the main actor for UI-bound models. |
| What is actor reentrancy at a high level? | While an actor method awaits, other tasks can enter the same actor, so state may change across suspension points. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. Value type containing a class — what happens on copy? `(45s)`

**Answer:**

> When you assign a struct, Swift copies its stored properties. Value-typed fields become independent; class-typed fields copy the reference, so both structs point at the same object. Mutating that nested object through either copy is visible to both. If you need a deep copy, you have to implement it explicitly — value semantics don’t recursively deep-copy the graph.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Give a UIKit cell-model example of this bug. | A struct cell model holding a shared `UIImage` cache object mutates cache state visible to every copied model. |
| How do you redesign to avoid it? | Keep value models pure data and pass services/caches separately, or deep-copy when shared mutation must not leak. |
| Interaction with COW arrays stored inside a class property? | The class is shared by reference; the array still COWs on mutate, but every holder of the class sees the same array storage. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. `===` vs `==`? `(30s)`

**Answer:**

> Double equals asks whether two values are equal according to Equatable. Triple equals asks whether two class instances are the exact same object. Structs don’t have triple equals because they aren’t identities — you compare their values. I use identity for things like the same view controller instance, and equality for model data.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Should ViewModels use identity or equality in tests? | Assert on published state equality (or snapshots); use identity only when proving the same instance is wired. |
| Hashing a class by identity vs by fields? | Identity hashing treats distinct instances as different; field hashing can collide logically equal but separate objects. |
| Equatable enums with associated `Error` — pitfalls? | `Error` isn’t Equatable by default, so you compare cases by type/code or erase to a comparable domain error. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. When would you use a class for a model? `(45s)`

**Answer:**

> I’d use a class for a model when shared identity is intentional — one session object many screens must see mutate — or when UIKit/ObjC interop forces it. For ordinary DTOs I still prefer structs. If the real need is safe concurrent mutation of shared storage, I’d consider an actor rather than an unsynchronized class.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Could an actor replace that class? | Yes for shared mutable storage needing isolation — Design: actor SafeDict is the greenfield shape vs a bare class. |
| How do you test shared mutable models safely? | Drive them through their synchronized API (queue/actor), assert via async tests, and avoid touching raw storage. |
| Reference cycles between model and observers? | Observers/closures must capture weakly, and delegates should be `weak` class-bound so the model doesn’t retain UI. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. Recursive enums — why `indirect`? `(45s)`

**Answer:**

> Swift enums have a size the compiler needs to know. If a case contains another value of the same enum, that would be infinite size unless you introduce indirection. Marking the enum or case `indirect` stores the associated value behind a reference so the layout stays finite. You see this with nested comment threads or tree-shaped feed nodes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `indirect` on whole enum vs one case? | Whole-enum `indirect` boxes every case; per-case `indirect` only boxes the recursive associated values you need. |
| How does this compare to a class-based tree? | Classes give identity and shared mutation; recursive enums give value trees with explicit copy/equality semantics. |
| Equatable/Hashable synthesis with recursive enums? | Synthesis still works if associated values are Equatable/Hashable; deep trees compare recursively through the indirection. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. Are actors value or reference types? `(30s)`

**Answer:**

> Actors are reference types — assigning an actor shares the same instance — but unlike a plain class, their mutable state is isolated. You don’t freely mutate from arbitrary threads; you go through the actor’s interface, usually with await.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What happens if two tasks call the same actor method? | Calls are serialized on the actor — one runs, the other waits — so isolated state isn’t data-raced. |
| Can actors inherit from classes freely? | Actors don’t participate in open class inheritance the way NSObject subclasses do; prefer composition and protocols. |
| Actor vs lock vs serial queue trade-offs? | Actors compose with async/await; serial queues match BookMyShow synchronised dictionaries; locks are low-level and deadlock-prone. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q10. Explain COW in one sentence to a junior. `(30s)`

**Answer:**

> Arrays act like values, but they cheaply share memory until somebody writes — then they copy if they’re not the only owner. So `var b = a` is cheap, and `b.append` won’t change `a`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which stdlib types use COW? | Array, Dictionary, Set, String, and related collections share storage until mutation requires a unique buffer. |
| Why doesn’t every struct get COW automatically? | COW needs a reference-counted buffer and uniqueness checks; plain stored properties just copy bit-for-bit. |
| Implement `ensureUnique` with `isKnownUniquelyReferenced`. | If `!isKnownUniquelyReferenced(&box)`, replace `box` with a deep-copied storage instance before writing. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q11. `let` on a class vs `let` on a struct? `(30–45s)`

**Answer:**

> `let` means the name can’t be reassigned. For a struct, that also blocks mutating properties because mutation is really replacing the value. For a class, `let` only fixes which instance you point at — you can still change the instance’s properties. That’s why `let` doesn’t mean ‘immutable object’ for reference types.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do you make a class’s properties immutable? | Declare stored properties as `let`, or expose only `private(set)` / read-only computed surfaces. |
| `private(set)` on structs vs classes? | Same visibility rule; on structs outsiders still need `var` binding to mutate via methods, on classes `let` instance can still mutate settable props. |
| Actors and mutation from outside? | Outside code can’t freely mutate isolated state — it must go through actor methods, usually with `await`. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q12. How do you explain preferring values for ads/listing models? `(45s)`

**Answer:**

> For ad and listing render data I prefer value semantics so one surface’s mutation doesn’t leak into another. That sits well with the type-safe ads pipeline we built with protocols and generics. Where identity and lifecycle matter — like HeroWidget pause/play tied to visibility — that’s a reference-type concern. So values for data, classes for identity boundaries.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do generics fit that pipeline? | BookMyShow Ads pipeline used protocol + generic installers so each creative stays typed without `Any` downcasts. |
| What breaks if an ad DTO secretly holds a shared cache object? | Value copies appear independent but share cache mutation, so one surface’s write corrupts another’s render path. |
| Testing strategy for value models vs singleton services? | Assert pure value transforms in isolation; inject fake services instead of hitting process-wide singletons. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

## Tricky questions

## Drill set (pick per session)

## Optional citations (appendix only — not required to study)

