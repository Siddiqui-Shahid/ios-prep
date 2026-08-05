# Sample 02 — Cells, reuse & prefetch (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Why does UITableView/UICollectionView reuse cells?

**Points to:** [Foundations · §4 Cells — intern path](../01-foundations.md#4-cells--intern-path) · [Deep dive · §3 Cells & Diffable](../02-deep-dive.md#3-cells--diffable)

**Answer:**

> Only a small number of cells exist on screen at once. The system dequeues recycled views for new index paths instead of allocating thousands. When the user scrolls, the cell goes to a reuse pool, gets reset, and binds a new model. Without reset, yesterday’s poster shows on today’s movie.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bind sequence? | dequeue → prepareForReuse → configure(model) → async with token → apply if token matches. |
| Diffable still need reuse? | Yes — identity drives updates; cells still recycle physically. |
| Self-sizing jank causes? | Bad estimates, ambiguous layout, image height changes after bind. |

---

### Q2. What must `prepareForReuse` do?

**Points to:** [Foundations · §4 Cells](../01-foundations.md#4-cells--intern-path) · [Deep dive · prepareForReuse checklist](../02-deep-dive.md#prepareforreuse-checklist) · [code/CellReuseGuard.swift](../code/CellReuseGuard.swift)

**Answer:**

> Cancel image and network tasks. Clear image, text, highlighted state. Nil out closures and targets that capture the view controller. Reset swipe/gesture transient UI. Invalidate display tokens or generation IDs. Never configure a recycled cell without this cleanup path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retain cycle via cell? | VC → collection → cell → closure → VC — use `[weak self]`; clear in reuse. |
| HeroWidget in cell? | Stop player in prepareForReuse — same lifecycle contract as S1. |
| Diffable animated diff? | Still need stable Hashable IDs — unstable hashes → flicker/reorder chaos. |

---

### Q3. How does the “wrong image” bug happen?

**Points to:** [Foundations · §12 Cell bind sequence](../01-foundations.md#12-cell-bind-sequence-memorize) · [Deep dive · Wrong-image anatomy](../02-deep-dive.md#wrong-image-anatomy)

**Answer:**

> Cell binds movie A and starts download A. User scrolls; cell reuses for movie B and starts download B. Download A completes later and sets the image without checking which model owns the cell → wrong poster. Fix: store `expectedID` on the cell; completion checks ID; cancel task on reuse.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Token pattern? | Generation counter or model ID — apply only if still current. |
| Prefetch + configure double-fetch? | Repository single-flight per URL coalesces prefetch and cell bind (Day 09 cousin). |
| Main-thread decode in bind? | Jank — decode off main with size budget (Week 3). |

---

### Q4. What is prefetching and when does it cancel?

**Points to:** [Foundations · §5 Prefetch](../01-foundations.md#5-prefetch--intern-path) · [Deep dive · §4 Prefetch budgets](../02-deep-dive.md#4-prefetch-budgets) · [code/PrefetchBudget.swift](../code/PrefetchBudget.swift)

**Answer:**

> The system hints upcoming index paths so you can warm data or images before they scroll on screen. Cancel when `cancelPrefetchingForItemsAt` fires — do not download off-screen forever. Bound concurrency to protect network and battery. Respect Low Data Mode. Tune prefetch distance — aggressive is not always better.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap? | Treating prefetch as unlimited download → data usage complaints. |
| Wi-Fi vs cellular? | Product policy — may throttle on cellular. |
| Couple with cancellation? | Same discipline as Day 09 — cancel stale work. |

---

### Q5. What are Diffable Data Source benefits and remaining duties?

**Points to:** [Deep dive · §3 Diffable benefits](../02-deep-dive.md#diffable-benefits) · [Foundations · §2 Glossary](../01-foundations.md#2-glossary)

**Answer:**

> Identity-based updates with animated diffs when IDs are stable — fewer `reloadData` footguns. You still need **stable Hashable IDs** from your model. Unstable or regenerated IDs cause flicker and reorder chaos. prepareForReuse and async token checks remain mandatory.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When prefer Diffable? | Large dynamic lists with insert/delete/move animations. |
| Server inserts banner above? | Stable server node IDs — not array indices (Day 10 crossover). |
| reloadData still valid? | Yes for simple cases — Diffable is for identity-safe diffs. |

---

### Q6. What prefetch rules protect users and App Store reviews?

**Points to:** [Deep dive · §4 Prefetch budgets table](../02-deep-dive.md#4-prefetch-budgets) · [Deep dive · §18 Prefetch + image pipeline](../02-deep-dive.md#18-prefetch--image-pipeline-interaction)

**Answer:**

> Cancel on cancelPrefetching. Bound concurrent warm operations. Respect Low Data Mode. Tune distance — do not prefetch the entire catalog. Coalesce prefetch and cell fetches through one repository so the same URL is not fetched twice in flight.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer: “Prefetch caused data bills”? | Bound concurrency, cancel off-screen, Low Data Mode, Wi-Fi policy. |
| Image pipeline interaction? | prefetch → warm(ids); configure → image(id) coalesced; cancel → drop unneeded warms. |
| Production claim? | Learning-lab patterns — honest about tuning, not invented savings %. |

---

### Q7. What is the cell + prefetch decision card?

**Points to:** [Deep dive · §14 Decision rule card](../02-deep-dive.md#14-decision-rule-card) · [Deep dive · §21 Extended decision card](../02-deep-dive.md#21-extended-decision-card)

**Answer:**

> Cells: reset + cancel in prepareForReuse; token-check async completions. Prefetch: warm + cancel + bound concurrency + Low Data Mode. Diffable: stable IDs. Never configure without a reuse reset path. Wrong image = missing cancel or missing ID check.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ads wrong creative in cell? | Same token pattern — cancel player and clear on reuse. |
| Self-sizing mitigation? | Better estimates, prefetch images, stable heights when product allows. |
| Next topic? | Hybrid interop — [03-hybrid-interop.md](03-hybrid-interop.md). |

---

Next: [03-hybrid-interop.md](03-hybrid-interop.md)
