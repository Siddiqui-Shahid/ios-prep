# Sample 05 — System-design mock: Mobile Security & Zero-Trust Engine (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/mobile-security-privacy-engine.md`](../../../../ios-system-design/docs/mobile-security-privacy-engine.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 19 — Parallel SD Security engine (+ pinning).

---

### Q1. Interviewer: “Design Mobile Security & Zero-Trust Engine.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Secure Enclave + biometrics** and **App Attest + SPKI**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Pinning + Keychain + App Attest in scope?
> 2. Jailbreak checks severity?
> 3. Which hosts pinned?
> 4. Biometric step-up for which actions?
> 5. Out: HSM/server audit?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** SPKI pinning; Secure Enclave/Keychain; App Attest; SQLCipher optional; jailbreak policy; out: server HSM.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Trust layer beside networking: pin delegate, attest assertions on critical ops, encrypted storage.
> **Backend:** gateway verifies attest; pin high-value hosts only.
> **Load:** attest token <2KB; cache keyId; don’t re-gen key every request.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pin all hosts? | No — high-value; backup pins; rotation. |
| Persistence tree? | Secrets→Keychain; not UserDefaults. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> Attestation challenge → Apple attest; `generateAssertion` on sensitive calls. Pinning via URLSession challenge.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pin fail? | Fail closed; metric; backup pin. |
| Biometry reset? | Keys invalidate — re-enroll. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q5. Deep dive 1 — Secure Enclave + biometrics?
**Answer:**

> SEP keygen; Face ID gated; AccessibleAfterFirstUnlock for background needs carefully.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Background refresh tokens? | Accessibility class trade-off — state aloud. |
| Passcode fallback? | Yes for UX. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q6. Deep dive 2 — App Attest + SPKI?
**Answer:**

> Attest integrity; pin SPKI SHA-256 of DER — not raw SecKey bytes. Rotation: ship client before rotate.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Break-glass? | Design label if not shipped runbook. |
| Jailbreak? | Terminate sensitive session policy. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Pin fail rate, attest fail, jailbreak hits. Kill: disable attest soft; never silently disable pin in prod without gate.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | BookMyShow SSL pinning + whitelist. |
| Payment link? | PCI — tokenization + pin. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + domain allowlist.

---

### Q8. Flow scorecard — did you hit the optimal spine?
**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.
> **Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |
| Invented crash-free %? | Forbidden — use resume-backed numbers or label as target. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.
