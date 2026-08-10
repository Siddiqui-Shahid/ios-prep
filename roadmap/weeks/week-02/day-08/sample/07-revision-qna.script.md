# Audio script — Sample 07 — Revision Q&A (day-08) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Explain MVVM vs MVC? `(30–45s)`

Next. Q1. Explain MVVM vs MVC? `(30–45s)` Answer. In UIKit MVC, view controllers often accumulate networking, state, and layout — Massive View Controller. M V V M keeps the View focused on rendering and forwarding intents, while the ViewModel owns presentation state and screen-level async. The model or domain stays free of UIKit. In UIKit you bind with closures or Combine; in SwiftUI you typically observe an @Observable model. I used that split on BookMyShow search and when thinning layers during District’s migration. Follow-ups. Probe deeper?: On BookMyShow search, the ViewModel owns debounce and explicit idle/loading/results/empty/error states so the view controller never owns networking..

## §1 Q2. When do you introduce Clean Architecture? `(45–60s)`

Next. Q2. When do you introduce Clean Architecture? `(45–60s)` Answer. I introduce Clean boundaries when domain rules are non-trivial, shared across screens, or I’m migrating safely under a fat layer. UseCases and entities stay independent of UIKit and SwiftUI; the ViewModel becomes a thin adapter that maps results to view state and still cancels tasks. I don’t Clean-ify a settings toggle — ceremony has to earn its keep. At District, Free Parking billing rules were a natural UseCase extraction while simpler chrome stayed M V V M. Follow-ups. Probe deeper?: At District, Free Parking billing rules became a UseCase while simple chrome stayed thin M V V M — ceremony only where policy lived..

## §2 Q3. What is MVI / unidirectional data flow? `(45s)`

Next. Q3. What is MVI / unidirectional data flow? `(45s)` Answer. MVI or unidirectional flow means the View sends Intents into a processor that produces a new immutable State, and the View renders that state. Side effects like networking are explicit and usually feed results back as Intents. It’s excellent when checkout or a live scoreboard has many async inputs fighting one screen. For simple CRUD, M V V M with an enum state machine is usually enough — I don’t pay reducer boilerplate by default. Follow-ups. Probe deeper?: A live in-arena scoreboard with many async inputs is a good unidirectional-flow candidate; simple CRUD stays enum-state M V V M..

## §3 Q4. How do you do DI on iOS without a container? `(45–60s)`

Next. Q4. How do you do DI on iOS without a container? `(45–60s)` Answer. My default is protocol boundaries with constructor injection — ViewModels and UseCases receive repositories and clients through init. A feature assembler builds the graph at the module edge. Tests inject fakes. I avoid service locators for domain dependencies. SwiftUI Environment is fine for theme and shallow U I deps, but I don’t hide the NetworkClient only in Environment for an S D K-style feature. Follow-ups. Probe deeper?: Stories S D K and Free Parking both take repositories through init so tests inject fakes without a service-locator container..

## §4 Q5. How would you structure BMS search in MVVM? `(60–90s)`

Next. Q5. How would you structure BMS search in MVVM? `(60–90s)` Answer. I’d give SearchViewModel a query handler that debounces around 300ms, cancels the previous Task, and moves through an explicit state enum — idle, loading, results, empty, error. The View only renders state and forwards text changes. A SearchRepository returns domain models; ranking stays server-side unless product needs local filter. Cancellation must not surface as a scary error. That’s aligned with how we made BookMyShow search race-safer under M V V M. Follow-ups. Probe deeper?: Cancel the previous search Task on each new query and treat CancellationError as silent so fast typing never flashes an error banner..

## §5 Q6. Fat ViewModel — smells and fix? `(45s)`

Next. Q6. Fat ViewModel — smells and fix? `(45s)` Answer. A fat ViewModel mixes networking strings, routing, analytics, and business rules. The fix is extraction: UseCase for policy, Router/Coordinator for navigation, AnalyticsClient protocol for events. I extract the UseCase under characterization or unit tests first so behavior doesn’t drift — that was the spirit of District’s incremental migration. Follow-ups. Probe deeper?: If the ViewModel starts routing and encoding billing policy, extract a UseCase and a Router first under characterization tests..

## §6 Q7. How do View and ViewModel communicate in UIKit vs SwiftUI? `(45s)`

Next. Q7. How do View and ViewModel communicate in UIKit vs SwiftUI? `(45s)` Answer. In UIKit, ViewModels typically push state through closures, Combine publishers, or occasionally delegates for one-off events — always mind [weak self]. In SwiftUI, I prefer an @Observable model with @Bindable for two-way fields. Pattern is state down, events up. Observation reduces some Combine cycle footguns, but long-lived Tasks still need cancellation on disappear. Follow-ups. Probe deeper?: In UIKit use closures or Combine with [weak self]; in SwiftUI prefer an @Observable model and cancel long-lived Tasks on disappear..

## §7 Q8. How did you use AI in the District migration without losing seniority? `(60–90s)`

Next. Q8. How did you use AI in the District migration without losing seniority? `(60–90s)` Answer. At District I used Context Engineering — feeding architecture constraints, existing module patterns, and acceptance intent into Cursor/Claude/Copilot. AI accelerated scaffolding, review assistance, and XCTest/XCUITest drafts. I reviewed every boundary-sensitive diff for misplaced rules, missing cancellation, and naming. Success wasn’t lines generated; it was shipping Free Parking and migrating patterns without skipping design ownership. I never say AI wrote the app. Follow-ups. Probe deeper?: AI drafts scaffolding and XCTest stubs only inside a review envelope — I still own boundary placement, cancellation, and naming..

## §8 Q9. Repository vs UseCase — difference? `(30–45s)`

Next. Q9. Repository vs UseCase — difference? `(30–45s)` Answer. A UseCase answers what the product should do — adjust Free Parking billing under eligibility rules. A Repository answers where data comes from and how cache versus remote is applied, including DTO mapping. The ViewModel shouldn’t know URLSession; the UseCase shouldn’t know UIKit. UseCases often orchestrate multiple repositories; repositories usually shouldn’t encode billing policy. Follow-ups. Probe deeper?: AdjustFreeParkingBilling encodes eligibility policy; the repository only maps DTOs and chooses cache versus remote..

## §9 Q10. How do you keep feature modules testable? `(45–60s)`

Next. Q10. How do you keep feature modules testable? `(45–60s)` Answer. Protocols at the edges, pure UseCases, and deterministic fakes give a cheap unit-test core. I add snapshot or U I tests sparingly for critical flows. CI gates matter more than clever mocks. At District, AI-assisted XCTest/XCUITest drafts were useful only inside a review loop — theater tests that never fail when policy flips are worse than no tests. Follow-ups. Probe deeper?: A good unit test fails when Free Parking policy inverts; theater tests that always pass are worse than none..

## §10 Q11. Coordinator vs Router vs NavigationPath? `(45s)`

Next. Q11. Coordinator vs Router vs NavigationPath? `(45s)` Answer. For simple pushes, the ViewModel can emit a NavigationEvent. Cross-feature flows, auth gates, and deeplinks belong in a Coordinator or Router so VMs stay testable. In SwiftUI, NavigationPath and deeplink handlers live at the app edge — Grizzlies taught deliberate ownership. UseCases must not push UIKit controllers. Follow-ups. Probe deeper?: Deeplinks and cross-feature exits belong in one Coordinator/Router; UseCases must never push UIKit controllers..

## §11 Q12. How does architecture relate to crash-free at 30L+ DAU? `(45–60s)`

Next. Q12. How does architecture relate to crash-free at 30L+ DAU? `(45–60s)` Answer. Architecture doesn’t magically create 99.95% crash-free sessions — observability and incident process still matter. What layers buy you is smaller blast radius: fail-soft U I states, fewer god objects, and clearer cancellation so you don’t force-unwrap your way through races. At BookMyShow scale, search error states and disciplined ownership are reliability features. Follow-ups. Probe deeper?: Fail-soft search error states and clear ownership shrink blast radius — architecture supports, but does not invent, crash-free bars.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “Explain MVVM vs MVC.?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Explain MVVM vs MVC.?” — how do you answer without jargon? `(60–90s)` Answer. “In UIKit MVC, view controllers often accumulate networking, state, and layout — Massive View Controller. M V V M keeps the View focused on rendering and forwarding intents, while the ViewModel owns presentation state and screen-level async. The model or domain stays free of UIKit. In UIKit you bind with closures or Combine; in SwiftUI you typically observe an @Observable model. I used that split on BookMyShow search and when thinning layers during District’s migration.” Follow-ups. What concept is this really?: Explain M V V M vs MVC.. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “When do you introduce Clean Architecture” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “When do you introduce Clean Architecture” just broke under load. What do you check first? `(60–90s)` Answer. “I introduce Clean boundaries when domain rules are non-trivial, shared across screens, or I’m migrating safely under a fat layer. UseCases and entities stay independent of UIKit and SwiftUI; the ViewModel becomes a thin adapter that maps results to view state and still cancels tasks. I don’t Clean-ify a settings toggle — ceremony has to earn its keep. At District, Free Parking billing rules were a natural UseCase extraction while simpler chrome stayed M V V M.” Follow-ups. What concept is this really?: When do you introduce Clean Architecture. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “What is MVI / unidirectional data flow”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “What is MVI / unidirectional data flow”. How do you diagnose? `(60–90s)` Answer. “MVI or unidirectional flow means the View sends Intents into a processor that produces a new immutable State, and the View renders that state. Side effects like networking are explicit and usually feed results back as Intents. It’s excellent when checkout or a live scoreboard has many async inputs fighting one screen. For simple CRUD, M V V M with an enum state machine is usually enough — I don’t pay reducer boilerplate by default.” Follow-ups. What concept is this really?: What is MVI / unidirectional data flow. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “How do you do DI on iOS without a container”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “How do you do DI on iOS without a container”. What do you say and what fix do you propose? `(60–90s)` Answer. “My default is protocol boundaries with constructor injection — ViewModels and UseCases receive repositories and clients through init. A feature assembler builds the graph at the module edge. Tests inject fakes. I avoid service locators for domain dependencies. SwiftUI Environment is fine for theme and shallow U I deps, but I don’t hide the NetworkClient only in Environment for an S D K-style feature.” Follow-ups. What concept is this really?: How do you do DI on i O S without a container. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “How would you structure BMS search in MVVM”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “How would you structure BMS search in MVVM”? `(60–90s)` Answer. “I’d give SearchViewModel a query handler that debounces around 300ms, cancels the previous Task, and moves through an explicit state enum — idle, loading, results, empty, error. The View only renders state and forwards text changes. A SearchRepository returns domain models; ranking stays server-side unless product needs local filter. Cancellation must not surface as a scary error. That’s aligned with how we made BookMyShow search race-safer under M V V M.” Follow-ups. What concept is this really?: How would you structure BMS search in M V V M. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Fat ViewModel — smells and fix” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Fat ViewModel — smells and fix” and how you’d correct it? `(60–90s)` Answer. “A fat ViewModel mixes networking strings, routing, analytics, and business rules. The fix is extraction: UseCase for policy, Router/Coordinator for navigation, AnalyticsClient protocol for events. I extract the UseCase under characterization or unit tests first so behavior doesn’t drift — that was the spirit of District’s incremental migration.” Follow-ups. What concept is this really?: Fat ViewModel — smells and fix. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “How do View and ViewModel communicate in UIKit vs SwiftUI?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “How do View and ViewModel communicate in UIKit vs SwiftUI?” — how do you answer without jargon? `(60–90s)` Answer. “In UIKit, ViewModels typically push state through closures, Combine publishers, or occasionally delegates for one-off events — always mind [weak self]. In SwiftUI, I prefer an @Observable model with @Bindable for two-way fields. Pattern is state down, events up. Observation reduces some Combine cycle footguns, but long-lived Tasks still need cancellation on disappear.” Follow-ups. What concept is this really?: How do View and ViewModel communicate in UIKit vs SwiftUI. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “How did you use AI in the District migration without losing seniority” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “How did you use AI in the District migration without losing seniority” just broke under load. What do you check first? `(60–90s)` Answer. “At District I used Context Engineering — feeding architecture constraints, existing module patterns, and acceptance intent into Cursor/Claude/Copilot. AI accelerated scaffolding, review assistance, and XCTest/XCUITest drafts. I reviewed every boundary-sensitive diff for misplaced rules, missing cancellation, and naming. Success wasn’t lines generated; it was shipping Free Parking and migrating patterns without skipping design ownership. I never say AI wrote the app.” Follow-ups. What concept is this really?: How did you use AI in the District migration without losing seniority. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. DI vs singletons under test? `(90–120s)`

Next. T1. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. Prefetch that hurts scrolling? `(90–120s)`

Next. T2. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. Actor reentrancy surprise? `(90–120s)`

Next. T3. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. They push you to invent a metric you don’t have? `(90–120s)`

Next. T4. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T5. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. They want a one-tool forever answer? `(90–120s)`

Next. T6. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T7. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Main-thread rule under pressure? `(90–120s)`

Next. T8. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Cancellation honesty? `(90–120s)`

Next. T9. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Cache invalidation trap? `(90–120s)`

Next. T10. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
