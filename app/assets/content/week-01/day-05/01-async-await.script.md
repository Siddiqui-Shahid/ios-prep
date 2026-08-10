# Audio script — Sample 01 — async/await mental model (Q&A)
> Listen-only sample Q&A from `01-async-await.md`. Spoken answers and follow-ups.

## §0 Q1. What does `async`/`await` mean in plain words?

Next. Q1. What does `async`/`await` mean in plain words? Answer. “An async function is allowed to pause. When it hits await, it can suspend — hand the thread back so other work can run — and later pick up right where it left off. That’s not the same as blocking a thread and sitting there frozen. Because of that, you write the code top to bottom instead of nesting callbacks, and errors go through normal try / throws.” Follow-ups. Is it automatically faster than G C D?: “No. It’s usually clearer and easier to compose. Not a free speed boost.”. What marks a possible pause?: “await. Treat everything after it as ‘maybe later’ — other work may have run in between.”. Do I throw away G C D?: “No. Big apps mix both. Pick the right tool at each boundary.”.

## §1 Q2. Does `await` always jump to a background thread?

Next. Q2. Does `await` always jump to a background thread? Answer. “No — and this is the trap people fall into. await means ‘I might suspend.’ Where you resume depends on actors and executors — main actor, a custom actor, or the cooperative pool. Tasks are not one-to-one with threads; many tasks can share threads. If you block inside async code with a long lock or DispatchQueue.sync, you can starve that pool.” Follow-ups. Does every await actually suspend?: “Not always — some calls finish without really pausing. Still treat await as a logical boundary.”. U I after network — where?: “Network off main; hop back to @MainActor when you update U I state.”. Self-check?: “‘Does await always mean background thread?’ → No.”.

## §2 Q3. What’s the difference between blocking and suspending?

Next. Q3. What’s the difference between blocking and suspending? Answer. “Blocking means a thread is stuck waiting — like DispatchQueue.sync on a busy queue, or holding a lock. That thread can’t help anyone else. Suspending means the async function yields. The runtime can reuse the thread for other tasks and come back to you later. Async/await is built around suspension, not ‘block less with magic.’” Follow-ups. Why do interviewers care?: “So you don’t say ‘async equals background thread magic.’”. G C D sync inside async?: “Risky — deadlock or starve the pool. Prefer async façades.”. Sleep?: “Task.sleep suspends. Thread.sleep blocks. Big difference.”.

## §3 Q4. What is a Task, and when do I start one?

Next. Q4. What is a Task, and when do I start one? Answer. “A Task is a unit of async work the system can schedule. Inside async code you usually just await other async functions — you don’t need a new Task for every call. From sync code — like a button tap — you bridge with Task { … }. Prefer staying in structured async calls. Treat Task.detached as rare; it doesn’t inherit parent context the same way.” Follow-ups. Task { } vs Task.detached?: “Task { } inherits more context — actor, priority. Detached is for truly independent work.”. Must I keep the handle?: “If you need to cancel — yes, like search. Fire-and-forget is a common bug.”. Button on MainActor?: “Task { await viewModel.load } — normal U I entry pattern.”.

## §4 Q5. How does async/await compare to GCD callbacks?

Next. Q5. How does async/await compare to GCD callbacks? Answer. “With callbacks, everything nests. Fetch, then parse, then save — each one inside the last. People call that the pyramid of doom. And every closure usually has its own error handling, so you repeat yourself. Async/await flattens that. You write it top to bottom: try await fetch, try await parse, try await save. Errors go through one throws path. Cancellation is different too. Instead of handmade flags everywhere, you cancel the Task, and the APIs that support it stop cooperatively. One thing that doesn’t go away: shared mutable state. You still have to protect it. Nowadays that’s often an actor and Sendable. Older code still uses G C D queues — and that’s fine. Day 04’s serial-queue dictionaries are still valid. Day 05 just gives you a language-native option on top.” Follow-ups. Mental model shift?: “From ‘which queue am I on?’ to ‘which isolation domain am I in?’”. URLSession example?: “try await URLSession.shared.data(from: url) — one line vs nested callbacks.”. Still need main?: “Yes for U I — often @MainActor instead of manual DispatchQueue.main.async.”.

## §5 Q6. Walk the tiny end-to-end picture in one breath?

Next. Q6. Walk the tiny end-to-end picture in one breath? Answer. “Button tap is sync, so I bridge with Task { await viewModel.search(query) }. The ViewModel cancels the previous search Task, waits a bit for debounce, checks cancellation, awaits the A P I, then updates published results on main. Shared caches can live in an actor — await get, await set. Story I tell: enter from U I → cancel old work → await network → update U I on main → isolate shared maps.” Follow-ups. Why cancel before debounce sleep?: “New keystroke should drop the old search — BookMyShow backend-driven header & search pattern.”. Where is unstructured Task OK?: “At the U I/sync boundary — not buried deep inside reusable async APIs.”. 30s definition?: “Suspension, structure, actors, and reentrancy — see foundations glossary.”.

## §6 Q7. What glossary words must I say cleanly?

Next. Q7. What glossary words must I say cleanly? Answer. “Suspension — pause at await. Executor — what runs the job, like main actor or an actor’s serial executor. Isolation — who may touch which mutable state. Cooperative cancellation — the task keeps going until it checks cancel or hits a cancellable await. Data race — unsynchronized concurrent access. Race condition — broader ordering bug. Don’t mix those up.” Follow-ups. Executor vs thread?: “Executor schedules work. Threads are OS resources tasks may share.”. Isolation example?: “@MainActor ViewModel vs a custom actor cache.”. Approachable Concurrency?: “Optional project settings — not universal language law.”.

## §7 Q8. What should I nail before structured concurrency?

Next. Q8. What should I nail before structured concurrency? Answer. “Five one-liners. One: await is not always a background thread. Two: structured parent cancel can hit children. Three: another call can interleave on an actor during await — that’s reentrancy. Four: structs are Sendable only if their stored properties are. Five: ‘Swift 6 defaults everything to MainActor’ is not a safe universal claim. If any of those feels fuzzy, re-read holding that question.” Follow-ups. Where next?: 02-structured-concurrency.md. Main module?: 02-deep-dive.md §2–3. Code to read aloud?: SafeDictActor.swift after actors sample.

## §8 Q9. Why does Day 05 exist after Day 04?

Next. Q9. Why does Day 05 exist after Day 04? Answer. “Yesterday was G C D — queues, sync and async, protecting a shared dictionary with a serial queue. That pattern actually shipped at BookMyShow as synchronised dictionaries. Today is the modern language-native half of the same problem. How do I write async work without callback pyramids? How do I keep parent and child work structured so cancel and errors make sense? How do I protect shared state with an actor instead of — or after — a G C D queue? And how does Sendable help the compiler catch races? I don’t throw G C D away. Big apps mix both. The senior skill is picking the right tool for the boundary, and migrating safely.” Follow-ups. One sentence?: “Day 04 was queues; Day 05 is async/await, structure, actors, and Sendable — same problem, modern tools.”. Throw away serial-queue dicts?: “No. They remain valid. For new maps I’d ask if an actor is cleaner.”.

## §9 Q10. Does every `await` actually suspend?

Next. Q10. Does every `await` actually suspend? Answer. “Not always. If the callee is already done — cached result, or you’re already on the right actor — resume can be basically immediate. I still treat every await as a logical boundary. After it, other concurrent work may have progressed, and any state I cared about might be stale. Suspension is possible, not guaranteed — the mental model still holds.” Follow-ups. So can I ignore await?: “No. Even a ‘fast’ await is a place where your assumptions about the world can break.”. From deep dive?: “Not every await suspends — still a logical boundary.”.

## §10 Q11. Give me the 30-second interview definition?

Next. Q11. Give me the 30-second interview definition? Answer. “async/await lets a function suspend at await points instead of nesting callbacks. Structured concurrency keeps child tasks under a parent so cancellation can propagate. Actors isolate shared mutable state — and after an await inside an actor, I re-check state because of reentrancy.” Follow-ups. Stretch to 90s with production?: “At BookMyShow we fixed shared-dictionary races with G C D serial queues and a closed A P I. For greenfield I’d expose the same get/set on a Swift actor. For search, debounce isn’t just a timer — you cancel the previous Task so stale responses can’t win.”. Where’s the full Q bank?: 07-revision-qna.md.

## §11 Q12. Data race vs race condition — don’t mix them up?

Next. Q12. Data race vs race condition — don’t mix them up? Answer. “A data race is unsynchronized concurrent access where at least one side writes — undefined, bad, crashes. A race condition is broader: your logic depends on ordering, and the ordering can go wrong even when the memory accesses are ‘safe.’ Actor reentrancy bugs are often race conditions without a data race — the actor protected the storage, but your business logic still broke across await.” Follow-ups. Example?: “Two spends both pass the balance check, both await, both subtract — no data race on the Int if it’s actor-isolated, still wrong money.”. Why interviewers care?: “Saying ‘actors fixed all concurrency bugs’ is too strong — they fixed a class of data races.”.
