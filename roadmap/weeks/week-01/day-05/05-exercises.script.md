# Audio script — 05 Exercises
> Listen-only audiobook of `05-exercises.md` (Day 05 — async/await, Structured Concurrency, Actors, Sendable). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Solutions are in-repo. Do not leave Cursor to “look up” the drills.

## §1 A. Conceptual drills (write answers in 5–8 bullets each)

Next. A. Conceptual drills (write answers in 5–8 bullets each).

A1. Reentrancy storyboard Draw or list steps for: Task A enters actor Wallet.spend Sees insufficient balance. await refresh() Task B enters spend or applyRemoteBalance before A resumes Task A resumes Write: What can go. wrong if A assumes pre-await balance? What local variables / generation checks fix it? Solution points: After await, balance/flags may differ. A must re-read. Snapshotting the old balance into a let doesn’t update the actor field. good for comparison, not for assuming the field is unchanged. Generation / version token: only apply remote if generation matches. bump on successful apply. Prefer: fetch remote as value, then short synchronous apply on actor after re-check. A2. Sendable true/false Mark true/false and fix false ones: “Every struct is Sendable.” “A struct whose only stored property. is let name: String can be Sendable.” “A struct storing var cache: NSMutableDictionary is Sendable because. it’s a value type.” “@unchecked Sendable proves thread safety.” “Default MainActor isolation is always on in all Swift. 6.2 apps.” Solution: False. stored props must be Sendable. True (String is Sendable). False. shared mutable reference inside struct. False. disables checking. you must prove safety. False. settings when enabled, not universal. A3. Cancellation checklist for search List 6 concrete code/actions for debounce search correctness. Solution sketch: Store searchTask Cancel previous on each query change Cancellable debounce sleep try Task.checkCancellation() before/after network Ignore. CancellationError for UX Publish results on @MainActor. optional generation token.

## §2 B. Coding drills

Next. B. Coding drills.

B1. Implement / extend SafeDictActor Open code/SafeDictActor.swift. Tasks: Explain aloud why Key and Value require Sendable. Add func merge(_ other: [Key: Value]) that replaces keys from other. Add a broken commented method that awaits a simulated network fetch mid-update and. documents the reentrancy hazard in comments. Write a brief comment contrasting this A P I with Day 04 G C D sync get /. async set. Acceptance: You can narrate isolation, Sendable bounds, and reentrancy without reading notes. B2. Debounced search Task (Learning-lab) In a Playground or scratch file. write a @MainActor class: Here is a simple example with an actor. An actor protects its own data. Other work talks to it with await. Access happens one at a time. Why this matters: fewer data races. What to remember: actors isolate mutable state. Simulate slow searches with Task.sleep. Prove that without cancel, older finishes can overwrite newer. with cancel, they cannot. Solution idea: Use an actor or MainActor-isolated counter of completions. print query id on finish. show overwrite vs cancel. B3. async let vs TaskGroup Implement two functions that fetch three fake resources: loadFixed() using async let loadDynamic(_ ids:. [String]) using withThrowingTaskGroup Print ordering differences. Cancel the parent early and observe child cancellation.

## §3 C. Debugging drills

Next. C. Debugging drills.

C1. Symptom: intermittent wrong search results Given: Debounce sleep exists. Tasks are not stored. Find: Root cause + fix in two sentences. Solution: Multiple in-flight Tasks. cancel/store Task (S3 pattern). C2. Symptom: “Impossible” actor invariant break Given: Actor method sets isRefreshing = true, awaits network, sets result, clears flag. Sometimes two refreshes interleave oddly. Find: Name the concurrency concept + one fix. Solution: Reentrancy across await. single-flight in-flight task/continuation or re-check flags/generation after await. C3. Symptom: Swift 6 errors on crossing a class into an actor Find: What to change architecturally (not just. @unchecked). Solution: Send Sendable data transfer object values. keep class inside MainActor/actor isolation. avoid unchecked unless proven.

## §4 D. Speaking drills (record)

Next. D. Speaking drills (record).

#: Prompt, Budget, Provenance. D1: async/await vs G C D, 45. 60s, S2 bridge. D2: Actor reentrancy, 60. 90s, Learning-lab. D3: Migrate sync dict. actor, 90s, S2. S2-A1. D4: Search cancellation, 60. 90s, S3. D5: Sendable + value types caveat, 45. 60s, Learning-lab. D6: Swift 6 defaults humility, 45s, Settings when enabled. Score each on: agenda opener, mechanism, trade-off, provenance honesty, timing.

## §5 E. Flash recall (cover / uncover)

Next. E. Flash recall (cover / uncover).

Front: Back. Structured concurrency: Parent owns children. cancel propagates · Trap: detached everywhere · Prod: search Task ownership. Actor: Isolated mutable state · Trap: ignore reentrancy · Prod: S2-A1 greenfield. Reentrancy: State may change after await · Trap: assume continuity · Prod: refresh/single-flight. Sendable: Cross-domain safe · Trap: “all structs” · Need: all stored props Sendable. @MainActor: U I isolation · Trap: heavy work on main · Prod: VM state. Task cancel: Cooperative · Trap: kill thread · Prod: S3 debounce. async let: Fixed parallel · Trap: unbounded N · Prod: dual/triple fetch. TaskGroup: Dynamic parallel · Trap: forget await children · Prod: prefetch. Detached: Independent lifetime · Trap: default choice · Prod: rare. S2: G C D sync dictionaries verified · Trap: claim app-wide CFS · Path-scoped races. S2-A1: Actor for greenfield · Trap: big-bang rewrite · Strangler. Settings: Swift 6 / Approachable / default MainActor · Trap: universal claim · Say when enabled.

## §6 F. Day close-out checklist

Next. F. Day close-out checklist.

[ ] Explained reentrancy without notes [ ] Stated Sendable stored-property rule correctly [ ] Delivered S2 STAR. ≤3 min with honest metrics scope [ ] Delivered S2-A1 migration as applied. not shipped rewrite [ ] Tied debounce cancellation to S3 [ ] Qualified Swift 6 / Approachable Concurrency. / default MainActor as settings when enabled [ ] Read SafeDictActor.swift aloud line-by-line once [ ] Completed timed. set from 04-questions.md.
