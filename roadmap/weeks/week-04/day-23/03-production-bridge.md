# 03 — Production Bridge: Maps & Top-K Without Cosplay

---

## Verified hooks

### Verified · S2 — Synchronised dictionaries (BookMyShow)

**Truth:** Shared maps needed **serialized access** (GCD serial queues / RW locks) to stop races — concurrency ownership, not “I optimized Dictionary hash.”

**≤20s:**  
> “In product code I treat maps as shared mutable state that needs a concurrency boundary — same respect for keyed aggregation I show in hash problems, plus synchronization.”

### Verified · S3 — Search debounce / state

**Truth:** Coalesce in-flight search keys; cancel stale responses — map/set of request identity.

**≤20s:**  
> “Search coalescing is keyed state — counts and last-seen identities show up the same way window maps do in interviews.”

### Verified · S16 — GymFlow top-K similar

**Truth:** Cosine top-K over embeddings; TF-IDF fail-soft. Heap/select is the *mental model* for “best K neighbors,” not a claim you shipped `CFBinaryHeap`.

**≤20s:**  
> “Recommender top-K is the product cousin of heap patterns — keep best K under a score, with a lexical fallback if the model path fails.”

---

## Honesty table

| OK | Not OK |
|---|---|
| “Maps for coalescing and counts” | “Our search is Two Sum” |
| “Top-K similar exercises” | Fake latency % from heap choice |
| Soft S8: aggregate Crashlytics by key | Invented triage metrics |

---

## Bridge script (45s)

> “Interview hash and heap problems train keyed aggregation and top-K selection. In production I’ve used maps for coalescing and safe shared state, and top-K style selection in an on-device recommender. I don’t force LeetCode names onto resume bullets — I reuse the complexity instincts.”

**Provenance:** Verified · S2 · S3 · S16 · learning-lab `code/`

→ [`04-questions.md`](04-questions.md)
