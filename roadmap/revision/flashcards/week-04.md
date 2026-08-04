# Week 4 Flashcards — DSA, On-device AI, Behavioral, Mock Tips

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Resume metrics only: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs**.

Source days: `weeks/week-04/day-22` … `day-28`.

**≈70 cards** · Tags: `dsa` · `ai` · `behavioral` · `machine` · `mock` · `bms`

---

## Trees BFS/DFS (`dsa`) · Day 22

| Front | Back |
|---|---|
| BFS vs DFS trigger | Levels/shortest unweighted → BFS; path/subtree/LCA/structure → DFS · Trap: using DFS for “level averages” · Prod: layout pass vs path resolve |
| Level-size BFS idiom | `for i in 0..<queue.count` each wave · Trap: mixing levels · Prod: batch UI updates by depth |
| BST validate | Bounds or inorder sorted · Trap: only compare parent · Prod: schema validation analogy |
| LCA binary tree | Postorder both-sides found → node · Trap: assuming BST walk · Prod: nearest shared nav ancestor |
| Tree complexity script | O(n) time; O(h)/O(w) space; worst O(n) · Trap: saying O(1) recursive · Prod: skewed CMS tree |
| Diameter one-pass | DFS height + global left+right max · Trap: root-only sum · Prod: longest dependency chain metaphor |
| Serialize need | Explicit nulls or count headers · Trap: values-only preorder · Prod: SDUI versioning |
| Inorder use | BST sorted ops, k-th · Trap: inorder on non-BST for “sorted” · Prod: — |
| Say this first | Clarify → brute → optimize → complex → edges → code · Trap: silent coding · Prod: senior signal |
| Symmetric tree | Mirror DFS or BFS pair queue · Trap: only check root children · Prod: mirrored layout QA |

## HashMap / Heap / mixed (`dsa`) · Day 23

| Front | Back |
|---|---|
| Two Sum default | Hash complement O(n) · Trap: sort loses indices · Prod: id→model maps |
| Top-K heap size | Min-heap size K → O(n log k) · Trap: max-heap confusion for Kth largest stream · Prod: top similar items |
| Prefix sum + hash | Subarray sum K with negatives · Trap: two pointer · Prod: analytics rollups |
| Window + counts | Shrink when invariant breaks · Trap: forget remove at 0 · Prod: debounce coalescing keys |
| Merge K lists | Heap heads O(N log K) · Trap: full sort only · Prod: merge paginated cursors metaphor |
| Hash complexity say | Expected O(1); space O(n) · Trap: claiming worst O(1) always · Prod: synchronised dict access ≠ hash math |
| Unknown pattern 90s | Clarify brute classify pick · Trap: code silently · Prod: senior signal |
| Bucket top-K freq | O(n) when freq ≤ n · Trap: always heap · Prod: — |
| Heap wrong when | Need full order / keyed delete · Trap: heap for everything · Prod: — |
| Clone graph | Hash old→new + DFS/BFS · Trap: no map infinite loop · Prod: object graph copy |

## On-device AI (`ai`) · Day 24

| Front | Back |
|---|---|
| On-device RAG | Local retrieve → prompt → generate · Trap: “fine-tune on user data” · Prod: FinTrack BM25 |
| Fail-soft AI | Rules/TF-IDF/capability flags · Trap: blank error only · Prod: S15/S16 |
| Quantization why | Fit RAM/ANE; INT8/INT4 · Trap: ignore quality · Prod: GymFlow MiniLM |
| Hybrid router inputs | Thermal, battery, tokens, capability · Trap: cloud always · Prod: doc HybridAIRouter |
| Privacy script | Local-first; minimize; consent cloud · Trap: HTTPS = privacy · Prod: FinTrack no sync |
| BM25 vs MiniLM | Lexical vs semantic · Trap: one-size · Prod: FinTrack vs GymFlow |
| Hallucinated money | DB is source of truth · Trap: trust tokens · Prod: FinTrack |
| KV-cache | Faster decode; RAM cost; drop on warning · Trap: ignore Jetsam · Prod: doc model manager |
| Token stream UI | Background + main append + cancel · Trap: sync main inference · Prod: — |
| AI tooling vs product AI | Accelerator ≠ on-device architecture · Trap: tool worship · Prod: District vs FinTrack |
| 30L DAU caution | Kill switch, sample, budgets · Trap: run LLM on all sessions · Prod: BMS judgment |
| Empty retrieval | No invent; generic + CTA · Trap: hallucinate · Prod: coach empty state |

## Machine round (`machine`) · Day 25

| Front | Back |
|---|---|
| 3-hr phases | Clarify 15 → slice → depth → tests → buffer · Trap: polish first · Prod: shipping bias |
| Vertical slice | One E2E happy path · Trap: all layers half-done · Prod: — |
| Pagination guard | In-flight + stale token · Trap: double append · Prod: search lists |
| Cache SWR | Show stale then refresh · Trap: empty until network · Prod: perceived perf |
| SDUI unknown type | Fallback not crash · Trap: force unwrap · Prod: S3/S12 |
| Tests enough | 3 meaningful · Trap: 0 or 40 flaky · Prod: District AI judgment |
| Cut line | Say what you skip · Trap: hide gaps · Prod: senior honesty |
| Protocol repo | Fake first then live · Trap: URLSession in VM · Prod: Clean/MVVM |
| Proctor agenda | Speak plan at 0:15 · Trap: silent · Prod: timing guide |
| Perfectionism flag | Styling while core broken · Trap: rename churn · Prod: — |

## Behavioral (`behavioral` `bms`) · Day 26

| Front | Back |
|---|---|
| STAR timing | 20 / 90 / 30 / 20 · Trap: 5-min Action · Prod: all stories |
| Conflict router | S6 or S8 · Trap: vague drama · Prod: 30% nav / IMOC |
| Incident lesson | Stabilize → RCA → prevent · Trap: blame · Prod: 99.95% CFS |
| Mentorship signal | Checklist, SDK, standards · Trap: “I’m nice” · Prod: S10/S14 |
| AI tooling | Context + review · Trap: tool-worship · Prod: S9 |
| Product vs process AI | S15/S16 vs S9 · Trap: conflate · Prod: Day 24 |
| Metrics allowed | 30L DAU, 99.95%, 30% nav · Trap: invent · Prod: resume |
| Failure STAR | Real miss + process change · Trap: humblebrag fail · Prod: — |
| Senior why | Scope + ownership + judgment · Trap: years only · Prod: — |
| Quick picker | Tags → IDs in story bank · Trap: search mid-answer · Prod: — |

## Full-mock tips (`mock`) · Days 27–28

| Front | Back |
|---|---|
| Coding first 3 min | Clarify brute optimize complex edges · Trap: silent code · Prod: — |
| SD 45 clock | 5–10–10–15–5 · Trap: deep dive forever · Prod: cheatsheet |
| Deep dive budget | 45s / 120s / 5 min arch · Trap: lecture · Prod: timing guide |
| Proof trio | 30L DAU / 99.95% / 30% nav · Trap: invent · Prod: resume |
| Protect ops | Always last 5 SD · Trap: cut metrics · Prod: kill switch |
| Blank recovery | Assumption + draw + brute · Trap: apology loop · Prod: — |
| Mock breaks | 10–15 min real · Trap: cram mid-loop · Prod: — |
| Debrief cap | ≤3 fix-forwards · Trap: rewrite life · Prod: Day 28 |
| AI pivot | Fail-soft + privacy · Trap: tool worship · Prod: S15/S9 |
| Score target | ≥3.5 segments · Trap: ignore timing · Prod: — |
| Metric trio | 30L+ DAU / 99.95% CFS / 30%+ nav · Trap: invent · Prod: resume |
| No new topics | Flash + stories + sleep · Trap: one more LC · Prod: — |
| Fail-soft one-liner | Degrade usefully; don’t crash · Trap: blank error · Prod: S15/S16 |
| SD protect ops | Last 5 min failure/metrics · Trap: skip · Prod: — |
| STAR cut | 3 Action bullets if long · Trap: 5 min story · Prod: — |

---

Anki sample: [anki-import.csv](anki-import.csv) · DSA track: [../coding/dsa-track.md](../coding/dsa-track.md) · Timing: [../timing/answer-timing-guide.md](../timing/answer-timing-guide.md)
