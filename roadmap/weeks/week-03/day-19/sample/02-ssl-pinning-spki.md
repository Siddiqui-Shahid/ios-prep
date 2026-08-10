# Sample 02 — SSL pinning & SPKI (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. Where does SSL pinning live on iOS?
**Answer:**

> In **URLSessionDelegate** → `urlSession(_:didReceive:completionHandler:)` on the **server trust challenge**. You evaluate trust, extract the certificate chain, compute **SHA-256(SPKI DER)**, compare to embedded pins for that **allowlisted host**, then succeed or **cancel** (fail closed on sensitive APIs).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why URLSession over Alamofire for Ads? | Own trust challenges end-to-end; smaller dependency surface on revenue module — BookMyShow SSL pinning + URLSession migration. |
| Pin in Network.framework? | Same trust-evaluation concept; URLSession delegate is the common interview answer. |
| Fail open vs closed? | Sensitive hosts: **fail closed** (cancel challenge). |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q2. What is SPKI pinning, and how is it computed correctly?
**Answer:**

> **SPKI pinning** hashes the **Subject Public Key Info DER bytes** from the server certificate: 
> `SPKI pin = SHA-256( SubjectPublicKeyInfo DER )` 
> Prefer SPKI over **leaf certificate** pinning — cert reissue with the same key often survives. **Not** the same as hashing `SecKeyCopyExternalRepresentation` raw bytes — that’s a common sample-code mistake.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not leaf cert pin? | Routine cert renewal breaks the app even when the key is unchanged. |
| SecKey raw export mistake? | External representation ≠ SPKI structure; pins won’t match real SPKI tooling. |
| Say aloud in interview? | “SPKI is the hash of Subject Public Key Info DER — not SecKeyCopyExternalRepresentation bytes.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Certificate pin vs SPKI pin — when which?
**Answer:**

> **Certificate (leaf) pin:** exact cert bytes — simple but breaks on routine renew. 
> **SPKI / public key pin:** hash of public key info — survives reissue **if the key is reused**. 
> Production default for owned APIs: **SPKI**. Leaf only for very short-lived or lab scenarios.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Key rotation still breaks SPKI? | Yes — when the server key changes, you need backup pins and a rotation plan (Design: pin rotation / break-glass (not shipped runbook)). |
| Copy random GitHub gist? | Audit the DER step — silent wrong pins = false security or instant outage. |
| Multiple pins per host? | Yes — primary + backup SPKI hashes for planned transitions. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q4. What happens when cert/key rotates — BookMyShow SSL pinning + URLSession migration vs Design: pin rotation / break-glass (not shipped runbook)?
**Answer:**

> **BookMyShow SSL pinning + URLSession migration:** Ads shipped URLSession + HTTPS + SSL pinning + domain whitelist. 
> **Design: pin rotation / break-glass (not shipped runbook):** backup pins, ship client **before** server key rotate, staged exposure, monitored break-glass — **design judgment**, not “I shipped the full ops runbook.” Pinning without rotation thinking bricks the app on renew.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Backup pins intent? | ≥2 acceptable SPKI hashes during planned key transition. |
| Break-glass? | Time-boxed, monitored emergency path — not silent forever-off. |
| Forbidden claim? | “I shipped the pin-rotation runbook to production” as Verified. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q5. Hard-fail vs soft-fail pinning?
**Answer:**

> **Hard-fail (cancel challenge):** Ads, auth, payments — mismatch blocks the connection. Outage if rotation is weak, but no silent MITM. Fix ops, don’t downgrade security quietly. 
> **Soft-fail / report only:** low-sensitivity experiments — risk is silent security regression. Default for revenue paths: **hard-fail**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pin failure spike on Ads? | Confirm TLS metrics; staged break-glass if designed; ship corrected SPKI from DER; Sev comms — revenue path is hard-fail by design. |
| “Just disable pinning in prod”? | Never silent forever-off on sensitive APIs. |
| Remote pin disable? | Break-glass only — protect the config channel. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is the BookMyShow SSL pinning + URLSession migration story in one breath?
**Answer:**

> “I moved BookMyShow Ads off Alamofire onto URLSession with HTTPS, SSL pinning, and domain allowlisting — so we owned transport security on a revenue-critical module and reduced MITM exposure. I’d pair that with backup pins and break-glass **design** so rotation doesn’t brick the app.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why leave Alamofire? | Trust challenge ownership, smaller surface, explicit policy — Deep dive §4. |
| Result line? | Clearer ownership of trust evaluation; reduced MITM exposure on high-traffic Ads. |
| Lesson? | Pinning without rotation/backup/break-glass design creates self-inflicted outages. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q7. How do you handle a pin failure incident (60–90s)?
**Answer:**

> “Pin failure spike on Ads hosts — confirm with TLS error metrics and allowlist hits. Mitigate with **designed, monitored** break-glass only — never silent forever-off. Ship a build with corrected/backup SPKI hashes generated from **DER**, not SecKey raw export. Communicate as Sev because revenue path is hard-fail by design. Postmortem: rotation checklist gaps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wrong SPKI bytes root cause? | Audit pin generation pipeline — common gist mistake. |
| Cert renew bricked app? | Expected without backup pins — Design: pin rotation / break-glass (not shipped runbook) lesson. |
| Pinning fixed CFS? | **Forbidden** — don’t claim pinning alone fixed app-wide crash-free. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q8. Timed BookMyShow SSL pinning + URLSession migration STAR — what is the Opener?
**Answer:**

> “I’ll walk through migrating BookMyShow Ads networking from Alamofire to URLSession so we owned transport security on a revenue-critical module.” Keep ≤15–20s — name module, migration, ownership motive. Don’t open with ATS theory or Design: pin rotation / break-glass (not shipped runbook) rotation design.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why Ads first? | Revenue-critical + high traffic — MITM exposure matters. |
| Mention Alamofire here? | Yes — migration source is part of the Verified claim. |
| Trap? | Leading with pin-rotation runbook as if Verified shipped. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q9. Timed BookMyShow SSL pinning + URLSession migration STAR — Situation / Task?
**Answer:**

> **Situation:** Ads networking lived on Alamofire. **Task:** stronger first-party control — **HTTPS**, **SSL pinning**, **domain allowlisting** — and less dependency surface on a revenue module. Frame the problem as trust-evaluation ownership, not “rewrite networking for fun.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scale signal? | High-traffic Ads — security is product risk. |
| Why not keep Alamofire? | Own trust challenges end-to-end; smaller surface. |
| ATS enough? | ATS is baseline — pinning is extra identity check on sensitive hosts. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q10. Timed BookMyShow SSL pinning + URLSession migration STAR — Action spine?
**Answer:**

> (1) First-party **URLSession** path for Ads. (2) Enforced **HTTPS**. (3) **SSL pinning** via session trust evaluation — **fail closed** on mismatch for pinned hosts. (4) **Domain whitelist** — only approved hosts. (5) Treated pinning incomplete without ops mindset → point to **Design: pin rotation / break-glass (not shipped runbook) design** (rotation/backup/break-glass) in a separate breath — not as Verified shipped runbook.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where does pin live? | URLSessionDelegate server-trust challenge → SPKI SHA-256. |
| Fail closed why? | Sensitive/revenue APIs — no silent MITM. |
| Forbidden in Action? | “I shipped the pin-rotation / break-glass runbook” as Verified. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q11. Timed BookMyShow SSL pinning + URLSession migration STAR — Result?
**Answer:**

> Reduced **MITM exposure** on the high-traffic Ads module; clearer **ownership of trust evaluation**. Don’t invent attack counts, conversion lifts, or “pinning fixed CFS.” Result is control + exposure reduction — security outcome, not crash-free theater.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric you can cite? | Qualitative ownership + MITM resistance — no fake %. |
| Pinning fixed CFS? | **Forbidden** claim. |
| Soft result line? | “We owned policy on the revenue path end-to-end.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q12. Timed BookMyShow SSL pinning + URLSession migration STAR — Lesson (+ Design: pin rotation / break-glass (not shipped runbook) breath)?
**Answer:**

> **Lesson:** Pinning without rotation / backup / break-glass **design** creates self-inflicted outages. **Design: pin rotation / break-glass (not shipped runbook) breath (How I would apply it):** backup pins, ship-before-rotate, staged exposure, monitored break-glass — design I’d insist on; **not** claiming I shipped the full ops runbook. Provenance split aloud: BookMyShow SSL pinning + URLSession migration for what shipped; Design: pin rotation / break-glass (not shipped runbook) for ops design.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s close? | Production bridge §3 one-liner — migration + pairing with backup/break-glass design. |
| Cert renew bricks app? | Predictable without backup pins — cite as Design: pin rotation / break-glass (not shipped runbook) lesson. |
| Time budget? | Full STAR 2–3 min; opener ~15s; Action ~90s; Design: pin rotation / break-glass (not shipped runbook) one breath at end. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q13. Walk the full timed BookMyShow SSL pinning + URLSession migration STAR spine (2–3 min)?
**Answer:**

> **Opener:** Migrate BMS Ads Alamofire → URLSession for transport ownership. **S/T:** Need HTTPS + SSL pinning + domain allowlist on revenue path; less dependency surface. **Action:** URLSession; HTTPS; SPKI pinning fail-closed; whitelist; ops mindset → Design: pin rotation / break-glass (not shipped runbook) design separately. **Result:** Reduced MITM exposure; clearer trust ownership. **Lesson:** Pinning without rotation/backup/break-glass design = self-outages. End with Design: pin rotation / break-glass (not shipped runbook) honesty breath.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | BookMyShow SSL pinning + URLSession migration · Ads URLSession + HTTPS + pinning + whitelist. |
| Drill order? | Opener → S/T → Action → Result → Lesson → Design: pin rotation / break-glass (not shipped runbook). |
| After sample? | [03-keychain-secrets.md](03-keychain-secrets.md) — secrets storage next. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Next: [03-keychain-secrets.md](03-keychain-secrets.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is SPKI pinning, and how is it computed correctly

**Ask yourself:** What is SPKI pinning, and how is it computed correctly?

**Answer:** “**SPKI pinning** hashes the **Subject Public Key Info DER bytes** from the server certificate: 
> `SPKI pin = SHA-256( SubjectPublicKeyInfo DER )` 
> Prefer SPKI over **leaf certificate** pinning — cert reissue with the same key often survives. **Not** the same as hashing `SecKeyCopyExternalRepresentation` raw bytes — that’s a common sample-code mistake.”

### Puzzle B — Certificate pin vs SPKI pin — when which

**Ask yourself:** Certificate pin vs SPKI pin — when which?

**Answer:** “**Certificate (leaf) pin:** exact cert bytes — simple but breaks on routine renew. 
> **SPKI / public key pin:** hash of public key info — survives reissue **if the key is reused**. 
> Production default for owned APIs: **SPKI**. Leaf only for very short-lived or lab scenarios.”

### Puzzle C — What happens when cert/key rotates — BookMyShow SSL pinning + URLSession migrati

**Ask yourself:** What happens when cert/key rotates — BookMyShow SSL pinning + URLSession migration vs Design: pin rotation / break-glass (not shipped runbook)?

**Answer:** “**BookMyShow SSL pinning + URLSession migration:** Ads shipped URLSession + HTTPS + SSL pinning + domain whitelist. 
> **Design: pin rotation / break-glass (not shipped runbook):** backup pins, ship client **before** server key rotate, staged exposure, monitored break-glass — **design judgment**, not “I shipped the full ops runbook.” Pinning without rotation thinking bricks the app on renew.”
