# Audio script — Sample 02 — Cells, reuse & prefetch (Q&A)
> Listen-only sample Q&A from `02-cells-reuse-prefetch.md`. Spoken answers and follow-ups.

## §0 Q1. Why does UITableView/UICollectionView reuse cells?

Next. Q1. Why does UITableView/UICollectionView reuse cells? Answer. Only a small number of cells exist on screen at once. The system dequeues recycled views for new index paths instead of allocating thousands. When the user scrolls, the cell goes to a reuse pool, gets reset, and binds a new model. Without reset, yesterday’s poster shows on today’s movie. Follow-ups. Bind sequence?: dequeue → prepareForReuse → configure(model) → async with token → apply if token matches.. Diffable still need reuse?: Yes — identity drives updates; cells still recycle physically.. Self-sizing jank causes?: Bad estimates, ambiguous layout, image height changes after bind..

## §1 Q2. What must `prepareForReuse` do?

Next. Q2. What must `prepareForReuse` do? Answer. Cancel image and network tasks. Clear image, text, highlighted state. Nil out closures and targets that capture the view controller. Reset swipe/gesture transient U I. Invalidate display tokens or generation IDs. Never configure a recycled cell without this cleanup path. Follow-ups. Retain cycle via cell?: view controller → collection → cell → closure → view controller — use [weak self]; clear in reuse.. HeroWidget in cell?: Stop player in prepareForReuse — same lifecycle contract as BookMyShow Ads pipeline + HeroWidget lifecycle.. Diffable animated diff?: Still need stable Hashable IDs — unstable hashes → flicker/reorder chaos..

## §2 Q3. How does the “wrong image” bug happen?

Next. Q3. How does the “wrong image” bug happen? Answer. Cell binds movie A and starts download A. User scrolls; cell reuses for movie B and starts download B. Download A completes later and sets the image without checking which model owns the cell → wrong poster. Fix: store expectedID on the cell; completion checks ID; cancel task on reuse. Follow-ups. Token pattern?: Generation counter or model ID — apply only if still current.. Prefetch + configure double-fetch?: Repository single-flight per URL coalesces prefetch and cell bind (Day 09 cousin).. Main-thread decode in bind?: Jank — decode off main with size budget (Week 3)..

## §3 Q4. What is prefetching and when does it cancel?

Next. Q4. What is prefetching and when does it cancel? Answer. The system hints upcoming index paths so you can warm data or images before they scroll on screen. Cancel when cancelPrefetchingForItemsAt fires — do not download off-screen forever. Bound concurrency to protect network and battery. Respect Low Data Mode. Tune prefetch distance — aggressive is not always better. Follow-ups. Trap?: Treating prefetch as unlimited download → data usage complaints.. Wi-Fi vs cellular?: Product policy — may throttle on cellular.. Couple with cancellation?: Same discipline as Day 09 — cancel stale work..

## §4 Q5. What are Diffable Data Source benefits and remaining duties?

Next. Q5. What are Diffable Data Source benefits and remaining duties? Answer. Identity-based updates with animated diffs when IDs are stable — fewer reloadData footguns. You still need stable Hashable IDs from your model. Unstable or regenerated IDs cause flicker and reorder chaos. prepareForReuse and async token checks remain mandatory. Follow-ups. When prefer Diffable?: Large dynamic lists with insert/delete/move animations.. Server inserts banner above?: Stable server node IDs — not array indices (Day 10 crossover).. reloadData still valid?: Yes for simple cases — Diffable is for identity-safe diffs..

## §5 Q6. What prefetch rules protect users and App Store reviews?

Next. Q6. What prefetch rules protect users and App Store reviews? Answer. Cancel on cancelPrefetching. Bound concurrent warm operations. Respect Low Data Mode. Tune distance — do not prefetch the entire catalog. Coalesce prefetch and cell fetches through one repository so the same URL is not fetched twice in flight. Follow-ups. Interviewer: “Prefetch caused data bills”?: Bound concurrency, cancel off-screen, Low Data Mode, Wi-Fi policy.. Image pipeline interaction?: prefetch → warm(ids); configure → image(id) coalesced; cancel → drop unneeded warms.. Production claim?: Learning-lab patterns — honest about tuning, not invented savings %..

## §6 Q7. What is the cell + prefetch decision card?

Next. Q7. What is the cell + prefetch decision card? Answer. Cells: reset + cancel in prepareForReuse; token-check async completions. Prefetch: warm + cancel + bound concurrency + Low Data Mode. Diffable: stable IDs. Never configure without a reuse reset path. Wrong image = missing cancel or missing ID check. Follow-ups. Ads wrong creative in cell?: Same token pattern — cancel player and clear on reuse.. Self-sizing mitigation?: Better estimates, prefetch images, stable heights when product allows.. Next topic?: Hybrid interop — 03-hybrid-interop.md..

## §7 Q8. What causes self-sizing collection jank?

Next. Q8. What causes self-sizing collection jank? Answer. Self-sizing jank usually comes from ambiguous Auto Layout, estimated sizes far from reality, images changing height after bind, or heavy main-thread work during bind. Fix estimates, prefetch images so heights stabilize earlier, use stable heights when product allows, and keep cell bind cheap — profile layout with Time Profiler / Core Animation rather than guessing “switch to SwiftUI List.” Follow-ups. Instruments first?: Time Profiler + Core Animation to see layout thrash.. Fixed height OK?: Yes when design allows — avoids multi-pass self-sizing thrash.. SwiftUI List as silver bullet?: Trap — Day 12 has its own identity/layout trade-offs..
