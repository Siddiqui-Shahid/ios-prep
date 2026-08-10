# Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)

> Pulled from `01-foundations`, `02-deep-dive`, `05-exercises`, and the day README — anything easy to miss if you only read samples 01–05. 
> Say answers like a conversation. Then do the real coding drills in [`../05-exercises.md`](../05-exercises.md).

---

### Q1. Walk the reentrancy storyboard out loud (exercise A1)?
**Answer:**

> “Task A enters Wallet.spend, sees low balance, awaits refresh. While A is suspended, Task B enters — spend or applyRemoteBalance — and changes balance or flags. A resumes. If A still trusts the pre-await balance, money logic breaks. Fix: re-read balance after await. Snapshotting into a local `let` is fine for comparison, but it doesn’t freeze the actor field. Better: generation token — only apply remote if generation still matches, then bump. Or fetch the remote value outside, then do a short synchronous apply on the actor after re-check.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Data race? | “No — actor isolated the Int. Logic race — yes.” |
| isRefreshing boolean alone? | “Fragile across await — another call can flip it.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Learning-lab wallet demo — not a shipped BMS wallet.

---

### Q2. Sendable true/false — fire them back fast (exercise A2)?
**Answer:**

> “One: every struct is Sendable — false; stored props must be Sendable. Two: struct with only `let name: String` — true. Three: struct holding NSMutableDictionary is Sendable because it’s a value type — false; shared mutable reference. Four: unchecked Sendable proves safety — false; it disables checking. Five: default MainActor is always on in every Swift 6.2 app — false; settings when enabled.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fix number three? | “Keep the mutable dict inside an actor, or send a value snapshot.” |
| Fix number four? | “Prove sync yourself, or prefer an actor for new code.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Six concrete actions for debounce search (exercise A3)?
**Answer:**

> “Store searchTask. Cancel previous on each query change. Use cancellable debounce sleep — Task.sleep, not Thread.sleep. checkCancellation before and after network. Ignore CancellationError for UX. Publish results on MainActor. Optional generation token. That’s the checklist I’d write on a whiteboard.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Prove without cancel? | “Lab: show older finish overwriting newer; then add cancel and show it stops.” |
| Provenance? | “BookMyShow backend-driven header & search — don’t invent ms.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search

---

### Q4. Debugging: intermittent wrong search results?
**Answer:**

> “Symptom: debounce sleep exists, but Tasks aren’t stored. Root cause: multiple in-flight searches; slow older one wins. Fix: store the Task and cancel it on each keystroke — pattern. Two sentences. Done.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Still wrong after cancel? | “Add generation token or ‘only apply if query matches.’” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search

---

### Q5. Debugging: “impossible” actor invariant break?
**Answer:**

> “Method sets isRefreshing true, awaits network, writes result, clears flag. Two refreshes interleave oddly. Name it: reentrancy across await. Fix: single-flight — one in-flight task — or re-check flags and generation after await before applying.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Same as wallet? | “Same family — logic across suspension.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Debugging: Swift 6 errors crossing a class into an actor?
**Answer:**

> “Don’t reach for unchecked first. Architecturally: send Sendable DTO values across the boundary, keep the class inside MainActor or an actor, expose async methods that return values. Unchecked only when you’ve proven synchronization — and prefer actors for new mutability.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| UIKit type? | “Hop to MainActor — don’t pretend UIView is Sendable.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Flash recall — fire front → back like cards?
**Answer:**

> “Structured concurrency — parent owns children, cancel propagates; trap is detached everywhere; prod is search Task ownership.
>
> Actor — isolated mutable state; trap is ignoring reentrancy; prod is greenfield SafeDict design.
>
> Reentrancy — state may change after await; trap is assuming continuity; prod is refresh and single-flight.
>
> Sendable — cross-domain safe; trap is ‘all structs’; need all stored props Sendable.
>
> MainActor — UI isolation; trap is heavy work on main; prod is ViewModel state.
>
> Task cancel — cooperative; trap is thinking you kill the thread; prod is debounce.
>
> async let — fixed parallel; trap is using it for unbounded N; prod is dual or triple fetch.
>
> TaskGroup — dynamic parallel; trap is forgetting to await children; prod is prefetch with a cap.
>
> Detached — independent lifetime; trap is making it the default; prod is rare.
>
> — GCD sync dictionaries verified; trap is claiming app-wide CFS; path-scoped races.
>
> — actor for greenfield; trap is big-bang rewrite; strangler.
>
> Settings — Swift 6 / Approachable / default MainActor; trap is universal claim; say when enabled.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drill how? | “Cover the name, speak the back, uncover, score yourself.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Day close-out — can you check these off?
**Answer:**

> “Without notes: I can explain reentrancy. I stated the Sendable stored-property rule correctly. I delivered STAR under three minutes with honest metric scope. I delivered as applied design, not a shipped rewrite. I tied debounce cancel to . I qualified Swift 6 / Approachable / default MainActor as settings when enabled. I read SafeDictActor aloud once. I ran a timed set from 07-revision-qna. If any box is open, that’s my next drill — not more reading.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where to practice code? | [../05-exercises.md](../05-exercises.md) B1–B3 |
| Where to time speak? | [07-revision-qna.md](07-revision-qna.md) T1–T10 |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse after every Day 05 study block.

---

### Q9. What should you be able to do by end of Day 05? (README outcomes)?
**Answer:**

> “Explain async/await as cooperative suspension — not background-thread magic. Contrast structured concurrency with unstructured Task. Describe cooperative cancel and why search debounce must cancel. Explain actor isolation, reentrancy, and MainActor. State Sendable correctly including the stored-property rule. Pitch BMS synchronised dictionaries and a greenfield actor migration honestly. Speak carefully about Swift 6 / Approachable Concurrency / default MainActor as settings when enabled.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timed drill? | “Q4, Q5, T1, T3 on a timer; then 90s migrate dictionaries to actors.” |

**How can I relate to my case:**
- **Shipped / design** as labeled in provenance — never blur them.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Snapshot local vs actor field

Task A does `let old = balance` then `await refresh` then `balance = old - amount`.

**Ask:** Is that safe?

**Answer:** Usually **worse**. You froze an old number and wrote it back, possibly wiping B’s updates. Re-read `balance` after await; don’t restore a stale snapshot as truth.

---

### Puzzle B — Lab search without cancel

You sleep 300ms, fetch, set `latest = query`. Never cancel. Type `a`, `av`, `ave` fast. Slow `a` finishes last.

**Ask:** What does `latest` show?

**Answer:** Often `"a"` — stale win. Cancel previous Task (or generation gate) so only the newest completion applies.

---

### Puzzle C — Approachable Concurrency claim

Interviewer: “In Swift 6 everything is MainActor by default, right?”

**Good reply:** “Not universally. Default isolation depends on language mode and concurrency settings. I check the target’s settings and write isolation explicitly for UI and shared state. When enabled, checking is stricter — the concepts don’t change.”
