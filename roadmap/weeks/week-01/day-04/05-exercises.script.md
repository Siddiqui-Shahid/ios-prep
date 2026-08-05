# Audio script — 05 Exercises
> Listen-only audiobook of `05-exercises.md` (Day 04 — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

After foundations + deep dive + production bridge. Speak while coding.

## §1 Exercise 1 — SafeDict `(25–35 min)`

Next. Exercise 1 — SafeDict `(25–35 min)`.

Implement code/SafeDict.swift from memory: final class SafeDict<Key: Hashable, Value> private storage + private serial queue get / set. (sync) / snapshot / count Optional setAsync with a comment on visibility Agenda (20s): “final class. hide storage and queue, sync get/set for read-after-write.” Done when: You can explain why sync set is the. teaching default.

## §2 Exercise 2 — Race contrast `(20–30 min)`

Next. Exercise 2 — Race contrast `(20–30 min)`.

Prompt: Write a tiny harness (playground or unit test ideas): Unsynchronized [String: Int] mutated from many queues. expect chaos conceptually. Same operations through SafeDict. expect coherent counts. Use DispatchQueue.concurrentPerform or many global().async + group notify. Speak (45s): What S2 fixed at the A P I boundary.

## §3 Exercise 3 — Deadlock lab `(15–20 min)`

Next. Exercise 3 — Deadlock lab `(15–20 min)`.

Prompt: Deliberately write (but don’t leave in prod): Here is a simple Swift example, explained in words. queue.async. queue.sync print("?"). What to remember: focus on the idea, not every symbol. Predict hang. Then refactor to unlocked internal method pattern. Speak (30s): “Not only main. any serial re-entry sync.”.

## §4 Exercise 4 — BarrierDict `(20–25 min)`

Next. Exercise 4 — BarrierDict `(20–25 min)`.

Implement code/BarrierDict.swift. Speak trade-off vs serial SafeDict in 60s. Mention S2 RW-where-read-heavy.

## §5 Exercise 5 — Visibility experiment `(15 min)`

Next. Exercise 5 — Visibility experiment `(15 min)`.

Compare: Here is a simple Swift example, explained in words. dict.setAsync("k", 1). print(dict.get("k")). What to remember: focus on the idea, not every symbol. vs sync set. Write one paragraph in your notes stating the interview-safe rule.

## §6 Exercise 6 — Timed speaking `(30–40 min)`

Next. Exercise 6 — Timed speaking `(30–40 min)`.

Record: Q4 thread-safe dictionary (2 min) Q2 async vs sync T1 visibility T3 re-entry deadlock Full S2 STAR. ≤3 min Score with timing guide. Zero invented crash %.

## §7 Exercise 7 — Actor coda `(10–15 min)`

Next. Exercise 7 — Actor coda `(10–15 min)`.

Read Day 05../day-05/code/SafeDictActor.swift. Speak S2. S2-A1 in ≤90s with honest provenance labels.

## §8 Exercise 8 — Visibility assertion note `(10 min)`

Next. Exercise 8 — Visibility assertion note `(10 min)`.

Write in your gotchas file (exact wording): “Async write then. sync read may not see the write until the write runs. use sync write for read-after-write.” Speak it once. Check SafeDict.set vs setAsync comments.

## §9 Exercise 9 — Spelling drill `(5 min)`

Next. Exercise 9 — Spelling drill `(5 min)`.

Type five times correctly: Here is a simple Swift example, explained in words. final class SafeDict Key: Hashable, Value. What to remember: focus on the idea, not every symbol. Never Final class.

## §10 Exit criteria

Next. Exit criteria.

[ ] Sketch SafeDict without notes (final class spelled right) [ ] State async-write / sync-read caveat correctly. [ ] Explain barrier RW in 45s [ ] S2 STAR ≤3 min ≥ score 4 target [. ] S2-A1 coda without claiming shipped actors [ ] Visibility sentence memorized Revision twin:../../../revision/weeks/week-01/day-04.md.
