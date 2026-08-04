# Week 1 Flashcards — Swift, Memory, Concurrency, DSA Warm-up

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Metrics only from resume: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs** (LE sheet).

Source days: `weeks/week-01/day-01` … `day-07`.  
Practice with [answer-timing-guide.md](../timing/answer-timing-guide.md).

**≈71 cards** · Tags: `swift` · `memory` · `concurrency` · `dsa` · `mock`

---

## Swift — value / POP / generics (`swift`) · Days 01–02

| Front | Back |
|---|---|
| struct vs class | Value vs reference · Trap: class for all models · Prod: BMS ad DTOs as structs |
| COW | Share buffer until write · Trap: assume A sees B’s mutation · Prod: listing arrays |
| actor (1-liner) | Isolated reference type · Trap: use for all UI · Prod: modernize sync dicts |
| enum state machine | Exhaustive states · Trap: boolean flags · Prod: payment popup |
| `===` | Referential identity · Trap: use for structs · Prod: VC identity |
| indirect enum | Heap box for recursion · Trap: forget indirect · Prod: nested domain trees |
| Prefer values when | No identity needed · Trap: premature class · Prod: Clean models |
| Nested class in struct copy | Reference shared · Trap: think deep copy · Prod: mixed graphs |
| `@MainActor` vs actor | UI affinity vs general isolation · Trap: conflate · Prod: VM on main |
| LoadState\<T\> | idle/loading/loaded/failed · Trap: isLoading+optional · Prod: search MVVM |
| POP | Compose protocols · Trap: deep inheritance · Prod: Ads pipeline |
| associatedtype | Conformer picks type · Trap: use as easy existential · Prod: AdRenderable |
| some vs any | Opaque vs existential · Trap: synonym · Prod: View returns |
| Type erasure | Box PAT · Trap: free · Prod: heterogeneous ads list |
| Protocol extension dispatch | Defaults may be static · Trap: expect override · Prod: shared track() |
| Generics benefit | Specialize + safety · Trap: Any everywhere · Prod: HeroWidget |
| AnyObject protocol | Class-bound · Trap: struct conform · Prod: weak delegate |
| Conditional conformance | where on extension · Trap: always free · Prod: model arrays |
| Composition A & B | Multi-capability · Trap: multiple inheritance myth · Prod: Render+Track |
| Open vs closed SDUI | Registry vs enum · Trap: enum forever · Prod: BMS header |
| Witness table | Dynamic protocol dispatch · Trap: always slow · Prod: cell bind |
| SDK public API | Protocols at boundary · Trap: expose concretes · Prod: Stories SDK |

## Memory / ARC (`memory`) · Day 03

| Front | Back |
|---|---|
| ARC | Retain count via compiler · Trap: GC pauses · Prod: BMS reliability |
| weak | Optional zeroing · Trap: overuse unowned · Prod: network callbacks |
| unowned | Non-optional · Trap: outlive owner · Prod: nested owned child |
| Closure cycle | self↔closure · Trap: forget capture list · Prod: ad completion |
| Leaks vs Graph | Unreachable vs cycles · Trap: same tool · Prod: triage |
| Timer cycle | Target retains · Trap: never invalidate · Prod: live scoreboard ticks |
| Task retain | Task holds locals · Trap: fire-and-forget · Prod: search debounce |
| Abandoned memory | Still referenced · Trap: call it leak · Prod: nav stack caches |
| deinit missing | Cycle checklist · Trap: blame ARC bug · Prod: Crashlytics + Graph |
| Autorelease | Drain temporaries · Trap: always needed · Prod: image loops |
| 99.95% CFS | Reliability bar · Trap: invent metrics · Prod: S8 |
| Delegate weak | Break VC↔delegate · Trap: strong delegate · Prod: UIKit |

## GCD (`concurrency`) · Day 04

| Front | Back |
|---|---|
| Serial queue | Mutex via queue · Trap: sync re-entry · Prod: S2 dicts |
| Concurrent + barrier | RW pattern · Trap: write without barrier · Prod: read-heavy caches |
| sync deadlock | Wait on current queue · Trap: only main · Prod: UI hops use async |
| DispatchGroup | Join parallel work · Trap: forget leave · Prod: prefetch |
| QoS | Priority/energy · Trap: always userInteractive · Prod: analytics batch |
| Race | Unsynchronized share · Trap: intermittent ignore · Prod: BMS crashes |
| Safe dict API | Hide storage · Trap: return mutable ref · Prod: S2 |
| Semaphore | Limit concurrency · Trap: deadlock wait · Prefer TaskGroup later |
| Main UI rule | UI on main · Trap: parse JSON on main · Prod: search bind |
| async write / sync read | Common serial pattern · Trap: return unsafely · Prod: S2 |
| Reader-writer | Parallel reads · Trap: writer starve · Prod: optional upgrade |
| Actor vs GCD | Language isolation · Trap: rewrite all now · Prod: new code actors |

## Swift Concurrency (`concurrency`) · Day 05

| Front | Back |
|---|---|
| Structured concurrency | Parent owns children · Trap: detached everywhere · Prod: search tasks |
| Actor | Isolated mutable state · Trap: no reentrancy · Prod: S2 future |
| Reentrancy | State may change after await · Trap: assume continuity · Prod: token refresh |
| Sendable | Cross-domain safe · Trap: @unchecked casually · Prod: Swift 6 |
| @MainActor | UI isolation · Trap: heavy work on main · Prod: VM |
| Task cancel | Cooperative · Trap: kill thread · Prod: debounce |
| async let | Fixed parallel · Trap: unbounded fanout · Prod: dual fetch |
| TaskGroup | Dynamic parallel · Trap: forget await all · Prod: prefetch |
| async vs GCD | Await + structure · Trap: throw GCD away blindly · Prod: mixed codebase |
| Detached | Independent lifetime · Trap: default choice · Prod: rare |
| Hop to main | await MainActor · Trap: sync main · Prod: bind UI |
| Migration pitch | Queue dict → actor · Trap: big-bang rewrite · Prod: S2 |

## DSA warm-up (`dsa`) · Day 06

| Front | Back |
|---|---|
| Two pointers opposite | Sorted pair / palindrome · O(n) |
| Sliding window variable | Longest with constraint · expand/shrink |
| Kadane | Max subarray · running reset |
| Prefix sum | Range sum O(1) after O(n) |
| Frequency map | Anagram / counts |
| Say first | Clarify→brute→opt→edges |
| Swift String index | Not random O(1) · use Array |
| Write pointer | In-place filter/dedup |
| Two Sum map | value→index · O(n) |
| Container water | Ends inward · O(n) |

## Mock meta (`mock`) · Day 07

Pin weak cards from Days 01–06; full mock agenda lives in `weeks/week-01/day-07.md`. Keep only:

| Front | Back |
|---|---|
| Mock agenda opener | “Defs → concurrency deep dive → story → feed HLD” |
| Score 5 means | On time + trade-off + prod proof |
| SD clarify first | DAU, offline, pagination |

---

### Drill tips

1. Cover Back; speak Front answer in **30–45s** with one BMS/District/Raw hook when relevant.
2. Pin weak cards into Week 2 daily warm-up.
3. Full list for Anki: [anki-import.csv](anki-import.csv).
