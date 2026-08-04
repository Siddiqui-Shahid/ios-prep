# 03 — Production Bridge: Trees Without Fake LeetCode Stories

> Map traversal *shapes* to shipped work. Labels from [`../../../provenance/README.md`](../../../provenance/README.md).

---

## 1. What you may say (Verified)

### Verified · S3 — Backend-driven header / search (BookMyShow)

**Resume anchor:** Generalised protocol-driven main header; search debounce + MVVM state.

**Tree-shaped truth:** CMS/header documents are nested component trees. Reasoning about parent/child layout and “walk the document” is the same *shape* as DFS; “process each section depth” can feel BFS-like. Schema/versioning + fallbacks matter more than which traversal you name.

**Interview line (≤20s):**  
> “Tree BFS/DFS show up in product as view and SDUI trees — I pick BFS for level-aware layout passes and DFS when I need path or subtree decisions.”

**Do not claim:** “We used LeetCode level-order in the header renderer.”

### Verified · S10 — Stories SDK (Raw / Miami Heat)

**Resume anchor:** Standalone reusable Stories SDK across portfolio apps.

**Tree-shaped truth:** SDK public API + internal story/page/frame hierarchy; isolation boundaries are a tree of ownership. Traversal thinking helps when debugging nested presenters — still not a DSA flex.

**Interview line (≤20s):**  
> “In the Stories SDK, nested page/frame structure forced clear ownership boundaries — same discipline as not leaking recursion past a max depth.”

### Verified · S13 — SwiftUI↔UIKit + deeplinks (Raw / Grizzlies)

**Resume anchor:** Hybrid UI; deeplinks + navigation/lifecycle.

**Tree-shaped truth:** Deeplink destinations and nested coordinators form a route tree. Resolving a path is DFS-like; listing siblings at a nav level is BFS-like.

**Interview line (≤20s):**  
> “Deeplink routing is a tree walk — I clarify path vs level concerns the same way I do in interview tree problems.”

---

## 2. How I would apply it (design, not shipped DSA)

| Applied idea | Honest framing |
|---|---|
| Max-depth guard on SDUI JSON | “I’d fail-soft with a placeholder after N nests — crash-free culture, not hero recursion.” Tie soft to **99.95%** mindset (Verified · S8 culture), not a claim you shipped this exact guard. |
| Parent map for “find path to component” | Design interview only — O(n) preprocess. |
| Iterative walk for huge CMS trees | Prefer iterative in production if depth unbounded. |

---

## 3. Metrics — what is and isn’t allowed today

| Allowed if topic drifts behavioral | Not allowed on DSA day |
|---|---|
| **30L+ DAU**, **99.95% crash-free**, **30%+ nav** (LE sheet) as *company context* | Invented “reduced tree walk latency by X%” |
| Qualitative: reusable SDK, hybrid nav shipped | Fake LeetCode volume as resume impact |

---

## 4. STAR pointers (architecture days, not coding narration)

| Need | Story |
|---|---|
| SDUI / header | [story-bank.md](../../../stories/story-bank.md)#S3 |
| SDK modularity | #S10 |
| Deeplink / hybrid | #S13 |
| Fail-soft / reliability culture (depth guards analogy) | #S8 (light touch) |

**Full spoken STAR lives on Day 26.** Today: ≤20s hooks only while coding.

---

## 5. Bridge script (45s) if interviewer asks “when do you use this at work?”

> “I don’t force interview patterns into product code for sport. Where trees appear — SDUI documents, view hierarchies, deeplink graphs — I use the same decision rule: level-aware work leans BFS-shaped; path and subtree decisions lean DFS-shaped. In production I also budget depth and prefer iterative walks when input is untrusted CMS depth, because crash-free sessions beat clever recursion.”

**Provenance:** Verified · S3 · S10 · S13 · learning-lab DSA in `code/`

---

## 6. Anti-patterns in production answers

1. Pretending BookMyShow search is “Two Sum.”
2. Claiming Morris traversal in a UIKit codebase.
3. Confusing District **AI tooling** (S9) with tree algorithms.
4. Skipping complexity when the “production” analogy starts — still say O(n)/O(h) for the interview problem.

→ Questions: [`04-questions.md`](04-questions.md)
'''