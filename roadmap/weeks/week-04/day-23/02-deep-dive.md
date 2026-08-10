# 02 — Deep Dive: Hash / Heap Catalogs & Mixed Simulation (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. HashMap pattern catalog? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Prefix sum + hash (negatives break two pointers)? `(45–60s)`
**Answer:**

> “text count = 0; map = {0: 1}; prefix = 0 for x in nums: prefix += x count += map[prefix - K] # how many earlier prefixes make subarray sum K map[prefix] += 1 Trap: Using sliding window two pointers when negatives exist.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Window + counts hygiene? `(45–60s)`
**Answer:**

> “When a key’s count hits 0, remove it (or treat carefully) so map.count reflects distinct keys. Forgetting this breaks “exactly K distinct” variants. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Heap pattern catalog? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Merge K — why not concat + sort? `(45–60s)`
**Answer:**

> “Concat + sort is O(N log N). Heap-of-heads is O(N log K). When K ≪ N, heap wins. Divide-and-conquer pairwise merge is also strong.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Top K frequent — bucket alternative? `(45–60s)`
**Answer:**

> “After frequency map, place numbers into buckets indexed by frequency 0...n. Walk buckets from high to low. O(n) time. Say this as the optimization over heap when applicable. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Mixed unknown-pattern simulation (today’s differentiator)? `(45–60s)`
**Answer:**

> “Drill protocol (90 min block): - Blindfold topic: pick 6 mixed problems (Array/Hash/Heap/Tree). - For each: timer 90s classification only (no code) → write pattern name → then solve or skip. - Goal: 5/6 correct pattern tags before coding.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Trade-offs? `(45–60s)`
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

### Q9. Failure modes? `(45–60s)`
**Answer:**

> “- Hashing mutable objects as keys. - Forgetting decrement/remove at zero in window maps. - Max-heap when you needed min-heap for Kth largest stream. - Returning heap contents unsorted when problem wants sorted top-K — clarify. - Mixed drill: jumping to DP because it “feels hard.” - Silent coding with no classification. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Approach scripts (two-layer ready)? `(45–60s)`
**Answer:**

> “Use these as Answer points skeletons in sample/07-revision-qna.md:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Worked complexity examples? `(45–60s)`
**Answer:**

> “→ 03-production-bridge.md · code/.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
