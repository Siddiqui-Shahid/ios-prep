# 02 — Deep Dive: Pinning, Rotation Design, Auth Persistence (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Where pinning lives on iOS? `(45–60s)`
**Answer:**

> “text URLSessionDelegate → urlSession(_:didReceive:completionHandler:) → server trust challenge → evaluate trust + extract leaf/chain cert → compute SHA-256(SPKI DER) → compare to embedded allowlisted pins for that host → succeed or cancel (fail closed for sensitive APIs) Domain allowlist: only pin / call hosts you own or tightly control. Don’t pin arbitrary CDNs you don’t operate — operational surprise.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Right mental model? `(45–60s)`
**Answer:**

> “1. Obtain certificate (SecCertificate) 2. Get Subject Public Key Info encoding (DER) 3. SHA-256 that DER blob 4. Compare to pinned hashes (often base64 or hex in config).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Common mistake? `(45–60s)`
**Answer:**

> “Interview correction script:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. S4-A1 — Pin ops as **design** (not shipped runbook claim)? `(45–60s)`
**Answer:**

> “When interviewers ask “what happens when cert/key rotates?”:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Hard-fail vs soft-fail? `(45–60s)`
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

### Q6. Why leave Alamofire for Ads (S4)? `(45–60s)`
**Answer:**

> “- Own URLSession trust challenges end-to-end - Smaller dependency surface on revenue-adjacent module - HTTPS + pinning + host allowlist as explicit policy - Interceptors/refresh still designable on first-party client (Day 09) ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Auth & biometric (client lens)? `(45–60s)`
**Answer:**

> “Obfuscation trap: Base64 in UserDefaults is not security.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Persistence tree — worked examples? `(45–60s)`
**Answer:**

> “Re-embed full table (same as foundations — muscle memory):.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Jailbreak / attestation (light)? `(45–60s)`
**Answer:**

> “- Client detection is bypassable — defense in depth only - Never sole control for payments - Prefer server attestation for high-risk when in scope - False positives destroy UX — be careful ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Trade-offs? `(45–60s)`
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

### Q11. Failure modes? `(45–60s)`
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

### Q12. Pin failure incident script (60–90s)? `(45–60s)`
**Answer:**

> “Pin failure spike on Ads hosts — confirm with TLS error metrics and domain allowlist hits. Mitigate with staged break-glass only if designed and monitored — never silent forever-off. Ship a build with corrected/backup SPKI hashes generated from DER, not SecKey raw export. Communicate as Sev because revenue path is hard-fail by design. Postmortem: rotation checklist gaps.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Persistence tree stress drills (embed again)? `(45–60s)`
**Answer:**

> “Recite without notes: 1. Refresh token → Keychain 2. Dark mode flag → UserDefaults 3. Offline orders query → SQLite WAL 4. Ticket PDF user saved → Application Support (not Caches) 5. Poster images session → NSCache + Caches files 6. Shared in-flight map → Actor / serial queue 7. Complex graph + tooling → Core Data bg writes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Optional citations? `(45–60s)`
**Answer:**

> “- mobile-security-privacy-engine.md, authentication-oauth-biometric.md, cheatsheet storage tree - Story Self-contained without opens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
