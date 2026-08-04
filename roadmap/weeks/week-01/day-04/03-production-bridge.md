# 03 — Production Bridge

> Resume-honest lines for GCD / synchronised dictionaries.  
> **Verified · S2** core · **How I would apply it · S2-A1** actor coda · **Learning-lab** code.

---

## 1. Story map

| Concept | Label |
|---|---|
| Serial-queue synchronised dictionaries | **Verified · S2** |
| RW locks where read-heavy | **Verified · S2** |
| Standardized access API (no raw storage) | **Verified · S2** |
| Crash/race reduction on that path | **Verified · S2** |
| Greenfield actor migration | **How I would apply it · S2-A1** |
| Crashlytics validation culture | **Verified · S8** soft (don’t attribute CFS solely to S2) |
| SafeDict.swift | **Learning-lab** |

---

## 2. Verified · S2 — Synchronised dictionaries

### What you can say (safe)

- Shared async state hit from multiple queues → data races / intermittent crashes  
- Introduced synchronised dictionaries gated by **GCD serial queues**  
- Used **read-write locks** where access was read-heavy  
- Standardized access API so call sites couldn’t touch raw storage  
- Validated under concurrency stress and Crashlytics watch  
- Eliminated concurrent-access crashes **in that shared state path**  
- Pattern reused where mutable maps were shared across async work  
- Lesson: serialize mutation at the boundary; don’t sprinkle locks ad hoc  
- Today you’d also evaluate a Swift `actor` for new code  

### What you must **not** invent

- Exact crash counts, percentages fixed by this work alone  
- “I alone brought the app to 99.95% CFS” (CFS is S8 culture metric — don’t steal it for S2)  
- Claiming every dictionary in the app was converted  
- Claiming production used your Learning-lab file literally  

### Interview lines

**≤20s:**  
> “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.”

**Timed opener:**  
> “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.”

**STAR Action (~90s):**  
> “Shared mutable dictionaries were accessed from multiple queues, which produced data races and intermittent crashes. I introduced synchronised dictionary wrappers gated by GCD serial queues — and read-write locking where the access pattern was read-heavy — and standardized the access API so call sites could not touch raw storage. We validated under concurrency stress and watched Crashlytics. The races on that path went away, and we reused the pattern wherever shared async maps showed up.”

**Result:**  
> “Eliminated concurrent-access crashes in that shared state path; pattern reused for similar shared maps.”

**Lesson + coda:**  
> “Serialize at the boundary. For greenfield code today I’d evaluate a Swift actor with the same safe API surface.”

> **Provenance:** Verified · S2 · BookMyShow · synchronised dictionaries

---

## 3. How I would apply it · S2-A1

Say explicitly this is design direction, not a claim you rewrote production:

> “Production used GCD. How I’d apply it in a new module is an `actor SafeDict` with get/set/snapshot — callers await, isolation is in the type system, same boundary idea.”

Point at Day 05 [`../day-05/code/SafeDictActor.swift`](../day-05/code/SafeDictActor.swift) as Learning-lab.

> **Provenance:** How I would apply it · S2-A1

---

## 4. Mapping concepts → lines

| Question | Lead | Support |
|---|---|---|
| Serial vs concurrent | Definitions | SafeDict uses serial |
| Thread-safe dict design | Private queue API | S2 |
| async vs sync write | Visibility caveat | Prefer sync for read-after-write |
| Barrier | RW pattern | S2 read-heavy mention |
| Deadlock | sync re-entry | Any serial queue |
| Actors | S2-A1 | Don’t claim shipped actors for S2 |
| Why hide queue | Call sites re-race | S2 standardized API |

---

## 5. Anti-patterns

| Anti-pattern | Fix |
|---|---|
| “Fixed all crashes at BMS” | Path-specific race elimination |
| Inventing crash % | Qualitative intermittent races → eliminated on path |
| `Final class` in code samples | `final class` |
| “Async set always visible on next line” | Teach sync set / visibility |
| Skipping actor coda when asked modern approach | S2-A1 honest label |

---

## 6. Flash map card

**Company / feature:** BookMyShow — synchronised dictionaries  

**What you did:** GCD serial queues / RW locks; safe access API; stress + Crashlytics validation.  

**Interview line (≤20s):**  
> “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.”

→ [S2](../../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow)

---

## 7. Timed drills

| Drill | Budget |
|---|---|
| ≤20s pitch | 20s |
| Full S2 STAR | ≤3 min |
| SafeDict whiteboard | 2 min |
| S2 → S2-A1 migration | 90s |

---

## Next

[`04-questions.md`](04-questions.md) — Answer points first, then Full spoken answer.
