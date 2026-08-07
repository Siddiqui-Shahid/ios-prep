# Sample 02 — Refresh, cancellation, and cache (Q&A)

> Guided teaching. Links deep dive mechanics to learning-lab single-flight code.

---

### Q1. What goes wrong if every 401 starts its own refresh?

**Answer:**

> When many requests hit 401 at once, each starting an independent refresh creates a thundering herd against the auth server. Some OAuth setups rotate refresh tokens so only the first refresh succeeds — later ones fail and can cascade mass logout. Retries fight each other and amplify load. **Single-flight** means the first waiter enters a critical section, others await the same in-flight refresh, everyone shares one result, originals retry once on success or fail together on refresh failure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retry count after refresh? | **Once** per original request — `didRefresh` flag prevents infinite 401 loops. |
| Refresh itself returns 401? | Clear tokens; force re-auth; fail all waiters. |
| Say aloud? | “Refresh is a critical section; retries are bounded.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do you implement single-flight refresh safely with actors?

**Answer:**

> Use an actor (or equivalent critical section) so only one refresh runs. **Broken pattern:** spawn an unstructured inner `Task` that mutates actor state off-isolation — that races. **Correct:** run network work, then assign tokens **on the actor** after awaiting the result; use continuations to fan out waiters; clear in-flight state carefully around reentrancy. See learning-lab [SingleFlightRefresh.swift](../code/SingleFlightRefresh.swift) for continuation-based shape.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Test assertion? | N parallel 401s → exactly **one** refresh network call. |
| POST after refresh? | Only auto-retry if idempotent or server idempotency key exists (BookMyShow payment processing-status popup payments). |
| Actor vs lock? | Actor is the teachable Swift concurrency answer; critical section semantics matter more than the keyword. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q3. How does cancellation work with async URLSession?

**Answer:**

> `session.data(for:)` and related async APIs **participate in Swift `Task` cancellation**. When the surrounding Task is cancelled — new search query, view disappeared — the await throws `CancellationError` and underlying work stops. Hold a `Task` handle in the ViewModel, cancel on new input, catch `CancellationError` silently, and check `Task.isCancelled` before applying UI state. This ties directly to BMS search debounce/cancel (BookMyShow backend-driven header & search).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap to avoid? | “I use async/await so cancel is free” — still need Task handle and ignore cancel in UI. |
| Map cancel in NetworkError? | Optional explicit case; UI treats as silent, not retry banner. |
| Debounce location? | Still ViewModel — transport doesn’t know keystroke cadence (Day 08). |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How do callback `dataTask` APIs differ for cancellation?

**Answer:**

> Completion-handler `dataTask` does **not** auto-cancel when a ViewModel deinits. You must keep the `URLSessionTask`, call `task.cancel()` when UI no longer wants the result, and use a **generation / request-id guard** so a late completion cannot apply after a newer search started. Without the guard, slow responses overwrite newer results — the same stale race search MVVM fixes with Task cancel.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URLError.cancelled in completion? | Return silently — not user-facing failure. |
| Generation increment when? | On each new search and on explicit `cancel()`. |
| Prefer which API style? | Modern async `data(for:)` with structured concurrency when you can migrate. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How do you split HTTP cache from app cache?

**Answer:**

> **HTTP / `URLCache`:** driven by `Cache-Control`, ETag, and `URLRequest.cachePolicy` — good for public static-ish GETs. **App cache:** memory/disk of **decoded** models or offline payloads — usually Repository concern (SDUI last-known-good is Day 10). **No cache:** authed personalized data and payments — correctness beats snappiness. Trap: caching personalized JSON without user key → user B sees user A after account switch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Force refresh policy? | `.reloadIgnoringLocalCacheData` on pull-to-refresh endpoints. |
| SDK shouldn’t become? | Kitchen-sink disk database + image loader + GraphQL — keep boundaries. |
| Public CMS config GET? | HTTP cache OK with validators; still version-gate SDUI payloads separately. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What retry policy is safe on a networking client?

**Answer:**

> Retry transient failures on **idempotent** methods — typically GET/HEAD — with exponential backoff plus jitter, capped attempts, honor `Retry-After` on 429 when present. Never install global “retry everything” — payment POSTs need explicit idempotency keys and status polling (BookMyShow payment processing-status popup), not a generic interceptor. Log final failure with path and status, not secrets.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 408 / 503 on GET? | Often retryable if policy allows. |
| 401? | Refresh path, not blind retry loop. |
| Decode error? | Treat as release bug — don’t infinite retry. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q7. What cancellation checklist should you memorize?

**Answer:**

> | API style | Auto with Task.cancel? | You must also |
> |---|---|---|
> | `session.data(for:)` | Yes | Hold Task handle; ignore CancellationError in UI |
> | `dataTask` completion | No | `task.cancel()` + generation guard |
> | Fire-and-forget Task | Only if you cancel that Task | Don’t orphan work on disappear |

> Search UX: debounce in VM; cancel stale in-flight; never show cancel as scary error — BookMyShow backend-driven header & search sibling beat.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Combine wrapper? | Still need explicit cancel on `AnyCancellable` — same stale race rules. |
| Test cancel bug? | Stub slow response; prove generation guard blocks stale apply. |
| Client timeout vs server p99? | 10s client vs 30s server p99 creates self-inflicted errors — align with SLOs (BookMyShow Firebase Performance traces). |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [03-pinning-security.md](03-pinning-security.md)

---

