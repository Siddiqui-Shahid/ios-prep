# Sample 04 — Production maps & top-K (Q&A)

> Guided teaching. **Verified** hooks only — interview patterns train instincts; don’t cosplay LeetCode on resume.

---

### Q1. What is the S2 synchronised dictionaries hook?

**Points to:** [Production bridge · Verified · S2](../03-production-bridge.md#verified--s2--synchronised-dictionaries-bookmyshow)

**Answer:**

> Shared maps needed **serialized access** (GCD serial queues / RW locks) to stop races — concurrency ownership, not “I optimized Dictionary hash.” ≤20s: “In product I treat maps as shared mutable state with a concurrency boundary — same respect for keyed aggregation as hash problems, plus synchronization.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| OK to say? | Maps for coalescing and counts with safe access. |
| Not OK? | “Our search is Two Sum.” |
| Soft S8 tie? | Aggregate Crashlytics by key — not invented triage metrics. |

---

### Q2. How does S3 search relate to hash patterns?

**Points to:** [Production bridge · Verified · S3](../03-production-bridge.md#verified--s3--search-debounce--state)

**Answer:**

> Search debounce and coalesce in-flight keys — map/set of request identity. Same keyed-state thinking as window maps and last-seen counts in interviews. ≤20s: “Search coalescing is keyed state — counts and last-seen identities like window maps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified truth? | Coalesce keys; cancel stale responses — not hash algorithm flex. |
| MVVM angle? | State keyed by query generation — stale response guard. |
| Invented latency? | Forbidden. |

---

### Q3. GymFlow S16 and heap mental model?

**Points to:** [Production bridge · Verified · S16](../03-production-bridge.md#verified--s16--gymflow-top-k-similar)

**Answer:**

> Cosine **top-K** over embeddings; TF-IDF fail-soft. Heap/select is the *mental model* for “best K neighbors” — **not** a claim you shipped `CFBinaryHeap`. ≤20s: “Recommender top-K is the product cousin of heap patterns — best K under a score, with lexical fallback if model path fails.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 24 link? | Full GymFlow architecture — MiniLM + TF-IDF. |
| Cloud LLM? | **Not claimed** for GymFlow. |
| Fake accuracy %? | Forbidden. |

---

### Q4. What is the honesty table for today?

**Points to:** [Production bridge · Honesty table](../03-production-bridge.md#honesty-table)

**Answer:**

> **OK:** maps for coalescing and counts; top-K similar as exercises; soft S8 aggregate-by-key culture. **Not OK:** “Our search is Two Sum”; fake latency % from heap choice; invented triage metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume trio if behavioral drift? | 30L+ DAU, 99.95%, 30%+ nav — company context only. |
| Learning-lab? | All `code/` Swift — interview practice. |
| Provenance file? | [`../../../provenance/README.md`](../../../provenance/README.md) |

---

### Q5. What is the 45s production bridge script?

**Points to:** [Production bridge · Bridge script](../03-production-bridge.md#bridge-script-45s)

**Answer:**

> “Interview hash and heap problems train keyed aggregation and top-K selection. In production I’ve used maps for coalescing and safe shared state, and top-K style selection in an on-device recommender. I don’t force LeetCode names onto resume bullets — I reuse the complexity instincts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified IDs? | S2 · S3 · S16 · learning-lab `code/`. |
| When full STAR? | Day 26 / behavioral — not during LC narration. |
| After sample? | [`../04-questions.md`](../04-questions.md) |

---

### Q6. How do hash/heap instincts connect to FinTrack/GymFlow?

**Points to:** [Production bridge · S16](../03-production-bridge.md#verified--s16--gymflow-top-k-similar) · [Day 24 GymFlow](../../day-24/02-deep-dive.md#2-gymflow--edge-embeddings-recommender-verified--s16)

**Answer:**

> GymFlow ranks exercises by cosine similarity — same “keep best K under a score” instinct as heap top-K. FinTrack BM25 retrieval uses keyed lexical scoring — aggregation over local index, not cloud LLM. Product AI is retrieval + rank + degrade — Day 24 expands; today stay at mental-model link only.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Conflate with District S9? | Tooling AI ≠ product on-device AI. |
| Heap in shipped GymFlow? | Mental model — don’t claim specific heap API unless verified. |
| Next study day? | Day 24 on-device AI deep dive. |

---

Next: main [`../04-questions.md`](../04-questions.md)
