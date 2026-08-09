# Sample 02 — COW and enums (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer.  
> Each answer ends with **How can I relate to my case** using named work — never S-codes.  
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is copy-on-write in plain words?

**Answer:**

> “COW means share storage until someone writes — then copy if needed. Assignment of an Array is cheap because two variables may share one buffer. Before mutating, Swift checks whether the buffer is uniquely referenced. If not, it copies first, then mutates the unique copy. Value semantics stay intact without paying a full deep copy on every assign.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Junior one-liner? | “Arrays act like values, but under the hood they cheaply share memory until someone changes something — then they copy.” |
| Wrong trap answers? | “‘Always shared’ or ‘always copied on assign.’ Correct: shared until a write forces uniqueness.” |
| Who pays for the copy? | “Whoever mutates while aliases exist — `a` or `b` in `var b = a`.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Walk through assign → read → mutate with Array

**Answer:**

> “Assign: `var b = a` — both may share one buffer; cheap — pointer plus refcount. Read: either variable reads freely; still shared. Mutate: `b.append(4)` — if `b` is not the unique owner, copy the buffer first, then mutate. Result: `a` still `[1,2,3]`, `b` is `[1,2,3,4]`.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if `a` mutates instead of `b`? | “Same rule — `a` may copy; `b` keeps the old buffer.” |
| Does read trigger a copy? | “No — reads are free while sharing.” |
| Runnable demo? | “See `COWDemo.arrayShareUntilWrite()` in [`code/COWDemo.swift`](../code/COWDemo.swift).” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Which standard library types use COW?

**Answer:**

> “Know these names: Array, Dictionary, Set, String. They are value types with a reference-counted buffer under the hood. Custom structs do not get COW unless you implement it — often with a private class storage plus `isKnownUniquelyReferenced`.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is `isKnownUniquelyReferenced` for? | “Checks whether a class buffer has only one strong owner — your hook before in-place mutation.” |
| Why not deep-copy every assign? | “Large listing and search arrays would be expensive in hot paths.” |
| Large struct vs COW collection? | “A fat ListingRow with many non-COW fields pays bitwise copy on assign; Array of rows shares until write.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Walk handmade `COWList` / `isKnownUniquelyReferenced`

**Answer:**

> “Pattern: value-type façade over a reference-counted Storage class. On assign, two COWList values share the same Storage. Before append, call `ensureUnique` — if `!isKnownUniquelyReferenced(&storage)`, replace storage with a copied buffer. Then mutate in place. After `var b = a; b.append(4)`, `a` still has the old items. That’s the interview sketch in [`code/COWDemo.swift`](../code/COWDemo.swift).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why must Storage be a class? | “`isKnownUniquelyReferenced` only works on class instances — COW needs a refcounted buffer.” |
| Mutating on `let list`? | “Compile error — `append` is mutating; need a `var` binding.” |
| 45s COW agenda? | “Share → uniqueness check → mutate; trust stdlib in hot paths.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab `COWList` — not a shipped BookMyShow type.

---

### Q5. What breaks COW independence across variables?

**Answer:**

> “Separate Array COW from object identity. With `var b = a` as two Array values, mutating `b` copies if not unique, so `a` stays unchanged. If you wrap the array in a class — ArrayBox — and do `let box2 = box1`, both names share one box. Mutating `box2.values` changes `box1.values` too. The inner Array still COWs relative to *other* Array values, but aliases through the class share the same property path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom? | “‘I thought arrays were values’ — but the box is shared identity.” |
| Production lesson? | “Don’t wrap collections in classes ‘for safety’ without thinking — you reintroduce shared mutation across UI aliases.” |
| Demo? | “`COWDemo.classBoxBreaksIndependence()`.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Why do enums beat boolean flags for UI state?

**Answer:**

> “Boolean soup — `isLoading`, `data`, `error` all optional — allows illegal combinations: loading and loaded and error at once. That’s the impossible-state explosion. An enum with idle, loading, loaded(T), failed(Error) encodes only legal rows. The compiler’s exhaustiveness on switch forces you to handle every mode.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not Result alone in the ViewModel? | “Result has no idle or loading — UI needs those screen semantics.” |
| Adding a new enum case? | “Every switch must update — that compile pressure is the feature.” |
| Generic pattern? | “`LoadState<T>` in [`code/LoadState.swift`](../code/LoadState.swift).” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What are associated values on an enum?

**Answer:**

> “Each case can carry payload specific to that mode. `loaded(T)` holds the data; `failed(Error)` holds the error; `processing(message:)` holds the status string. You don’t keep a stray optional bookingID around during processing — the case owns exactly what the UI needs for that screen.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs raw-value enum? | “Raw values are fixed constants; associated values are per-case structured data.” |
| Extract in a switch? | “`case .loaded(let value):` — bind the payload in the pattern.” |
| Payment example? | “`success(bookingID:)` — ID only exists in success, not in processing.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How would you model a payment processing popup as an enum?

**Answer:**

> “Cases: hidden, processing(message:), success(bookingID:), failure(...), timedOut(message:). Transitions come from events — userStartedCheckout, backendSuccess, timeout, dismiss. Illegal transitions are ignored or asserted in DEBUG. Full graph: hidden → processing on checkout; processing → success / failure / timedOut; any terminal or processing → hidden on dismiss. Label clearly: BookMyShow payment processing-status popup is the product intent; Design: payment status pattern is how I’d model it in Swift — not a claim that production shipped this enum by name.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why enum over five booleans? | “Impossible UI modes can’t exist — no success banner plus processing spinner.” |
| Map from network Result? | “LoadState.from(result:) at the edge; UI enum adds idle/loading.” |
| Product problem it solves? | “Silent waiting during checkout — users need explicit processing status.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q9. When do you need `indirect` on an enum?

**Answer:**

> “Enums have a fixed size at compile time. A case that contains another value of the same enum — a recursive tree — needs a heap box. `indirect` tells Swift to store that associated value behind a reference so the layout stays finite. Useful for comment threads, nested feed sections, or FeedNode trees.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `indirect enum` vs `indirect case`? | “Whole enum or single case — both introduce indirection where recursion demands it.” |
| Without indirect? | “The type would have infinite size — it won’t compile.” |
| Tie to listings? | “`section(title:children:)` for nested ad or event rows.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. How do you map Result into UI state — and stay resilient when the backend adds modes?

**Answer:**

> “Keep Result at the networking edge — it models a one-shot success or failure. Map at the boundary into a UI enum like LoadState with idle, loading, loaded, failed. For backend-driven or versioned payloads — SDUI-ish headers — add an explicit unknown(type:raw:) fallback, or use `@unknown default` on frozen system enums, so new server modes degrade gracefully instead of crashing decode or switch. Domain enums communicate screen semantics; Result communicates attempt outcomes; unknown cases buy versioning resilience.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not Result alone? | “No idle / loading — UI needs those modes.” |
| Versioning trap? | “Exhaustive enum with no unknown → crash or force-update on every CMS case add.” |
| `@unknown default`? | “For non-frozen enums you don’t own — future cases won’t break your binary at runtime the same way; still handle known cases explicitly.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Give the 45-second spoken agendas for COW and enum state

**Answer:**

> “COW agenda: share → uniqueness → mutate. Assignment of Array is cheap because buffers are shared. On mutation, if the buffer isn’t uniquely referenced, Swift copies first. Value semantics stay intact.
>
> Enum agenda: impossible states → exhaustiveness → payload. Booleans allow illegal combinations. An associated-value enum makes each mode carry only the data it needs, and switches stay exhaustive. That’s how I’d model payment processing UI — Design: payment status pattern — on top of the BookMyShow payment processing-status popup product intent.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where next? | [03-actors-classes.md](03-actors-classes.md) |
| Code to read? | [`LoadState.swift`](../code/LoadState.swift) and [`COWDemo.swift`](../code/COWDemo.swift) |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)

---

## Brain puzzles (cover → think → check)

### Puzzle A — ArrayBox kills independence

```swift
final class ArrayBox { var values: [Int]; init(_ v: [Int]) { values = v } }
let box1 = ArrayBox([1, 2])
let box2 = box1
box2.values.append(3)
```

**Ask yourself:** What are `box1.values` and `box2.values`?

**Answer:** Both `[1,2,3]`. The *box* is shared identity. Inner Array COW does not make two names pointing at one class independent.

---

### Puzzle B — Result alone as ViewModel state

Someone stores `var state: Result<[Show], Error>?` on the ViewModel and drives the whole screen from it.

**Ask yourself:** What UI modes are missing? What illegal combo can you still hit with extra booleans?

**Answer:** No first-class idle or loading. People bolt on `isLoading` and get loading-plus-success. Prefer `LoadState` (or similar) so modes are exclusive.

---

### Puzzle C — Payment transition graph hole

State is `.success(bookingID:)`. Event is `.backendFailure(...)`.

**Ask yourself:** Should `apply` flip to failure?

**Answer:** No — illegal transition. Ignore (or assert in DEBUG). Success only dismisses to hidden. That’s the point of a closed graph.

---

Next: [03-actors-classes.md](03-actors-classes.md)
