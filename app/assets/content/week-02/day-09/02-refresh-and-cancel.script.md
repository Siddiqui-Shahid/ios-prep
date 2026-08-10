# Audio script — Sample 02 — Refresh, cancellation, and cache (Q&A)
> Listen-only sample Q&A from `02-refresh-and-cancel.md`. Spoken answers and follow-ups.

## §0 Q1. What goes wrong if every 401 starts its own refresh?

Next. Q1. What goes wrong if every 401 starts its own refresh? Answer. When many requests hit 401 at once, each starting an independent refresh creates a thundering herd against the auth server. Some OAuth setups rotate refresh tokens so only the first refresh succeeds — later ones fail and can cascade mass logout. Retries fight each other and amplify load. Single-flight means the first waiter enters a critical section, others await the same in-flight refresh, everyone shares one result, originals retry once on success or fail together on refresh failure. Follow-ups. Retry count after refresh?: Once per original request — didRefresh flag prevents infinite 401 loops.. Refresh itself returns 401?: Clear tokens; force re-auth; fail all waiters.. Say aloud?: “Refresh is a critical section; retries are bounded.”.

## §1 Q2. How do you implement single-flight refresh safely with actors?

Next. Q2. How do you implement single-flight refresh safely with actors? Answer. Use an actor (or equivalent critical section) so only one refresh runs. Broken pattern: spawn an unstructured inner Task that mutates actor state off-isolation — that races. Correct: run network work, then assign tokens on the actor after awaiting the result; use continuations to fan out waiters; clear in-flight state carefully around reentrancy. See learning-lab SingleFlightRefresh.swift for continuation-based shape. Follow-ups. Test assertion?: N parallel 401s → exactly one refresh network call.. POST after refresh?: Only auto-retry if idempotent or server idempotency key exists (BookMyShow payment processing-status popup payments).. Actor vs lock?: Actor is the teachable Swift concurrency answer; critical section semantics matter more than the keyword..

## §2 Q3. How does cancellation work with async URLSession?

Next. Q3. How does cancellation work with async URLSession? Answer. session.data(for:) and related async APIs participate in Swift Task cancellation. When the surrounding Task is cancelled — new search query, view disappeared — the await throws CancellationError and underlying work stops. Hold a Task handle in the ViewModel, cancel on new input, catch CancellationError silently, and check Task.isCancelled before applying U I state. This ties directly to BMS search debounce/cancel (BookMyShow backend-driven header & search). Follow-ups. Trap to avoid?: “I use async/await so cancel is free” — still need Task handle and ignore cancel in U I.. Map cancel in NetworkError?: Optional explicit case; U I treats as silent, not retry banner.. Debounce location?: Still ViewModel — transport doesn’t know keystroke cadence (Day 08)..

## §3 Q4. How do callback `dataTask` APIs differ for cancellation?

Next. Q4. How do callback `dataTask` APIs differ for cancellation? Answer. Completion-handler dataTask does not auto-cancel when a ViewModel deinits. You must keep the URLSessionTask, call task.cancel when U I no longer wants the result, and use a generation / request-id guard so a late completion cannot apply after a newer search started. Without the guard, slow responses overwrite newer results — the same stale race search M V V M fixes with Task cancel. Follow-ups. URLError.cancelled in completion?: Return silently — not user-facing failure.. Generation increment when?: On each new search and on explicit cancel.. Prefer which A P I style?: Modern async data(for:) with structured concurrency when you can migrate..

## §4 Q5. How do you split HTTP cache from app cache?

Next. Q5. How do you split HTTP cache from app cache? Answer. HTTP / URLCache: driven by Cache-Control, ETag, and URLRequest.cachePolicy — good for public static-ish GETs. App cache: memory/disk of decoded models or offline payloads — usually Repository concern (S D U I last-known-good is Day 10). No cache: authed personalized data and payments — correctness beats snappiness. Trap: caching personalized JSON without user key → user B sees user A after account switch. Follow-ups. Force refresh policy?:.reloadIgnoringLocalCacheData on pull-to-refresh endpoints.. S D K shouldn’t become?: Kitchen-sink disk database + image loader + GraphQL — keep boundaries.. Public CMS config GET?: HTTP cache OK with validators; still version-gate S D U I payloads separately..

## §5 Q6. What retry policy is safe on a networking client?

Next. Q6. What retry policy is safe on a networking client? Answer. Retry transient failures on idempotent methods — typically GET/HEAD — with exponential backoff plus jitter, capped attempts, honor Retry-After on 429 when present. Never install global “retry everything” — payment POSTs need explicit idempotency keys and status polling (BookMyShow payment processing-status popup), not a generic interceptor. Log final failure with path and status, not secrets. Follow-ups. 408 / 503 on GET?: Often retryable if policy allows.. 401?: Refresh path, not blind retry loop.. Decode error?: Treat as release bug — don’t infinite retry..

## §6 Q7. What cancellation checklist should you memorize?

Next. Q7. What cancellation checklist should you memorize? Answer. | A P I style | Auto with Task.cancel? | You must also | session.data(for:): Yes. dataTask completion: No. Fire-and-forget Task: Only if you cancel that Task. Search UX: debounce in VM; cancel stale in-flight; never show cancel as scary error — BookMyShow backend-driven header & search sibling beat. Follow-ups. Combine wrapper?: Still need explicit cancel on AnyCancellable — same stale race rules.. Test cancel bug?: Stub slow response; prove generation guard blocks stale apply.. Client timeout vs server p99?: 10s client vs 30s server p99 creates self-inflicted errors — align with SLOs (BookMyShow Firebase Performance traces)..
