# Audio script — Sample design — networking / HTTP client

## §0 Introduction

Sample design — networking / HTTP client They say: “Design our iOS networking layer.” They mean one session, auth refresh, and tests — not Alamofire fanfic.

## §1 Problem

Every feature hits HTTPS. Tokens expire. The user backgrounds the app. A junior created URLSession() in every ViewModel and now the connection pool is sad. You are on the whiteboard to put one client under the app.

## §2 Requirements (2 minutes — ask, then lock)

One shared URLSession (Apple’s HTTP stack; pooling, HTTP/2). A protocol HTTPClient so tests inject a fake. An auth header interceptor. 401 (Unauthorized) refresh is single-flight (one refresh Task; waiters retry once). Timeouts about 30s. Retry idempotent GET with exponential backoff + jitter (random delay so you don’t thundering-herd the server after a blip). Honor ETag / 304. Decode Codable off main. No card PAN, no tokens in logs. Confirm: “One session, Keychain tokens, single-flight refresh, ETag, Codable off main. Downloads are a different task type on that session. Does that work?”

## §3 API and data

This is the client. Upstream is whatever the app needs: GET /v1/... Authorization: Bearer {access} If-None-Match: {etag} POST /oauth/token { refresh token } Tokens live in Keychain (encrypted item store), not UserDefaults . A request model is method + URL + headers + body. A download is a file destination + progress + cancel per id. Same session. Two APIs. That sentence is the 21 Aug round.

## §4 iOS LLD (types and sequence)

AppContainer owns URLSession + TokenStore actor + HTTPClientImpl . ViewModels never see the session. Happy path: build URLRequest → attach bearer → data(for:) → map status → decode off main → return a typed value. 401 path: await refresher.refresh() → retry the original once → if still 401, logout. TokenRefresher holds one Task<Token, Error ? . Second caller awaits the same Task. If you don’t say this, the interview dies on “what if two 401s.” Retries: GET/HEAD only unless they give you idempotent POST with Idempotency-Key . Honor Retry-After on 429 . Errors map to NetworkError (offline, timeout, 4xx, 5xx, decode). ViewModels switch on that for empty/error/retry chrome. Do not try! . Failure: airplane mode returns a typed offline error; the repository may still paint disk. Decode failure on one endpoint does not crash the app.

## §5 HLD (scale, cache, consistency)

Mobile is chatty. Gateway rate limits. You reduce load with ETags, optional coalesced identical GETs, and not polling every second. Certificate pinning is a product choice; if you mention it, mention rotation or you lock yourself out of an App Store build. Consistency here is boring and correct: the client does not cache a 200 that was a POST side effect unless the API says so.

## §6 Tradeoffs

Combine vs async/await: pick async/await in 2026 unless the codebase is Combine. GraphQL vs REST: don’t start a religion; pagination and error shapes matter more. Background URLSession for large files is a different configuration, not a second architecture.

## §7 60-second close

“If they ask me to wrap: one session, protocol for tests, Keychain tokens, single-flight refresh, Codable off main, retry only what is safe. I never alloc a session per screen. A download is a task type, not a JSON DTO.”
