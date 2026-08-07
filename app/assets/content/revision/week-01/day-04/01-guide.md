# Day 04 — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary

> Week 1 · Revision pass ~45–60 min  
> Full study: [weeks/week-01/day-04/](../../../weeks/week-01/day-04/README.md)  
> Sample Q&A (guided): [weeks/week-01/day-04/sample/](../../../weeks/week-01/day-04/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Serial vs concurrent queues; main vs global QoS
- `sync` vs `async` and why sync-to-current-queue deadlocks
- Thread-safe dictionary behind a hidden queue API — serial and barrier patterns
- BookMyShow synchronised dictionaries synchronised dictionaries story in ≤3 min, with honest Design: actor SafeDict (not shipped) coda

## 2. Concept refresh (simple)

### 2.1 Queue types

| Queue | Behavior |
|---|---|
| Main (serial) | UI only |
| Serial private | Mutual exclusion for one resource |
| Concurrent global | Parallelism; QoS userInteractive → background |
| Concurrent + barrier | Reader-writer |

### 2.2 sync vs async

- `async`: schedule and return.
- `sync`: block until done — **never sync to the queue you’re already on** (deadlock). Main is the famous case; any serial queue can deadlock on re-entry.

### 2.3 Thread-safe dictionary

**Pattern A — serial queue:** sync reads, async/sync writes — all through private queue.  
**Pattern B — concurrent + barrier:** parallel reads; writes use `.barrier` for exclusive access.

**Visibility rule:** async write + sync read may not see the write until the write runs — prefer **sync set** when you need read-after-write.

**Hide the queue:** expose safe methods only; callers must not touch storage directly (BookMyShow synchronised dictionaries lesson).

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Shared dict without sync | **Data race** — undefined behavior |
| `main.sync` from main | **Deadlock** — same rule for any serial queue |
| Async write + sync read | May not see write until write runs — prefer sync set for read-after-write |
| Hide the queue | Expose safe methods only — BookMyShow synchronised dictionaries lesson |
| Barrier on concurrent queue | Exclusive writer; plain reads may overlap |
| BookMyShow synchronised dictionaries | Path-specific race elimination on synchronised dictionaries |
| Design: actor SafeDict (not shipped) actor | **How I would apply it** — not a claim you rewrote production |
| Spell it | **`final class`**, never `Final class` |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-01/day-04/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-01/day-04/01-foundations.md) | Gaps |
| Drill | [04-questions](../../../weeks/week-01/day-04/04-questions.md) | Timed answers |

## 4. Map to your work

**BookMyShow synchronised dictionaries:** BookMyShow — introduced GCD serial queues / read-write locks to eliminate race conditions and concurrent-access crashes in shared async state (synchronised dictionaries).  
**Design: actor SafeDict (not shipped):** Greenfield actor migration — how you would expose the same safe API with an actor today, not a claim you rewrote production.

**Interview line (≤20s):** “We gated shared dictionaries behind a serial-queue API so call sites couldn’t race the storage — crashes went away on that path.”

→ [Synchronised dictionaries (story bank)](../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow)

## 5. Flash prompts

1. Serial vs concurrent in one sentence each
2. Why `main.sync` from main deadlocks — generalize to any serial queue
3. Thread-safe dict Pattern A — who syncs, who asyncs
4. Barrier flag purpose on concurrent queue
5. Async write + sync read visibility trap
6. Why hide the queue from callers (BookMyShow synchronised dictionaries)
7. Race vs deadlock — define both
8. BookMyShow synchronised dictionaries ≤3 min STAR — **`final class`** spelling
9. Design: actor SafeDict (not shipped) actor coda — design-only, not “we rewrote prod”

## 6. Timed drills

| Drill | Budget |
|---|---|
| thread-safe dictionary design | 2 min |
| sync vs async + deadlock | 45s |
| BookMyShow synchronised dictionaries full STAR | 3 min |
| Design: actor SafeDict (not shipped) migration coda | 60s |

Expand from [sample cards](../../../weeks/week-01/day-04/sample/), [SafeDict.swift](../../../weeks/week-01/day-04/code/SafeDict.swift), and [04-questions](../../../weeks/week-01/day-04/04-questions.md).
