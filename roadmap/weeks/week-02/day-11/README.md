# Day 11 — UIKit Lifecycle, Cells, Prefetch · Hybrid UIKit ↔ SwiftUI

> Week 2 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-02/day-11.md](../../../revision/weeks/week-02/day-11.md)

## Outcomes

By end of day, without notes, you can:

- Walk **UIViewController lifecycle** landmarks and where to start/stop work (incl. video/ads pause-play)
- Explain **cell reuse**, `prepareForReuse`, Diffable identity, and **prefetch** budgets
- Host **SwiftUI in UIKit** and **UIKit in SwiftUI** without identity/lifecycle bugs
- Deliver **S13** Grizzlies hybrid + deeplinks; **S6** LE Bottom Sheet (**30%+** fewer full-screen navs)
- Tie **S1** HeroWidget pause/play to visibility/VC lifecycle

## How to study

1. `01-foundations.md`
2. `02-deep-dive.md`
3. `03-production-bridge.md`
4. `code/` — CellReuseGuard, PrefetchBudget, HybridHosting
5. `sample/07-revision-qna.md` — Answer points → full spoken
6. `05-exercises.md`
7. Revision twin

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/CellReuseGuard.swift](code/CellReuseGuard.swift), [code/PrefetchBudget.swift](code/PrefetchBudget.swift), [code/HybridHostingNotes.swift](code/HybridHostingNotes.swift) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Provenance reminder

| Label | Meaning |
|---|---|
| **Verified · S13** | Grizzlies SwiftUI↔UIKit interop; deeplinks; Mixpanel; Airship |
| **Verified · S6** | LE Bottom Sheet; **30%+** of user flows fewer full-screen navigations |
| **Verified · S1** | HeroWidget pause/play with visibility / VC lifecycle |
| **Learning-lab** | Cell/prefetch/hosting snippets |

Do **not** invent additional nav % beyond resume’s **30%+**; don’t claim dual NavigationPath+UINavigationController sync as a virtue.

## Agenda opener

> “Lifecycle ownership first, then cells and prefetch budgets, then hybrid identity, then product sheet metric and deeplink routing.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge | 30–40 |
| Questions | 45–60 |
| Exercises | 30–40 |
| Revision skim | 15 |
