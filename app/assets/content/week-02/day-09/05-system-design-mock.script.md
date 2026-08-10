# Audio script — Sample 05 — System-design mock: Networking Layer / HTTP Client (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Networking Layer / HTTP Client.” How do you open?

Next. Q1. Interviewer: “Design Networking Layer / HTTP Client.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Interceptor pipeline and Single-flight 401 refresh, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. REST URLSession client with interceptors — GraphQL/WS out? 2. Auth refresh + SSL pinning in scope? 3. daily active users and peak RPS to origin? 4. Timeout defaults (~30s)? 5. Offline cache layer in or out? 6. i O S-only? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: URLSession APIClient; auth interceptor; single-flight refresh; SPKI pinning; retries on idempotent GET; out: GraphQL/WS, image S D K. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Features → APIClient (build→intercept→execute→decode→map errors) → Auth/Retry/Tracing → URLSession + SPKI + allowlist → URLCache/Keychain. Backend: A P I gateway; /auth/refresh. Load: HTTP/2 multiplex; gzip; timeout ~30s; paginate huge JSON; pin rotation 60–90d. Follow-ups. Alamofire?: Prefer URLSession when owning trust/pinning — BMS migration story.. Where pinning sits?: URLSessionDelegate challenge — before bytes..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. APIEndpoint + request(_:) async throws. 401 → refresh coordinator; retry 408/429/5xx on idempotent GET only; never blind-retry charge POST. Follow-ups. Idempotency-Key?: For mutations that must be exactly-once.. Tracing?: X-Request-ID on all calls..

## §4 Q5. Deep dive 1 — Interceptor pipeline?

Next. Q5. Deep dive 1 — Interceptor pipeline? Answer. Ordered interceptors: auth header → retry → tracing. Decode Codable on background; map to domain errors. Follow-ups. URLProtocol tests?: Inject fakes without hitting network.. Priority/cancel?: Task cancel propagates to URLSessionTask..

## §5 Q6. Deep dive 2 — Single-flight 401 refresh?

Next. Q6. Deep dive 2 — Single-flight 401 refresh? Answer. N parallel 401s → one actor-owned refresh; waiters await; success retries once; failure → logout clear Keychain. Follow-ups. Refresh 401?: Logout — avoid infinite loop.. Pin mismatch?: Fail closed; backup pins + rotation design..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. p50/p90/p99, 5xx rate, refresh fail→logout, pin fail metrics. Kill: loosen retries; break-glass pin design (label design vs shipped). Follow-ups. Thundering herd?: Jitter backoff ≤3 retries.. Production?: BookMyShow SSL pinning + URLSession migration Ads proof..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
