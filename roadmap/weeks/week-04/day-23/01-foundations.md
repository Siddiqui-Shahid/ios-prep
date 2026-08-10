# 01 — Foundations: HashMaps & Heaps (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. North star? `(45–60s)`
**Answer:**

> “HashMaps turn repeated scans into expected O(1) lookups when you can design a key. Heaps turn “keep the best K” into O(n log k) instead of full sorts. When the problem is unlabeled, spend 90 seconds classifying before you romanticize either. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. What a Dictionary buys you? `(45–60s)`
**Answer:**

> “text Brute: for i, for j > i … → O(n²) Hash: one pass, look up complement → expected O(n), space O(n).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Intern demo — Two Sum? `(45–60s)`
**Answer:**

> “I pick hash when I need indices or unsorted input; I mention sort alternative when memory is tight and indices don’t matter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Average vs worst case (interview script)? `(45–60s)`
**Answer:**

> “Dictionary lookup is expected O(1). Pathological collisions can degrade toward O(n) — theoretical in interviews; I design good keys and state expected O(n) total. Space O(n).” Swift note: keys must be Hashable. Don’t hash mutable identity carelessly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. What a heap buys you? `(45–60s)`
**Answer:**

> “Complexity script:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Min vs max — the interview trap? `(45–60s)`
**Answer:**

> “For Kth largest, a min-heap of size K stores the K largest seen; the root is the smallest among them = Kth largest. Using a max-heap of all n is wasteful.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Swift interview pragmatism? `(45–60s)`
**Answer:**

> “- iOS 18+ / packages may expose Heap; in interviews, a clear array + sift or “I’ll use a binary heap API” narration beats broken boilerplate. - If n is tiny, say “I’d sort — O(n log n) — acceptable here” and move on. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Mixed unknown-pattern — the 90-second protocol? `(45–60s)`
**Answer:**

> “Interviewers paste unlabeled Mediums. First 90 seconds: 1. Restate + constraints (sorted? online? duplicates? memory?). 2. Brute one sentence. 3. Classify: array scan / two pointer / window / hash / heap / tree / graph / binary search / DP-lite. 4. Pick one + reject one alternative aloud.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Complexity cheat card? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. First scripts to memorize? `(45–60s)`
**Answer:**

> “Hash: > “Clarify uniqueness and whether order matters. Brute nested loops O(n²). Optimized: hash complements / frequencies for expected O(n). Edges: empties, duplicates, negatives, unicode keys if strings.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Swift-specific gotchas (say if relevant)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Checklist before Deep Dive? `(45–60s)`
**Answer:**

> “- [ ] Two Sum hash script clean - [ ] Min-heap size K for Kth largest explained - [ ] Negatives → prefix+hash (not window) internalized - [ ] 90s unknown-pattern protocol rehearsed once.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
