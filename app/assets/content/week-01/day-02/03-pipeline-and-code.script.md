# Audio script — Sample 03 — Pipeline shape and code demos (Q&A)
> Listen-only sample Q&A from `03-pipeline-and-code.md`. Spoken answers and follow-ups.

## §0 Q1. What is the preferred ads pipeline shape?

Next. Q1. What is the preferred ads pipeline shape? Answer. “Keep the outer A P I generic so the compiler still sees a concrete creative type. Compose video-only behavior as an extra capability — PlaybackControllable — do not force image creatives to pretend they play video. Avoid as? VideoCreative on the revenue path. New types plug in by conforming, not by casting.” Follow-ups. Demo type?: “AdPipeline of C where C is Creative and AdTrackable — AdsPipeline.swift.”. What does install do?: “Track impression, then makeBody — type-safe end to end.”. Why not Any cast ladder?: “Casts hide bugs until a new creative ships Friday night.”.

## §1 Q2. How do where clauses help with associated types?

Next. Q2. How do where clauses help with associated types? Answer. “where lets you say only when the associated view is this kind — for example where C.View is UIImageView. You keep specialization and avoid casting. Use typealiases for long A & B & C contracts so whiteboard signatures stay readable.” Follow-ups. Example typealias?: “TrackedCreative equals AdRenderable and AdTrackable.”. Array helper idea?: “renderAll only when every element’s associated View is the same V.”. Interview signal?: “You constrain associated types instead of force-casting.”.

## §2 Q3. How does HeroWidget mix POP with UIKit identity?

Next. Q3. How does HeroWidget mix POP with UIKit identity? Answer. “HeroWidget needs three things: a real view lifecycle — class identity — pause and play when visibility changes, and clean contracts so the ads pipeline does not care about player internals. Make it a UIView that adopts PlaybackControllable. P O P gave the pipeline; the widget stays a class because lifecycle and player identity are reference concerns. That’s not a contradiction.” Follow-ups. Interview line?: “P O P for the pipeline; HeroWidget is still a class — pause/play tied to visibility.”. Why AnyObject on playback?: “Often weak ownership / class identity for the player surface.”. Provenance?: “BookMyShow Ads pipeline + HeroWidget lifecycle.”.

## §3 Q4. What should you explain when reading AdsPipeline.swift?

Next. Q4. What should you explain when reading AdsPipeline.swift? Answer. “Point at each capability protocol — AdTrackable, Creative, PlaybackControllable. Show image versus video conformers. Explain why the pipeline is generic. Note that extension defaults on trackClick are for identical behavior — polymorphic overrides belong in requirements. Say aloud: this is learning-lab teaching shape, not claimed BMS source.” Follow-ups. Why is VideoCreative a class?: “Playback and identity — also adopts PlaybackControllable.”. Why is ImageCreative a struct?: “Value-friendly model with no player identity need.”. bindPlayback idea?: “Only types that are Creative and PlaybackControllable get pause/play.”.

## §4 Q5. What should you explain when reading TypeErasureDemo.swift?

Next. Q5. What should you explain when reading TypeErasureDemo.swift? Answer. “AnyTrackable is one concrete type that stores an id and a _track closure. Banner and Interstitial both fit in an array of AnyTrackable. The init captures the concrete adopter into the box. Cost is heap/closure indirection and lost specialization. Prefer a generic install inside the pipeline; erase only for mixed lists or boundaries. Same motive as Combine’s AnyPublisher.” Follow-ups. Why not claim this shipped at BMS?: “Learning-lab — teaching mechanics. Prefer lab for erasure demos unless personally true.”. Upcast angle?: “When erasing renderers, views often collapse to UIView as the common surface.”. When skip erasure?: “When the hot path can stay generic end-to-end.”.

## §5 Q6. What trade-offs should you memorize — including YAGNI vs revenue scale?

Next. Q6. What trade-offs should you memorize — including YAGNI vs revenue scale? Answer. “P O P plus generics: many variants and revenue safety — cost is learning curve and associated-type friction. Inheritance tree: rare shared UIKit identity — cost is fragile base. Type erasure: mixed arrays and boundaries — cost is allocation. any Protocol: flexibility — existential overhead and associated-type limits. Closed enum: stable small set — app release for every new case. Two similar types forever — maybe don’t abstract yet. Highest-revenue growing creatives — abstraction pays. Trap: always P O P everything. Senior: introduce P O P when variants or test seams demand it.” Follow-ups. BMS ads justification?: “Variants justified the BookMyShow Ads pipeline — still no invented fill-rate %.”. Stories S D K angle?: “Protocols at the S D K boundary — soft bridge, don’t steal Ads credit.”.

## §6 Q7. What is a 5-minute whiteboard architecture spine?

Next. Q7. What is a 5-minute whiteboard architecture spine? Answer. “Agenda: revenue ads path — inheritance problems, P O P contracts, generics pipeline, HeroWidget lifecycle, trade-offs. Problem: new creatives forking render code; video lifecycle bugs. Design: capability protocols plus Pipeline of C. Lifecycle: pause/play on visibility. Trade-off: generics inside; erasure only if mixed feed requires it. Honesty: no invented fill-rate percent; maintainable type-safe pipeline is the claim. Fifteen-second opener: highest-revenue Ads path — protocols, generics, and video lifecycle.” Follow-ups. Anti-pattern to avoid?: “Diving into Generics Manifesto trivia instead of safety → pipeline → lifecycle → trade-off.”. Next practice after code tour?: “Production bridge sample, then timed questions.”.

## §7 Q8. Name five anti-patterns and their fixes?

Next. Q8. Name five anti-patterns and their fixes? Answer. “One: Any plus cast ladder — generic constraint or typed factory. Two: deep AdView tree — capability protocols. Three: erasing every generic — erase at boundary only. Four: extension-only overrides — promote to requirements. Five: structs can’t do P O P — structs are first-class adopters. Bonus: forgetting UIKit subclass needs — class for view identity, P O P for capabilities.” Follow-ups. Claiming any is free?: “Know existential plus associated-type limits.”. Claiming every creative was a struct?: “Don’t invent — video/player identity often needs a class.”. Done with code sample?: “Move to Ads plus HeroWidget interview language, then Stories soft bridge if asked.”.

## §8 Q9. rethrows ergonomics on a pipeline mapper?

Next. Q9. rethrows ergonomics on a pipeline mapper? Answer. “A generic mapCreatives that rethrows keeps non-throwing call sites clean — no forced try — while still allowing a throwing transform when decoding or validation can fail. It’s pipeline A P I manners: don’t make every installer look like it always throws.” Follow-ups. Ceremony trap?: “Marking everything rethrows when nothing throws.”. Tie to generics?: “Same higher-order style as stdlib map — typed, constrained, honest about errors.”.
