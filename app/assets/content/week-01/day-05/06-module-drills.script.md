# Audio script — Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)
> Listen-only sample Q&A from `06-module-drills.md`. Spoken answers and follow-ups.

## §0 Q1. Walk the reentrancy storyboard out loud (exercise A1)

Next. Q1. Walk the reentrancy storyboard out loud (exercise A1) Answer. “Task A enters Wallet.spend, sees low balance, awaits refresh. While A is suspended, Task B enters — spend or applyRemoteBalance — and changes balance or flags. A resumes. If A still trusts the pre-await balance, money logic breaks. Fix: re-read balance after await. Snapshotting into a local let is fine for comparison, but it doesn’t freeze the actor field. Better: generation token — only apply remote if generation still matches, then bump. Or fetch the remote value outside, then do a short synchronous apply on the actor after re-check.” Follow-ups. Data race?: “No — actor isolated the Int. Logic race — yes.”. isRefreshing boolean alone?: “Fragile across await — another call can flip it.”.

## §1 Q2. Sendable true/false — fire them back fast (exercise A2)

Next. Q2. Sendable true/false — fire them back fast (exercise A2) Answer. “One: every struct is Sendable — false; stored props must be Sendable. Two: struct with only let name: String — true. Three: struct holding NSMutableDictionary is Sendable because it’s a value type — false; shared mutable reference. Four: unchecked Sendable proves safety — false; it disables checking. Five: default MainActor is always on in every Swift 6.2 app — false; settings when enabled.” Follow-ups. Fix number three?: “Keep the mutable dict inside an actor, or send a value snapshot.”. Fix number four?: “Prove sync yourself, or prefer an actor for new code.”.

## §2 Q3. Six concrete actions for debounce search (exercise A3)

Next. Q3. Six concrete actions for debounce search (exercise A3) Answer. “Store searchTask. Cancel previous on each query change. Use cancellable debounce sleep — Task.sleep, not Thread.sleep. checkCancellation before and after network. Ignore CancellationError for UX. Publish results on MainActor. Optional generation token. That’s the checklist I’d write on a whiteboard.” Follow-ups. Prove without cancel?: “Lab: show older finish overwriting newer; then add cancel and show it stops.”. Provenance?: “BookMyShow backend-driven header & search — don’t invent ms.”.

## §3 Q4. Debugging: intermittent wrong search results

Next. Q4. Debugging: intermittent wrong search results Answer. “Symptom: debounce sleep exists, but Tasks aren’t stored. Root cause: multiple in-flight searches; slow older one wins. Fix: store the Task and cancel it on each keystroke — S3 pattern. Two sentences. Done.” Follow-ups. Still wrong after cancel?: “Add generation token or ‘only apply if query matches.’”.

## §4 Q5. Debugging: “impossible” actor invariant break

Next. Q5. Debugging: “impossible” actor invariant break Answer. “Method sets isRefreshing true, awaits network, writes result, clears flag. Two refreshes interleave oddly. Name it: reentrancy across await. Fix: single-flight — one in-flight task — or re-check flags and generation after await before applying.” Follow-ups. Same as wallet?: “Same family — logic across suspension.”.

## §5 Q6. Debugging: Swift 6 errors crossing a class into an actor

Next. Q6. Debugging: Swift 6 errors crossing a class into an actor Answer. “Don’t reach for unchecked first. Architecturally: send Sendable DTO values across the boundary, keep the class inside MainActor or an actor, expose async methods that return values. Unchecked only when you’ve proven synchronization — and prefer actors for new mutability.” Follow-ups. UIKit type?: “Hop to MainActor — don’t pretend UIView is Sendable.”.

## §6 Q7. Flash recall — fire front → back like cards

Next. Q7. Flash recall — fire front → back like cards Answer. “Structured concurrency — parent owns children, cancel propagates; trap is detached everywhere; prod is search Task ownership. Actor — isolated mutable state; trap is ignoring reentrancy; prod is greenfield SafeDict design. Reentrancy — state may change after await; trap is assuming continuity; prod is refresh and single-flight. Sendable — cross-domain safe; trap is ‘all structs’; need all stored props Sendable. MainActor — U I isolation; trap is heavy work on main; prod is ViewModel state. Task cancel — cooperative; trap is thinking you kill the thread; prod is S3 debounce. async let — fixed parallel; trap is using it for unbounded N; prod is dual or triple fetch. TaskGroup — dynamic parallel; trap is forgetting to await children; prod is prefetch with a cap. Detached — independent lifetime; trap is making it the default; prod is rare. S 2 — G C D sync dictionaries verified; trap is claiming app-wide crash free sessions; path-scoped races. S 2-A1 — actor for greenfield; trap is big-bang rewrite; strangler. Settings — Swift 6 / Approachable / default MainActor; trap is universal claim; say when enabled.” Follow-ups. Drill how?: “Cover the name, speak the back, uncover, score yourself.”.

## §7 Q8. Day close-out — can you check these off?

Next. Q8. Day close-out — can you check these off? Answer. “Without notes: I can explain reentrancy. I stated the Sendable stored-property rule correctly. I delivered S 2 STAR under three minutes with honest metric scope. I delivered S 2-A1 as applied design, not a shipped rewrite. I tied debounce cancel to S3. I qualified Swift 6 / Approachable / default MainActor as settings when enabled. I read SafeDictActor aloud once. I ran a timed set from 04-questions. If any box is open, that’s my next drill — not more reading.” Follow-ups. Where to practice code?:../05-exercises.md B1–B3. Where to time speak?:../04-questions.md T1–T10.

## §8 Q9. What should you be able to do by end of Day 05? (README outcomes)

Next. Q9. What should you be able to do by end of Day 05? (README outcomes) Answer. “Explain async/await as cooperative suspension — not background-thread magic. Contrast structured concurrency with unstructured Task. Describe cooperative cancel and why search debounce must cancel. Explain actor isolation, reentrancy, and MainActor. State Sendable correctly including the stored-property rule. Pitch BMS synchronised dictionaries and a greenfield actor migration honestly. Speak carefully about Swift 6 / Approachable Concurrency / default MainActor as settings when enabled.” Follow-ups. Timed drill?: “Q4, Q5, T1, T3 on a timer; then 90s migrate dictionaries to actors.”.
