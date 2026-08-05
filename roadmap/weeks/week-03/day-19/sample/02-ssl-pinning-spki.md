# Sample 02 — SSL pinning & SPKI (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Where does SSL pinning live on iOS?

**Points to:** [Deep dive · §1 Where pinning lives](../02-deep-dive.md#1-where-pinning-lives-on-ios)

**Answer:**

> In **URLSessionDelegate** → `urlSession(_:didReceive:completionHandler:)` on the **server trust challenge**. You evaluate trust, extract the certificate chain, compute **SHA-256(SPKI DER)**, compare to embedded pins for that **allowlisted host**, then succeed or **cancel** (fail closed on sensitive APIs).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why URLSession over Alamofire for Ads? | Own trust challenges end-to-end; smaller dependency surface on revenue module — Verified S4. |
| Pin in Network.framework? | Same trust-evaluation concept; URLSession delegate is the common interview answer. |
| Fail open vs closed? | Sensitive hosts: **fail closed** (cancel challenge). |

---

### Q2. What is SPKI pinning, and how is it computed correctly?

**Points to:** [Foundations · §2 Pinning modes](../01-foundations.md#2-pinning-modes-first-pass) · [Deep dive · §2 SPKI extraction](../02-deep-dive.md#2-spki-extraction--correctness-deep-dive)

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

---

### Q3. Certificate pin vs SPKI pin — when which?

**Points to:** [Foundations · §2 Pinning modes](../01-foundations.md#2-pinning-modes-first-pass) · [Deep dive · §2.2 Common mistake](../02-deep-dive.md#22-common-mistake)

**Answer:**

> **Certificate (leaf) pin:** exact cert bytes — simple but breaks on routine renew.  
> **SPKI / public key pin:** hash of public key info — survives reissue **if the key is reused**.  
> Production default for owned APIs: **SPKI**. Leaf only for very short-lived or lab scenarios.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Key rotation still breaks SPKI? | Yes — when the server key changes, you need backup pins and a rotation plan (S4-A1). |
| Copy random GitHub gist? | Audit the DER step — silent wrong pins = false security or instant outage. |
| Multiple pins per host? | Yes — primary + backup SPKI hashes for planned transitions. |

---

### Q4. What happens when cert/key rotates — S4 vs S4-A1?

**Points to:** [Deep dive · §3 S4-A1](../02-deep-dive.md#3-s4-a1--pin-ops-as-design-not-shipped-runbook-claim) · [Production bridge · §1 Provenance](../03-production-bridge.md#1-provenance-map)

**Answer:**

> **Verified · S4:** Ads shipped URLSession + HTTPS + SSL pinning + domain whitelist.  
> **How I would apply it · S4-A1:** backup pins, ship client **before** server key rotate, staged exposure, monitored break-glass — **design judgment**, not “I shipped the full ops runbook.” Pinning without rotation thinking bricks the app on renew.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Backup pins intent? | ≥2 acceptable SPKI hashes during planned key transition. |
| Break-glass? | Time-boxed, monitored emergency path — not silent forever-off. |
| Forbidden claim? | “I shipped the pin-rotation runbook to production” as Verified. |

---

### Q5. Hard-fail vs soft-fail pinning?

**Points to:** [Deep dive · §3.1 Hard-fail vs soft-fail](../02-deep-dive.md#31-hard-fail-vs-soft-fail)

**Answer:**

> **Hard-fail (cancel challenge):** Ads, auth, payments — mismatch blocks the connection. Outage if rotation is weak, but no silent MITM. Fix ops, don’t downgrade security quietly.  
> **Soft-fail / report only:** low-sensitivity experiments — risk is silent security regression. Default for revenue paths: **hard-fail**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pin failure spike on Ads? | Confirm TLS metrics; staged break-glass if designed; ship corrected SPKI from DER; Sev comms — revenue path is hard-fail by design. |
| “Just disable pinning in prod”? | Never silent forever-off on sensitive APIs. |
| Remote pin disable? | Break-glass only — protect the config channel. |

---

### Q6. What is the Verified S4 story in one breath?

**Points to:** [Production bridge · §2 Verified S4](../03-production-bridge.md#2-verified-s4--star-23-min) · [Production bridge · §3 ≤20s line](../03-production-bridge.md#3-20s-line)

**Answer:**

> “I moved BookMyShow Ads off Alamofire onto URLSession with HTTPS, SSL pinning, and domain allowlisting — so we owned transport security on a revenue-critical module and reduced MITM exposure. I’d pair that with backup pins and break-glass **design** so rotation doesn’t brick the app.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why leave Alamofire? | Trust challenge ownership, smaller surface, explicit policy — Deep dive §4. |
| Result line? | Clearer ownership of trust evaluation; reduced MITM exposure on high-traffic Ads. |
| Lesson? | Pinning without rotation/backup/break-glass design creates self-inflicted outages. |

---

### Q7. How do you handle a pin failure incident (60–90s)?

**Points to:** [Deep dive · §10 Pin failure incident script](../02-deep-dive.md#10-pin-failure-incident-script-6090s) · [Deep dive · §9 Failure modes](../02-deep-dive.md#9-failure-modes)

**Answer:**

> “Pin failure spike on Ads hosts — confirm with TLS error metrics and allowlist hits. Mitigate with **designed, monitored** break-glass only — never silent forever-off. Ship a build with corrected/backup SPKI hashes generated from **DER**, not SecKey raw export. Communicate as Sev because revenue path is hard-fail by design. Postmortem: rotation checklist gaps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Wrong SPKI bytes root cause? | Audit pin generation pipeline — common gist mistake. |
| Cert renew bricked app? | Expected without backup pins — S4-A1 lesson. |
| Pinning fixed CFS? | **Forbidden** — don’t claim pinning alone fixed app-wide crash-free. |

---

Next: [03-keychain-secrets.md](03-keychain-secrets.md)
