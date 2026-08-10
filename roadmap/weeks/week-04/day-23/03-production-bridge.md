# 03 — Production Bridge: Maps & Top-K Without Cosplay (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Verified · S2 — Synchronised dictionaries (BookMyShow)? `(45–60s)`
**Answer:**

> “Truth: Shared maps needed serialized access (GCD serial queues / RW locks) to stop races — concurrency ownership, not “I optimized Dictionary hash.” ≤20s: “In product code I treat maps as shared mutable state that needs a concurrency boundary — same respect for keyed aggregation I show in hash problems, plus synchronization.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Verified · S3 — Search debounce / state? `(45–60s)`
**Answer:**

> “Truth: Coalesce in-flight search keys; cancel stale responses — map/set of request identity. ≤20s: “Search coalescing is keyed state — counts and last-seen identities show up the same way window maps do in interviews.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Verified · S16 — GymFlow top-K similar? `(45–60s)`
**Answer:**

> “Truth: Cosine top-K over embeddings; TF-IDF fail-soft. Heap/select is the mental model for “best K neighbors,” not a claim you shipped CFBinaryHeap. ≤20s: “Recommender top-K is the product cousin of heap patterns — keep best K under a score, with a lexical fallback if the model path fails.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Honesty table? `(45–60s)`
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

### Q5. Bridge script (45s)? `(45–60s)`
**Answer:**

> “Interview hash and heap problems train keyed aggregation and top-K selection. In production I’ve used maps for coalescing and safe shared state, and top-K style selection in an on-device recommender. I don’t force LeetCode names onto resume bullets — I reuse the complexity instincts.” Provenance: Verified · · · · learning-lab code/.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
