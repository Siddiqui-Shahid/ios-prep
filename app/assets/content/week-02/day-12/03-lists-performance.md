# Sample 03 — Lists & performance (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. When do I use `List` vs `LazyVStack` vs eager `VStack`?

**Points to:** [Foundations · §6 Lists — intern path](../01-foundations.md#6-lists--intern-path) · [Deep dive · §4 Container choice](../02-deep-dive.md#container-choice) · [code/LazyListNotes.swift](../code/LazyListNotes.swift)

**Answer:**

> **`List`:** platform list behaviors, edit modes, large collections. **`LazyVStack` in `ScrollView`:** custom scroll layouts, large stacks. **Eager `VStack`:** tiny static content only — death for thousands of rows because every child’s `body` runs up front. Lazy containers build on demand as rows enter the viewport.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lazy still janks? | Profile data path — image decode, main-thread JSON, god observable — not only container. |
| 10k rows in VStack? | Never for production — memory and layout cost explode. |
| UITableView cousin? | Same “only visible cells matter” idea — Day 11 reuse discipline. |

---

### Q2. What are the row-level performance rules?

**Points to:** [Deep dive · §4 Row rules](../02-deep-dive.md#row-rules) · [Foundations · §6 Do / Don’t](../01-foundations.md#6-lists--intern-path)

**Answer:**

> Stable `Identifiable` — never `UUID()` per body. Avoid `id: \.self` when value equality changes often. Don’t observe entire catalog inside each row — pass row models. Precompute formatted strings in model. Images: async + decode/size budgets. Scope animations — don’t `.animation` the whole tree.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Format JSON in row body? | Bad — precompute in model or cached formatter. |
| Row observes root `@Observable`? | Pulls entire catalog invalidations into row — pass slice. |
| Shadows and blurs on every row? | Expensive — use sparingly; measure. |

---

### Q3. What is an invalidation storm?

**Points to:** [Foundations · §2 Invalidation storm](../01-foundations.md#2-glossary) · [Deep dive · §2 Granularity and storms](../02-deep-dive.md#granularity-and-storms)

**Answer:**

> One monolithic `@Observable` with many fields, read by a root view, invalidates a **huge subtree** when any field changes. Legacy `ObservableObject` can broadcast coarsely too. Fix: **split models** — player vs chrome vs catalog — and pass slices into children so rows only observe what they need.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Observation unread fields? | `@Observable` skips invalidation for unread properties — but root still reads too much if model is god-object. |
| Whole screen redraw symptom? | Typing in search refreshes unrelated chrome — split state. |
| Equatable View micro-opt? | Useful for rare-changing expensive subtrees — measure first; don’t sprinkle early. |

---

### Q4. How should Stories player lists handle progress updates?

**Points to:** [Foundations · §5 Happy Stories player](../01-foundations.md#5-intern-path-happy-stories-player) · [Deep dive · §7 Stories SDK design](../02-deep-dive.md#7-stories-sdk-design-s10-shape) · [code/StoriesPlayerModel.swift](../code/StoriesPlayerModel.swift)

**Answer:**

> `StoriesPlayerModel` (`@Observable`) owns timeline: idle → loading → playing ⇄ paused → finished. Views render progress from model — not ad-hoc view timers alone. **Stable page IDs** in `ForEach` so progress ticks don’t reset identity. Pause on `onDisappear` and scene background. Adjacent media prefetch with budget (Day 11).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CTA navigation? | Host callback — SDK doesn’t push tickets VC internally. |
| Image bytes? | Injectable loader protocol — host variance. |
| UIKit host? | UIHostingController façade OK — public API shouldn’t force one nav paradigm. |

---

### Q5. What belongs in `body` vs the model for list screens?

**Points to:** [Deep dive · §5 body purity](../02-deep-dive.md#5-body-purity) · [Deep dive · §1 Anti-patterns](../02-deep-dive.md#anti-patterns)

**Answer:**

> **`body`:** compose views from state; cheap cached formatting. **Model / `.task`:** network fetch, sorting large arrays, disk writes. Fetch inside `body` is an anti-pattern. Sort 10k rows every `body` call will jank even inside `LazyVStack`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `.task(id:)`? | Refetch when stable id changes — not every body pass. |
| Cancel on disappear? | Same discipline as UIKit — pause and cancel work. |
| Testing list logic? | XCTest observable model / UseCase primary — not ViewInspector alone. |

---

### Q6. How does SDUI connect to list identity?

**Points to:** [Deep dive · §8 SDUI leaf identity](../02-deep-dive.md#8-sdui-leaf-identity-day-10-crossover)

**Answer:**

> Registry-rendered SDUI trees should use **server-stable node ids** for `ForEach` / `.id`. Array indices break when CMS inserts a banner above — rows jump, state attaches to wrong node, analytics lie. Same stable-ID discipline as native SwiftUI lists.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unknown node type? | Skip + metric — Day 10 fail-soft. |
| Mock #2 SDUI track? | Version gate + registry + fallback — Day 14. |
| Native vs SDUI list? | Both need stable identity — different data source, same rule. |

---

### Q7. What is the lists + performance decision card?

**Points to:** [Deep dive · §14 Decision rule card](../02-deep-dive.md#14-decision-rule-card) · [Deep dive · §11 Trade-offs](../02-deep-dive.md#11-trade-offs)

**Answer:**

> Large collections → lazy container + stable ids + cheap body. Split models to avoid storms. Images async with budgets. No UUID in body. Stories: model timeline + stable page ids + pause on disappear. Profile before micro-opts like Equatable View.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `AnyView` erasure? | Rare need — kills optimization and clarity. |
| All `@State` tiny screen? | OK; async spaghetti if you never hoist domain. |
| Next topic? | S10 production — [04-production-s10.md](04-production-s10.md). |

---

Next: [04-production-s10.md](04-production-s10.md)
