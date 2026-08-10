# Audio script — Sample 02 — COW and enums (Q&A)
> Listen-only sample Q&A from `02-cow-enums.md`. Spoken answers and follow-ups.

## §0 Q1. What is copy-on-write in plain words?

Next. Q1. What is copy-on-write in plain words? Answer. “copy on write means share storage until someone writes — then copy if needed. Assignment of an Array is cheap because two variables may share one buffer. Before mutating, Swift checks whether the buffer is uniquely referenced. If not, it copies first, then mutates the unique copy. Value semantics stay intact without paying a full deep copy on every assign.” Follow-ups. Junior one-liner?: “Arrays act like values, but under the hood they cheaply share memory until someone changes something — then they copy.”. Wrong trap answers?: “‘Always shared’ or ‘always copied on assign.’ Correct: shared until a write forces uniqueness.”. Who pays for the copy?: “Whoever mutates while aliases exist — a or b in var b = a.”.

## §1 Q2. Walk through assign → read → mutate with Array?

Next. Q2. Walk through assign → read → mutate with Array? Answer. “Assign: var b = a — both may share one buffer; cheap — pointer plus refcount. Read: either variable reads freely; still shared. Mutate: b.append(4) — if b is not the unique owner, copy the buffer first, then mutate. Result: a still [1,2,3], b is [1,2,3,4].” Follow-ups. What if a mutates instead of b?: “Same rule — a may copy; b keeps the old buffer.”. Does read trigger a copy?: “No — reads are free while sharing.”. Runnable demo?: “See COWDemo.arrayShareUntilWrite in code/COWDemo.swift.”.

## §2 Q3. Which standard library types use COW?

Next. Q3. Which standard library types use COW? Answer. “Know these names: Array, Dictionary, Set, String. They are value types with a reference-counted buffer under the hood. Custom structs do not get copy on write unless you implement it — often with a private class storage plus isKnownUniquelyReferenced.” Follow-ups. What is isKnownUniquelyReferenced for?: “Checks whether a class buffer has only one strong owner — your hook before in-place mutation.”. Why not deep-copy every assign?: “Large listing and search arrays would be expensive in hot paths.”. Large struct vs copy on write collection?: “A fat ListingRow with many non-copy on write fields pays bitwise copy on assign; Array of rows shares until write.”.

## §3 Q4. Walk handmade `COWList` / `isKnownUniquelyReferenced`?

Next. Q4. Walk handmade `COWList` / `isKnownUniquelyReferenced`? Answer. “Pattern: value-type façade over a reference-counted Storage class. On assign, two COWList values share the same Storage. Before append, call ensureUnique — if !isKnownUniquelyReferenced(&storage), replace storage with a copied buffer. Then mutate in place. After var b = a; b.append(4), a still has the old items. That’s the interview sketch in code/COWDemo.swift.” Follow-ups. Why must Storage be a class?: “isKnownUniquelyReferenced only works on class instances — copy on write needs a refcounted buffer.”. Mutating on let list?: “Compile error — append is mutating; need a var binding.”. 45s copy on write agenda?: “Share → uniqueness check → mutate; trust stdlib in hot paths.”.

## §4 Q5. What breaks COW independence across variables?

Next. Q5. What breaks COW independence across variables? Answer. “Separate Array copy on write from object identity. With var b = a as two Array values, mutating b copies if not unique, so a stays unchanged. If you wrap the array in a class — ArrayBox — and do let box2 = box1, both names share one box. Mutating box2.values changes box1.values too. The inner Array still COWs relative to other Array values, but aliases through the class share the same property path.” Follow-ups. Symptom?: “‘I thought arrays were values’ — but the box is shared identity.”. Production lesson?: “Don’t wrap collections in classes ‘for safety’ without thinking — you reintroduce shared mutation across U I aliases.”. Demo?: “COWDemo.classBoxBreaksIndependence.”.

## §5 Q6. Why do enums beat boolean flags for UI state?

Next. Q6. Why do enums beat boolean flags for UI state? Answer. “Boolean soup — isLoading, data, error all optional — allows illegal combinations: loading and loaded and error at once. That’s the impossible-state explosion. An enum with idle, loading, loaded(T), failed(Error) encodes only legal rows. The compiler’s exhaustiveness on switch forces you to handle every mode.” Follow-ups. Why not Result alone in the ViewModel?: “Result has no idle or loading — U I needs those screen semantics.”. Adding a new enum case?: “Every switch must update — that compile pressure is the feature.”. Generic pattern?: “LoadState<T in code/LoadState.swift.”.

## §6 Q7. What are associated values on an enum?

Next. Q7. What are associated values on an enum? Answer. “Each case can carry payload specific to that mode. loaded(T) holds the data; failed(Error) holds the error; processing(message:) holds the status string. You don’t keep a stray optional bookingID around during processing — the case owns exactly what the U I needs for that screen.” Follow-ups. vs raw-value enum?: “Raw values are fixed constants; associated values are per-case structured data.”. Extract in a switch?: “case.loaded(let value): — bind the payload in the pattern.”. Payment example?: “success(bookingID:) — ID only exists in success, not in processing.”.

## §7 Q8. How would you model a payment processing popup as an enum?

Next. Q8. How would you model a payment processing popup as an enum? Answer. “Cases: hidden, processing(message:), success(bookingID:), failure(...), timedOut(message:). Transitions come from events — userStartedCheckout, backendSuccess, timeout, dismiss. Illegal transitions are ignored or asserted in DEBUG. Full graph: hidden → processing on checkout; processing → success / failure / timedOut; any terminal or processing → hidden on dismiss. Label clearly: BookMyShow payment processing-status popup is the product intent; Design: payment status pattern is how I’d model it in Swift — not a claim that production shipped this enum by name.” Follow-ups. Why enum over five booleans?: “Impossible U I modes can’t exist — no success banner plus processing spinner.”. Map from network Result?: “LoadState.from(result:) at the edge; U I enum adds idle/loading.”. Product problem it solves?: “Silent waiting during checkout — users need explicit processing status.”.

## §8 Q9. When do you need `indirect` on an enum?

Next. Q9. When do you need `indirect` on an enum? Answer. “Enums have a fixed size at compile time. A case that contains another value of the same enum — a recursive tree — needs a heap box. indirect tells Swift to store that associated value behind a reference so the layout stays finite. Useful for comment threads, nested feed sections, or FeedNode trees.” Follow-ups. indirect enum vs indirect case?: “Whole enum or single case — both introduce indirection where recursion demands it.”. Without indirect?: “The type would have infinite size — it won’t compile.”. Tie to listings?: “section(title:children:) for nested ad or event rows.”.

## §9 Q10. How do you map Result into UI state — and stay resilient when the backend adds modes?

Next. Q10. How do you map Result into UI state — and stay resilient when the backend adds modes? Answer. “Keep Result at the networking edge — it models a one-shot success or failure. Map at the boundary into a U I enum like LoadState with idle, loading, loaded, failed. For backend-driven or versioned payloads — S D U I-ish headers — add an explicit unknown(type:raw:) fallback, or use @unknown default on frozen system enums, so new server modes degrade gracefully instead of crashing decode or switch. Domain enums communicate screen semantics; Result communicates attempt outcomes; unknown cases buy versioning resilience.” Follow-ups. Why not Result alone?: “No idle / loading — U I needs those modes.”. Versioning trap?: “Exhaustive enum with no unknown → crash or force-update on every CMS case add.”. @unknown default?: “For non-frozen enums you don’t own — future cases won’t break your binary at runtime the same way; still handle known cases explicitly.”.

## §10 Q11. Give the 45-second spoken agendas for COW and enum state?

Next. Q11. Give the 45-second spoken agendas for COW and enum state? Answer. “copy on write agenda: share → uniqueness → mutate. Assignment of Array is cheap because buffers are shared. On mutation, if the buffer isn’t uniquely referenced, Swift copies first. Value semantics stay intact. Enum agenda: impossible states → exhaustiveness → payload. Booleans allow illegal combinations. An associated-value enum makes each mode carry only the data it needs, and switches stay exhaustive. That’s how I’d model payment processing U I — Design: payment status pattern — on top of the BookMyShow payment processing-status popup product intent.” Follow-ups. Where next?: 03-actors-classes.md. Code to read?: LoadState.swift and COWDemo.swift.
