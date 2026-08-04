# 05 — Exercises

## A. Conceptual

### A1. Lifecycle placement table
For each: start video, refresh list, screen analytics, cancel search — pick hooks.

**Solution:** start video → didAppear+visibility; refresh → willAppear (throttled); analytics → didAppear/disappear; cancel search → willDisappear.

### A2. T/F
1. viewDidLoad runs every tab switch.  
2. prepareForReuse should cancel image tasks.  
3. Dual NavigationPath + UINav is fine if you sync hard.  
4. S6 metric is 30%+ fewer full-screen navs.  
5. Pause ads only in deinit.

**Solution:** 1F 2T 3F 4T 5F

### A3. Provenance rewrite
> “I rebuilt Grizzlies in pure SwiftUI and cut navigation 50%.”

**Solution:** “I architected SwiftUI↔UIKit interop on Grizzlies with deeplink ownership plus Mixpanel/Airship. Separately, on BookMyShow the LE Bottom Sheet reduced full-screen navigations for 30%+ of user flows — I don’t claim a 50% Grizzlies nav metric or a pure-SwiftUI rewrite.”

## B. Coding

### B1. CellReuseGuard
Explain why `generation` token is updated in `prepareForReuse`.

**Solution:** Invalidates in-flight completions tied to prior bind.

### B2. PrefetchBudget
What happens if cancel isn’t called?

**Solution:** Tasks keep running → data/battery burn.

### B3. DeeplinkInbox
Write a sequence: enqueue before ready, markReady, assert order.

## C. Speaking
S13 20s; S6 20s; S6 full 2–3m; T3 dual nav 120s; T5 tab vs sheet 90s.

## D. Whiteboard
Deeplink → router → UIKit host vs SwiftUI host; annotate cold-start queue.

## E. Timed drill
Q7, Q8, Q5 + T3, T5. Timing guide. Log dual-nav + hosting sizing misses.

## F. Flashcards

| Front | Back |
|---|---|
| Pause video | willDisappear/offscreen · S1 |
| Reuse | prepareForReuse · wrong image |
| Prefetch | cancel + budget |
| Hosting | UIHostingController · S13 |
| Representable | make/update · stable id |
| Deeplink | single router · S13 |
| Sheet win | 30%+ · S6 |
| Dual stack | forbidden |

## G. Deeper
1. Visibility threshold policy paragraph for in-feed ads.  
2. List three Mixpanel double-count risks in hybrid hosting.  
3. Sketch LE sheet API: inputs, dismiss, analytics events.


## H. Scenario drills

### H1. In-feed ad visibility (90s speak)
Write a threshold policy: play above 50% visible for 250ms; pause below 50% or on VC disappear or background.

### H2. Cold-start deeplink + push simultaneously
Both fire for the same game screen. How does DeeplinkInbox + dedupe behave?

**Solution sketch:** Queue until ready; identical route intents within short window collapse to one present; analytics once.

### H3. LE sheet API sketch
```text
LEBottomSheet(eventId, summaryDTO, onOpenTickets, onShare, onDismiss)
detents: [.medium, .large]
analytics: le_sheet_open / cta / dismiss
```

### H4. Hosting height war story (60s)
Speak: intrinsic bridging, one scroll owner, avoid recreating hosting VC.

### H5. Cell closure cycle diagram
Draw VC → CV → Cell → closure → VC; mark weak + prepareForReuse clear.
