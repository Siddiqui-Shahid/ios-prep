# Audio script — Revision guide — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary
> Listen-only revision day guide from `day-04.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Serial vs concurrent queues; main vs global QoS sync vs async and why sync-to-current-queue deadlocks Thread-safe dictionary behind a hidden queue A P I — serial and barrier patterns.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Queue types

Next. 2.1 Queue types. 2.1 Queue types.

## §3 2.2 sync vs async

Next. 2.2 sync vs async. async: schedule and return. sync: block until done — never sync to the queue you’re already on (deadlock). Main is the famous case; any serial queue can deadlock on re-entry.

## §4 2.3 Thread-safe dictionary

Next. 2.3 Thread-safe dictionary. Pattern A — serial queue: sync reads, async/sync writes — all through private queue. Pattern B — concurrent + barrier: parallel reads; writes use .barrier for exclusive access. Visibility rule: async write + sync read may not see the write until the write runs — prefer sync set when you need read-after-write. Hide the queue: expose safe methods only; callers must not touch storage directly (BookMyShow synchronised dictionaries lesson).

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow synchronised dictionaries: BookMyShow — introduced G C D serial queues / read-write locks to eliminate race conditions and concurrent-access crashes in shared async state (synchronised dictionaries). Design: actor SafeDict (not shipped): Greenfield actor migration — how you would expose the same safe A P I with an actor today, not a claim you rewrote production. Interview line (≤20s): “We gated shared dictionaries behind a serial-queue A P I so call sites couldn’t race the storage — crashes went away on that path.” → Synchronised dictionaries (story bank).

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. Serial vs concurrent in one sentence each 2. Why main.sync from main deadlocks — generalize to any serial queue 3. Thread-safe dict Pattern A — who syncs, who asyncs 4. Barrier flag purpose on concurrent queue.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards, SafeDict.swift, and 04-questions.
