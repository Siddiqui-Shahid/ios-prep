# Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)

> Pulled from `01-foundations`, `02-deep-dive`, `03-production-bridge`, `05-exercises`, and the day README — anything easy to miss if you only read samples 01–05.  
> Say answers like a conversation. Then do the real coding drills in [`../05-exercises.md`](../05-exercises.md).

---

### Q1. Walk LoadState fluency out loud (exercise 1)

**Answer:**

> “Idle, loading, loaded(T), failed(Error). Map Result at the boundary — success to loaded, failure to failed. Map transforms only loaded and preserves other cases. Reduce on SearchEvent: startSearch goes to loading; succeed and fail land in loaded or failed; reset to idle. Agenda before coding: define the enum, map Result at the edge, then a pure reduce. Result alone is insufficient because UI needs idle and loading.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stretch? | “Hold a domain error enum in failed for Equatable tests.” |
| Code? | [`../code/LoadState.swift`](../code/LoadState.swift) |

**How can I relate to my case:**
- **Lab only:** Learning-lab LoadState — not production source.

---

### Q2. Walk the payment transition graph (exercise 2)

**Answer:**

> “Hidden plus userStartedCheckout becomes processing. Processing plus backendSuccess becomes success with bookingID. Processing plus backendFailure becomes failure. Processing plus timeout becomes timedOut. Success, failure, timedOut, or processing plus dismiss becomes hidden. Illegal pairs no-op. Speak after coding: product intent from the payment processing-status popup, why enum beats booleans, one illegal state eliminated — and label the enum machine as how I’d apply it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Honesty check? | “Enum machine is design — not a claim we shipped that exact type.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)

---

### Q3. COW playground — three predictions (exercise 3)

**Answer:**

> “Plain Array: assign shares; mutate one; the other keeps the old buffer. ArrayBox: both names see the append — shared class identity. Handmade COWList: ensureUnique with isKnownUniquelyReferenced before append — same independence as Array. Speak: share until write; class boxes share identity; handmade COW is a value façade over a buffer class.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap? | “Don’t claim assignment always deep-copies elements.” |
| Code? | [`../code/COWDemo.swift`](../code/COWDemo.swift) |

**How can I relate to my case:**
- **Lab only:** Learning-lab COW demos.

---

### Q4. Nested reference audit — AdCellModel + Metrics (exercise 4)

**Answer:**

> “After copy, title is independent — a stays A, b becomes B. Metrics taps append is shared — a.metrics sees the click. Root cause: class inside struct. Redesign: keep value models pure data; inject Metrics at the boundary; or make metrics a value. Story hook: why value-friendly ads models matter — BookMyShow Ads pipeline — without inventing fill-rate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Closure cousin? | “Capturing class self in a nested function is the same nested-ref family.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate %.

---

### Q5. Actor intro sketch — SyncedMap (exercise 5)

**Answer:**

> “Fill serial-queue get and set — sync for tiny critical sections if you accept deadlock risk; prefer async façades when bridging from async code. Rewrite as actor SyncedMap with the same method names. Forty-five second bridge: BookMyShow synchronised dictionaries used a serial queue; for greenfield I’d expose the same surface on an actor. Do not claim you rewrote production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When not to migrate? | “Stable closed API under load — strangler, don’t big-bang.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)

---

### Q6. Flash recall — fire front → back like cards

**Answer:**

> “Value vs reference — snapshot versus shared identity; trap is let means immutable class; prod is Ads models versus HeroWidget.
>
> COW — share until write; trap is ArrayBox; lab is COWList uniqueness.
>
> Enum state — impossible states out; trap is Result alone; prod is payment popup intent plus design machine.
>
> Nested class in struct — shallow share; trap is cache pollution; fix inject services.
>
> Actor intro — isolated reference; trap is every VM is actor; bridge is synchronised dictionaries.
>
> Reentrancy awareness — state may change after await; deepen Day 05.
>
> Exclusivity — no overlapping inout; mutating replaces self on var only.
>
> Hashing classes — stable id or ObjectIdentifier; never mutate hash fields in a Set.
>
> Versioning — unknown fallback / @unknown default under SDUI-ish payloads.
>
> Honesty — no invented fill-rate or drop-off; don’t combine stories into fake org metrics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drill how? | “Cover the name, speak the back, uncover, score yourself.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Spoken 45s agenda templates — fire all four

**Answer:**

> “Struct versus class: semantics → mutation → example — values for ads models, classes for UIKit and HeroWidget.
>
> COW: share → uniqueness → mutate — trust stdlib in listing hot paths.
>
> Enum state: impossible states → exhaustiveness → payload — payment status design.
>
> Actor intro: race → isolation → bridge — synchronised dictionaries prior art, SafeDict for greenfield.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always open with? | “Agenda in the first ten seconds — claim, mechanism, trade-off, production hook.” |

**How can I relate to my case:**
- **Shipped / design** as labeled in provenance — never blur them.

---

### Q8. Day close-out — can you check these off?

**Answer:**

> “Without notes: I can state the decision rule for struct, class, enum, actor. I explained COW with the uniqueness nuance. I said why enums beat boolean UI flags. I delivered a twenty-second Ads value-semantics pitch without invented fill-rate. I delivered payment popup plus design enum under ninety seconds with honest provenance. I delivered the synchronised-dictionaries to actor bridge under forty-five seconds without claiming a rewrite. I read LoadState and COWDemo aloud once. I ran a timed set from 04-questions including T1 through T10. If any box is open, that’s my next drill — not more reading.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where to practice code? | [../05-exercises.md](../05-exercises.md) |
| Where to time speak? | [../04-questions.md](../04-questions.md) T1–T10 |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse after every Day 01 study block.

---

### Q9. What should you be able to do by end of Day 01? (README outcomes)

**Answer:**

> “Choose struct versus class versus enum versus actor with a clear rule and one production example. Explain copy-on-write for Array, String, Dictionary — when assign is cheap and when a real copy happens. Model UI and payment flows as associated-value enums. Give a thirty-second actors intro that bridges GCD serial queues to Swift actors. Speak a twenty-second pitch tying value semantics to BookMyShow ads and listing models — no invented metrics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timed drill? | “Q1, Q2, Q3, T1, T3, T9 on a timer; then ninety seconds payment popup plus design.” |

**How can I relate to my case:**
- **Shipped / design** as labeled in provenance — never blur them.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Boolean flags explosion

`isLoading`, `hasData`, `hasError` all true at once.

**Ask:** What does the screen show?

**Answer:** Nonsense — spinner plus content plus error. Enum makes that row unrepresentable.

---

### Puzzle B — Large struct copy vs COW array

You pass a 40-field `ListingRow` by value in a hot map, and separately pass `[ListingRow]` between screens.

**Ask:** Which pays what?

**Answer:** Fat struct pays bitwise copy of stored properties each pass. The Array shares a buffer until mutation. Don’t say “structs are always cheaper.”

---

### Puzzle C — ObjectIdentifier vs ID Hashable

Two `Seat` instances with the same `id` but different addresses.

**Ask:** ObjectIdentifier equality vs id-based equality?

**Answer:** ObjectIdentifier — different. ID-based Hashable — same business key. Pick intentionally; never mix mutable fields into the hash while in a Set.

---

Back to: [README.md](README.md)
