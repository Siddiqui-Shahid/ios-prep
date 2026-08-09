# Audio script — Sample 05 — System-design mock: Auth: OAuth2 PKCE + Biometrics (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Auth: OAuth2 PKCE + Biometrics.” How do you open?

Next. Q1. Interviewer: “Design Auth: OAuth2 PKCE + Biometrics.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on PKCE exchange and Single-flight refresh, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. OAuth2 PKCE + biometric step-up? 2. Token TTLs? 3. Single-flight refresh on concurrent 401? 4. SSO ASWebAuthenticationSession? 5. Out: IdP server internals? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: PKCE; Keychain tokens; actor refresh; Face ID step-up; logout revoke; out: IdP internals. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Login U I → AuthService → ASWebAuth session → Keychain → APIClient interceptors. Backend: /authorize, /token, logout revoke. Load: access 15m–1h; Keychain no iCloud sync; SSO ~1–3s. Follow-ups. S D U I/network alt?: Expert may pick — same 45‑min spine.. Pinning?: Auth hosts high-value — security sister..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. PKCE authorize→token; refresh grant; logout revoke. Biometric gate before revealing refresh token usage for step-up. Follow-ups. Refresh fail?: Logout clear Keychain.. Multi-device revoke?: Server invalidate refresh family..

## §4 Q5. Deep dive 1 — PKCE exchange?

Next. Q5. Deep dive 1 — PKCE exchange? Answer. code_verifier/challenge; no client secret in public app; state CSRF. Follow-ups. Custom scheme hijack?: Universal Links / ephemeral session preferred.. Keychain accessibility?: AfterFirstUnlock vs WhenUnlocked — trade-off..

## §5 Q6. Deep dive 2 — Single-flight refresh?

Next. Q6. Deep dive 2 — Single-flight refresh? Answer. Same as networking dive — actor; waiters; one refresh; failure logout. Follow-ups. Biometric fail?: Passcode fallback; limit retries.. Ops last 5?: Protect — metrics + kill SSO provider..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Refresh success, login funnel, biometric fail rate. Kill: force re-login; disable SSO provider. Follow-ups. Tie to Mock #4?: Coding + i O S deep dive + this SD — calendar discipline.. Openers?: Day 27 warmup scripts..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
