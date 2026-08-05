# 05 — Exercises

> Do these after reading foundations + deep dive + production bridge. Prefer speaking out loud even for coding prompts.

---

## Exercise 1 — `LoadState` fluency `(20–25 min)`

**Prompt:** Using `[code/LoadState.swift](code/LoadState.swift)` as a base (or rewrite from memory):

1. Implement `LoadState<T>` with `idle | loading | loaded(T) | failed(Error)`.
2. Add `static func from(result: Result<T, Error>) -> LoadState<T>`.
3. Add `map` that transforms `loaded` values and preserves other cases.
4. Write a tiny ViewModel-shaped function:

```swift
func reduce(state: LoadState<[String]>, event: SearchEvent) -> LoadState<[String]>
```

Define `SearchEvent` as `startSearch | succeed([String]) | fail(Error) | reset`.

**Agenda to say before coding (30s):**  

> “I’ll define the enum, map Result at the boundary, then a pure reduce for events.”

**Done when:** You can explain why `Result` alone is insufficient for UI.

**Stretch:** Make `failed` hold a domain error enum instead of `Error` for Equatable tests.

---



## Exercise 2 — Payment state machine `(20–30 min)`

**Prompt:** Implement `PaymentPopupState` + `PaymentEvent` + `apply` from the Applied · S7-A1 sketch.

Required transitions:


| From                                | Event               | To                 |
| ----------------------------------- | ------------------- | ------------------ |
| hidden                              | userStartedCheckout | processing         |
| processing                          | backendSuccess      | success(bookingID) |
| processing                          | backendFailure      | failure            |
| processing                          | timeout             | timedOut           |
| success/failure/timedOut/processing | dismiss             | hidden             |


**Speak (≤90s) after coding:**  
Product intent (Verified · S7) → why enum beats booleans → one illegal state you eliminated.

**Honesty check:** End with “enum machine is how I’d apply it (S7-A1).”

---



## Exercise 3 — COW playground `(15–20 min)`

**Prompt:** Run or mentally simulate `[code/COWDemo.swift](code/COWDemo.swift)`.

1. Two `Array` vars — assign, mutate one, predict prints.
2. `ArrayBox` class wrapper — predict shared mutation.
3. Implement or read `COWList` with `isKnownUniquelyReferenced`.

**Speak (30s):**  

> “Share until write; class boxes share identity; handmade COW is a value façade over a buffer class.”

**Trap to avoid:** Claiming assignment always deep-copies elements.

---



## Exercise 4 — Nested reference audit `(15 min)`

**Prompt:** Find the bug and fix the design:

```swift
final class Metrics {
    var taps: [String] = []
}

struct AdCellModel {
    var title: String
    var metrics: Metrics
}

var a = AdCellModel(title: "A", metrics: Metrics())
var b = a
b.title = "B"
b.metrics.taps.append("click")
// What is a.title? a.metrics.taps?
```

**Write:**

- Observed behavior  
- Root cause (one sentence)  
- Two redesigns (prefer values / don’t store shared services in DTOs)

**Story hook:** Why value-friendly ads models matter (Verified · S1) without inventing metrics.

---



## Exercise 5 — Actor intro sketch `(15–20 min)`

**Prompt:** Given a queue-style API:

```swift
final class SyncedMap {
    private var storage: [String: Int] = [:]
    private let queue = DispatchQueue(label: "synced.map")

    func set(_ key: String, _ value: Int) { /* serialise */ }
    func get(_ key: String) -> Int? { /* serialise */ }
}
```

1. Fill in serial-queue implementations (sync/async choices — speak trade-offs).
2. Rewrite as `actor SyncedMap` with the same method names.
3. Speak the S2 → S2-A1 bridge in ≤45s.

**Do not claim** you rewrote production dictionaries as actors.

---



## Exercise 6 — Timed speaking drill `(25–35 min)`

Record (phone voice memo is fine):

1. Q1 struct vs class
2. Q2 COW
3. Q3 enums vs booleans
4. T1 array mutate after assign
5. T6 payment state machine

Score with `[../../../timing/answer-timing-guide.md](../../../timing/answer-timing-guide.md)`:


| Check                                    | Pass? |
| ---------------------------------------- | ----- |
| Agenda in first 10s                      |       |
| Trade-off mentioned                      |       |
| Production hook without invented metrics |       |
| Finished inside budget                   |       |


Log misses → gotchas file / notes.

---



## Exercise 7 — Social Feed clarifying questions `(20–30 min)`

SD spine warm-up (requirements only mindset):

Write **5 clarifying questions** you would ask before designing a BMS-scale listing/feed (use scale context carefully: 30L+ DAU is Verified · S8 if you mention it).

Examples of good question shapes (write your own):

- Offline / stale content expectations?  
- Ad slots vs organic mixing rules?  
- Pagination vs realtime invalidation?  
- Video autoplay lifecycle (HeroWidget-like)?  
- Failure modes for SDUI-ish components?

Keep this as questions only — full SD is later weeks.

---



## Solutions pointers (don’t spoil yourself)


| Exercise | Look at                                           |
| -------- | ------------------------------------------------- |
| 1–2      | `[code/LoadState.swift](code/LoadState.swift)`    |
| 3        | `[code/COWDemo.swift](code/COWDemo.swift)`        |
| 4        | Deep dive §3 nested references                    |
| 5        | Deep dive §6; production bridge §5                |
| 6        | `[04-questions.md](04-questions.md)` full answers |
| 7        | Your notes; Week 1 SD spine later                 |


---



## Exit criteria

You may mark Day 01 complete when you can, **without notes**:

- [ ] Decision rule for struct / class / enum / actor  
- [ ] COW one-liner + uniqueness nuance  
- [ ] Why enums beat boolean UI flags  
- [ ] ≤20s S1 value-semantics pitch  
- [ ] ≤90s S7 + S7-A1 payment state answer with honest provenance  
- [ ] ≤45s S2 → actor bridge without overclaiming  

Then use the revision twin for spaced drills:  
`[../../../revision/weeks/week-01/day-01.md](../../../revision/weeks/week-01/day-01.md)`