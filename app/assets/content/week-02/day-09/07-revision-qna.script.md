# Audio script — Sample 07 — Revision Q&A (day-09) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Why prefer URLSession over Alamofire in a senior design? `(30–45s)`

Next. Q1. Why prefer URLSession over Alamofire in a senior design? `(30–45s)` Answer. Alamofire is fine for rapid CRUD, but on a security-sensitive module I prefer a first-party URLSession client. You own the session delegate for pinning, you reduce dependency surface, and async/await is native. At BookMyShow we moved Ads networking off Alamofire onto URLSession so we could enforce HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — that was about ownership, not hating libraries. Follow-ups. Probe deeper?: On Ads we preferred URLSession so the session delegate could enforce HTTPS, SPKI pinning, and a domain whitelist without a third-party stack..

## §1 Q2. Sketch a generic request API? `(45–60s)`

Next. Q2. Sketch a generic request API? `(45–60s)` Answer. I define an APIEndpoint with path, method, headers, body, and whether auth is required, usually with an associated Response: Decodable. The client exposes something like request(_ endpoint:) async throws - Response. A builder turns that into a URLRequest, interceptors attach auth, URLSession executes, then I validate status and decode. The session is behind a protocol so tests inject fixtures. Errors become a typed NetworkError — transport, HTTP, decoding, unauthorized — not raw strings for the U I. Follow-ups. Probe deeper?: Endpoint types carry Response: Decodable and requiresAuth so the client stays a thin builder → interceptor → session → decode pipeline..

## §2 Q3. How do auth interceptors work? `(45s)`

Next. Q3. How do auth interceptors work? `(45s)` Answer. Before send, an auth interceptor reads the access token from a Keychain-backed store and attaches a Bearer header when the endpoint requires auth. It must not block the main thread or log tokens. On 401, control moves to the refresh coordinator rather than each call site inventing retry logic. Guest endpoints simply flip requiresAuth off so we don’t attach or refresh unnecessarily. Follow-ups. Probe deeper?: Attach Bearer only when requiresAuth is true; on 401 hand off to the refresh coordinator instead of per-callsite retry loops..

## §3 Q4. Explain safe token refresh under concurrency? `(60–90s)`

Next. Q4. Explain safe token refresh under concurrency? `(60–90s)` Answer. If ten requests get 401 at once, you must not start ten refreshes — that thundering herd can invalidate grants and log everyone out. I keep refresh behind an actor: the first caller starts the refresh network call; others await the same in-flight result via continuations or by joining one task. On success I update the token store and retry the original requests once. On failure I fail all waiters and force re-auth. Importantly, I don’t mutate actor-isolated token state inside an unstructured Task body — that races isolation. Mutations happen on the actor after the await, or I use continuations only. Follow-ups. Probe deeper?: An actor (or single in-flight Task) makes the first 401 start refresh while others await the same result, then retry originals once..

## §4 Q5. How do you cancel in-flight search requests? `(45–60s)`

Next. Q5. How do you cancel in-flight search requests? `(45–60s)` Answer. On each query change I cancel the previous Task and start a new one, usually after debounce. With async URLSession APIs, cancelling the Task cancels the underlying transfer — they participate in Swift cancellation. I treat CancellationError as silent so typing fast doesn’t flash errors. If I still had callback dataTasks, I’d call cancel myself and use a generation counter so a late response can’t overwrite newer results. That pairs with the search M V V M work we did for debounce and state. Follow-ups. Probe deeper?: Cancelling the search Task cancels async URLSession work; with legacy dataTask, cancel plus a generation token blocks stale overwrites..

## §5 Q6. Retry policy — what do you retry? `(45–60s)`

Next. Q6. Retry policy — what do you retry? `(45–60s)` Answer. I retry transient failures — timeouts, 408, 429, some 5xx — on idempotent methods like GET, with exponential backoff and jitter and a hard attempt cap. On 429 I honor Retry-After when present. I do not blindly retry POSTs that create charges; payments need idempotency keys and explicit status handling. The networking S D K should let endpoints opt into retry so a convenience helper can’t double-charge. Follow-ups. Probe deeper?: Retry GET timeouts and 429 with backoff; never blindly retry a payment POST without an idempotency contract..

## §6 Q7. HTTP cache vs app cache? `(45–60s)`

Next. Q7. HTTP cache vs app cache? `(45–60s)` Answer. HTTP caching via URLCache follows Cache-Control and validators — great for public, static-ish GETs. App cache holds decoded models in memory or disk for UX and offline. Authenticated personalized data must be keyed by user or not cached. I keep the networking S D K focused on transport policy; offline/domain caches usually live in repositories — for example S D U I fallback engines — so the client doesn’t become a kitchen-sink database. Follow-ups. Probe deeper?: URLCache is for Cache-Control GETs; decoded offline models live in the repository layer so the networking S D K stays transport-focused..

## §7 Q8. What is SSL pinning and what goes wrong? `(60–75s)`

Next. Q8. What is SSL pinning and what goes wrong? `(60–75s)` Answer. SSL pinning means we reject TLS connections whose server identity doesn’t match pins we embedded — mitigating MITM cases where trust stores or CAs aren’t enough. I pin the SHA-256 of the certificate’s Subject Public Key Info DER — true SPKI — not the raw bytes from SecKeyCopyExternalRepresentation, which is a common sample-code mistake. The main failure mode is operational: if keys or certs change and pins don’t, the app bricks networking. ATS is only the baseline HTTPS policy; it is not pinning. On Ads we shipped pinning with URLSession; backup pins and break-glass I’d treat as required design, not set-and-forget. Follow-ups. Probe deeper?: Pin the SHA-256 of SPKI DER — not SecKeyCopyExternalRepresentation bytes — and design backup pins because a key rotate without updates bricks the app..

## §8 Q9. Domain whitelisting — why? `(30–45s)`

Next. Q9. Domain whitelisting — why? `(30–45s)` Answer. A domain whitelist means the Ads or A P I client refuses to send requests to hosts outside an allow-list. That cuts down SSRF-ish misconfiguration and surprising third-party calls if CMS or config goes wrong. I enforce it centrally in the request builder before the session runs. Image CDNs can be a separate policy from authenticated A P I hosts — don’t conflate them. Follow-ups. Probe deeper?: Ads A P I hosts are allow-listed in the request builder before the session runs so CMS misconfig cannot open arbitrary hosts..

## §9 Q10. How do you test networking without flaky CI? `(45–60s)`

Next. Q10. How do you test networking without flaky CI? `(45–60s)` Answer. I wrap URLSession behind a protocol and return fixture Data and status codes in unit tests. That lets me test decoding, error mapping, whitelist rejections, and the 401 → single-flight refresh → retry-once path without networks. URLProtocol is useful for slightly higher fidelity. I keep tokens and PII out of fixtures. A tiny staging smoke suite can exist, but CI stay deterministic. Follow-ups. Probe deeper?: Protocol-wrapped URLSession fixtures cover decode, whitelist reject, and 401→refresh→retry without network flakiness in CI..

## §10 Q11. Error mapping you use in production? `(45s)`

Next. Q11. Error mapping you use in production? `(45s)` Answer. I map to transport failures like offline and timeout, HTTP status errors, decoding failures, cancellation, and auth failures after refresh is exhausted. Pinning and whitelist failures should be explicit for metrics even if the U I shows a generic failure. The U I decides retryable versus fatal and never shows raw server JSON. Cancellation stays silent. Follow-ups. Probe deeper?: Map to transport, HTTP, decoding, cancellation, and auth-exhausted errors; U I gets retryable versus fatal, never raw JSON..

## §11 Q12. How does networking relate to p50/p90? `(45s)`

Next. Q12. How does networking relate to p50/p90? `(45s)` Answer. Networking shows up in user journeys, so we instrument traces and look at p50 and p90, not just averages. Slow endpoints and fat tails drive perceived jank. Client timeouts should match backend reality. Client-side wins include caching public data, prefetching, and cancelling wasteful in-flight work. At BookMyShow we used Firebase Performance with p50/p90 on listing, checkout, and search. Follow-ups. Probe deeper?: Instrument journey traces and watch p50/p90 — averages hide fat tails that users feel on search and checkout.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “Why prefer URLSession over Alamofire in a senior design?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Why prefer URLSession over Alamofire in a senior design?” — how do you answer without jargon? `(60–90s)` Answer. “Alamofire is fine for rapid CRUD, but on a security-sensitive module I prefer a first-party URLSession client. You own the session delegate for pinning, you reduce dependency surface, and async/await is native. At BookMyShow we moved Ads networking off Alamofire onto URLSession so we could enforce HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — that was about ownership, not hating libraries.” Follow-ups. What concept is this really?: Why prefer URLSession over Alamofire in a senior design. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Sketch a generic request API.” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Sketch a generic request API.” just broke under load. What do you check first? `(60–90s)` Answer. “I define an APIEndpoint with path, method, headers, body, and whether auth is required, usually with an associated Response: Decodable. The client exposes something like request(_ endpoint:) async throws - Response. A builder turns that into a URLRequest, interceptors attach auth, URLSession executes, then I validate status and decode. The session is behind a protocol so tests inject fixtures. Errors become a typed NetworkError — transport, HTTP, decoding, unauthorized — not raw strings for the U I.” Follow-ups. What concept is this really?: Sketch a generic request A P I.. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “How do auth interceptors work”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “How do auth interceptors work”. How do you diagnose? `(60–90s)` Answer. “Before send, an auth interceptor reads the access token from a Keychain-backed store and attaches a Bearer header when the endpoint requires auth. It must not block the main thread or log tokens. On 401, control moves to the refresh coordinator rather than each call site inventing retry logic. Guest endpoints simply flip requiresAuth off so we don’t attach or refresh unnecessarily.” Follow-ups. What concept is this really?: How do auth interceptors work. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Explain safe token refresh under concurrency.”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Explain safe token refresh under concurrency.”. What do you say and what fix do you propose? `(60–90s)` Answer. “If ten requests get 401 at once, you must not start ten refreshes — that thundering herd can invalidate grants and log everyone out. I keep refresh behind an actor: the first caller starts the refresh network call; others await the same in-flight result via continuations or by joining one task. On success I update the token store and retry the original requests once. On failure I fail all waiters and force re-auth. Importantly, I don’t mutate actor-isolated token state inside an unstructured Task body — that races isolation. Mutations happen on the actor after the await, or I use continuations only.” Follow-ups. What concept is this really?: Explain safe token refresh under concurrency.. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “How do you cancel in-flight search requests”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “How do you cancel in-flight search requests”? `(60–90s)` Answer. “On each query change I cancel the previous Task and start a new one, usually after debounce. With async URLSession APIs, cancelling the Task cancels the underlying transfer — they participate in Swift cancellation. I treat CancellationError as silent so typing fast doesn’t flash errors. If I still had callback dataTasks, I’d call cancel myself and use a generation counter so a late response can’t overwrite newer results. That pairs with the search M V V M work we did for debounce and state.” Follow-ups. What concept is this really?: How do you cancel in-flight search requests. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Retry policy — what do you retry” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Retry policy — what do you retry” and how you’d correct it? `(60–90s)` Answer. “I retry transient failures — timeouts, 408, 429, some 5xx — on idempotent methods like GET, with exponential backoff and jitter and a hard attempt cap. On 429 I honor Retry-After when present. I do not blindly retry POSTs that create charges; payments need idempotency keys and explicit status handling. The networking S D K should let endpoints opt into retry so a convenience helper can’t double-charge.” Follow-ups. What concept is this really?: Retry policy — what do you retry. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “HTTP cache vs app cache?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “HTTP cache vs app cache?” — how do you answer without jargon? `(60–90s)` Answer. “HTTP caching via URLCache follows Cache-Control and validators — great for public, static-ish GETs. App cache holds decoded models in memory or disk for UX and offline. Authenticated personalized data must be keyed by user or not cached. I keep the networking S D K focused on transport policy; offline/domain caches usually live in repositories — for example S D U I fallback engines — so the client doesn’t become a kitchen-sink database.” Follow-ups. What concept is this really?: HTTP cache vs app cache. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “What is SSL pinning and what goes wrong” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “What is SSL pinning and what goes wrong” just broke under load. What do you check first? `(60–90s)` Answer. “SSL pinning means we reject TLS connections whose server identity doesn’t match pins we embedded — mitigating MITM cases where trust stores or CAs aren’t enough. I pin the SHA-256 of the certificate’s Subject Public Key Info DER — true SPKI — not the raw bytes from SecKeyCopyExternalRepresentation, which is a common sample-code mistake. The main failure mode is operational: if keys or certs change and pins don’t, the app bricks networking. ATS is only the baseline HTTPS policy; it is not pinning. On Ads we shipped pinning with URLSession; backup pins and break-glass I’d treat as required design, not set-and-forget.” Follow-ups. What concept is this really?: What is SSL pinning and what goes wrong. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Prefetch that hurts scrolling? `(90–120s)`

Next. T1. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. Actor reentrancy surprise? `(90–120s)`

Next. T2. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. They push you to invent a metric you don’t have? `(90–120s)`

Next. T3. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T4. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. They want a one-tool forever answer? `(90–120s)`

Next. T5. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T6. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. Main-thread rule under pressure? `(90–120s)`

Next. T7. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Cancellation honesty? `(90–120s)`

Next. T8. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Cache invalidation trap? `(90–120s)`

Next. T9. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Security theater vs real pinning? `(90–120s)`

Next. T10. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
