# Audio script — 05 Exercises
> Listen-only audiobook of `05-exercises.md` (Day 01 — Value vs Reference, COW, Enums, Actors Intro). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Do these after reading foundations + deep dive + production bridge. Prefer speaking out loud even for coding prompts.

## §1 Exercise 1 — `LoadState` fluency `(20–25 min)`

Next. Exercise 1 — `LoadState` fluency `(20–25 min)`.

Prompt: Using code/LoadState.swift as a base (or rewrite from memory): Implement LoadState<T> with idle | loading | loaded(T). | failed(Error). Add static func from(result: Result<T, Error>) -> LoadState<T>. Add map that transforms loaded values and preserves other cases. Write a tiny ViewModel-shaped function: Here is a simple Swift example, explained in words. func reduce(state: LoadState [String] , event: SearchEvent) - LoadState [String]. What to remember: focus on the idea, not every symbol. Define SearchEvent as startSearch | succeed([String]) | fail(Error) | reset. Agenda to say before coding (30s): “I’ll define the enum. map Result at the boundary, then a pure reduce for events.” Done when: You can explain why Result. alone is insufficient for U I. Stretch: Make failed hold a domain error enum instead of Error for Equatable tests.

## §2 Exercise 2 — Payment state machine `(20–30 min)`

Next. Exercise 2 — Payment state machine `(20–30 min)`.

Prompt: Implement PaymentPopupState + PaymentEvent + apply from the Applied · S7-A1 sketch. Required transitions: From: Event, To. hidden: userStartedCheckout, processing. processing: backendSuccess, success(bookingID). processing: backendFailure, failure. processing: timeout, timedOut. success/failure/timedOut/processing: dismiss, hidden. Speak (≤90s) after coding: Product intent (Verified · S7). why enum beats booleans. one illegal state you eliminated. Honesty check: End with “enum machine is how I’d apply it (S7-A1).”.

## §3 Exercise 3 — COW playground `(15–20 min)`

Next. Exercise 3 — copy on write playground `(15–20 min)`.

Prompt: Run or mentally simulate code/COWDemo.swift. Two Array vars. assign, mutate one, predict prints. ArrayBox class wrapper. predict shared mutation. Implement or read COWList with isKnownUniquelyReferenced. Speak (30s): “Share until write. class boxes share identity. handmade copy on write is a value façade over a buffer class.” Trap to avoid: Claiming assignment always. deep-copies elements.

## §4 Exercise 4 — Nested reference audit `(15 min)`

Next. Exercise 4 — Nested reference audit `(15 min)`.

Prompt: Find the bug and fix the design: Here is a simple Swift example, explained in words. final class Metrics. var taps: [String] equals []. struct AdCellModel. var title: String. var metrics: Metrics. What to remember: focus on the idea, not every symbol. Write: Observed behavior Root cause (one sentence) Two redesigns (prefer values / don’t store shared services in data. transfer objects) Story hook: Why value-friendly ads models matter (Verified · S1) without inventing metrics.

## §5 Exercise 5 — Actor intro sketch `(15–20 min)`

Next. Exercise 5 — Actor intro sketch `(15–20 min)`.

Prompt: Given a queue-style A P I: Here is a simple Swift example, explained in words. final class SyncedMap. private var storage: [String: Int] equals [:]. private let queue equals DispatchQueue(label: "synced.map"). func set(_ key: String, _ value: Int) / serialise /. func get(_ key: String) - Int? / serialise /. What to remember: focus on the idea, not every symbol. Fill in serial-queue implementations (sync/async choices. speak trade-offs). Rewrite as actor SyncedMap with the same method names. Speak the S2. S2-A1 bridge in ≤45s. Do not claim you rewrote production dictionaries as actors.

## §6 Exercise 6 — Timed speaking drill `(25–35 min)`

Next. Exercise 6 — Timed speaking drill `(25–35 min)`.

Record (phone voice memo is fine): Q1 struct vs class Q2 copy on write Q3 enums vs booleans. T1 array mutate after assign T6 payment state machine Score with../../../timing/answer-timing-guide.md: Check: Pass?. Agenda in first 10s. Trade-off mentioned. Production hook without invented metrics. Finished inside budget. Log misses. gotchas file / notes.

## §7 Exercise 7 — Social Feed clarifying questions `(20–30 min)`

Next. Exercise 7 — Social Feed clarifying questions `(20–30 min)`.

SD spine warm-up (requirements only mindset): Write 5 clarifying questions you would ask before designing a BMS-scale listing/feed. (use scale context carefully: 30L+ DAU is Verified · S8 if you mention it). Examples of good question shapes (write your own): Offline / stale content expectations? Ad slots vs organic mixing rules? Pagination vs realtime invalidation? Video autoplay lifecycle (HeroWidget-like)? Failure modes for S D U I-ish components? Keep this as questions only. full SD is later weeks.

## §8 Solutions pointers (don’t spoil yourself)

Next. Solutions pointers (don’t spoil yourself).

Exercise: 1. 2: code/LoadState.swift. 3: code/COWDemo.swift. 4: Deep dive §3 nested references. 5: Deep dive §6. production bridge §5. 6: sample/07-revision-qna.md full answers. 7: Your notes. Week 1 SD spine later.

## §9 Exit criteria

Next. Exit criteria.

You may mark Day 01 complete when you can, without notes: [ ] Decision rule for struct /. class / enum / actor [ ] copy on write one-liner + uniqueness small difference [ ] Why. enums beat boolean U I flags [ ] ≤20s S1 value-semantics pitch [ ] ≤90s S7 + S7-A1. payment state answer with honest provenance [ ] ≤45s S2. actor bridge without overclaiming Then use the revision twin for spaced drills:../../../revision/weeks/week-01/day-01.md.
