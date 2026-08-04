# 04 — Questions (two-layer answers)

> Study flow: cover the full spoken answer → speak from **Answer points** only → uncover and compare timing.  
> Totals: **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. Why prefer URLSession over Alamofire in a senior design? `(30–45s)`

**Answer points (frame first):**
- First-party control of session / trust challenges
- Smaller dependency surface
- Native async/await
- Alamofire fine for speed; Ads needed security ownership
- Hook S4 without overclaiming rollout theater

**Agenda opener:** “I’d choose based on control and threat model, not ideology…”

**Full spoken answer:**
> “Alamofire is fine for rapid CRUD, but on a security-sensitive module I prefer a first-party URLSession client. You own the session delegate for pinning, you reduce dependency surface, and async/await is native. At BookMyShow we moved Ads networking off Alamofire onto URLSession so we could enforce HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — that was about ownership, not hating libraries.”

**Common wrong answer:** “Never use third-party networking; Alamofire is obsolete.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What did you lose? | Convenience adapters/plugins — reimplement only what you need. |
| L2 | Whole app migrate? | Risk-based; start where threat/value highest (Ads). |
| L3 | How test parity? | Protocol session + fixtures; status/decode/error parity tests. |

**Provenance:** Verified · S4 · Ads Alamofire → URLSession

---

### Q2. Sketch a generic request API. `(45–60s)`

**Answer points:**
- `APIEndpoint` + `request<T: Decodable>` / associated Response
- Inject `NetworkSession`
- Map HTTP → domain `NetworkError`
- Auth flag on endpoint
- No UI types in the client

**Agenda opener:** “I’d start with an endpoint protocol and a generic async client…”

**Full spoken answer:**
> “I define an `APIEndpoint` with path, method, headers, body, and whether auth is required, usually with an associated `Response: Decodable`. The client exposes something like `request(_ endpoint:) async throws -> Response`. A builder turns that into a `URLRequest`, interceptors attach auth, URLSession executes, then I validate status and decode. The session is behind a protocol so tests inject fixtures. Errors become a typed `NetworkError` — transport, HTTP, decoding, unauthorized — not raw strings for the UI.”

**Common wrong answer:** “One giant enum of all URLs with stringly-typed callbacks.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Uploads? | Separate upload task APIs; progress as AsyncSequence or delegate. |
| L2 | Multiple base URLs? | Config per service; endpoint or client holds base URL. |
| L3 | Priority? | `URLSessionTask.priority` for UI vs analytics. |

**Provenance:** Learning-lab · chapter client shape

---

### Q3. How do auth interceptors work? `(45s)`

**Answer points:**
- Pre-send: read token store, attach Authorization
- On 401: refresh path
- Never log secrets
- `requiresAuth` gate for guest endpoints

**Agenda opener:** “Auth is a pipeline step, not ViewModel copy-paste…”

**Full spoken answer:**
> “Before send, an auth interceptor reads the access token from a Keychain-backed store and attaches a Bearer header when the endpoint requires auth. It must not block the main thread or log tokens. On 401, control moves to the refresh coordinator rather than each call site inventing retry logic. Guest endpoints simply flip `requiresAuth` off so we don’t attach or refresh unnecessarily.”

**Common wrong answer:** “Put the token in UserDefaults and append it in every ViewModel.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Where tokens live? | Keychain; not UserDefaults. |
| L2 | Order of interceptors? | Auth before logging/tracing send. |
| L3 | Device attestation headers? | Same interceptor seam; keep PII-safe. |

**Provenance:** Learning-lab · auth pipeline / Verified · S4 stack ownership mindset

---

### Q4. Explain safe token refresh under concurrency. `(60–90s)`

**Answer points:**
- N parallel 401s → one refresh (single-flight)
- Actor or serial critical section
- Waiters share result
- Retry once; failure fan-out → logout
- No actor-state mutation inside unstructured Task

**Agenda opener:** “Refresh is a critical section…”

**Full spoken answer:**
> “If ten requests get 401 at once, you must not start ten refreshes — that thundering herd can invalidate grants and log everyone out. I keep refresh behind an actor: the first caller starts the refresh network call; others await the same in-flight result via continuations or by joining one task. On success I update the token store and retry the original requests once. On failure I fail all waiters and force re-auth. Importantly, I don’t mutate actor-isolated token state inside an unstructured Task body — that races isolation. Mutations happen on the actor after the await, or I use continuations only.”

**Common wrong answer:** “Each request refreshes then retries in a loop until success.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Refresh token reuse detection? | Server revoke → clear local → login. |
| L2 | Non-idempotent POST after refresh? | Don’t auto-retry without idempotency key. |
| L3 | Show code smell? | `Task { self.token = … }` inside actor method. |

**Provenance:** Learning-lab · SingleFlightRefresh / architecture answer

---

### Q5. How do you cancel in-flight search requests? `(45–60s)`

**Answer points:**
- New query cancels previous `Task`
- Async URLSession participates in cancellation
- Ignore `CancellationError` in UI
- Debounce in VM (S3)
- Callback tasks need explicit cancel + stale guards

**Agenda opener:** “Search cancel is about correctness, not just saving bytes…”

**Full spoken answer:**
> “On each query change I cancel the previous Task and start a new one, usually after debounce. With async URLSession APIs, cancelling the Task cancels the underlying transfer — they participate in Swift cancellation. I treat `CancellationError` as silent so typing fast doesn’t flash errors. If I still had callback `dataTask`s, I’d call `cancel()` myself and use a generation counter so a late response can’t overwrite newer results. That pairs with the search MVVM work we did for debounce and state.”

**Common wrong answer:** “Cancellation is automatic for every URLSession API.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | dataTask difference? | Needs explicit cancel + stale guard. |
| L2 | Shared request across screens? | Repository coalescing / refcount. |
| L3 | onDisappear? | Cancel Task handle tied to lifecycle. |

**Provenance:** Verified · S3 · search debounce/cancel

---

### Q6. Retry policy — what do you retry? `(45–60s)`

**Answer points:**
- Transient 408/429/5xx
- Idempotent GETs
- Exponential backoff + jitter
- Cap attempts; honor Retry-After
- No blind payment POST retry

**Agenda opener:** “Retry is a policy per endpoint, not a global hammer…”

**Full spoken answer:**
> “I retry transient failures — timeouts, 408, 429, some 5xx — on idempotent methods like GET, with exponential backoff and jitter and a hard attempt cap. On 429 I honor Retry-After when present. I do not blindly retry POSTs that create charges; payments need idempotency keys and explicit status handling. The networking SDK should let endpoints opt into retry so a convenience helper can’t double-charge.”

**Common wrong answer:** “Retry all failed requests three times.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | 400? | Usually no — client bug. |
| L2 | Payment case? | Idempotency + poll status (S7 caution). |
| L3 | Offline? | Fail fast to UI; don’t backoff forever. |

**Provenance:** How I would apply it · retry policy / Verified · S7 payment caution

---

### Q7. HTTP cache vs app cache? `(45–60s)`

**Answer points:**
- URLCache honors headers
- App cache = decoded models / offline
- Key private data by user
- SDK vs repository boundary
- SDUI disk/TTL often Day 10

**Agenda opener:** “I split transport cache from domain cache…”

**Full spoken answer:**
> “HTTP caching via URLCache follows Cache-Control and validators — great for public, static-ish GETs. App cache holds decoded models in memory or disk for UX and offline. Authenticated personalized data must be keyed by user or not cached. I keep the networking SDK focused on transport policy; offline/domain caches usually live in repositories — for example SDUI fallback engines — so the client doesn’t become a kitchen-sink database.”

**Common wrong answer:** “Cache everything in the networking singleton for speed.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Account switch? | Clear user-keyed caches on logout. |
| L2 | Force refresh? | reloadIgnoringLocalCacheData / TTL bust. |
| L3 | Should SDK own disk? | Usually no — transport optional only. |

**Provenance:** Learning-lab · cache boundaries

---

### Q8. What is SSL pinning and what goes wrong? `(60–75s)`

**Answer points:**
- Extra identity check beyond default TLS
- Prefer SPKI hash of Subject Public Key Info DER
- Not raw SecKeyCopyExternalRepresentation bytes
- Failure mode: outdated pins → outage
- Backup pins / rotation as design (S4-A1)
- ATS ≠ pinning

**Agenda opener:** “Pinning is an app-level identity constraint on top of TLS…”

**Full spoken answer:**
> “SSL pinning means we reject TLS connections whose server identity doesn’t match pins we embedded — mitigating MITM cases where trust stores or CAs aren’t enough. I pin the SHA-256 of the certificate’s Subject Public Key Info DER — true SPKI — not the raw bytes from SecKeyCopyExternalRepresentation, which is a common sample-code mistake. The main failure mode is operational: if keys or certs change and pins don’t, the app bricks networking. ATS is only the baseline HTTPS policy; it is not pinning. On Ads we shipped pinning with URLSession; backup pins and break-glass I’d treat as required design, not set-and-forget.”

**Common wrong answer:** “ATS pins our certificates automatically.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Cert vs SPKI pin? | Leaf cert breaks on reissue; SPKI survives if key reused. |
| L2 | Where implemented? | URLSessionDelegate server-trust challenge. |
| L3 | Debug HTTPS proxy? | Debug-only trust path; never weaken prod casually. |

**Provenance:** Verified · S4 · pinning / How I would apply it · S4-A1 rotation design

---

### Q9. Domain whitelisting — why? `(30–45s)`

**Answer points:**
- Only approved hosts
- Reduces misconfig / unexpected third-party API calls
- Enforce in central request builder
- Distinct from image CDN rules if needed

**Agenda opener:** “Whitelist is a client hard gate before resume…”

**Full spoken answer:**
> “A domain whitelist means the Ads or API client refuses to send requests to hosts outside an allow-list. That cuts down SSRF-ish misconfiguration and surprising third-party calls if CMS or config goes wrong. I enforce it centrally in the request builder before the session runs. Image CDNs can be a separate policy from authenticated API hosts — don’t conflate them.”

**Common wrong answer:** “HTTPS already means any host is fine.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | How enforced? | `allowedHosts.contains(url.host)`. |
| L2 | Dynamic hosts? | Signed config / build-time set; careful updates. |
| L3 | Tie to S4? | Verified control on Ads migration. |

**Provenance:** Verified · S4 · domain whitelist

---

### Q10. How do you test networking without flaky CI? `(45–60s)`

**Answer points:**
- Protocol-wrap session / fixtures
- URLProtocol optional
- Fake 401 refresh state machine
- Keep secrets out of fixtures
- Few integration smokes only

**Agenda opener:** “Unit-test the state machine; don’t hit prod from CI…”

**Full spoken answer:**
> “I wrap URLSession behind a protocol and return fixture Data and status codes in unit tests. That lets me test decoding, error mapping, whitelist rejections, and the 401 → single-flight refresh → retry-once path without networks. URLProtocol is useful for slightly higher fidelity. I keep tokens and PII out of fixtures. A tiny staging smoke suite can exist, but CI stay deterministic.”

**Common wrong answer:** “Our tests call production APIs with retries until green.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Assert single-flight? | N parallel 401s → one refresh invocation. |
| L2 | Cancel tests? | Expect silent cancel; no error UI path. |
| L3 | Migration parity? | Same fixtures against old/new client. |

**Provenance:** Learning-lab · test strategy / S4 migration discipline

---

### Q11. Error mapping you use in production? `(45s)`

**Answer points:**
- Transport / HTTP / decoding / cancel / auth
- UI: retryable vs fatal vs silent
- No raw JSON in alerts
- Pinning / whitelist as explicit cases when useful

**Agenda opener:** “Typed errors at the boundary, friendly mapping in UI…”

**Full spoken answer:**
> “I map to transport failures like offline and timeout, HTTP status errors, decoding failures, cancellation, and auth failures after refresh is exhausted. Pinning and whitelist failures should be explicit for metrics even if the UI shows a generic failure. The UI decides retryable versus fatal and never shows raw server JSON. Cancellation stays silent.”

**Common wrong answer:** “Throw NSError and `localizedDescription` everywhere.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Partial success? | Domain-specific; don’t hide in generic client. |
| L2 | 401 vs 403? | 401 → refresh path; 403 → permissions UI. |
| L3 | Telemetry? | Status + path template; no bodies. |

**Provenance:** Learning-lab · error model

---

### Q12. How does networking relate to p50/p90? `(45s)`

**Answer points:**
- Trace spans / journey latency
- Averages lie — watch p90
- Timeouts align with backend SLOs
- Client fixes: cache, prefetch, cancel waste

**Agenda opener:** “Latency culture beats anecdotal ‘it feels slow’…”

**Full spoken answer:**
> “Networking shows up in user journeys, so we instrument traces and look at p50 and p90, not just averages. Slow endpoints and fat tails drive perceived jank. Client timeouts should match backend reality. Client-side wins include caching public data, prefetching, and cancelling wasteful in-flight work. At BookMyShow we used Firebase Performance with p50/p90 on listing, checkout, and search.”

**Common wrong answer:** “If mean latency is fine, we’re done.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Interceptor vs journey? | Baseline path vs product trace (S5-A1). |
| L2 | Double counting? | Don’t nest identical spans carelessly. |
| L3 | What not to log? | PII, tokens, full bodies. |

**Provenance:** Verified · S5 · Firebase Performance p50/p90

---

## Tricky questions

### T1. “N requests get 401 at once — design refresh.” `(90–120s)`

**Answer points:**
- Trap: refresh per request
- Single-flight actor
- One retry
- Failure → global logout
- Draw sequence
- Idempotency caveat on POST

**Agenda opener:** “I’ll treat refresh as a single-flight critical section…”

**Full spoken answer:**
> “The trap is starting one refresh per 401. I’d detect unauthorized once per request, then enter an actor-backed refresher: if refresh is already in flight, await the same result; otherwise perform exactly one refresh call. On success, update Keychain-backed tokens and retry each original request once with the new access token. On failure, resume every waiter with the error, clear credentials, and force login. I’d sketch the sequence for three parallel 401s. For non-idempotent POSTs, I still won’t blindly retry without an idempotency key even after a successful refresh.”

**Common wrong answer:** “Mutex around each request’s full execute including decode.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Why actor? | Serialize refresh state safely with async. |
| L2 | Task mutation bug? | Don’t assign tokens inside unstructured Task. |
| L3 | Refresh returns 401? | Fail closed → logout all waiters. |

**Provenance:** Learning-lab · SingleFlightRefresh

---

### T2. “Should the networking SDK own disk cache?” `(90s)`

**Answer points:**
- Trap: kitchen-sink SDK
- Transport cache optional
- Domain/offline in Repository / SDUI
- Focus: build, auth, execute, decode, cancel

**Agenda opener:** “I’d keep the HTTP client narrow…”

**Full spoken answer:**
> “Transport-level HTTP caching can live near the client via URLCache and request cache policy. Disk offline caches for domain models or SDUI documents usually belong in a repository or fallback engine. If the networking SDK owns everything — images, disk DB, GraphQL, offline sync — it becomes untestable and violates boundaries. I keep the SDK to build, auth, execute, decode, cancel, and policy hooks.”

**Common wrong answer:** “Yes, one NetworkManager singleton with NSCache and files.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Image loading? | Separate pipeline (Kingfisher-style). |
| L2 | Who invalidates? | Feature/repository policies + logout. |
| L3 | Interview HLD tip? | Explicitly list out-of-scope. |

**Provenance:** Learning-lab · boundary design

---

### T3. “Pinning broke production after cert rotate — your fault?” `(90–120s)`

**Answer points:**
- Trap: blame-only or “pinning bad”
- Pinning without rotation design is incomplete
- Backup pins, monitoring, break-glass (S4-A1 design)
- S4 shipped pinning; ops path = design honesty
- Detect via TLS failure metrics / canary

**Agenda opener:** “I’d separate the control from the operational pairing…”

**Full spoken answer:**
> “If pinning is in prod without a rotation story, that’s an incomplete design — the failure mode is a total networking outage. I wouldn’t conclude ‘pinning is bad’; I’d conclude we needed backup pins, a planned pin update path, TLS failure monitoring, and a carefully scoped break-glass. On Ads we did migrate to URLSession with pinning and whitelist. I’m careful not to claim I shipped a full pin-rotation runbook — but in interview design I’d insist on those operational pieces before calling the security work done. Early detection is canary releases plus spiking TLS failure metrics.”

**Common wrong answer:** “Pinning always causes outages so we removed it.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SPKI vs leaf? | SPKI survives reissue if key reused. |
| L2 | Break-glass risk? | Time-box; monitor; don’t leave off. |
| L3 | Who generates pins? | From SPKI DER via known tooling. |

**Provenance:** Verified · S4 · How I would apply it · S4-A1

---

### T4. “Alamofire already supports interceptors — why migrate?” `(90s)`

**Answer points:**
- Trap: NIH
- First-party pinning/whitelist control
- Dependency reduction
- Pod ownership consistency
- Justified on revenue module — not ideology

**Agenda opener:** “Migration cost needs a security/control ROI…”

**Full spoken answer:**
> “Alamofire’s interceptors weren’t the blocker — ownership was. For Ads we wanted first-party URLSession control for pinning and host whitelisting, plus less third-party surface on a revenue-critical pod. We paid migration cost for that control, with parity testing around status and decode. I wouldn’t migrate an entire app out of ideology; I’d start where threat and value are highest.”

**Common wrong answer:** “We rewrote it because Alamofire can’t do HTTPS.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Keep Alamofire elsewhere? | Yes, risk-based. |
| L2 | What parity tests? | Fixtures for success/401/decode fail. |
| L3 | Shadow traffic? | Don’t claim shipped; phased rollout as design. |

**Provenance:** Verified · S4

---

### T5. “How do you cancel URLSession work with async/await correctly?” `(90s)`

**Answer points:**
- Trap: fire-and-forget Task
- Hold Task handle; cancel on lifecycle / new query
- Async APIs participate in Task cancellation
- Callback APIs need explicit cancel + stale guards
- Map cancel to silent UI

**Agenda opener:** “Cancellation starts with owning the Task handle…”

**Full spoken answer:**
> “I keep an explicit Task handle on the ViewModel and cancel it when the query changes or the screen disappears. Async URLSession methods participate in that cancellation, so the await fails with cancellation and I ignore it in the UI. The trap is fire-and-forget tasks you can never cancel. If any code path still uses callback dataTasks, participation doesn’t save you — you must cancel the URLSessionTask and guard against stale completions with a generation token.”

**Common wrong answer:** “Async/await means URLSession always auto-cancels everything.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | withTaskCancellationHandler? | Useful to bridge legacy cancel hooks. |
| L2 | Multiple consumers? | Coalesce in repository. |
| L3 | Detached Task? | Avoid for UI-bound work. |

**Provenance:** Verified · S3 · cancel discipline / Learning-lab mechanics

---

### T6. “Retry + payment checkout.” `(90–120s)`

**Answer points:**
- Trap: generic retry on all routes
- Idempotency keys
- Status polling / explicit states
- Endpoint opt-in retry policy
- Tie to checkout UX caution (S7)

**Agenda opener:** “Payments break the generic retry story…”

**Full spoken answer:**
> “A global retry interceptor on POST charges is how you double-bill. For checkout I’d require server idempotency keys, make retry policy opt-in per endpoint, and prefer explicit payment status polling with clear UI states over silent client replays. Networking can refresh auth and retry safe GETs, but charge creation is a different contract. That mindset matches why payment UX needs careful processing-state handling rather than ‘just hit the API again.’”

**Common wrong answer:** “Our client retries every 5xx including /charge.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What is idempotency key? | Client-generated key server dedupes. |
| L2 | Refresh then POST? | Still need idempotency. |
| L3 | User double-tap? | UI disable + same key. |

**Provenance:** Verified · S7 · payment caution / How I would apply it · retry policy

---

### T7. “Man-in-the-middle on public Wi-Fi — what layers help?” `(90s)`

**Answer points:**
- Trap: only “use HTTPS”
- ATS/HTTPS baseline
- Default trust evaluation
- Pinning for high-value
- Whitelist
- No cleartext fallback; careful WebViews
- User education ≠ engineering control

**Agenda opener:** “Defense in layers, starting with TLS baseline…”

**Full spoken answer:**
> “HTTPS with ATS is the baseline — no cleartext APIs. Default certificate validation still matters. For high-value Ads or auth traffic, pinning adds an identity check against embedded SPKI pins, and a host whitelist prevents talking to surprise endpoints. I’d avoid cleartext exceptions and be careful with WebViews that can bypass app networking controls. Telling users ‘don’t use public Wi-Fi’ is not an engineering control. On Ads we owned HTTPS, pinning, and whitelist on the URLSession stack for that reason.”

**Common wrong answer:** “TLS means MITM is impossible.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | ATS vs pin? | Policy vs app identity pin. |
| L2 | Compromised CA? | Pinning helps; still need ops. |
| L3 | Charles users? | Debug builds only. |

**Provenance:** Verified · S4 · Ads threat model

---

### T8. “Where do you put Firebase Performance tracing — interceptor or call site?” `(90s)`

**Answer points:**
- Trap: only one right answer
- Interceptor for baseline path latency
- Call sites for product journeys
- Avoid double-counting; PII-safe names
- p50/p90 culture (S5)

**Agenda opener:** “Both — for different questions…”

**Full spoken answer:**
> “I’d put lightweight per-path latency in an interceptor for baseline networking health, and keep product journey traces — listing to checkout, search submit to results — at the call site or coordinator so they match user-visible flows. Avoid double-counting the same interval under two names, and keep trace names free of PII. We instrumented Firebase Performance with p50/p90 on those journeys; exact interceptor-versus-journey split is a design choice I’d make explicit.”

**Common wrong answer:** “Only interceptors; journeys are unnecessary.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What is p90? | 90% of samples faster than this. |
| L2 | Client-only wins? | Cancel waste, cache, prefetch. |
| L3 | Cardinality? | Template paths, not raw query strings. |

**Provenance:** Verified · S5 · How I would apply it · S5-A1

---

## Timed drill set (recommended)

Record: **Q4, Q8, Q5, T1, T3** — then deliver **S4 STAR** in 2–3 minutes.

Score against your answer-timing guide; log misses on refresh concurrency and SPKI/ATS distinctions.

Revision twin for skeleton recall: [../../../revision/weeks/week-02/day-09.md](../../../revision/weeks/week-02/day-09.md)
