# Sample 04 — Maps & top-K in production (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What is the BookMyShow synchronised dictionaries synchronised dictionaries hook?
**Answer:**

> Shared maps needed **serialized access** (GCD serial queues / RW locks) to stop races — concurrency ownership, not “I optimized Dictionary hash.” ≤20s: “In product I treat maps as shared mutable state with a concurrency boundary — same respect for keyed aggregation as hash problems, plus synchronization.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| OK to say? | Maps for coalescing and counts with safe access. |
| Not OK? | “Our search is Two Sum.” |
| Soft BookMyShow IMOC + crash-free at scale tie? | Aggregate Crashlytics by key — not invented triage metrics. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q2. How does BookMyShow backend-driven header & search search relate to hash patterns?
**Answer:**

> Search debounce and coalesce in-flight keys — map/set of request identity. Same keyed-state thinking as window maps and last-seen counts in interviews. ≤20s: “Search coalescing is keyed state — counts and last-seen identities like window maps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified truth? | Coalesce keys; cancel stale responses — not hash algorithm flex. |
| MVVM angle? | State keyed by query generation — stale response guard. |
| Invented latency? | Forbidden. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. GymFlow GymFlow on-device AI and heap mental model?
**Answer:**

> Cosine **top-K** over embeddings; TF-IDF fail-soft. Heap/select is the *mental model* for “best K neighbors” — **not** a claim you shipped `CFBinaryHeap`. ≤20s: “Recommender top-K is the product cousin of heap patterns — best K under a score, with lexical fallback if model path fails.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 24 link? | Full GymFlow architecture — MiniLM + TF-IDF. |
| Cloud LLM? | **Not claimed** for GymFlow. |
| Fake accuracy %? | Forbidden. |

**How can I relate to my case:**
- **Shipped:** GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What is the honesty table for today?
**Answer:**

> **OK:** maps for coalescing and counts; top-K similar as exercises; soft BookMyShow IMOC + crash-free at scale aggregate-by-key culture. **Not OK:** “Our search is Two Sum”; fake latency % from heap choice; invented triage metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume trio if behavioral drift? | 30L+ DAU, 99.95%, 30%+ nav — company context only. |
| Learning-lab? | All `code/` Swift — interview practice. |
| Provenance file? | [`../../../provenance/README.md`](../../../provenance/README.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q5. What is the 45s production bridge script?
**Answer:**

> “Interview hash and heap problems train keyed aggregation and top-K selection. In production I’ve used maps for coalescing and safe shared state, and top-K style selection in an on-device recommender. I don’t force LeetCode names onto resume bullets — I reuse the complexity instincts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified IDs? | BookMyShow synchronised dictionaries · BookMyShow backend-driven header & search · GymFlow on-device AI · learning-lab `code/`. |
| When full STAR? | Day 26 / behavioral — not during LC narration. |
| After sample? | [07-revision-qna.md](07-revision-qna.md) |

**How can I relate to my case:**
- **Shipped:** GymFlow on-device AI; BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. How do hash/heap instincts connect to FinTrack/GymFlow?
**Answer:**

> GymFlow ranks exercises by cosine similarity — same “keep best K under a score” instinct as heap top-K. FinTrack BM25 retrieval uses keyed lexical scoring — aggregation over local index, not cloud LLM. Product AI is retrieval + rank + degrade — Day 24 expands; today stay at mental-model link only.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Conflate with District District Free Parking + Clean/MVVM + AI tooling? | Tooling AI ≠ product on-device AI. |
| Heap in shipped GymFlow? | Mental model — don’t claim specific heap API unless verified. |
| Next study day? | Day 24 on-device AI deep dive. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: main [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — How does BookMyShow backend-driven header & search search relate to hash pattern

**Ask yourself:** How does BookMyShow backend-driven header & search search relate to hash patterns?

**Answer:** “Search debounce and coalesce in-flight keys — map/set of request identity. Same keyed-state thinking as window maps and last-seen counts in interviews. ≤20s: “Search coalescing is keyed state — counts and last-seen identities like window maps.”

### Puzzle B — GymFlow GymFlow on-device AI and heap mental model

**Ask yourself:** GymFlow GymFlow on-device AI and heap mental model?

**Answer:** “Cosine **top-K** over embeddings; TF-IDF fail-soft. Heap/select is the *mental model* for “best K neighbors” — **not** a claim you shipped `CFBinaryHeap`. ≤20s: “Recommender top-K is the product cousin of heap patterns — best K under a score, with lexical fallback if model path fails.”

### Puzzle C — What is the honesty table for today

**Ask yourself:** What is the honesty table for today?

**Answer:** “**OK:** maps for coalescing and counts; top-K similar as exercises; soft BookMyShow IMOC + crash-free at scale aggregate-by-key culture. **Not OK:** “Our search is Two Sum”; fake latency % from heap choice; invented triage metrics.”
