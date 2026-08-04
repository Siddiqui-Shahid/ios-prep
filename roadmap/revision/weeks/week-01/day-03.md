# Day 03 — ARC, Retain Cycles, weak/unowned, Instruments Leaks

> Week 1 · Phase: Memory · Time budget today: ~4–5 hrs

## 1. Outcome

Explain aloud:

- How ARC works (strong/weak/unowned) and when objects deallocate
- Classic retain cycle patterns (closures, delegates, Timer, NotificationCenter)
- How you’d hunt a leak with Instruments at BMS scale
- Difference between leak, abandoned memory, and high watermark

## 2. Concept deep dive

### 2.1 ARC basics

Strong references increment retain count; at zero, `deinit` runs. `weak` is optional zeroing; `unowned` is non-optional non-zeroing (crash if dangling). Use `unowned` only when lifetimes are provably tied (e.g. child owned by parent).

### 2.2 Cycle hotspots

| Pattern | Fix |
|---|---|
| Closure captures `self` strongly | `[weak self]` + guard |
| Delegate `strong` | `weak var delegate` (AnyObject) |
| Timer targeting self | Block timer + weak / invalidate in deinit |
| NotificationCenter observer (older API) | Token-based / weak observer patterns |
| Parent→child→parent | One side weak/unowned |

### 2.3 Instruments

- **Leaks:** true leaked objects (no pointers)
- **Allocations:** growth, abandoned memory still referenced
- **Debug Memory Graph:** visual cycles in Xcode

At 30L+ DAU, even small leaks in navigation/ad paths become memory pressure and jetsam.

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| always `[weak self]` | Uncertain lifetime | Optional noise; early nil |
| `unowned` | Nested clearly owned | Crash if wrong |
| `unowned(unsafe)` | Extreme perf | Never in app code casually |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Automatic Reference Counting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/) | Canonical |
| Must | Xcode Memory Graph + Leaks instrument (practice once) | Muscle memory |
| Deepen | [crash-reporting-sdk.md](../../../ios-system-design/docs/crash-reporting-sdk.md) — breadcrumbs/OOM skim | Memory ↔ crashes |
| Repo | [social-feed.md](../../../ios-system-design/docs/social-feed.md) image/memory notes if present | Feed memory |

## 4. Map to your work

**Company / feature:** BookMyShow — crash triage / Crashlytics workflows  
**What you did:** Maintained 99.95%+ crash-free via structured crash workflows; memory/race issues were part of reliability work.  
**Interview line (≤20s):** “At 30L+ DAU we treated retain cycles and abandoned VCs as reliability bugs — Memory Graph + Crashlytics, not guesswork.”

→ [S8 IMOC](../../stories/story-bank.md#s8--imoc--crash-free-at-scale-bookmyshow)

## 5. Normal questions

### Q1. How does ARC work? `(30–45s)`
**Skeleton:** Compile-time inserts retains/releases; zero → deinit.  
**Follow-up:** ARC vs GC pause behavior.

### Q2. weak vs unowned? `(45s)`
**Skeleton:** Optional zeroing vs non-optional; crash if dangling.  
**Story:** Closure in ads networking.

### Q3. Common retain cycle? `(45s)`
**Skeleton:** Escaping closure → self → owns closure.  
**Follow-up:** How detect?

### Q4. Should delegates be weak? `(30s)`
**Skeleton:** Yes for class delegates to avoid cycles.  

### Q5. What is a memory leak vs abandoned memory? `(60s)`
**Skeleton:** Unreachable vs reachable but unused.  
**Follow-up:** Which Instruments?

### Q6. Does `[weak self]` always fix cycles? `(45s)`
**Skeleton:** Only if that edge was the cycle; nested captures may remain.  

### Q7. `deinit` not called — checklist? `(60s)`
**Skeleton:** Cycle, singleton ownership, still on screen, timer, observation.  

### Q8. Value types and ARC? `(30s)`
**Skeleton:** Structs aren’t ARC’d; nested classes are.  

### Q9. Autorelease pools — when? `(45s)`
**Skeleton:** Tight loops creating many temporaries (ObjC bridging).  

### Q10. How do you prevent leaks in async Task? `(60s)`
**Skeleton:** Task retains; cancel on disappear; weak self in task body.  

## 6. Tricky questions

### T1. `unowned self` in async callback after VC dismissed `(90s)`
**Trap:** unowned for convenience.  
**Senior answer:** Use weak; unowned crashes if callback outlives VC — common in network/ad SDK callbacks.

### T2. NotificationCenter + closure observer cycle `(90s)`
**Trap:** Forget remove/token.  
**Senior answer:** Store token; remove on deinit; capture list.

### T3. Lazy var closure capturing self `(90s)`
**Trap:** Lazy init cycle.  
**Senior answer:** Lazy closure can capture self strongly during init — careful patterns / weak.

### T4. Collection of closures storing self `(120s)`
**Trap:** Only weak the outer one.  
**Senior answer:** Each escaping closure needs capture discipline; prefer structured concurrency cancellation.

### T5. Why Memory Graph shows cycle but Leaks doesn’t `(90s)`
**Trap:** Tools are synonyms.  
**Senior answer:** Leaks finds unreachable; cycles are reachable → Allocations/Graph.

### T6. UIKit view retain via layer delegate `(90s)`
**Trap:** Only Swift closures matter.  
**Senior answer:** CALayer.delegate strong quirks historically — know UIKit ownership edges.

## 7. Flashcards for today

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

## 8. Practice

- **Coding:** Deliberately create a retain cycle in a Playground/sample, prove with Memory Graph, then fix with `[weak self]`.
- **Story:** Record S8 in 2:30 focusing on triage process.

## 9. Timed drill

1. Q1, Q2, Q5, T1, T5 — record.
2. Score timing.
3. Gotchas log: any weak/unowned confusion.
