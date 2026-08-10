# Audio script — Sample 07 — Revision Q&A (day-12) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. @State vs @Observable — when each? `(30–45s)`

Next. Q1. @State vs @Observable — when each? `(30–45s)` Answer. I use @State for view-local ephemeral U I like chrome toggles. For feature-level async and state shared across children I use an @Observable model on i O S 17+, with @Bindable when controls write into that model. On older deployment targets I’d use ObservableObject and @Published. Stories player timeline belongs in the model; local overlay chrome can stay @State. Follow-ups. Probe deeper?: Stories progress timers live in the @Observable player model; a local mute toggle can stay @State on the chrome view..

## §1 Q2. What is view identity? `(45–60s)`

Next. Q2. What is view identity? `(45–60s)` Answer. View identity is how SwiftUI decides two renders are the same view. Structural identity comes from type and position; explicit identity uses.id or ForEach identifiers. @State storage follows identity — change the id and state resets. That’s why stable Stories page IDs matter and why UUID-in-body is catastrophic. Follow-ups. Probe deeper?: Changing.id or ForEach keys resets @State — minting UUID in body rebuilds the view every render and drops progress..

## §2 Q3. Why did my Representable reset? `(45s)`

Next. Q3. Why did my Representable reset? `(45s)` Answer. Usually the parent’s identity changed or an.id churned, so SwiftUI remade the representable instead of calling update. Stabilize identifiers and push prop changes through updateUIViewController. Recreate only when you truly need a fresh controller — hybrid apps feel this cost immediately. Follow-ups. Probe deeper?: If the parent’s identity churns, SwiftUI remakes the Representable instead of calling update — stabilize IDs and push props through update..

## §3 Q4. ForEach best practices? `(45s)`

Next. Q4. ForEach best practices? `(45s)` Answer. ForEach needs stable Identifiable keys from your models. Don’t use indices when rows reorder, and never mint UUID ids inside body. Duplicate IDs cause undefined weirdness. Stories pages should carry host/server ids that survive progress updates. Follow-ups. Probe deeper?: Stories pages carry host/server IDs that survive progress ticks; index-based ForEach breaks when pages reorder..

## §4 Q5. Make a long list smooth? `(60–90s)`

Next. Q5. Make a long list smooth? `(60–90s)` Answer. Use List or LazyVStack, keep Identifiable IDs stable, make row body cheap with precomputed formatting, load images asynchronously with size budgets, paginate when needed, and don’t observe a giant catalog from every row. If it’s still janky, profile decode and main-thread work — Lazy alone isn’t a silver bullet. Follow-ups. Probe deeper?: LazyVStack alone won’t save you if every row observes a giant catalog — pass slices and precompute formatting in the model..

## §5 Q6. How do you design Stories SDK API? `(60–90s)`

Next. Q6. How do you design Stories SDK API? `(60–90s)` Answer. I’d expose a StoriesPlayer entry point, a data source protocol so hosts supply story groups, event callbacks for open/close/CTA, and injectable image/video loaders so networking stays host-owned where needed. The module is versioned and theming-hooked. That’s how we kept a reusable Stories S D K isolatable across portfolio apps instead of hardcoding one app’s networking. Follow-ups. Probe deeper?: Expose StoriesPlayer plus a host data-source protocol and injectable loaders so networking stays host-owned across portfolio apps..

## §6 Q7. Pause stories on background/disappear? `(45s)`

Next. Q7. Pause stories on background/disappear? `(45s)` Answer. On disappear and background scene phase I pause the player model — timers and AVPlayer — with an explicit resume policy when returning. Views shouldn’t keep rogue timers alive. It’s the same lifecycle discipline as Ads HeroWidget pause/play: media without visibility policy wastes resources and surprises users. Follow-ups. Probe deeper?: On disappear and background scene phase, pause timers and AVPlayer in the player model — views must not keep rogue timers..

## §7 Q8. Environment for DI — good idea? `(45s)`

Next. Q8. Environment for DI — good idea? `(45s)` Answer. Environment is great for theme and layout direction. It’s a poor service locator for NetworkClient everywhere — hidden dependencies hurt tests and S D K hosts. Stories S D K should take injectable loaders through init so hosts see the graph. That matches Day 08’s constructor DI default. Follow-ups. Probe deeper?: Theme via Environment is fine; NetworkClient-only-in-Environment hides the graph from S D K hosts and makes tests brittle..

## §8 Q9. Animation causes list jump — causes? `(45–60s)`

Next. Q9. Animation causes list jump — causes? `(45–60s)` Answer. List jumps usually come from identity changes, row height changes without a careful transaction, or scroll position loss when IDs reshuffle. Fix stable Identifiable keys, animate data changes carefully, and avoid applying animation modifiers to entire giant trees. Follow-ups. Probe deeper?: List jumps usually mean IDs reshuffled or row heights changed under a broad animation — fix Identifiable keys before tweaking spring curves..

## §9 Q10. body called often — is that a problem? `(45s)`

Next. Q10. body called often — is that a problem? `(45s)` Answer. body being called often is normal — SwiftUI diffs descriptions. It becomes a problem when body does heavy formatting, sorting, or side effects like networking. Keep body cheap and pure-ish; precompute in the model. Fetching in body is an interview classic fail. Follow-ups. Probe deeper?: body being called often is normal; networking or sorting 10k rows inside body is the failure mode — move side effects to.task/model..

## §10 Q11. Cross-app reuse challenges for Stories? `(45–60s)`

Next. Q11. Cross-app reuse challenges for Stories? `(45–60s)` Answer. Portfolio reuse hits theming, analytics, media formats, how CTAs exit into host navigation, and dependency versions. You solve it with protocols, sensible defaults, and a versioned module — not by forking the S D K per team. That’s the modularity lesson behind the Stories S D K adoption across apps. Follow-ups. Probe deeper?: Cross-app Stories reuse needs theming hooks, CTA exit protocols, and a versioned module — not a fork per team..

## §11 Q12. SwiftUI + SDUI registry? `(45–60s)`

Next. Q12. SwiftUI + SDUI registry? `(45–60s)` Answer. An S D U I registry can return SwiftUI views keyed by type while the ViewModel owns payload lifecycle. Keep leaf views dumb. Give each node a server-stable id so ForEach identity doesn’t break when CMS inserts content — same identity rules as Stories pages. Follow-ups. Probe deeper?: S D U I registry leaves return SwiftUI views keyed by type with server-stable node IDs so ForEach identity survives CMS inserts.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “@State vs @Observable — when each?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “@State vs @Observable — when each?” — how do you answer without jargon? `(60–90s)` Answer. “I use @State for view-local ephemeral U I like chrome toggles. For feature-level async and state shared across children I use an @Observable model on i O S 17+, with @Bindable when controls write into that model. On older deployment targets I’d use ObservableObject and @Published. Stories player timeline belongs in the model; local overlay chrome can stay @State.” Follow-ups. What concept is this really?: @State vs @Observable — when each. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “What is view identity” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “What is view identity” just broke under load. What do you check first? `(60–90s)` Answer. “View identity is how SwiftUI decides two renders are the same view. Structural identity comes from type and position; explicit identity uses.id or ForEach identifiers. @State storage follows identity — change the id and state resets. That’s why stable Stories page IDs matter and why UUID-in-body is catastrophic.” Follow-ups. What concept is this really?: What is view identity. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Why did my Representable reset”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Why did my Representable reset”. How do you diagnose? `(60–90s)` Answer. “Usually the parent’s identity changed or an.id churned, so SwiftUI remade the representable instead of calling update. Stabilize identifiers and push prop changes through updateUIViewController. Recreate only when you truly need a fresh controller — hybrid apps feel this cost immediately.” Follow-ups. What concept is this really?: Why did my Representable reset. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “ForEach best practices”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “ForEach best practices”. What do you say and what fix do you propose? `(60–90s)` Answer. “ForEach needs stable Identifiable keys from your models. Don’t use indices when rows reorder, and never mint UUID ids inside body. Duplicate IDs cause undefined weirdness. Stories pages should carry host/server ids that survive progress updates.” Follow-ups. What concept is this really?: ForEach best practices. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Make a long list smooth.”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Make a long list smooth.”? `(60–90s)` Answer. “Use List or LazyVStack, keep Identifiable IDs stable, make row body cheap with precomputed formatting, load images asynchronously with size budgets, paginate when needed, and don’t observe a giant catalog from every row. If it’s still janky, profile decode and main-thread work — Lazy alone isn’t a silver bullet.” Follow-ups. What concept is this really?: Make a long list smooth.. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “How do you design Stories SDK API” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “How do you design Stories SDK API” and how you’d correct it? `(60–90s)` Answer. “I’d expose a StoriesPlayer entry point, a data source protocol so hosts supply story groups, event callbacks for open/close/CTA, and injectable image/video loaders so networking stays host-owned where needed. The module is versioned and theming-hooked. That’s how we kept a reusable Stories S D K isolatable across portfolio apps instead of hardcoding one app’s networking.” Follow-ups. What concept is this really?: How do you design Stories S D K A P I. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Pause stories on background/disappear?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Pause stories on background/disappear?” — how do you answer without jargon? `(60–90s)` Answer. “On disappear and background scene phase I pause the player model — timers and AVPlayer — with an explicit resume policy when returning. Views shouldn’t keep rogue timers alive. It’s the same lifecycle discipline as Ads HeroWidget pause/play: media without visibility policy wastes resources and surprises users.” Follow-ups. What concept is this really?: Pause stories on background/disappear. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Environment for DI — good idea” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Environment for DI — good idea” just broke under load. What do you check first? `(60–90s)` Answer. “Environment is great for theme and layout direction. It’s a poor service locator for NetworkClient everywhere — hidden dependencies hurt tests and S D K hosts. Stories S D K should take injectable loaders through init so hosts see the graph. That matches Day 08’s constructor DI default.” Follow-ups. What concept is this really?: Environment for DI — good idea. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T1. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. They want a one-tool forever answer? `(90–120s)`

Next. T2. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T3. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Main-thread rule under pressure? `(90–120s)`

Next. T4. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Cancellation honesty? `(90–120s)`

Next. T5. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. Cache invalidation trap? `(90–120s)`

Next. T6. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. Security theater vs real pinning? `(90–120s)`

Next. T7. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. SDUI unknown component in prod? `(90–120s)`

Next. T8. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. DI vs singletons under test? `(90–120s)`

Next. T9. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Prefetch that hurts scrolling? `(90–120s)`

Next. T10. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
