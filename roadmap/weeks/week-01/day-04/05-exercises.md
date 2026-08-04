# 05 — Exercises

> After foundations + deep dive + production bridge. Speak while coding.

---

## Exercise 1 — SafeDict `(25–35 min)`

Implement [`code/SafeDict.swift`](code/SafeDict.swift) from memory:

1. `final class SafeDict<Key: Hashable, Value>`  
2. private storage + private serial queue  
3. `get` / `set` (sync) / `snapshot` / `count`  
4. Optional `setAsync` with a comment on visibility  

**Agenda (20s):**  
> “final class, hide storage and queue, sync get/set for read-after-write.”

**Done when:** You can explain why sync set is the teaching default.

---

## Exercise 2 — Race contrast `(20–30 min)`

**Prompt:** Write a tiny harness (playground or unit test ideas):

1. Unsynchronized `[String: Int]` mutated from many queues — expect chaos conceptually.  
2. Same operations through `SafeDict` — expect coherent counts.  

Use `DispatchQueue.concurrentPerform` or many `global().async` + group notify.

**Speak (45s):** What S2 fixed at the API boundary.

---

## Exercise 3 — Deadlock lab `(15–20 min)`

**Prompt:** Deliberately write (but don’t leave in prod):

```swift
queue.async {
  queue.sync { print("?") }
}
```

Predict hang. Then refactor to unlocked internal method pattern.

**Speak (30s):** “Not only main — any serial re-entry sync.”

---

## Exercise 4 — BarrierDict `(20–25 min)`

Implement [`code/BarrierDict.swift`](code/BarrierDict.swift).

Speak trade-off vs serial SafeDict in 60s. Mention S2 RW-where-read-heavy.

---

## Exercise 5 — Visibility experiment `(15 min)`

Compare:

```swift
dict.setAsync("k", 1)
print(dict.get("k"))
```

vs sync `set`. Write one paragraph in your notes stating the interview-safe rule.

---

## Exercise 6 — Timed speaking `(30–40 min)`

Record:

1. Q4 thread-safe dictionary (2 min)  
2. Q2 async vs sync  
3. T1 visibility  
4. T3 re-entry deadlock  
5. Full S2 STAR ≤3 min  

Score with timing guide. Zero invented crash %.

---

## Exercise 7 — Actor coda `(10–15 min)`

Read Day 05 [`../day-05/code/SafeDictActor.swift`](../day-05/code/SafeDictActor.swift).  
Speak S2 → S2-A1 in ≤90s with honest provenance labels.

---

## Exercise 8 — Visibility assertion note `(10 min)`

Write in your gotchas file (exact wording):

> “Async write then sync read may not see the write until the write runs; use sync write for read-after-write.”

Speak it once. Check `SafeDict.set` vs `setAsync` comments.

---

## Exercise 9 — Spelling drill `(5 min)`

Type five times correctly:

```swift
final class SafeDict<Key: Hashable, Value> {
```

Never `Final class`.

---

## Exit criteria

- [ ] Sketch SafeDict without notes (`final class` spelled right)  
- [ ] State async-write / sync-read caveat correctly  
- [ ] Explain barrier RW in 45s  
- [ ] S2 STAR ≤3 min ≥ score 4 target  
- [ ] S2-A1 coda without claiming shipped actors  
- [ ] Visibility sentence memorized  

Revision twin: [`../../../revision/weeks/week-01/day-04.md`](../../../revision/weeks/week-01/day-04.md)
