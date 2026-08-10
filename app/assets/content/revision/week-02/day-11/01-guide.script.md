# Audio script — Revision guide — UIKit Lifecycle · Cells · Hybrid UIKit ↔ SwiftUI
> Listen-only revision day guide from `day-11.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: view controller lifecycle order — viewDidLoad once vs viewWillAppear on every tab switch Cell reuse, prepareForReuse, and the async-wrong-image trap Prefetch: warm + cancel + bound concurrency — not unlimited download.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Lifecycle traps

Next. 2.1 Lifecycle traps. Ads HeroWidget pause/play is a product contract tied to visibility — not incidental plumbing.

## §3 2.2 Cells + prefetch

Next. 2.2 Cells + prefetch. Reuse pool recycles cells — reset in prepareForReuse. Async image loads must check cell/ID before applying — otherwise wrong image on wrong row. Prefetch warms ahead but must cancel on scroll-away and bound concurrency — Diffable Data Source helps identity; unlimited prefetch is a battery/network bug.

## §4 2.3 Hybrid navigation

Next. 2.3 Hybrid navigation. One router owner — dual UIKit + SwiftUI stacks that both present cause double-present bugs. Deeplinks parse at app edge → intent → single coordinator. UIHostingController sizing and lifecycle must be designed, not bolted.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. Suggested sample order: 01-lifecycle-hooks → 02-cells-reuse-prefetch → 03-hybrid-interop → 04-production-s13-s6.

## §7 4. Map to your work

Next. 4. Map to your work. Hybrid U I / deeplinks: Memphis Grizzlies — SwiftUI + UIKit interop architecture; deeplinks + navigation/lifecycle; Mixpanel + Airship. BookMyShow LE Bottom Sheet: Book My Show LE Bottom Sheet — 30%+ fewer full-screen navigations (resume metric only). BookMyShow Ads pipeline + HeroWidget lifecycle: Ads HeroWidget pause/play with visibility / view controller lifecycle. Interview line (≤20s): “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — one router, not ad-hoc hosting.”.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. viewDidLoad vs viewWillAppear — tab bar trap 2. Wrong cell image — root cause + fix 3. Prefetch budget — warm, cancel, bound 4. UIHostingController sizing/lifecycle gotcha.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
