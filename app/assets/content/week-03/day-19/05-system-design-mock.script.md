# Audio script — Sample 05 — System-design mock: Mobile Security & Zero-Trust Engine (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Mobile Security & Zero-Trust Engine.” How do you open?

Next. Q1. Interviewer: “Design Mobile Security & Zero-Trust Engine.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Secure Enclave + biometrics and App Attest + SPKI, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Pinning + Keychain + App Attest in scope? 2. Jailbreak checks severity? 3. Which hosts pinned? 4. Biometric step-up for which actions? 5. Out: HSM/server audit? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: SPKI pinning; Secure Enclave/Keychain; App Attest; SQLCipher optional; jailbreak policy; out: server HSM. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Trust layer beside networking: pin delegate, attest assertions on critical ops, encrypted storage. Backend: gateway verifies attest; pin high-value hosts only. Load: attest token <2KB; cache keyId; don’t re-gen key every request. Follow-ups. Pin all hosts?: No — high-value; backup pins; rotation.. Persistence tree?: Secrets→Keychain; not UserDefaults..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. Attestation challenge → Apple attest; generateAssertion on sensitive calls. Pinning via URLSession challenge. Follow-ups. Pin fail?: Fail closed; metric; backup pin.. Biometry reset?: Keys invalidate — re-enroll..

## §4 Q5. Deep dive 1 — Secure Enclave + biometrics?

Next. Q5. Deep dive 1 — Secure Enclave + biometrics? Answer. SEP keygen; Face ID gated; AccessibleAfterFirstUnlock for background needs carefully. Follow-ups. Background refresh tokens?: Accessibility class trade-off — state aloud.. Passcode fallback?: Yes for UX..

## §5 Q6. Deep dive 2 — App Attest + SPKI?

Next. Q6. Deep dive 2 — App Attest + SPKI? Answer. Attest integrity; pin SPKI SHA-256 of DER — not raw SecKey bytes. Rotation: ship client before rotate. Follow-ups. Break-glass?: Design label if not shipped runbook.. Jailbreak?: Terminate sensitive session policy..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Pin fail rate, attest fail, jailbreak hits. Kill: disable attest soft; never silently disable pin in prod without gate. Follow-ups. Production?: BookMyShow SSL pinning + whitelist.. Payment link?: PCI — tokenization + pin..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
