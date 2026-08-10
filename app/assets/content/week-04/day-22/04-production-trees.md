# Sample 04 — Trees in production systems (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. How do trees show up in SDUI / header work (BookMyShow backend-driven header & search)?
**Answer:**

> CMS and header documents are **nested component trees**. Walking parent/child layout is DFS-shaped; processing each section depth can feel BFS-like. Schema versioning and unknown-type fallbacks matter more than naming LeetCode level-order. **Do not claim:** “We used LeetCode BFS in the header renderer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s interview line? | “Tree traversals map to SDUI and view trees — BFS for level-aware passes, DFS for path/subtree decisions.” |
| What *is* verified for BookMyShow backend-driven header & search? | Protocol-driven header, search debounce, MVVM state. |
| Day 25 link? | Brief B SDUI renderer — same fail-soft instinct. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What is the Stories SDK tree angle (Stories SDK (Raw / Miami Heat))?
**Answer:**

> Stories SDK has story/page/frame hierarchy — a tree of ownership and isolation boundaries. Traversal thinking helps debug nested presenters, but this is **not** a DSA flex. ≤20s: “Nested page/frame structure forced clear ownership — same discipline as bounding recursion depth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume anchor? | Standalone reusable Stories SDK across portfolio apps. |
| Max-depth guard analogy? | Design: fail-soft placeholder after N nests — crash-free culture, not a shipped claim unless verified. |
| STAR timing? | Full STAR on Day 26; today ≤20s hooks while coding. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do deeplinks relate to tree walks (Hybrid UI / deeplinks)?
**Answer:**

> Deeplink destinations and nested coordinators form a **route tree**. Resolving a specific path is DFS-like; listing siblings at a navigation level is BFS-like. Same clarify-first habit as interview tree problems: path vs level concern.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified anchor? | Hybrid UI; deeplinks + navigation/lifecycle. |
| Production iterative walk? | Prefer iterative when CMS/JSON depth is unbounded — reliability over clever recursion. |
| Invented metric? | Forbidden — no “reduced tree walk latency X%.” |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What metrics may I mention on a DSA tree day?
**Answer:**

> **Allowed** if behavioral drift: **30L+ DAU**, **99.95% crash-free**, **30%+ nav** as company context. Qualitative: reusable SDK, hybrid nav shipped. **Not allowed:** invented “solved N trees in prod” or fake latency % from traversal choice.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow IMOC + crash-free at scale soft touch? | Fail-soft / depth guards tie to crash-free **culture** — not a Memory Graph war story. |
| Learning-lab code? | All LeetCode Swift in `code/` — interview practice, not shipped product. |
| When full STAR? | Day 26 architecture/behavioral — not while narrating LC medium #5. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q5. What is the 45s bridge if asked “when do you use this at work?”?
**Answer:**

> “I don’t force interview patterns into product code for sport. Where trees appear — SDUI documents, view hierarchies, deeplink graphs — I use the same rule: level-aware work leans BFS-shaped; path and subtree decisions lean DFS-shaped. In production I budget depth and prefer iterative walks when input is untrusted CMS depth, because crash-free sessions beat clever recursion.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Applied max-depth guard? | Design-only unless verified — placeholder after N nests. |
| Parent map for component path? | O(n) preprocess — design interview, not resume claim. |
| Anti-pattern? | “Our search is level-order BFS” — cosplay. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What production anti-patterns should I avoid?
**Answer:**

> Don’t map every LC problem to a resume bullet. Don’t invent fill-rate or latency ms from traversal choice. Don’t claim Instruments proved a “tree optimization.” Don’t blur learning-lab Swift with BookMyShow production. Keep hooks ≤20s while coding; save STAR for behavioral days.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Honest framing for depth guard? | “I’d design fail-soft — tie to 99.95% mindset, not ‘I shipped this guard.’” |
| STAR pointers? | BookMyShow backend-driven header & search header, Stories SDK (Raw / Miami Heat) SDK, Hybrid UI / deeplinks deeplink, BookMyShow IMOC + crash-free at scale reliability — story-bank IDs. |
| After sample? | [07-revision-qna.md](07-revision-qna.md) for timed two-layer Q&A. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks; BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

Next: main [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the Stories SDK tree angle (Stories SDK (Raw / Miami Heat))

**Ask yourself:** What is the Stories SDK tree angle (Stories SDK (Raw / Miami Heat))?

**Answer:** “Stories SDK has story/page/frame hierarchy — a tree of ownership and isolation boundaries. Traversal thinking helps debug nested presenters, but this is **not** a DSA flex. ≤20s: “Nested page/frame structure forced clear ownership — same discipline as bounding recursion depth.”

### Puzzle B — How do deeplinks relate to tree walks (Hybrid UI / deeplinks)

**Ask yourself:** How do deeplinks relate to tree walks (Hybrid UI / deeplinks)?

**Answer:** “Deeplink destinations and nested coordinators form a **route tree**. Resolving a specific path is DFS-like; listing siblings at a navigation level is BFS-like. Same clarify-first habit as interview tree problems: path vs level concern.”

### Puzzle C — What metrics may I mention on a DSA tree day

**Ask yourself:** What metrics may I mention on a DSA tree day?

**Answer:** “**Allowed** if behavioral drift: **30L+ DAU**, **99.95% crash-free**, **30%+ nav** as company context. Qualitative: reusable SDK, hybrid nav shipped. **Not allowed:** invented “solved N trees in prod” or fake latency % from traversal choice.”
