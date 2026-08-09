# Audio script — Sample 02 — Structured concurrency and cancellation (Q&A)
> Listen-only sample Q&A from `02-structured-concurrency.md`. Spoken answers and follow-ups.

## §0 Q1. What is structured concurrency?

Next. Q1. What is structured concurrency? Answer. “Think of async work as a tree. A parent starts children and doesn’t finish until those children finish or get cancelled. Cancel and errors can travel down that tree. The scope that started the work owns it — so when the user leaves a screen, you know what to cancel. Unstructured fire-and-forget Tasks escape that tree. Then you’re on your own for lifetime.” Follow-ups. Plain analogy?: “Like a function waiting for two helpers before returning — but for async children.”. Without structure?: “Work outlives the screen. Stale results win. Orphans keep running.”. One-liner?: “Parent owns children — cancellation propagates.”.

## §1 Q2. When do I use `async let` vs TaskGroup?

Next. Q2. When do I use `async let` vs TaskGroup? Answer. “async let when I know a small fixed set — load details, showtimes, and offers together. Kids start together; I await them when the scope ends. withTaskGroup when N is dynamic — prefetch N poster URLs. If N can be huge, I say I’d cap concurrency so we don’t stampede the network. Both are structured: cancel the parent and the kids get the cancel signal.” Follow-ups. Errors with async let?: “If a child throws, the parent’s try await surfaces it — one place for errors.”. Collecting TaskGroup results?: “for await over the group into an array or dictionary.”. Interview risk?: “Unbounded group on thousands of URLs — say you’d chunk or cap.”.

## §2 Q3. What is unstructured concurrency, and when is it OK?

Next. Q3. What is unstructured concurrency, and when is it OK? Answer. “Task { … } and Task.detached start work outside a strict parent/child scope. You store the handle, plan cancel, and decide isolation yourself. That’s fine at sync boundaries — button taps, old UIKit entry points. Avoid burying naked Task { } deep inside reusable async APIs where async let or TaskGroup already say who owns the work. Search typing that forgets cancel is the classic bug.” Follow-ups. Detached by default?: “No. Rare. Truly independent background work. Pass Sendable values explicitly.”. MainActor inheritance?: “Task { } from MainActor often runs on main — be explicit for U I mutations.”. Prefer inside async APIs?: “Structured — not fire-and-forget helpers.”.

## §3 Q4. How does Task cancellation work?

Next. Q4. How does Task cancellation work? Answer. “Cancellation is cooperative — not ‘kill the thread now.’ Something calls task.cancel(), or a parent cancels. The task gets marked cancelled. Work actually stops when you hit a cancellable await that throws CancellationError, or you check Task.isCancelled / try Task.checkCancellation(), or you exit early on purpose. A tight CPU loop with no checks can ignore cancel completely.” Follow-ups. Like pthread kill?: “No. Swift concurrency doesn’t yank the thread mid-instruction.”. CancellationError in debounce?: “Often expected — don’t treat it like a real failure.”. Parent cancelled — children?: “Structured kids get the signal too — they still have to cooperate.”.

## §4 Q5. Why must search debounce cancel in-flight work?

Next. Q5. Why must search debounce cancel in-flight work? Answer. “User types a, then av, then ave. Three requests fly. If the slow a comes back last, it can overwrite the fresh ave results. Sleep alone doesn’t fix that. On each keystroke I cancel the previous Task, start a new one — debounce sleep plus fetch — and sometimes I also keep a generation token. At BookMyShow, backend-driven header & search: debounce plus clear loading/empty/error state in M V V M. Cancellation is part of the product behavior, not a nice-to-have.” Follow-ups. Debounce = only sleep?: “No. The senior piece is cancel + ignore stale responses.”. Where store Task?: “ViewModel property — cancel before starting the next.”. ≤20s line?: “Debounced and cancelled the previous in-flight Task so older responses couldn’t win.”.

## §5 Q6. What about URLSession and cancellation?

Next. Q6. What about URLSession and cancellation? Answer. “Async URLSession APIs like data(for:) participate in Task cancellation — cancel the Task and the request usually cancels too. Old callback dataTask style needs explicit URLSessionTask.cancel() and stale-response guards. I don’t claim ‘all networking magically cancels’ — I say which A P I family I’m on.” Follow-ups. Belt-and-suspenders?: “Generation token, or only apply if the query still matches after await.”. Migrating callbacks?: “Async path composes with structured cancel. Callbacks need manual wiring.”. Stale guard without cancel?: “Possible but fragile. Cancel is the primary fix.”.

## §6 Q7. What failure modes should I name?

Next. Q7. What failure modes should I name? Answer. “Fire-and-forget Task — work after the view controller is gone, stale U I. Debounce without cancel — out-of-order search. Blocking G C D sync inside async — pool starvation. Fixes: store and cancel the Task; weak self / MainActor VM patterns; async façades instead of sync hops. Rule I use: any user-driven repeated request → cancel the previous Task.” Follow-ups. view controller dismissed mid-Task?: “Cancel on disappear or deinit; weak self if the closure captures U I.”. Parallel known children?: “async let. Dynamic N → TaskGroup, preferably bounded.”. Next sample?: Actors — 03-actors-sendable.md..

## §7 Q8. Structured vs unstructured — how do I choose?

Next. Q8. Structured vs unstructured — how do I choose? Answer. “Prefer structured concurrency inside async APIs — async let or TaskGroup — so the parent owns the kids and cancel propagates. Use unstructured Task only at sync boundaries like U I actions. And when the user can repeat the action quickly — search — always plan cancellation. That’s the BookMyShow search story: unstructured Task at the VM boundary, cooperative cancel on every query change.” Follow-ups. Inside loadVenuePage?: “Structured — async let for parallel fetches.”. Button tap?: “Unstructured bridge — Task { await … }.”. Next file?: 03-actors-sendable.md.

## §8 Q9. What do you say about Task priority / QoS?

Next. Q9. What do you say about Task priority / QoS? Answer. “Tasks carry priority and often inherit from the parent — same spirit as caring about G C D QoS, different knobs. Keep interactive U I work responsive. Don’t casually run bulk prefetch at the highest priority. Set priority on purpose for true background work, and don’t assume the runtime will save you from heavy decoding on MainActor.” Follow-ups. Detached priority?: “You can set it — still don’t starve U I.”. Inherit?: “Usually yes for Task { }. Detached is independent.”. Bridge from G C D QoS?: “Same judgment: urgency vs battery — different APIs.”.

## §9 Q10. Why is GCD `sync` inside async risky?

Next. Q10. Why is GCD `sync` inside async risky? Answer. “Swift concurrency multiplexes many tasks onto a thread pool. If async code calls DispatchQueue.sync and blocks, you can starve that pool and hang. Sync onto main is especially sharp — deadlock or long stalls. In mixed codebases I wrap legacy queue APIs with async façades using continuations, resume exactly once, and avoid sync bridges from async paths. At BMS we still have G C D dictionary isolation — the lesson is serialize at the boundary without blocking the world.” Follow-ups. When is sync OK?: “Tiny known sync contexts — not as the spine of your async design.”. Prefer instead?: “Continuations, actors, async methods end-to-end.”. Symptom?: “Hang, watchdog, or ‘async but everything stalled.’”.

## §10 Q11. Walk a real search ViewModel like you’d code it

Next. Q11. Walk a real search ViewModel like you’d code it Answer. “I’d keep a @MainActor ViewModel with a stored searchTask. On each query change I cancel the old task, then start a new one. Inside: sleep for debounce, try Task.checkCancellation(), await the A P I, assign results. I catch CancellationError as normal — not an error banner. Other errors map to U I error state. That’s the BookMyShow search shape: unstructured Task at the U I boundary, cooperative cancel on every keystroke.” Follow-ups. Why MainActor VM?: “Published U I state stays on main while the Task cancels and restarts.”. Generation token?: “Optional belt-and-suspenders — only apply if the query still matches.”. Invent 300ms from prod?: “No. I may demo 300ms in a lab; I don’t claim a production constant.”.

## §11 Q12. What failure modes should I name in production thinking?

Next. Q12. What failure modes should I name in production thinking? Answer. “Fire-and-forget Task — work after the screen is gone, stale U I. Debounce without cancel — out-of-order search. Reentrancy assumption — balances or flags wrong after await. Unchecked Sendable lie — intermittent crashes. Heavy work on MainActor — jank. Blocking G C D sync inside async — pool starvation. Big-bang G C D-to-actor rewrite — regressions. Mitigations: store and cancel; re-validate after await; prefer actors for new mutability; offload CPU; async façades; strangler migration.” Follow-ups. One rule that covers search?: “Any user-driven repeated request → cancel the previous Task.”. One rule for actors?: “After every await in an actor → assume state may have changed.”.

## §12 Q13. How do you wrap a legacy GCD API into async?

Next. Q13. How do you wrap a legacy GCD API into async? Answer. “I expose an async façade with a continuation. The G C D callback resumes the continuation — and I resume exactly once. No double-resume, no forget-to-resume. From async code I await that façade. I avoid calling DispatchQueue.sync from the middle of async/await paths, especially sync to main. Prefer await MainActor.run or a MainActor method for U I hops.” Follow-ups. Why resume-once?: “Double resume crashes; never resume leaves the await hung forever.”. Still use G C D underneath?: “Yes — strangler. Stable queue stays; new callers see async.”.

## §13 Q14. `async let` venue page — say it like a story

Next. Q14. `async let` venue page — say it like a story Answer. “Loading a venue page I need details, showtimes, and offers — fixed three. I write three async lets so they start together, then try await them into one page model. If the parent is cancelled — user left — the children get cancelled too. That’s structured fan-out for a known small set. If I’m prefetching N poster URLs, that’s TaskGroup, and I name the stampede risk and cap concurrency.” Follow-ups. One child throws?: “The parent’s try await surfaces it; structure keeps errors in one place.”. Cap how?: “Chunk URLs, or limit in-flight adds — interviewers care that you name the risk.”.

## §14 Q15. Timeouts — what do you say?

Next. Q15. Timeouts — what do you say? Answer. “Async/await doesn’t magically give you timeouts. I design them — race the work against Task.sleep in a group or use A P I-level timeouts — and cancel the loser. Same cooperative story: cancel must actually stop the work.” Follow-ups. Search timeout?: “Cancel the search Task; show error or empty; don’t leave a hung spinner.”.
