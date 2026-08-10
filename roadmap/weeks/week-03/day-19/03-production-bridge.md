# 03 — Production Bridge: S4 Pinning + S4-A1 Design (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Provenance map? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. Forbidden? `(45–60s)`
**Answer:**

> “- “I shipped the pin-rotation runbook / break-glass flag to production” as Verified - “We hash SecKeyCopyExternalRepresentation as SPKI” - “ATS is our pinning” - “Pinning alone fixed app-wide CFS” - Shadow-traffic rollout theater.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q3. Opener? `(45–60s)`
**Answer:**

> “I’ll walk through migrating BookMyShow Ads networking from Alamofire to URLSession so we owned transport security on a revenue-critical module.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Situation / Task? `(45–60s)`
**Answer:**

> “Ads on Alamofire; need stronger first-party control — HTTPS, SSL pinning, domain allowlisting — and less dependency surface.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Action? `(45–60s)`
**Answer:**

> “1. First-party URLSession path for Ads networking. 2. Enforced HTTPS. 3. SSL pinning via session trust evaluation — fail closed on mismatch for pinned hosts. 4. Domain whitelist — only approved hosts. 5. Treated pinning incomplete without ops mindset → see as design.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Result? `(45–60s)`
**Answer:**

> “Reduced MITM exposure on high-traffic Ads module; clearer ownership of trust evaluation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Lesson? `(45–60s)`
**Answer:**

> “Pinning without rotation/backup/break-glass design creates self-inflicted outages. > Provenance: Verified · · Ads URLSession + HTTPS + pinning + whitelist.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. ≤20s line? `(45–60s)`
**Answer:**

> “I moved Ads off Alamofire onto URLSession with HTTPS, SSL pinning, and domain allowlisting — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. S4-A1 script (separate breath)? `(45–60s)`
**Answer:**

> “Backup pins, ship-before-rotate, staged exposure, monitored break-glass — that’s the design I’d insist on. I’m not claiming I shipped that full runbook; I’m claiming the controls we owned plus the operational design required to keep pinning safe.” > Provenance: How I would apply it · .

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Persistence recite (45s drill)? `(45–60s)`
**Answer:**

> “Recite the 7-row tree from foundations without notes. End with: “Tokens never in UserDefaults.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
