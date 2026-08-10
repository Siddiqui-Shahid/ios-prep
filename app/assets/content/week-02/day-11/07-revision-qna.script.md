# Audio script — Sample 07 — Revision Q&A (day-11) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Walk UIViewController appearance lifecycle? `(30–45s)`

Next. Q1. Walk UIViewController appearance lifecycle? `(30–45s)` Answer. After load and viewDidLoad for one-time setup, viewWillAppear and viewDidAppear run each time the screen shows — that’s where I refresh on-screen state and start players. On the way out, viewWillDisappear and viewDidDisappear are where I pause video and cancel tasks. Layout callbacks handle bounds. Relying on deinit for critical pause is too late. Follow-ups. Probe deeper?: Pause ad video in viewWillDisappear — waiting for deinit is too late once the user has already left the screen..

## §1 Q2. Why does cell reuse show wrong images? `(45s)`

Next. Q2. Why does cell reuse show wrong images? `(45s)` Answer. Cells are recycled. If an image download for movie A finishes after the cell was reused for movie B, you’ll assign the wrong poster unless you cancel on prepareForReuse and check a generation token or model ID before applying. Clearing handlers matters too so closures don’t retain the wrong context. Follow-ups. Probe deeper?: Cancel the image Task in prepareForReuse and match model ID before applying so a late Movie A response cannot paint Movie B’s cell..

## §2 Q3. Diffable data source benefit? `(30–45s)`

Next. Q3. Diffable data source benefit? `(30–45s)` Answer. Diffable data sources update lists by identity instead of blanket reloadData, which reduces flicker and makes animated diffs practical. You still need stable Hashable identifiers — unstable hashes cause flicker and weird moves. Follow-ups. Probe deeper?: Stable Hashable item IDs let Diffable animate inserts; unstable hashes cause flicker that looks like reloadData all over again..

## §3 Q4. How does prefetching work? `(45–60s)`

Next. Q4. How does prefetching work? `(45–60s)` Answer. UICollectionView prefetching tells you indexPaths likely to appear soon so you can warm images or data. You must implement cancelPrefetching for paths that scroll away, and bound concurrency so prefetch doesn’t become an unbounded downloader — especially on cellular. Follow-ups. Probe deeper?: cancelPrefetchingForItemsAt must tear down work for paths that scrolled away, with a concurrency budget on cellular..

## §4 Q5. Embed SwiftUI in a UIKit app? `(45–60s)`

Next. Q5. Embed SwiftUI in a UIKit app? `(45–60s)` Answer. I embed SwiftUI with UIHostingController, add it as a proper child view controller, pass state through an observable model, and constrain sizing carefully — including safe-area quirks. I avoid recreating the hosting controller on every tiny state change. That’s the hosting half of the Grizzlies hybrid approach. Follow-ups. Probe deeper?: Add UIHostingController as a real child view controller and avoid recreating it on every tiny state tick — Grizzlies hybrid paid that tax..

## §5 Q6. Embed UIKit in SwiftUI? `(45–60s)`

Next. Q6. Embed UIKit in SwiftUI? `(45–60s)` Answer. I wrap UIKit in UIViewControllerRepresentable or UIViewRepresentable, use a Coordinator for delegates, apply prop changes in update, and keep identity stable so SwiftUI doesn’t remake the controller every render. Recreate only when you truly need a fresh instance. Follow-ups. Probe deeper?: Push prop changes through updateUIViewController and keep representable identity stable so SwiftUI doesn’t remake the controller each render..

## §6 Q7. Deeplink into hybrid nav stack — approach? `(60–90s)`

Next. Q7. Deeplink into hybrid nav stack — approach? `(60–90s)` Answer. I parse the URL at the app edge into a typed Intent, then a single router builds or pushes the correct UIKit or SwiftUI host. On cold start I queue until the root is ready. Push notification taps use the same router so Airship doesn’t invent a parallel navigation path. Dual stacks fighting deeplinks is the classic hybrid failure. Follow-ups. Probe deeper?: Parse the URL to a typed Intent at the app edge; one router serves universal links and Airship taps so stacks don’t duel..

## §7 Q8. Bottom sheet vs push — decision? `(45s)`

Next. Q8. Bottom sheet vs push — decision? `(45s)` Answer. Use a sheet when the user needs a glanceable overview and should keep underlying context; push when the flow is a deep hierarchy that needs history. The LE Bottom Sheet on BookMyShow reduced full-screen navigations for 30%+ of user flows by making event overview lightweight. Follow-ups. Probe deeper?: LE Bottom Sheet kept event overview glanceable and reduced full-screen navigations for 30%+ of those flows — keep underlying context..

## §8 Q9. Where do you pause ad video? `(45s)`

Next. Q9. Where do you pause ad video? `(45s)` Answer. Pause when the screen disappears, when the ad scrolls below a visibility threshold, and on app background. Resume only when visibly eligible. On BookMyShow Ads we protocolised HeroWidget pause/play with lifecycle — wasted playback is a product bug on a revenue module. Follow-ups. Probe deeper?: Pause when off-screen, on disappear, and on background; resume only when visibly eligible — HeroWidget made that contractual on Ads..

## §9 Q10. Retain cycle via closure in cell? `(45s)`

Next. Q10. Retain cycle via closure in cell? `(45s)` Answer. A cell holding a strong closure to its view controller which owns the collection view creates a cycle. Capture [weak self], and clear handlers in prepareForReuse so recycled cells don’t keep old view controller references. That’s leak hygiene under scroll pressure. Follow-ups. Probe deeper?: Clear cell action handlers in prepareForReuse and capture [weak self] so recycled cells don’t retain the old view controller..

## §10 Q11. Mixpanel + Airship with UI lifecycle? `(45–60s)`

Next. Q11. Mixpanel + Airship with UI lifecycle? `(45–60s)` Answer. Fire screen analytics from appear/disappear with hybrid hosts in mind so you don’t double-count. Route Airship push taps through the same deeplink router as universal links. Gate S D K initialization on privacy consent. Lifecycle and growth tooling share one navigation story — that was part of the Grizzlies work. Follow-ups. Probe deeper?: Fire screen analytics once per appear across hybrid hosts and route push taps through the same deeplink router as universal links..

## §11 Q12. Self-sizing collection jank causes? `(45–60s)`

Next. Q12. Self-sizing collection jank causes? `(45–60s)` Answer. Self-sizing jank usually comes from ambiguous constraints, estimated sizes far from reality, images changing height after bind, or heavy work on the main thread during bind. Fix estimates, prefetch images, stabilize heights when product allows, and keep cell bind cheap. Follow-ups. Probe deeper?: Bad estimated sizes plus late image height changes force collection invalidation storms — prefetch and stabilize heights when product allows.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “Walk UIViewController appearance lifecycle.?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Walk UIViewController appearance lifecycle.?” — how do you answer without jargon? `(60–90s)` Answer. “After load and viewDidLoad for one-time setup, viewWillAppear and viewDidAppear run each time the screen shows — that’s where I refresh on-screen state and start players. On the way out, viewWillDisappear and viewDidDisappear are where I pause video and cancel tasks. Layout callbacks handle bounds. Relying on deinit for critical pause is too late.” Follow-ups. What concept is this really?: Walk UIViewController appearance lifecycle.. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Why does cell reuse show wrong images” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Why does cell reuse show wrong images” just broke under load. What do you check first? `(60–90s)` Answer. “Cells are recycled. If an image download for movie A finishes after the cell was reused for movie B, you’ll assign the wrong poster unless you cancel on prepareForReuse and check a generation token or model ID before applying. Clearing handlers matters too so closures don’t retain the wrong context.” Follow-ups. What concept is this really?: Why does cell reuse show wrong images. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Diffable data source benefit”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Diffable data source benefit”. How do you diagnose? `(60–90s)` Answer. “Diffable data sources update lists by identity instead of blanket reloadData, which reduces flicker and makes animated diffs practical. You still need stable Hashable identifiers — unstable hashes cause flicker and weird moves.” Follow-ups. What concept is this really?: Diffable data source benefit. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “How does prefetching work”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “How does prefetching work”. What do you say and what fix do you propose? `(60–90s)` Answer. “UICollectionView prefetching tells you indexPaths likely to appear soon so you can warm images or data. You must implement cancelPrefetching for paths that scroll away, and bound concurrency so prefetch doesn’t become an unbounded downloader — especially on cellular.” Follow-ups. What concept is this really?: How does prefetching work. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Embed SwiftUI in a UIKit app”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Embed SwiftUI in a UIKit app”? `(60–90s)` Answer. “I embed SwiftUI with UIHostingController, add it as a proper child view controller, pass state through an observable model, and constrain sizing carefully — including safe-area quirks. I avoid recreating the hosting controller on every tiny state change. That’s the hosting half of the Grizzlies hybrid approach.” Follow-ups. What concept is this really?: Embed SwiftUI in a UIKit app. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Embed UIKit in SwiftUI” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Embed UIKit in SwiftUI” and how you’d correct it? `(60–90s)` Answer. “I wrap UIKit in UIViewControllerRepresentable or UIViewRepresentable, use a Coordinator for delegates, apply prop changes in update, and keep identity stable so SwiftUI doesn’t remake the controller every render. Recreate only when you truly need a fresh instance.” Follow-ups. What concept is this really?: Embed UIKit in SwiftUI. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Deeplink into hybrid nav stack — approach?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Deeplink into hybrid nav stack — approach?” — how do you answer without jargon? `(60–90s)` Answer. “I parse the URL at the app edge into a typed Intent, then a single router builds or pushes the correct UIKit or SwiftUI host. On cold start I queue until the root is ready. Push notification taps use the same router so Airship doesn’t invent a parallel navigation path. Dual stacks fighting deeplinks is the classic hybrid failure.” Follow-ups. What concept is this really?: Deeplink into hybrid nav stack — approach. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Bottom sheet vs push — decision” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Bottom sheet vs push — decision” just broke under load. What do you check first? `(60–90s)` Answer. “Use a sheet when the user needs a glanceable overview and should keep underlying context; push when the flow is a deep hierarchy that needs history. The LE Bottom Sheet on BookMyShow reduced full-screen navigations for 30%+ of user flows by making event overview lightweight.” Follow-ups. What concept is this really?: Bottom sheet vs push — decision. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. They push you to invent a metric you don’t have? `(90–120s)`

Next. T1. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T2. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. They want a one-tool forever answer? `(90–120s)`

Next. T3. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T4. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Main-thread rule under pressure? `(90–120s)`

Next. T5. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. Cancellation honesty? `(90–120s)`

Next. T6. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. Cache invalidation trap? `(90–120s)`

Next. T7. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Security theater vs real pinning? `(90–120s)`

Next. T8. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. SDUI unknown component in prod? `(90–120s)`

Next. T9. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. DI vs singletons under test? `(90–120s)`

Next. T10. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
