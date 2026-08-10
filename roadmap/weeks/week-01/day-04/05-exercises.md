# 05 — Exercises (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Exercise 1 — SafeDict `(25–35 min)`? `(45–60s)`
**Answer:**

> “Implement code/SafeDict.swift from memory: 1. final class SafeDict<Key: Hashable, Value> 2. private storage + private serial queue 3. get / set (sync) / snapshot / count 4. Optional setAsync with a comment on visibility.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Exercise 2 — Race contrast `(20–30 min)`? `(45–60s)`
**Answer:**

> “Prompt: Write a tiny harness (playground or unit test ideas): 1. Unsynchronized [String: Int] mutated from many queues — expect chaos conceptually. 2. Same operations through SafeDict — expect coherent counts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Exercise 3 — Deadlock lab `(15–20 min)`? `(45–60s)`
**Answer:**

> “Prompt: Deliberately write (but don’t leave in prod): swift queue.async { queue.sync { print("?") } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Exercise 4 — BarrierDict `(20–25 min)`? `(45–60s)`
**Answer:**

> “Implement code/BarrierDict.swift. Speak trade-off vs serial SafeDict in 60s. Mention RW-where-read-heavy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Exercise 5 — Visibility experiment `(15 min)`? `(45–60s)`
**Answer:**

> “Compare: swift dict.setAsync("k", 1) print(dict.get("k")).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Exercise 6 — Timed speaking `(30–40 min)`? `(45–60s)`
**Answer:**

> “Record: 1. Q4 thread-safe dictionary (2 min) 2. Q2 async vs sync 3. T1 visibility 4. T3 re-entry deadlock 5. Full STAR ≤3 min.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Exercise 7 — Actor coda `(10–15 min)`? `(45–60s)`
**Answer:**

> “Read Day 05 ../day-05/code/SafeDictActor.swift. Speak → in ≤90s with honest provenance labels. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Exercise 8 — Visibility assertion note `(10 min)`? `(45–60s)`
**Answer:**

> “Write in your gotchas file (exact wording): > “Async write then sync read may not see the write until the write runs; use sync write for read-after-write.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Exercise 9 — Spelling drill `(5 min)`? `(45–60s)`
**Answer:**

> “Type five times correctly: swift final class SafeDict<Key: Hashable, Value> {.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Exit criteria? `(45–60s)`
**Answer:**

> “- [ ] Sketch SafeDict without notes (final class spelled right) - [ ] State async-write / sync-read caveat correctly - [ ] Explain barrier RW in 45s - [ ] STAR ≤3 min ≥ score 4 target - [ ] coda without claiming shipped actors - [ ] Visibility sentence memorized Revision twin: ../../../revision/weeks/week-01/day-04.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
