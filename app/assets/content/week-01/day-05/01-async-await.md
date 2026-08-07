# Sample 01 — async/await mental model (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What does `async`/`await` mean in plain words?

**Answer:**

> An `async` function can **suspend** at `await` points instead of nesting callbacks. Suspension means the function yields so the runtime can do other work; it is **not** the same as blocking a thread. When the awaited work finishes, the function **resumes** where it left off. You get linear control flow and normal `throws`/`try` error handling.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is async/await automatically faster than GCD? | No. It is usually **clearer** and easier to compose — not a free speed boost. |
| What marks a possible pause? | `await` — treat code after it as running **later**, possibly after other concurrent work. |
| Do I throw away GCD? | No. Large apps mix both. Pick the right tool per boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Does `await` always jump to a background thread?

**Answer:**

> **No.** `await` means “possible suspension.” Where you resume depends on **actor isolation** and the callee’s executor — main actor, a custom actor, or the cooperative thread pool. Threads and tasks are different: many tasks can share threads. Blocking inside async code (long locks, `DispatchQueue.sync`) can starve the pool.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Does every `await` actually suspend? | Not always — some callees finish synchronously. Still treat `await` as a **logical** boundary. |
| UI updates after network — where? | Usually hop back to `@MainActor` for UI state; network work stays off main. |
| Self-check from foundations? | “Does await always mean background thread?” → **No.** |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is the difference between blocking and suspending?

**Answer:**

> **Blocking** ties up a thread waiting — e.g. `DispatchQueue.sync` on a busy queue, or holding a lock. That thread cannot do other useful work. **Suspending** lets the async function yield; the runtime may reuse the thread for other tasks and resume your function later. Async/await is built around suspension, not “block less magically.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why care in interviews? | Shows you won’t say “async = background thread magic.” |
| GCD `sync` inside async code? | Risky — can deadlock or starve the cooperative pool. Prefer async facades. |
| Suspension vs sleep? | `Task.sleep` suspends cooperatively; `Thread.sleep` blocks a thread. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is a Task, and when do I start one?

**Answer:**

> A **Task** is a unit of async work the system can schedule. Inside async code you usually just `await` other async functions. From **synchronous** code — like a button tap — you bridge with `Task { … }`. Prefer staying in structured async calls; use plain `Task` at sync boundaries. Treat `Task.detached` as rare — it does not inherit parent context the same way.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `Task { }` vs `Task.detached`? | `Task { }` inherits more context (actor, priority); detached is for truly independent work. |
| Must I store the Task handle? | When you need to **cancel** (search debounce) — yes. Fire-and-forget is a common bug. |
| `@MainActor` button handler? | `Task { await viewModel.load() }` — common UI entry pattern. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How does async/await compare to GCD callbacks?

**Answer:**

> Callbacks nest — pyramid of doom — and errors often repeat in every closure. Async/await gives linear `try await` flow and one `throws` path. Cancellation moves toward cooperative Task cancel (plus API participation). Shared state still needs discipline — actors and Sendable now, GCD queues where legacy. Day 04 serial-queue dictionaries remain valid; Day 05 adds language-native options.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mental model shift? | From “which queue am I on?” to “which **isolation domain** am I in?” |
| URLSession example? | `try await URLSession.shared.data(from: url)` — one line vs nested callbacks. |
| Still need main queue? | Yes for UI — often via `@MainActor` instead of manual `DispatchQueue.main.async`. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Walk through the tiny end-to-end picture in one breath

**Answer:**

> Button tap (sync) → `Task { @MainActor in await viewModel.search(query) }` bridges into async. ViewModel cancels the previous search Task, sleeps for debounce, checks cancellation, awaits the API, then updates `@Published` results on main. Shared caches can live in an actor with `await get` / `await set`. Narrate: entry → cancel old work → await network → UI state on main → isolate shared maps.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why cancel before debounce sleep? | New keystroke should drop the old in-flight search — BookMyShow backend-driven header & search pattern. |
| Where is unstructured Task OK? | UI/sync boundary — not deep inside reusable async APIs. |
| 30s interview definition? | See foundations §6 — suspension, structure, actors, reentrancy preview. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What glossary terms must I speak cleanly?

**Answer:**

> **Suspension** — pause at `await`. **Executor** — what runs the job (main actor, actor serial executor). **Isolation** — who may touch which mutable state. **Cooperative cancellation** — task keeps running until it checks cancel or hits a cancellable `await`. **Data race** — unsynchronized concurrent access; **race condition** — broader ordering bug. Say these without mixing them up.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Executor vs thread? | Executor schedules work; threads are OS resources tasks may share. |
| Isolation domain example? | `@MainActor` ViewModel vs custom `actor` cache. |
| Approachable Concurrency? | Optional **settings** direction — not universal language law (deep dive §7). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What should I nail before moving to structured concurrency?

**Answer:**

> One sentence each: (1) `await` ≠ always background thread. (2) Structured parent cancel propagates to children. (3) Another call **can** interleave on an actor during `await` — reentrancy. (4) Structs are Sendable **only if** stored properties are. (5) “Swift 6 defaults everything to MainActor” is **not** a safe universal claim. If any felt fuzzy, re-read while holding that question.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where next in sample path? | [02-structured-concurrency.md](02-structured-concurrency.md) |
| Main module after sample? | [02-deep-dive.md](../02-deep-dive.md) §2–3 |
| Code to read aloud? | [SafeDictActor.swift](../code/SafeDictActor.swift) after actors sample |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-structured-concurrency.md](02-structured-concurrency.md)

---

