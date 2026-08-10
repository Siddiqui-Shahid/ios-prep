# Day 11 — UIKit Lifecycle · Cells · Hybrid UIKit ↔ SwiftUI

> Week 2 · Revision pass ~45–60 min  
> Full study: [weeks/week-02/day-11/](../../../weeks/week-02/day-11/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-11/sample/](../../../weeks/week-02/day-11/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- VC lifecycle order — `viewDidLoad` once vs `viewWillAppear` on every tab switch
- Cell reuse, `prepareForReuse`, and the async-wrong-image trap
- Prefetch: warm + cancel + bound concurrency — not unlimited download
- Hybrid interop: UIHostingController, Representables, one router owner
- Verified Hybrid UI / deeplinks Grizzlies hybrid + BookMyShow LE Bottom Sheet LE Bottom Sheet + BookMyShow Ads pipeline + HeroWidget lifecycle HeroWidget lifecycle

## 2. Concept refresh (simple)

### 2.1 Lifecycle traps

| Hook | When | Trap |
|---|---|---|
| `viewDidLoad` | Once, before first layout | Heavy setup only |
| `viewWillAppear` | Every time VC becomes visible | Tab bars — refresh here, not only in load |
| `viewDidDisappear` | Leaving screen | Pause media, cancel work |

Ads HeroWidget pause/play is a **product contract** tied to visibility — not incidental plumbing.

### 2.2 Cells + prefetch

Reuse pool recycles cells — reset in `prepareForReuse`. Async image loads must check cell/ID before applying — otherwise wrong image on wrong row.

Prefetch warms ahead but must **cancel** on scroll-away and **bound** concurrency — Diffable Data Source helps identity; unlimited prefetch is a battery/network bug.

### 2.3 Hybrid navigation

**One router owner** — dual UIKit + SwiftUI stacks that both present cause double-present bugs. Deeplinks parse at app edge → intent → single coordinator. `UIHostingController` sizing and lifecycle must be designed, not bolted.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Load vs appear | `viewDidLoad` once; tabs **appear many times** — refresh on appear |
| Wrong cell image | Async completion after reuse without ID check |
| Prefetch | Warm + **cancel** + bound concurrency — not unlimited download |
| Hybrid nav | **One router owner** — dual stacks double-present |
| BookMyShow LE Bottom Sheet metric | **30%+** fewer full-screen navigations — resume only |
| Hybrid UI / deeplinks | Hybrid interop + deeplinks **designed**, not bolted |
| BookMyShow Ads pipeline + HeroWidget lifecycle | HeroWidget pause/play is a **product contract**, not plumbing |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-11/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-02/day-11/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-02/day-11/sample/07-revision-qna.md) | Timed answers |

Suggested sample order: `01-lifecycle-hooks` → `02-cells-reuse-prefetch` → `03-hybrid-interop` → `04-production-s13-s6`.

## 4. Map to your work

**Hybrid UI / deeplinks:** Memphis Grizzlies — SwiftUI + UIKit interop architecture; deeplinks + navigation/lifecycle; Mixpanel + Airship.  
**BookMyShow LE Bottom Sheet:** BMS LE Bottom Sheet — **30%+** fewer full-screen navigations (resume metric only).  
**BookMyShow Ads pipeline + HeroWidget lifecycle:** Ads HeroWidget pause/play with visibility / VC lifecycle.

**Interview line (≤20s):** “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — one router, not ad-hoc hosting.”

→ [Hybrid UI / deeplinks Hybrid](../../stories/story-bank.md#s13--memphis-grizzlies--swiftui--uikit-interop) · [BookMyShow LE Bottom Sheet Bottom Sheet](../../stories/story-bank.md#s6--le-bottom-sheet-bookmyshow) · [BookMyShow Ads pipeline + HeroWidget lifecycle HeroWidget](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow)

## 5. Flash prompts

1. `viewDidLoad` vs `viewWillAppear` — tab bar trap
2. Wrong cell image — root cause + fix
3. Prefetch budget — warm, cancel, bound
4. UIHostingController sizing/lifecycle gotcha
5. One router owner — why dual stacks fail
6. BookMyShow LE Bottom Sheet impact line — 30%+ only, no invented nav %
7. BookMyShow Ads pipeline + HeroWidget lifecycle pause/play as product contract
8. Hybrid UI / deeplinks ≤20s hybrid pitch

## 6. Timed drills

| Drill | Budget |
|---|---|
| Lifecycle order + tab trap | 60s |
| Cell reuse + async ID check | 60s |
| Hybrid interop whiteboard | 90s |
| BookMyShow LE Bottom Sheet ≤20s impact pitch | 20s |
| Hybrid UI / deeplinks full STAR | 2–3 min |

Expand from [sample cards](../../../weeks/week-02/day-11/sample/) and [07-revision-qna](../../../weeks/week-02/day-11/sample/07-revision-qna.md) answer points.
