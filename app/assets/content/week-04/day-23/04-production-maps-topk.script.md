# Audio script — Sample 04 — Maps & top-K in production (Q&A)
> Listen-only sample Q&A from `04-production-maps-topk.md`. Spoken answers and follow-ups.

## §0 Q1. What is the BookMyShow synchronised dictionaries synchronised dictionaries hook?

Next. Q1. What is the BookMyShow synchronised dictionaries synchronised dictionaries hook? Answer. Shared maps needed serialized access (G C D serial queues / RW locks) to stop races — concurrency ownership, not “I optimized Dictionary hash.” ≤20s: “In product I treat maps as shared mutable state with a concurrency boundary — same respect for keyed aggregation as hash problems, plus synchronization.” Follow-ups. OK to say?: Maps for coalescing and counts with safe access.. Not OK?: “Our search is Two Sum.”. Soft BookMyShow I M O C + crash-free at scale tie?: Aggregate Crashlytics by key — not invented triage metrics..

## §1 Q2. How does BookMyShow backend-driven header & search search relate to hash patterns?

Next. Q2. How does BookMyShow backend-driven header & search search relate to hash patterns? Answer. Search debounce and coalesce in-flight keys — map/set of request identity. Same keyed-state thinking as window maps and last-seen counts in interviews. ≤20s: “Search coalescing is keyed state — counts and last-seen identities like window maps.” Follow-ups. Verified truth?: Coalesce keys; cancel stale responses — not hash algorithm flex.. M V V M angle?: State keyed by query generation — stale response guard.. Invented latency?: Forbidden..

## §2 Q3. GymFlow GymFlow on-device AI and heap mental model?

Next. Q3. GymFlow GymFlow on-device AI and heap mental model? Answer. Cosine top-K over embeddings; TF-IDF fail-soft. Heap/select is the mental model for “best K neighbors” — not a claim you shipped CFBinaryHeap. ≤20s: “Recommender top-K is the product cousin of heap patterns — best K under a score, with lexical fallback if model path fails.” Follow-ups. Day 24 link?: Full GymFlow architecture — MiniLM + TF-IDF.. Cloud LLM?: Not claimed for GymFlow.. Fake accuracy %?: Forbidden..

## §3 Q4. What is the honesty table for today?

Next. Q4. What is the honesty table for today? Answer. OK: maps for coalescing and counts; top-K similar as exercises; soft BookMyShow I M O C + crash-free at scale aggregate-by-key culture. Not OK: “Our search is Two Sum”; fake latency % from heap choice; invented triage metrics. Follow-ups. Resume trio if behavioral drift?: 30L+ daily active users, 99.95%, 30%+ nav — company context only.. Learning-lab?: All code/ Swift — interview practice.. Provenance file?:../../../provenance/README.md.

## §4 Q5. What is the 45s production bridge script?

Next. Q5. What is the 45s production bridge script? Answer. “Interview hash and heap problems train keyed aggregation and top-K selection. In production I’ve used maps for coalescing and safe shared state, and top-K style selection in an on-device recommender. I don’t force LeetCode names onto resume bullets — I reuse the complexity instincts.” Follow-ups. Verified IDs?: BookMyShow synchronised dictionaries · BookMyShow backend-driven header & search · GymFlow on-device AI · learning-lab code/.. When full STAR?: Day 26 / behavioral — not during LC narration.. After sample?: 07-revision-qna.md.

## §5 Q6. How do hash/heap instincts connect to FinTrack/GymFlow?

Next. Q6. How do hash/heap instincts connect to FinTrack/GymFlow? Answer. GymFlow ranks exercises by cosine similarity — same “keep best K under a score” instinct as heap top-K. FinTrack BM25 retrieval uses keyed lexical scoring — aggregation over local index, not cloud LLM. Product AI is retrieval + rank + degrade — Day 24 expands; today stay at mental-model link only. Follow-ups. Conflate with District District Free Parking + Clean/M V V M + AI tooling?: Tooling AI ≠ product on-device AI.. Heap in shipped GymFlow?: Mental model — don’t claim specific heap A P I unless verified.. Next study day?: Day 24 on-device AI deep dive..
