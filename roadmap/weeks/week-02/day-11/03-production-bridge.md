# 03 — Production Bridge: Grizzlies Hybrid + LE Bottom Sheet

> Interview stories without overclaiming.

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S13** | Verified | Memphis Grizzlies: **SwiftUI + UIKit** interop architecture; **deeplinks** + navigation/lifecycle; **Mixpanel** + **Airship** |
| **S6** | Verified | BMS **LE Bottom Sheet**; reduced full-screen navigations for **30%+ of user flows** |
| **S1** | Verified | Ads **HeroWidget** pause/play with visibility / VC lifecycle |
| Learning-lab | Illustrative | Cell/prefetch/hosting code samples |

### Forbidden

- Invent nav % other than resume **30%+**
- “Dual stacks in sync continuously” as best practice
- Claim Airship/Mixpanel without lifecycle discipline story when asked nav
- Invent Grizzlies crash-free % 

## 2. S13 STAR (2–3 min)

### Opener

> “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — not ad-hoc hosting.”

### Situation

Production NBA app needed modern SwiftUI features beside existing UIKit, plus growth tooling (analytics/push).

### Action

1. Architected key UI with **SwiftUI + UIKit interoperability** — hosting/representables with sizing and lifecycle considered.
2. Deep linking with **navigation/lifecycle handling**; cold-start readiness queue mindset.
3. Integrated **Mixpanel** + **Airship** so taps route through the same navigation story.

### Result

Shipped hybrid UI with production navigation and engagement stack.

### Lesson

Interop costs (identity, lifecycle, hosting) must be **designed**, not bolted.

> **Provenance:** Verified · S13 · Raw/Grizzlies · hybrid UI + deeplinks + Mixpanel/Airship

## 3. S6 STAR beat (2–3 min or impact answer)

### Opener

> “I’ll cover the LE Bottom Sheet — a lightweight event overview that cut full-screen navigations for 30%+ of user flows.”

### Action

1. Led end-to-end lightweight event-overview bottom sheet.  
2. Aligned PM, Design, Backend on API contracts and content.  
3. Shipped reusable component into high-traffic flows.

### Result

**30%+** fewer full-screen navigations for user flows (resume metric).

### Lesson

Small UI surfaces with clear contracts beat large rewrites for navigation pain.

> **Provenance:** Verified · S6 · BookMyShow · LE Bottom Sheet · 30%+ nav

## 4. S1 lifecycle hook (30–45s insert)

When asked where ads video pauses: disappear / offscreen / background — HeroWidget protocolised behavior.

> **Provenance:** Verified · S1 · HeroWidget lifecycle

## 5. Interview lines ≤20s

**S13:** “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — not ad-hoc hosting.”

**S6:** “I shipped a reusable LE Bottom Sheet that reduced full-screen navigations for 30%+ of user flows by keeping event overview in context.”

## 6. Topic mapping

| Topic | Verified? | Speak |
|---|---|---|
| Hybrid architecture | S13 | Yes |
| Deeplink router ownership | S13 | Yes — designed handling |
| Mixpanel/Airship | S13 | Yes |
| Exact hosting sizingOptions API | Learning-lab | Teaching detail |
| LE sheet + 30%+ | S6 | Yes — resume metric |
| HeroWidget pause | S1 | Yes |

## 7. Interviewer pushes

| Push | Strong reply |
|---|---|
| “Why not pure SwiftUI?” | Legacy UIKit + ship velocity; hybrid with one nav owner. |
| “Why not a new tab for LE?” | Tabs change IA; sheet fixes local friction; 30%+ metric. |
| “Hosting height broken?” | Intrinsic/sizing ownership; avoid nested scroll fights. |
| “Prefetch caused data bills.” | Bound concurrency; cancel; Low Data Mode. |
| “Push opened wrong screen.” | Single router; same path as deeplinks. |

## 8. Practice

**60s S13:** hybrid need → interop + deeplink owner → Mixpanel/Airship same path → lesson design costs.  
**60s S6:** nav fatigue → sheet + contracts → 30%+ → small surface lesson.  
**3 min:** add cell reuse / ads pause if asked.

## 9. Links

- Code: [code/](code/)
- Questions: [04-questions.md](04-questions.md)
- Revision: [../../../revision/weeks/week-02/day-11.md](../../../revision/weeks/week-02/day-11.md)
- Stories: [S13](../../../stories/story-bank.md)#s13--swiftuiuikit--deeplinks--analyticspush-raw--memphis-grizzlies · [S6](../../../stories/story-bank.md)#s6--le-bottom-sheet-bookmyshow
