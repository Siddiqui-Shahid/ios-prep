# Audio script — Sample 03 — Pipeline shape and code demos (Q&A)
> Listen-only sample Q&A from `03-pipeline-and-code.md`. Spoken answers and follow-ups.

## §0 Q1. What is the preferred ads pipeline shape?

Next. Q1. What is the preferred ads pipeline shape? Answer. Keep the outer A P I generic so the compiler still sees a concrete creative type. Compose video-only behavior as an extra capability (PlaybackControllable) — do not force image creatives to pretend they play video. Avoid as? VideoCreative on the revenue path. New types plug in by conforming, not by casting. Follow-ups. Demo type?: AdPipeline<C: Creative & AdTrackable in AdsPipeline.swift.. What does install() do?: Track impression, then makeBody() — type-safe end to end.. Why not Any cast ladder?: Casts hide bugs until a new creative ships Friday night..

## §1 Q2. How do `where` clauses help with associated types?

Next. Q2. How do `where` clauses help with associated types? Answer. where lets you say “only when the associated view is this kind” — for example where C.View: UIImageView. You keep specialization and avoid casting. Use typealiases for long A & B & C contracts so whiteboard signatures stay readable. Follow-ups. Example typealias?: TrackedCreative = AdRenderable & AdTrackable.. Array helper idea?: renderAll only when every element’s associated View is the same V.. Interview signal?: You constrain associated types instead of force-casting..

## §2 Q3. How does HeroWidget mix POP with UIKit identity?

Next. Q3. How does HeroWidget mix POP with UIKit identity? Answer. HeroWidget needs three things: a real view lifecycle (class identity), pause/play when visibility changes, and clean contracts so the ads pipeline does not care about player internals. Make it a UIView (or similar) that adopts PlaybackControllable. P O P gave the pipeline; the widget stays a class because lifecycle and player identity are reference concerns. Follow-ups. Interview line?: “P O P for the pipeline; HeroWidget is still a class — pause/play tied to visibility.”. Why : AnyObject on playback?: Often weak ownership / class identity for the player surface.. Provenance?: BookMyShow Ads pipeline + HeroWidget lifecycle · HeroWidget pause/play lifecycle..

## §3 Q4. What should you explain when reading `AdsPipeline.swift`?

Next. Q4. What should you explain when reading `AdsPipeline.swift`? Answer. Point at each capability protocol (AdTrackable, Creative, PlaybackControllable). Show image vs video conformers. Explain why the pipeline is generic. Note that extension defaults on trackClick are for identical behavior — polymorphic overrides belong in requirements. Say aloud: this is Learning-lab teaching shape, not claimed BMS source. Follow-ups. Why is VideoCreative a class?: Playback / identity — also adopts PlaybackControllable.. Why is ImageCreative a struct?: Value-friendly model with no player identity need.. bindPlayback idea?: Only types that are Creative & PlaybackControllable get pause/play..

## §4 Q5. What should you explain when reading `TypeErasureDemo.swift`?

Next. Q5. What should you explain when reading `TypeErasureDemo.swift`? Answer. AnyTrackable is one concrete type that stores an id and a _track closure. Banner and Interstitial both fit in [AnyTrackable]. Cost is heap/closure indirection and lost specialization. Prefer func install<T: Trackable (_ t: T) inside the pipeline; erase only for mixed lists or boundaries. Same motive as Combine’s AnyPublisher. Follow-ups. Why not claim this shipped at BMS?: Learning-lab — teaching mechanics. Prefer Applied/lab for erasure demos unless personally true.. What does init<T: Trackable do?: Captures the concrete adopter’s behavior into the box.. When skip erasure?: When the hot path can stay generic end-to-end..

## §5 Q6. What trade-offs should you memorize for architecture choices?

Next. Q6. What trade-offs should you memorize for architecture choices? Answer. P O P + generics: many variants and revenue safety — cost is learning curve and associated-type friction. Inheritance tree: rare shared UIKit identity — cost is fragile base. Type erasure: mixed arrays / boundaries — cost is allocation. any Protocol: flexibility — existential overhead and associated-type limits. Closed enum: stable small set — app release for every new case. Follow-ups. YAGNI vs BMS ads scale?: Two similar types forever — maybe don’t abstract yet. Highest-revenue growing creatives — abstraction pays (BookMyShow Ads pipeline + HeroWidget lifecycle justification).. Trap answer?: “Always P O P everything.”. Senior answer?: Introduce P O P when variants or test seams demand it..

## §6 Q7. What is a 5-minute whiteboard flow for Day 02?

Next. Q7. What is a 5-minute whiteboard flow for Day 02? Answer. Agenda: revenue ads path — inheritance problems → P O P contracts → generics pipeline → HeroWidget lifecycle → trade-offs. Problem: new creatives forking render code; video lifecycle bugs. Design: capability protocols + Pipeline<C. Lifecycle: pause/play on visibility. Trade-off: generics inside; erasure only if mixed feed requires it. Honesty: no invented fill-rate %; maintainable type-safe pipeline is the claim. Follow-ups. 15s agenda opener?: “Highest-revenue Ads path — protocols, generics, and video lifecycle.”. Anti-pattern to avoid?: Diving into Generics Manifesto trivia instead of safety → pipeline → lifecycle → trade-off.. Next practice after code tour?: Production bridge sample, then timed questions..

## §7 Q8. Name five anti-patterns and their fixes

Next. Q8. Name five anti-patterns and their fixes Answer. (1) Any + cast ladder → generic constraint or typed factory. (2) Deep AdView tree → capability protocols. (3) Erasing every generic → erase at boundary only. (4) Extension-only overrides → promote to requirements. (5) “Structs can’t do P O P” → structs are first-class adopters. Bonus: forgetting UIKit subclass needs → class for view identity, P O P for capabilities. Follow-ups. Claiming any is free?: Know existential + associated-type limits.. Claiming every creative was a struct?: Don’t invent — video/player identity often needs a class.. Done with code sample?: Move to BookMyShow Ads pipeline + HeroWidget lifecycle / Stories S D K (Raw / Miami Heat) language..
