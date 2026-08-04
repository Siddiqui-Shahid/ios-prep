# Day 05 — Production Bridge: S2, S2-A1, S3

> Map concurrency concepts to verified BookMyShow work and honest applied extensions.  
> Registry: [`../../../provenance/README.md`](../../../provenance/README.md)

---

## 1. Verified · S2 — Synchronised dictionaries (BookMyShow)

> **Provenance:** Verified · S2 · BookMyShow · synchronised dictionaries via GCD serial queues and RW locks

### Situation / Task

Shared async state was hit from multiple queues. Unsynchronized dictionary mutation produced data races and intermittent crashes on that path.

### Action (what you can claim)

1. Introduced **synchronised dictionaries** gated by **GCD serial queues** (and read-write locks where read-heavy).
2. Standardized a **closed access API** so call sites could not touch raw storage.
3. Validated under concurrency stress and watched Crashlytics for that failure mode.

### Result (honest scope)

Eliminated concurrent-access crashes **on that shared-state path**. Pattern reused where mutable maps were shared across async work.

**Do not say:** “This alone produced 99.95% crash-free.” Crash-free is an app-wide reliability culture metric (S8 adjacency). S2 owns the race fix on the dictionary path.

### Lesson

Serialize mutation at the boundary. Don’t sprinkle locks ad hoc across call sites.

### Timed opener (≤15s)

> “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.”

### 90–120s STAR spine (practice aloud)

> “Shared maps were read and written from multiple async contexts, which caused intermittent crashes. We hid the storage behind a synchronised-dictionary API: writes scheduled on a serial queue, reads synchronized for a safe snapshot, and where reads dominated we used a reader-writer approach. Call sites never touched the raw dictionary. That removed the race class on that path. Trade-off: `sync` reads can deadlock if misused on the same queue, and under extreme read contention you revisit the locking strategy. Today, for greenfield modules, I’d consider a Swift actor with the same API surface.”

Full story text: [story-bank S2](../../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow)

---

## 2. How I would apply it · S2-A1 — Actor migration for greenfield

> **Provenance:** How I would apply it · S2-A1 · greenfield shared maps → Swift `actor`

This is **design judgment**, not a claim that BMS rewrote all dictionaries to actors.

### Migration pitch (interview-ready)

**Goal:** Keep the **same safe API ideas** (hide storage, serialize mutation), change the **implementation** to language-native isolation.

| Legacy (S2) | Greenfield (S2-A1) |
|---|---|
| `final class SafeDict` + serial queue | `actor SafeDict` |
| `sync` get / `async` set on queue | `await get` / `await set` |
| Manual discipline not to expose storage | Compiler-enforced isolation |
| Deadlock risk with `queue.sync` | Reentrancy across `await` instead |

### Strangler strategy (say this if asked “how do you migrate?”)

1. **Don’t big-bang** rewrite every call site in a revenue app.
2. Introduce `actor SafeDict` for **new modules** / new shared maps.
3. Optionally wrap the actor behind an async façade that matches domain needs.
4. Leave stable GCD dictionaries alone until a feature touch requires change.
5. Teach the team the **reentrancy** rule so “we moved to actors” doesn’t create logic bugs.

### API shape to defend

See [code/SafeDictActor.swift](code/SafeDictActor.swift):

- Generic `Key: Hashable & Sendable`, `Value: Sendable`
- `get` / `set` / `remove` / `snapshot`
- Never return a mutable interior reference that callers can race

### 45–60s applied answer

> “Production fix was GCD serial-queue dictionaries — Verified S2. For greenfield shared maps I’d expose an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite a stable module just for fashion; I’d strangler-migrate at boundaries and train on actor reentrancy so state is re-validated after await.”

---

## 3. Verified · S3 — Search debounce and Task cancellation

> **Provenance:** Verified · S3 · BookMyShow · backend-driven header; search debounce, state, MVVM

S3 is broader (SDUI header + search UX). For **this day**, the concurrency slice is:

- Debounced search input
- Explicit loading / empty / error state
- MVVM binding
- Cancellation so in-flight requests don’t clobber newer queries

### Concurrency lesson from S3

Debounce is not only `sleep(300ms)`. The senior piece is **cancel the previous Task** (and treat `CancellationError` as normal).

### Interview line (≤20s)

> “For search we debounced and cancelled the previous in-flight Task so slower older responses couldn’t overwrite fresher results.”

### Tie-back to Day 05 vocabulary

| Concept | S3 application |
|---|---|
| Unstructured `Task` | Started from UI/ViewModel boundary |
| Cooperative cancel | New keystroke cancels prior Task |
| `@MainActor` VM | UI state updates on main |
| Structured vs unstructured | Prefer cancel handles at this boundary |

Full story: [story-bank S3](../../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow)

---

## 4. What not to invent

| Claim | Status |
|---|---|
| GCD synchronised dictionaries at BMS | ✅ Verified · S2 |
| Actor migration shipped org-wide at BMS | ❌ Not verified — use S2-A1 “how I would apply it” |
| Search debounce / MVVM at BMS | ✅ Verified · S3 |
| Specific ms debounce constant from production | ❌ Don’t invent numbers |
| S2 caused app-wide 99.95% CFS alone | ❌ Overclaim — CFS is S8 culture/metric |

---

## 5. Ready-to-speak bridges (keep short)

### Bridge A — GCD → actors (S2 → S2-A1)

> “We serialized dictionary access with GCD. Actors are the language-native equivalent for new code: same boundary idea, compiler isolation, but revalidate after await.”

### Bridge B — Cancellation (S3)

> “Unstructured Tasks need ownership. In search, I store the Task and cancel on each query change so cancellation is part of the product behavior, not an afterthought.”

### Bridge C — Settings humility (Swift 6)

> “Under Swift 6 checking when enabled, Sendable and isolation violations become errors. Default MainActor isolation is a setting, not something I assert as universal.”

---

## 6. Social feed / SD adjacent note (light)

If Week 1 social-feed HLD asks where concurrency fits:

- Image/poster prefetch → TaskGroup with a bound
- Feed pagination → cancel in-flight page on pull-to-refresh
- In-memory metadata maps → actor or GCD-safe store (S2 / S2-A1)

Keep this as architecture judgment; don’t claim a specific BMS feed implementation detail not in the registry.
