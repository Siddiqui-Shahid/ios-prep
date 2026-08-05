# Sample 03 — Search MVVM: debounce, cancel, states (Q&A)

> Guided teaching. Ties learning-lab code to Verified S3 search behavior.

---

### Q1. Walk the happy path for debounced search in MVVM.

**Points to:** [Foundations · §6 Intern path: search](../01-foundations.md#6-intern-path-one-happy-search) · [Deep dive · §8 BMS search](../02-deep-dive.md#8-bms-search--full-mvvm-walkthrough-s3)

**Answer:**

> User types in the search bar; the View forwards `onQueryChange` to the ViewModel. The VM debounces ~300ms, cancels any previous `Task`, sets state to `.loading`, and calls `SearchRepository.search(query:)`. The repository hits remote (and maybe cache), returns domain models, and the VM maps to `.results` or `.empty`. The View renders from the enum — it never builds URLRequests or parses JSON.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who owns ranking? | Usually the server; client filters only if product requires local filter. |
| Offline / timeout branch? | Map to `.error` with a retry intent — not a crash. |
| Task cancelled mid-flight? | Ignore — not user-facing error. |

---

### Q2. Why does debounce belong in the ViewModel, not URLSession?

**Points to:** [Deep dive · §8.2 Timing policy](../02-deep-dive.md#82-timing-policy) · [Deep dive · §1 Ownership matrix](../02-deep-dive.md#1-ownership-matrix-interview-gold)

**Answer:**

> Debounce cadence is a UX/presentation choice tied to keystrokes — it lives with the screen that owns the search bar. The transport layer may cancel in-flight tasks when asked, but it should not know about 300ms keystroke timing. Putting debounce in the repository leaks presentation policy into data access and makes reuse across surfaces awkward.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Could debounce live in a UseCase? | Yes if product standardizes the same timing across multiple entry points. |
| AI mistake to call out? | “It placed debounce in the repository” — move to VM and add cancel. |
| Interview push: “Where does debounce live?” | VM/UseCase presentation policy; repo cancels tasks, not keystroke rhythm. |

---

### Q3. What is the stale-response race and how do you fix it?

**Points to:** [Deep dive · §2.4 Cancellation](../02-deep-dive.md#24-cancellation-is-part-of-mvvm) · [Deep dive · §8.3 Out-of-order responses](../02-deep-dive.md#83-out-of-order-responses)

**Answer:**

> Without cancel or generation tokens, query `"a"` can return after `"av"` already displayed — the UI flashes old results. Fix by cancelling the prior `Task` on each new query (preferred with structured concurrency), then checking `Task.isCancelled` before applying state. Alternative: monotonic request IDs and ignore stale generations. BMS search (S3) shipped debounce + cancel + explicit states specifically to make this race-safer on a high-traffic surface.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel vs generation token? | Prefer cancel + structured concurrency; generation guards are essential for callback `dataTask` APIs. |
| Show cancel as error banner? | No — expected when typing fast; silent ignore. |
| See code? | [SearchViewModel.swift](../code/SearchViewModel.swift) learning-lab shape. |

---

### Q4. What are the five presentation states search must name?

**Points to:** [Foundations · §6 Failure branches](../01-foundations.md#6-intern-path-one-happy-search) · [Deep dive · §2.1 State enum](../02-deep-dive.md#21-state-enum-beats-boolean-soup)

**Answer:**

> **Idle** before meaningful input. **Loading** while a debounced query is in flight. **Results** with hits. **Empty** when the server returned successfully but zero matches — not an error. **Error** for offline, timeout, or decode/contract breaks with retry. Cancellation returns to idle or stays on the latest query — never masquerades as error.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty vs error in interview? | Empty = valid “no matches”; error = could not complete request. |
| Decode failure? | Error state + metric; don’t crash the app on CMS/API drift. |
| Self-check from foundations? | Name all five before opening deep dive. |

---

### Q5. How does cancellation fit MVVM ownership?

**Points to:** [Deep dive · §2.4 Cancellation](../02-deep-dive.md#24-cancellation-is-part-of-mvvm) · [Foundations · §11 S3 search keys](../01-foundations.md#11-two-production-anchors-preview)

**Answer:**

> The ViewModel owns the search `Task` handle: on new query, cancel previous work; on `onDisappear`, cancel in-flight search. The View may signal lifecycle; the VM executes policy. Repository/DataSource may propagate task cancellation to URLSession, but the decision to stop caring about a result is a screen concern. Async `URLSession.data(for:)` participates in Swift `Task` cancellation; callback APIs need explicit `task.cancel()` plus stale guards (Day 09).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `[weak self]` in search Task? | Yes for escaping async work tied to a screen. |
| Fire-and-forget `Task { }` without handle? | Orphan work can apply after dismiss — hold and cancel the Task. |
| S3 verified claim? | Debounce, explicit states, MVVM binding, race-safer UX on BMS search. |

---

### Q6. What does the Repository own in search vs the ViewModel?

**Points to:** [Deep dive · §8.1 Responsibilities](../02-deep-dive.md#81-responsibilities) · [Foundations · §5 Layer shape](../01-foundations.md#5-layer-shape-60-second-hld)

**Answer:**

> The **SearchRepository** fetches remote/cached results and maps DTOs to domain `Movie` (or row) models — it hides endpoints and decode. The **SearchViewModel** owns debounce, cancel, the state enum, and mapping domain rows to display rows (images, subtitles). Neither layer should embed ranking policy unless product demands client-side filter — ranking is usually server-side.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URLs in ViewModel? | Smell — belongs in data layer behind repository protocol. |
| Header SDUI today? | Backend-driven header is Day 10; today’s beat is search VM shape. |
| Test seam? | Fake `SearchRepository` in VM unit tests; no URLProtocol at VM layer. |

---

### Q7. What is the 45-second agenda opener for search design?

**Points to:** [Deep dive · §8.4 Agenda opener](../02-deep-dive.md#84-agenda-opener-for-search-design) · [Production bridge · §4 Verified S3](../03-production-bridge.md#4-verified-s3--search-mvvm-secondary-star--deep-dive-beat)

**Answer:**

> “I’d put debounce and cancellation in the search ViewModel, keep ranking server-side unless product needs local filter, and model idle/loading/results/empty/error explicitly — that’s how we made BMS search race-safer.” Pair with layer diagram: View ↔ VM ↔ Repository. Mention stale-response race without cancel as the bug you’re preventing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s S3 line from production bridge? | “BMS search sits in MVVM: debounce and cancel in the ViewModel, explicit states — out-of-order responses can’t win.” |
| Combine vs async VM? | Both valid — cancel `AnyCancellable` store or cancel `Task`; same ownership rules. |
| Whiteboard Script A? | Draw View↔VM↔Repo, debounce+cancel on VM, state enum, stale race, tie S3. |

---

Next: [04-production-s9-s3.md](04-production-s9-s3.md)
