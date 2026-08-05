# Sample 04 — Production tree hooks (Q&A)

> Guided teaching. Maps traversal *shapes* to shipped work. **Verified** labels only — no fake LeetCode metrics.

---

### Q1. How do trees show up in SDUI / header work (S3)?

**Points to:** [Production bridge · §1 Verified · S3](../03-production-bridge.md#verified--s3--backend-driven-header--search-bookmyshow)

**Answer:**

> CMS and header documents are **nested component trees**. Walking parent/child layout is DFS-shaped; processing each section depth can feel BFS-like. Schema versioning and unknown-type fallbacks matter more than naming LeetCode level-order. **Do not claim:** “We used LeetCode BFS in the header renderer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s interview line? | “Tree traversals map to SDUI and view trees — BFS for level-aware passes, DFS for path/subtree decisions.” |
| What *is* verified for S3? | Protocol-driven header, search debounce, MVVM state. |
| Day 25 link? | Brief B SDUI renderer — same fail-soft instinct. |

---

### Q2. What is the Stories SDK tree angle (S10)?

**Points to:** [Production bridge · §1 Verified · S10](../03-production-bridge.md#verified--s10--stories-sdk-raw--miami-heat)

**Answer:**

> Stories SDK has story/page/frame hierarchy — a tree of ownership and isolation boundaries. Traversal thinking helps debug nested presenters, but this is **not** a DSA flex. ≤20s: “Nested page/frame structure forced clear ownership — same discipline as bounding recursion depth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume anchor? | Standalone reusable Stories SDK across portfolio apps. |
| Max-depth guard analogy? | Design: fail-soft placeholder after N nests — crash-free culture, not a shipped claim unless verified. |
| STAR timing? | Full STAR on Day 26; today ≤20s hooks while coding. |

---

### Q3. How do deeplinks relate to tree walks (S13)?

**Points to:** [Production bridge · §1 Verified · S13](../03-production-bridge.md#verified--s13--swiftuiuikit--deeplinks-raw--grizzlies)

**Answer:**

> Deeplink destinations and nested coordinators form a **route tree**. Resolving a specific path is DFS-like; listing siblings at a navigation level is BFS-like. Same clarify-first habit as interview tree problems: path vs level concern.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified anchor? | Hybrid UI; deeplinks + navigation/lifecycle. |
| Production iterative walk? | Prefer iterative when CMS/JSON depth is unbounded — reliability over clever recursion. |
| Invented metric? | Forbidden — no “reduced tree walk latency X%.” |

---

### Q4. What metrics may I mention on a DSA tree day?

**Points to:** [Production bridge · §3 Metrics](../03-production-bridge.md#3-metrics--what-is-and-isnt-allowed-today)

**Answer:**

> **Allowed** if behavioral drift: **30L+ DAU**, **99.95% crash-free**, **30%+ nav** as company context. Qualitative: reusable SDK, hybrid nav shipped. **Not allowed:** invented “solved N trees in prod” or fake latency % from traversal choice.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S8 soft touch? | Fail-soft / depth guards tie to crash-free **culture** — not a Memory Graph war story. |
| Learning-lab code? | All LeetCode Swift in `code/` — interview practice, not shipped product. |
| When full STAR? | Day 26 architecture/behavioral — not while narrating LC medium #5. |

---

### Q5. What is the 45s bridge if asked “when do you use this at work?”

**Points to:** [Production bridge · §5 Bridge script](../03-production-bridge.md#5-bridge-script-45s-if-interviewer-asks-when-do-you-use-this-at-work)

**Answer:**

> “I don’t force interview patterns into product code for sport. Where trees appear — SDUI documents, view hierarchies, deeplink graphs — I use the same rule: level-aware work leans BFS-shaped; path and subtree decisions lean DFS-shaped. In production I budget depth and prefer iterative walks when input is untrusted CMS depth, because crash-free sessions beat clever recursion.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Applied max-depth guard? | Design-only unless verified — placeholder after N nests. |
| Parent map for component path? | O(n) preprocess — design interview, not resume claim. |
| Anti-pattern? | “Our search is level-order BFS” — cosplay. |

---

### Q6. What production anti-patterns should I avoid?

**Points to:** [Production bridge · §6 Anti-patterns](../03-production-bridge.md#6-anti-patterns-in-production-answers)

**Answer:**

> Don’t map every LC problem to a resume bullet. Don’t invent fill-rate or latency ms from traversal choice. Don’t claim Instruments proved a “tree optimization.” Don’t blur learning-lab Swift with BookMyShow production. Keep hooks ≤20s while coding; save STAR for behavioral days.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Honest framing for depth guard? | “I’d design fail-soft — tie to 99.95% mindset, not ‘I shipped this guard.’” |
| STAR pointers? | S3 header, S10 SDK, S13 deeplink, S8 reliability — story-bank IDs. |
| After sample? | [`../04-questions.md`](../04-questions.md) for timed two-layer Q&A. |

---

Next: main [`../04-questions.md`](../04-questions.md)
