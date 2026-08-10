# Audio script — Sample 01 — Lifecycle hooks (Q&A)
> Listen-only sample Q&A from `01-lifecycle-hooks.md`. Spoken answers and follow-ups.

## §0 Q1. What is the UIViewController lifecycle order?

Next. Q1. What is the UIViewController lifecycle order? Answer. Say aloud: init → loadView → viewDidLoad → viewWillAppear → viewIsAppearing (i O S 17+) → viewDidAppear → layout callbacks → viewWillDisappear → viewDidDisappear → deinit. Load runs once per view controller instance load. Appear/disappear run every time the screen becomes visible or leaves — including tab switches. Follow-ups. What is viewIsAppearing?: i O S 17+ appear-phase hook — between will and did appear.. When is deinit useful in DEBUG?: Logging to prove no retain cycle — not for critical production cleanup.. Custom container view controller risk?: Must forward appearance transitions or child hooks never fire..

## §1 Q2. What belongs in `viewDidLoad` vs appear hooks?

Next. Q2. What belongs in `viewDidLoad` vs appear hooks? Answer. viewDidLoad: one-time setup — add subviews, bind view model once, configure static U I. Do not assume final bounds; do not fire “forever” network here. viewWillAppear: refresh data every show — scores, headers, throttled refetch. viewDidAppear: analytics “screen viewed”; start players only when actually visible. viewWillDisappear: pause video, cancel in-flight search, stop ads playback. Follow-ups. Heavy sync I/O on appear?: Avoid — blocks transition; async with cancel on disappear.. Analytics on viewDidLoad for tabs?: Wrong — tab may load off-screen; fire on didAppear when visible.. Layout-dependent snap?: viewDidLayoutSubviews when bounds are ready — use carefully to avoid loops..

## §2 Q3. What is the tab bar “load once, appear many” trap?

Next. Q3. What is the tab bar “load once, appear many” trap? Answer. Tab view controllers often load a child view controller once but call appear/disappear every tab switch. If you fetch only in viewDidLoad, data goes stale forever when the user returns. Put refresh policy in appear hooks with caching or throttle (e.g. refetch if older than N seconds). Follow-ups. User opens Tab A then B then A — what reruns?: A: disappear when leaving; appear when returning. viewDidLoad does not rerun.. Is missing viewDidLoad recall a bug?: Often feature — view controller retained in nav stack; repeatable work belongs in appear.. Background refresh while tab hidden?: Possible with policy, but U I bind should respect appear/disappear for players..

## §3 Q4. Where should HeroWidget pause/play tie in? (BookMyShow Ads pipeline + HeroWidget lifecycle)?

Next. Q4. Where should HeroWidget pause/play tie in? (BookMyShow Ads pipeline + HeroWidget lifecycle)? Answer. Revenue contract: visible enough → play; below threshold, disappear, or app background → pause. Implement with view controller viewWillDisappear / viewDidDisappear for full-screen players, collection visibility % for in-feed ads, and background notifications as a third signal. Lifecycle is part of the product contract, not optional plumbing. Follow-ups. Interview one-liner?: “For HeroWidget, lifecycle was part of the revenue contract — pause on disappear and offscreen.”. In-feed vs full-screen?: Full-screen: view controller hooks. In-feed: visibility threshold on scroll.. Background without disappear?: App background notification still pauses — user left the app..

## §4 Q5. What work should never wait for `deinit`?

Next. Q5. What work should never wait for `deinit`? Answer. Critical cleanup — timers, observers, players, network tasks — belongs in viewWillDisappear or explicit teardown. deinit proves retain cycles in DEBUG but may run late or never if something still holds the view controller. Do not rely on it for user-visible behavior. Follow-ups. Timer not invalidated?: Strong retain on target until invalidate — classic cycle (Day 03 recall).. NotificationCenter block A P I?: Store token; remove on disappear/deinit path.. deinit never runs — always a cycle?: No — view controller may still be on stack, in cache, or presented..

## §5 Q6. How do custom containers break lifecycle?

Next. Q6. How do custom containers break lifecycle? Answer. If you swap child VCs in a custom container without forwarding beginAppearanceTransition / endAppearanceTransition, child viewWillAppear and pause/play logic never run. UINavigationController and UITabBarController do this for you; your clever container might not — analytics and media pause break silently. Follow-ups. Symptom in production?: Video plays offscreen; screen analytics double-count or never fire.. UIHostingController child?: Parent appear/disappear should inform nested player pause policies.. Fix?: Forward appearance like Apple’s container VCs, or use standard containers..

## §6 Q7. What should I be able to say after lifecycle foundations?

Next. Q7. What should I be able to say after lifecycle foundations? Answer. “UIKit separates one-time load from every-show appear work. Pause and cancel on disappear. Tabs load once but appear many — refresh on appear. For revenue video, visibility and view controller lifecycle are the product contract. Custom containers must forward appearance or child hooks break.” Follow-ups. One-time vs every-show rule?: Setup in didLoad; refresh and analytics on appear; teardown on disappear.. BookMyShow Ads pipeline + HeroWidget lifecycle provenance?: HeroWidget pause/play tied to visibility / view controller lifecycle.. Next topic?: Cells — reuse and prefetch — 02-cells-reuse-prefetch.md..
