# Sample 03 — Search MVVM: debounce, cancel, states (Q&A)

> Guided teaching. Ties learning-lab code to BookMyShow backend-driven header & search search behavior.

---

### Q1. Walk the happy path for debounced search in MVVM.

**Answer:**

> User types in the search bar; the View forwards `onQueryChange` to the ViewModel. The VM debounces ~300ms, cancels any previous `Task`, sets state to `.loading`, and calls `SearchRepository.search(query:)`. The repository hits remote (and maybe cache), returns domain models, and the VM maps to `.results` or `.empty`. The View renders from the enum — it never builds URLRequests or parses JSON.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who owns ranking? | Usually the server; client filters only if product requires local filter. |
| Offline / timeout branch? | Map to `.error` with a retry intent — not a crash. |
| Task cancelled mid-flight? | Ignore — not user-facing error. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Why does debounce belong in the ViewModel, not URLSession?

**Answer:**

> Debounce cadence is a UX/presentation choice tied to keystrokes — it lives with the screen that owns the search bar. The transport layer may cancel in-flight tasks when asked, but it should not know about 300ms keystroke timing. Putting debounce in the repository leaks presentation policy into data access and makes reuse across surfaces awkward.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Could debounce live in a UseCase? | Yes if product standardizes the same timing across multiple entry points. |
| AI mistake to call out? | “It placed debounce in the repository” — move to VM and add cancel. |
| Interview push: “Where does debounce live?” | VM/UseCase presentation policy; repo cancels tasks, not keystroke rhythm. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is the stale-response race and how do you fix it?

**Answer:**

> Without cancel or generation tokens, query `"a"` can return after `"av"` already displayed — the UI flashes old results. Fix by cancelling the prior `Task` on each new query (preferred with structured concurrency), then checking `Task.isCancelled` before applying state. Alternative: monotonic request IDs and ignore stale generations. BMS search (BookMyShow backend-driven header & search) shipped debounce + cancel + explicit states specifically to make this race-safer on a high-traffic surface.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel vs generation token? | Prefer cancel + structured concurrency; generation guards are essential for callback `dataTask` APIs. |
| Show cancel as error banner? | No — expected when typing fast; silent ignore. |
| See code? | [SearchViewModel.swift](../code/SearchViewModel.swift) learning-lab shape. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What are the five presentation states search must name?

**Answer:**

> **Idle** before meaningful input. **Loading** while a debounced query is in flight. **Results** with hits. **Empty** when the server returned successfully but zero matches — not an error. **Error** for offline, timeout, or decode/contract breaks with retry. Cancellation returns to idle or stays on the latest query — never masquerades as error.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty vs error in interview? | Empty = valid “no matches”; error = could not complete request. |
| Decode failure? | Error state + metric; don’t crash the app on CMS/API drift. |
| Self-check from foundations? | Name all five before opening deep dive. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How does cancellation fit MVVM ownership?

**Answer:**

> The ViewModel owns the search `Task` handle: on new query, cancel previous work; on `onDisappear`, cancel in-flight search. The View may signal lifecycle; the VM executes policy. Repository/DataSource may propagate task cancellation to URLSession, but the decision to stop caring about a result is a screen concern. Async `URLSession.data(for:)` participates in Swift `Task` cancellation; callback APIs need explicit `task.cancel()` plus stale guards (Day 09).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `[weak self]` in search Task? | Yes for escaping async work tied to a screen. |
| Fire-and-forget `Task { }` without handle? | Orphan work can apply after dismiss — hold and cancel the Task. |
| BookMyShow backend-driven header & search verified claim? | Debounce, explicit states, MVVM binding, race-safer UX on BMS search. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What does the Repository own in search vs the ViewModel?

**Answer:**

> The **SearchRepository** fetches remote/cached results and maps DTOs to domain `Movie` (or row) models — it hides endpoints and decode. The **SearchViewModel** owns debounce, cancel, the state enum, and mapping domain rows to display rows (images, subtitles). Neither layer should embed ranking policy unless product demands client-side filter — ranking is usually server-side.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URLs in ViewModel? | Smell — belongs in data layer behind repository protocol. |
| Header SDUI today? | Backend-driven header is Day 10; today’s beat is search VM shape. |
| Test seam? | Fake `SearchRepository` in VM unit tests; no URLProtocol at VM layer. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What is the 45-second agenda opener for search design?

**Answer:**

> “I’d put debounce and cancellation in the search ViewModel, keep ranking server-side unless product needs local filter, and model idle/loading/results/empty/error explicitly — that’s how we made BMS search race-safer.” Pair with layer diagram: View ↔ VM ↔ Repository. Mention stale-response race without cancel as the bug you’re preventing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s BookMyShow backend-driven header & search line from production bridge? | “BMS search sits in MVVM: debounce and cancel in the ViewModel, explicit states — out-of-order responses can’t win.” |
| Combine vs async VM? | Both valid — cancel `AnyCancellable` store or cancel `Task`; same ownership rules. |
| Whiteboard Script A? | Draw View↔VM↔Repo, debounce+cancel on VM, state enum, stale race, tie BookMyShow backend-driven header & search. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [04-production-s9-s3.md](04-production-s9-s3.md)

---

