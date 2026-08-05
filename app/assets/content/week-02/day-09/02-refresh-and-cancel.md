# Sample 02 — Refresh, cancellation, and cache (Q&A)

> Guided teaching. Links deep dive mechanics to learning-lab single-flight code.

---

### Q1. What goes wrong if every 401 starts its own refresh?

**Points to:** [Foundations · §7 Token refresh](../01-foundations.md#7-token-refresh--intern-picture) · [Deep dive · §4.1 Failure mode](../02-deep-dive.md#41-failure-mode-without-single-flight)

**Answer:**

> When many requests hit 401 at once, each starting an independent refresh creates a thundering herd against the auth server. Some OAuth setups rotate refresh tokens so only the first refresh succeeds — later ones fail and can cascade mass logout. Retries fight each other and amplify load. **Single-flight** means the first waiter enters a critical section, others await the same in-flight refresh, everyone shares one result, originals retry once on success or fail together on refresh failure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retry count after refresh? | **Once** per original request — `didRefresh` flag prevents infinite 401 loops. |
| Refresh itself returns 401? | Clear tokens; force re-auth; fail all waiters. |
| Say aloud? | “Refresh is a critical section; retries are bounded.” |

---

### Q2. How do you implement single-flight refresh safely with actors?

**Points to:** [Deep dive · §4.3 Actor safety](../02-deep-dive.md#43-actor-safety--what-went-wrong-in-many-samples) · [code · SingleFlightRefresh](../code/SingleFlightRefresh.swift)

**Answer:**

> Use an actor (or equivalent critical section) so only one refresh runs. **Broken pattern:** spawn an unstructured inner `Task` that mutates actor state off-isolation — that races. **Correct:** run network work, then assign tokens **on the actor** after awaiting the result; use continuations to fan out waiters; clear in-flight state carefully around reentrancy. See learning-lab [SingleFlightRefresh.swift](../code/SingleFlightRefresh.swift) for continuation-based shape.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Test assertion? | N parallel 401s → exactly **one** refresh network call. |
| POST after refresh? | Only auto-retry if idempotent or server idempotency key exists (S7 payments). |
| Actor vs lock? | Actor is the teachable Swift concurrency answer; critical section semantics matter more than the keyword. |

---

### Q3. How does cancellation work with async URLSession?

**Points to:** [Foundations · §8.1 Async URLSession](../01-foundations.md#81-async-urlsession-datafor-bytesfor-) · [Deep dive · §5.1 Async API participation](../02-deep-dive.md#51-async-api-participation)

**Answer:**

> `session.data(for:)` and related async APIs **participate in Swift `Task` cancellation**. When the surrounding Task is cancelled — new search query, view disappeared — the await throws `CancellationError` and underlying work stops. Hold a `Task` handle in the ViewModel, cancel on new input, catch `CancellationError` silently, and check `Task.isCancelled` before applying UI state. This ties directly to BMS search debounce/cancel (S3).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap to avoid? | “I use async/await so cancel is free” — still need Task handle and ignore cancel in UI. |
| Map cancel in NetworkError? | Optional explicit case; UI treats as silent, not retry banner. |
| Debounce location? | Still ViewModel — transport doesn’t know keystroke cadence (Day 08). |

---

### Q4. How do callback `dataTask` APIs differ for cancellation?

**Points to:** [Foundations · §8.2 Callback dataTask](../01-foundations.md#82-callback-datataskwithcompletionhandler) · [Deep dive · §5.2 Callback dataTask](../02-deep-dive.md#52-callback-datatask--explicit-cancel--stale-guards)

**Answer:**

> Completion-handler `dataTask` does **not** auto-cancel when a ViewModel deinits. You must keep the `URLSessionTask`, call `task.cancel()` when UI no longer wants the result, and use a **generation / request-id guard** so a late completion cannot apply after a newer search started. Without the guard, slow responses overwrite newer results — the same stale race search MVVM fixes with Task cancel.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URLError.cancelled in completion? | Return silently — not user-facing failure. |
| Generation increment when? | On each new search and on explicit `cancel()`. |
| Prefer which API style? | Modern async `data(for:)` with structured concurrency when you can migrate. |

---

### Q5. How do you split HTTP cache from app cache?

**Points to:** [Foundations · §9 Caching](../01-foundations.md#9-caching--split-the-brain) · [Deep dive · §7 Caching responsibilities](../02-deep-dive.md#7-caching-responsibilities)

**Answer:**

> **HTTP / `URLCache`:** driven by `Cache-Control`, ETag, and `URLRequest.cachePolicy` — good for public static-ish GETs. **App cache:** memory/disk of **decoded** models or offline payloads — usually Repository concern (SDUI last-known-good is Day 10). **No cache:** authed personalized data and payments — correctness beats snappiness. Trap: caching personalized JSON without user key → user B sees user A after account switch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Force refresh policy? | `.reloadIgnoringLocalCacheData` on pull-to-refresh endpoints. |
| SDK shouldn’t become? | Kitchen-sink disk database + image loader + GraphQL — keep boundaries. |
| Public CMS config GET? | HTTP cache OK with validators; still version-gate SDUI payloads separately. |

---

### Q6. What retry policy is safe on a networking client?

**Points to:** [Deep dive · §6 Retries and backoff](../02-deep-dive.md#6-retries-and-backoff) · [Foundations · §14 Decision rules](../01-foundations.md#14-decision-rules-early)

**Answer:**

> Retry transient failures on **idempotent** methods — typically GET/HEAD — with exponential backoff plus jitter, capped attempts, honor `Retry-After` on 429 when present. Never install global “retry everything” — payment POSTs need explicit idempotency keys and status polling (S7), not a generic interceptor. Log final failure with path and status, not secrets.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 408 / 503 on GET? | Often retryable if policy allows. |
| 401? | Refresh path, not blind retry loop. |
| Decode error? | Treat as release bug — don’t infinite retry. |

---

### Q7. What cancellation checklist should you memorize?

**Points to:** [Deep dive · §5.3 Checklist](../02-deep-dive.md#53-checklist) · [Production bridge · §5 Search cancel S3](../03-production-bridge.md#search-cancel--s3)

**Answer:**

> | API style | Auto with Task.cancel? | You must also |
> |---|---|---|
> | `session.data(for:)` | Yes | Hold Task handle; ignore CancellationError in UI |
> | `dataTask` completion | No | `task.cancel()` + generation guard |
> | Fire-and-forget Task | Only if you cancel that Task | Don’t orphan work on disappear |

> Search UX: debounce in VM; cancel stale in-flight; never show cancel as scary error — Verified S3 sibling beat.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Combine wrapper? | Still need explicit cancel on `AnyCancellable` — same stale race rules. |
| Test cancel bug? | Stub slow response; prove generation guard blocks stale apply. |
| Client timeout vs server p99? | 10s client vs 30s server p99 creates self-inflicted errors — align with SLOs (S5). |

---

Next: [03-pinning-security.md](03-pinning-security.md)
