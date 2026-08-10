# 01 — Foundations: Transport Security & Persistence (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. North star? `(45–60s)`
**Answer:**

> “ATS is the floor; pinning is an extra identity check on sensitive hosts; secrets live in Keychain; pick storage from a decision tree — not one tool for everything. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Transport security stack? `(45–60s)`
**Answer:**

> “text ATS (HTTPS / TLS defaults / no cleartext by default) → System certificate chain trust → Optional Pinning (SPKI hash match in URLSession delegate) → Domain allowlist (only call / pin known hosts).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Pinning modes (first pass)? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. SPKI correctness (memorize)? `(45–60s)`
**Answer:**

> “SPKI is the hash of the Subject Public Key Info DER — not the raw bytes from SecKeyCopyExternalRepresentation. That’s a common sample-code mistake.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Full persistence decision tree (EMBEDDED — recite this)? `(45–60s)`
**Answer:**

> “Quote this table in interviews. It lives in-chapter so you are not dependent on opening the cheatsheet.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Hard rules? `(45–60s)`
**Answer:**

> “1. Tokens ≠ UserDefaults (plist/backups/jailbreak exposure) 2. PII at rest → encrypt when threat model requires (SQLCipher / file protection; keys in Keychain/SEP) 3. Don’t invent Core Data for three booleans 4. Caches can vanish — never sole source of truth for irreplaceable user data 5. Main thread: no heavy SQLite/Core Data writes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Recite opener (≤20s)? `(45–60s)`
**Answer:**

> “It depends on sensitivity and access pattern — secrets in Keychain, prefs in UserDefaults, media in FileManager, queries in SQLite WAL or Core Data for graphs, NSCache for session images, actors for concurrent in-session state.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Keychain vs UserDefaults (zoom)? `(45–60s)`
**Answer:**

> “Biometrics: LocalAuthentication + SecAccessControl unlocks a Keychain item — you do not store Face templates in your app.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. BMS production proof (preview)? `(45–60s)`
**Answer:**

> “Migrated Ads Alamofire → URLSession; enforced HTTPS, SSL pinning, domain whitelisting. Pin rotation / backup / break-glass → speak as design, not Verified shipped runbook.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. Glossary? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Teach-back? `(45–60s)`
**Answer:**

> “1. ATS ≠ pinning 2. SPKI DER hash ≠ SecKey raw export 3. Full persistence table (7 rows) 4. shipped vs design Next: 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
