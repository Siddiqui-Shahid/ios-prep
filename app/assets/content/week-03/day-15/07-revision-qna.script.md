# Audio script — Sample 07 — Revision Q&A (day-15) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Why modularize an iOS app? `(30–45s)`

Next. Q1. Why modularize an iOS app? `(30–45s)` Answer. Modularization buys incremental build speed, clearer team ownership, independent tests, and reuse. The key is an enforced import graph — Interface versus Impl — not folders with good intentions. My production proof is the Stories S D K: one module adopted across portfolio apps instead of copy-paste U I. Follow-ups. First module?: Leaf with clear A P I — design system, network, or Stories.. Story?: Stories S D K (Raw / Miami Heat)..

## §1 Q2. CocoaPods vs SPM — how choose? `(30–45s)`

Next. Q2. CocoaPods vs SPM — how choose? `(30–45s)` Answer. For new modules I default to SPM — native Xcode, no Ruby. CocoaPods stays when binary pods or legacy resource bundles dominate. Migration is incremental: leaf packages first. And packaging isn’t architecture — a CocoaPod can still have a clean A P I boundary. Follow-ups. Resources in SPM?: Process resources carefully per target.. Ads context?: BookMyShow Ads URLSession + pinning ownership lived behind a module boundary..

## §2 Q3. What belongs in a Feature Interface? `(30–45s)`

Next. Q3. What belongs in a Feature Interface? `(30–45s)` Answer. Interfaces hold protocols, lightweight models peers need, and builder/factory types. They should not own heavy UIKit view controllers or concrete networking. Depending on Core abstractions is OK when it stays lean — Interfaces must stay cheap to compile. Follow-ups. UIKit in Interface?: Smell — prefer opaque factories..

## §3 Q4. Explain a DI composition root? `(30–45s)`

Next. Q4. Explain a DI composition root? `(30–45s)` Answer. The App target is the composition root: it constructs concrete services and injects them into feature builders. Features depend on protocols, not globals. That compile-time graph beats discovering a missing Swinject registration in production. For Stories, the host injects providers at the root. Follow-ups. Deeplink factories?: Registered at App root.. Story?: Stories S D K (Raw / Miami Heat) host injects..

## §4 Q5. Navigate without importing other Impls? `(30–45s)`

Next. Q5. Navigate without importing other Impls? `(30–45s)` Answer. Feature A imports FeatureB’s Interface and asks DI for a FeatureBBuildable. The App registered the concrete builder. That gives compile-time missing-dep failures instead of runtime surprises and prevents Impl↔Impl cycles. Follow-ups. Home routes everywhere?: Home depends on many Interfaces; App wires..

## §5 Q6. Dynamic vs static — launch impact? `(30–45s)`

Next. Q6. Dynamic vs static — launch impact? `(30–45s)` Answer. Lots of dynamic frameworks cost dyld time at launch. I prefer static linking for internal modules and reserve dynamic for true app-and-extension sharing. Modularization shouldn’t mean forty dylibs by accident. Follow-ups. Binary size?: Watch duplicates; CI budgets..

## §6 Q7. Independently testable modules? `(30–45s)`

Next. Q7. Independently testable modules? `(30–45s)` Answer. If dependencies are protocols from Interface packages, unit tests inject fakes and CI can test Checkout without booting the full app. Snapshot tests usually live with Impl U I. That matches the test discipline we used around District architecture work. Follow-ups. Story?: District Free Parking / Clean architecture — soft production hook..

## §7 Q8. Circular dependency — prevent? `(30–45s)`

Next. Q8. Circular dependency — prevent? `(30–45s)` Answer. Cycles usually mean two Impls import each other. Break them by depending only on Interfaces and letting App register builders. SPM/Xcode will fail resolution instead of giving you mysterious runtime loops. Follow-ups. Debug SPM?: swift package / dependency graph tools..

## §8 Q9. Extract Stories into an SDK today? `(45–60s)`

Next. Q9. Extract Stories into an SDK today? `(45–60s)` Answer. I’d freeze a public A P I, inject content, analytics, and image loading, add semantic versioning, prove it in a demo host, then adopt a second production host before wide rollout. Theming stays protocolised so Heat and Aces don’t fork the S D K. That’s the same shape we used for portfolio Stories reuse. Follow-ups. Breaking change?: Major bump + migration notes.. Story?: Stories S D K (Raw / Miami Heat)..

## §9 Q10. Singletons — ever OK? `(30–45s)`

Next. Q10. Singletons — ever OK? `(30–45s)` Answer. A process-wide analytics sink might be constructed once at App launch, but features should still receive it via injection. Feature-level NetworkManager.shared hides the graph and kills testability. Actors change how we isolate state — they don’t excuse hidden globals. Follow-ups. Shared-maps bridge?: Shared maps need explicit isolation APIs..

## §10 Q11. Modularization vs CI? `(30–45s)`

Next. Q11. Modularization vs CI? `(30–45s)` Answer. Modules let CI build and test only what changed, cache SPM artifacts on runners, and parallelise package builds. That’s a Day 20-shaped conversation — today the point is the graph enables selective work. Follow-ups. GH Actions?: Preview Day 20..

## §11 Q12. Binary size risk? `(30–45s)`

Next. Q12. Binary size risk? `(30–45s)` Answer. Modules don’t magically shrink binaries. Dead-code stripping helps, but duplicate symbols and unused dynamic frameworks hurt. I’d put a size budget in CI and watch diffs per release. Follow-ups. Metric?: Compressed download / install size.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “Why modularize an iOS app?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Why modularize an iOS app?” — how do you answer without jargon? `(60–90s)` Answer. “Modularization buys incremental build speed, clearer team ownership, independent tests, and reuse. The key is an enforced import graph — Interface versus Impl — not folders with good intentions. My production proof is the Stories S D K: one module adopted across portfolio apps instead of copy-paste U I.” Follow-ups. What concept is this really?: Why modularize an i O S app. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “CocoaPods vs SPM — how choose” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “CocoaPods vs SPM — how choose” just broke under load. What do you check first? `(60–90s)` Answer. “For new modules I default to SPM — native Xcode, no Ruby. CocoaPods stays when binary pods or legacy resource bundles dominate. Migration is incremental: leaf packages first. And packaging isn’t architecture — a CocoaPod can still have a clean A P I boundary.” Follow-ups. What concept is this really?: CocoaPods vs SPM — how choose. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “What belongs in a Feature Interface”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “What belongs in a Feature Interface”. How do you diagnose? `(60–90s)` Answer. “Interfaces hold protocols, lightweight models peers need, and builder/factory types. They should not own heavy UIKit view controllers or concrete networking. Depending on Core abstractions is OK when it stays lean — Interfaces must stay cheap to compile.” Follow-ups. What concept is this really?: What belongs in a Feature Interface. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Explain a DI composition root.”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Explain a DI composition root.”. What do you say and what fix do you propose? `(60–90s)` Answer. “The App target is the composition root: it constructs concrete services and injects them into feature builders. Features depend on protocols, not globals. That compile-time graph beats discovering a missing Swinject registration in production. For Stories, the host injects providers at the root.” Follow-ups. What concept is this really?: Explain a DI composition root.. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Navigate without importing other Impls”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Navigate without importing other Impls”? `(60–90s)` Answer. “Feature A imports FeatureB’s Interface and asks DI for a FeatureBBuildable. The App registered the concrete builder. That gives compile-time missing-dep failures instead of runtime surprises and prevents Impl↔Impl cycles.” Follow-ups. What concept is this really?: Navigate without importing other Impls. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Dynamic vs static — launch impact” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Dynamic vs static — launch impact” and how you’d correct it? `(60–90s)` Answer. “Lots of dynamic frameworks cost dyld time at launch. I prefer static linking for internal modules and reserve dynamic for true app-and-extension sharing. Modularization shouldn’t mean forty dylibs by accident.” Follow-ups. What concept is this really?: Dynamic vs static — launch impact. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Independently testable modules?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Independently testable modules?” — how do you answer without jargon? `(60–90s)` Answer. “If dependencies are protocols from Interface packages, unit tests inject fakes and CI can test Checkout without booting the full app. Snapshot tests usually live with Impl U I. That matches the test discipline we used around District architecture work.” Follow-ups. What concept is this really?: Independently testable modules. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Circular dependency — prevent” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Circular dependency — prevent” just broke under load. What do you check first? `(60–90s)` Answer. “Cycles usually mean two Impls import each other. Break them by depending only on Interfaces and letting App register builders. SPM/Xcode will fail resolution instead of giving you mysterious runtime loops.” Follow-ups. What concept is this really?: Circular dependency — prevent. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Main-thread rule under pressure? `(90–120s)`

Next. T1. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. Cancellation honesty? `(90–120s)`

Next. T2. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. Cache invalidation trap? `(90–120s)`

Next. T3. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Security theater vs real pinning? `(90–120s)`

Next. T4. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. SDUI unknown component in prod? `(90–120s)`

Next. T5. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. DI vs singletons under test? `(90–120s)`

Next. T6. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. Prefetch that hurts scrolling? `(90–120s)`

Next. T7. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Actor reentrancy surprise? `(90–120s)`

Next. T8. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. They push you to invent a metric you don’t have? `(90–120s)`

Next. T9. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T10. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
