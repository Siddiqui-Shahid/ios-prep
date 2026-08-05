# Sample 02 — COW and enums (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is copy-on-write in plain words?

**Points to:** [Foundations · §6 Copy-on-write](../01-foundations.md#6-copy-on-write-cow--intern-version) · [Deep dive · §2 Copy-on-write — senior mechanics](../02-deep-dive.md#2-copy-on-write--senior-mechanics)

**Answer:**

> COW means **share storage until someone writes; then copy if needed**. Assignment of an `Array` is cheap because two variables may share one buffer. Before mutating, Swift checks whether the buffer is uniquely referenced. If not, it copies first, then mutates the unique copy. Value semantics stay intact without paying a full deep copy on every assign.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Junior one-liner? | “Arrays act like values, but under the hood they cheaply share memory until someone changes something — then they copy.” |
| Wrong trap answers? | “Always shared” or “always copied on assign.” Correct: **shared until a write forces uniqueness.** |
| Who pays for the copy? | Whoever mutates while aliases exist — `a` or `b` in `var b = a`. |

---

### Q2. Walk through assign → read → mutate with Array.

**Points to:** [Foundations · §6.2 The three steps](../01-foundations.md#62-the-three-steps) · [code/COWDemo.swift](../code/COWDemo.swift)

**Answer:**

> **Assign:** `var b = a` — both may share one buffer; cheap (pointer + refcount). **Read:** either variable reads freely; still shared. **Mutate:** `b.append(4)` — if `b` is not the unique owner, copy buffer first; then mutate. Result: `a` still `[1,2,3]`, `b` is `[1,2,3,4]`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if `a` mutates instead of `b`? | Same rule — `a` may copy; `b` keeps the old buffer. |
| Does read trigger a copy? | No — reads are free while sharing. |
| Runnable demo? | See `COWDemo.arrayShareUntilWrite()` in [`code/COWDemo.swift`](../code/COWDemo.swift). |

---

### Q3. Which standard library types use COW?

**Points to:** [Foundations · §6.2](../01-foundations.md#62-the-three-steps) · [Deep dive · §2.1 Uniqueness](../02-deep-dive.md#21-uniqueness)

**Answer:**

> Know these names: **`Array`**, **`Dictionary`**, **`Set`**, **`String`**. They are value types with a reference-counted buffer under the hood. Custom structs do not get COW unless you implement it (often with a private `class` storage + `isKnownUniquelyReferenced`).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is `isKnownUniquelyReferenced` for? | Checks whether a **class** buffer has only one strong owner — your hook before in-place mutation. |
| COW in one implementation pattern? | Value-type façade over a reference-counted `Storage` class — see handmade `COWList` in deep dive and code. |
| Why not deep-copy every assign? | Large listing/search arrays would be expensive in hot paths. |

---

### Q4. What breaks COW independence across variables?

**Points to:** [Deep dive · §2.3 Wrapping arrays in a class](../02-deep-dive.md#23-wrapping-arrays-in-a-class-kills-cow-across-that-wrapper) · [code/COWDemo.swift](../code/COWDemo.swift)

**Answer:**

> The inner `Array` still COWs relative to other `Array` values — but if you wrap it in a **`class`** (`ArrayBox`), two names pointing at one box share the same array **property path**. Mutating `box2.values` changes `box1.values` too. Interviewers use this to test whether you confuse collection COW with object identity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom? | “I thought arrays were values” — but the box is shared. |
| Production lesson? | Don’t wrap collections in classes “for safety” without thinking — you reintroduce shared mutation. |
| Demo? | `COWDemo.classBoxBreaksIndependence()` in [`code/COWDemo.swift`](../code/COWDemo.swift). |

---

### Q5. Why do enums beat boolean flags for UI state?

**Points to:** [Foundations · §5.1 Associated values](../01-foundations.md#51-associated-values--data-that-travels-with-the-mode) · [Deep dive · §4.1 Impossible states](../02-deep-dive.md#41-impossible-states-are-bugs-you-dont-ship)

**Answer:**

> Boolean soup (`isLoading`, `data`, `error` all optional) allows illegal combinations — loading **and** loaded **and** error at once. An enum with cases like `idle`, `loading`, `loaded(T)`, `failed(Error)` encodes only legal rows. The compiler’s exhaustiveness on `switch` forces you to handle every mode.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not `Result` alone in the ViewModel? | `Result` has no `idle` or `loading` — UI needs those screen semantics. |
| Adding a new enum case? | Every `switch` must update — that compile pressure is the feature. |
| Generic pattern? | `LoadState<T>` in [`code/LoadState.swift`](../code/LoadState.swift). |

---

### Q6. What are associated values on an enum?

**Points to:** [Foundations · §5.1](../01-foundations.md#51-associated-values--data-that-travels-with-the-mode) · [Foundations · §5.2 Why this matters for UI](../01-foundations.md#52-why-this-matters-for-ui)

**Answer:**

> Each case can carry **payload** specific to that mode. `loaded(T)` holds the data; `failed(Error)` holds the error; `processing(message:)` holds the status string. You don’t keep a stray optional `bookingID` around during `processing` — the case owns exactly what the UI needs for that screen.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs raw-value enum? | Raw values are fixed constants; associated values are per-case structured data. |
| Extract in a switch? | `case .loaded(let value):` — bind the payload in the pattern. |
| Payment example? | `success(bookingID: String)` — ID only exists in success, not in processing. |

---

### Q7. How would you model a payment processing popup as an enum?

**Points to:** [Deep dive · §4.3 Payment popup machine](../02-deep-dive.md#43-payment-popup-machine-applied--s7-a1) · [code/LoadState.swift](../code/LoadState.swift) · [Production bridge · S7-A1](../03-production-bridge.md#4-applied--s7-a1--enum-state-machine-design)

**Answer:**

> Cases: `hidden`, `processing(message:)`, `success(bookingID:)`, `failure(...)`, `timedOut(message:)`. Transitions come from events (`userStartedCheckout`, `backendSuccess`, `timeout`, `dismiss`). Illegal transitions are ignored or asserted in DEBUG. Label clearly: **Verified S7** is the popup intent; **Applied S7-A1** is how you’d model it in Swift — not a claim that production shipped this enum by name.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why enum over five booleans? | Impossible UI modes can’t exist — no “success banner + processing spinner.” |
| Map from network `Result`? | `LoadState.from(result:)` at the edge; UI enum adds idle/loading. |
| Product problem S7 solves? | Silent waiting during checkout — users need explicit processing status. |

---

### Q8. When do you need `indirect` on an enum?

**Points to:** [Foundations · §5.3 Recursive enums](../01-foundations.md#53-recursive-enums-need-indirect) · [Deep dive · §4.5 Recursive / nested domain trees](../02-deep-dive.md#45-recursive--nested-domain-trees)

**Answer:**

> Enums have a fixed size at compile time. A case that contains **another value of the same enum** (or a recursive tree) needs a heap box. `indirect` tells Swift to store that associated value behind a reference so the layout stays finite — useful for comment threads, nested feed sections, or `FeedNode` trees.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `indirect enum` vs `indirect case`? | Whole enum or single case — both introduce indirection where recursion demands it. |
| Unknown backend modes? | Fallback case like `unknown(type:raw:)` beats crashing on new JSON — resilience pattern. |
| Tie to listings? | `section(title:children: [FeedNode])` for nested ad/event rows. |

---

Next: [03-actors-classes.md](03-actors-classes.md)
