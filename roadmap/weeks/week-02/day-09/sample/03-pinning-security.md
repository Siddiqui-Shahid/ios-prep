# Sample 03 — Pinning, ATS, and whitelist (Q&A)

> Guided teaching. Security ladder without collapsing distinct controls.

---

### Q1. What is the security ladder and why not collapse rungs?
**Answer:**

> Rungs: (1) HTTPS only — no cleartext API traffic. (2) ATS baseline — system policy preferring secure connections. (3) Default certificate validation via system trust. (4) Optional **pinning** — extra identity check for high-value traffic. (5) **Domain whitelist** — client only calls approved hosts. **ATS ≠ pinning.** ATS pushes TLS and blocks insecure cleartext; pinning says “among TLS servers, only these SPKI hashes/certs are acceptable for our API hosts.” You can have ATS without pinning; pinning without HTTPS is nonsense.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview trap? | “ATS is our pinning” — wrong; separate layers and failure modes. |
| Ads module why first-party? | Revenue-adjacent high volume; MITM risk; need session delegate ownership (BookMyShow SSL pinning + URLSession migration). |
| Creative CDN URLs vs API hosts? | Whitelist API POST credentials hosts separately from image CDN loads. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q2. What is SPKI pinning and what must you NOT hash?
**Answer:**

> **SPKI** = Subject Public Key Info — the DER-encoded structure inside the X.509 certificate describing the public key. Pin value is commonly `Base64(SHA256(spkiDER))`. Flow: TLS handshake → inspect server cert → extract SPKI DER → hash → compare to embedded allow-list (primary + backup pins). **Wrong:** hash raw bytes from `SecKeyCopyExternalRepresentation` and call it SPKI — that API exports key material in a key-type-specific format, not the SPKI DER blob; it breaks interoperability with standard pin generators.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cert pinning vs SPKI? | Cert pin breaks on reissue even with same key; SPKI survives reissue **only if same key pair reused**. |
| Pin generator alignment? | Ops must hash SPKI DER — same as `openssl dgst` workflows in rotation docs. |
| Forbidden resume claim? | “We hash SecKeyCopyExternalRepresentation as SPKI.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Where does SSL pinning hook in URLSession?
**Answer:**

> Implement `URLSessionDelegate` method `urlSession(_:didReceive:completionHandler:)` for server trust challenges (`NSURLAuthenticationMethodServerTrust`). System presents server trust; you evaluate certificates in the chain; compute pin(s); compare to allow-list; call `completionHandler(.useCredential, credential)` on match or `.cancelAuthenticationChallenge` on mismatch — **fail closed**. At BMS Ads (BookMyShow SSL pinning + URLSession migration), pinning was added on the URLSession stack alongside HTTPS enforcement and domain whitelist after migrating off Alamofire.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debug with Charles? | Only on builds that disable pinning or use debug trust path — never weaken prod casually. |
| Pin mismatch user experience? | Request fails; security metric — don’t silently fall back to unpinned in prod without design. |
| Alamofire pinning? | Possible via session wiring — BookMyShow SSL pinning + URLSession migration moved to first-party delegate ownership. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q4. What is a domain whitelist and why Ads needed it?
**Answer:**

> Central builder validation: if `url.host` is not in `allowedHosts`, throw `hostNotAllowed` **before** the session sends bytes. Even with pinning, a CMS typo or malicious config could point API traffic at unexpected hosts — whitelist reduces misconfig risk. Ads modules face elevated “unexpected URL” pressure from third-party creative ecosystems; **API** hosts still deserve strict allow-lists separate from CDN image loads.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where in pipeline? | RequestBuilder before `session.data(for:)`. |
| Test? | Assert bad host never hits URLProtocol stub. |
| Tie to Day 10? | SDUI action URLs should also respect domain/deeplink policy. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is Design: pin rotation / break-glass (not shipped runbook) and how do you speak pin rotation?
**Answer:**

> **Design: pin rotation / break-glass (not shipped runbook)** is **How I would apply it** — design judgment, not a verified shipped runbook. When interviewers ask “cert rotates?”, answer with **backup pins** (≥2 SPKI hashes), pin set ownership, staged/canary exposure, monitored **break-glass** (build flag or remote config, time-boxed), and fail-closed default. Pinning without rotation thinking is an outage generator when keys change. You shipped pinning on Ads (BookMyShow SSL pinning + URLSession migration); you **design** rotation — don’t claim you shipped the full ops runbook unless verified later.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Script fragment? | “We shipped pinning and whitelist; separately I’d require backup pins and monitored break-glass — I’m not claiming the full ops runbook.” |
| “Did pinning break you?” | Honest: failure mode is outage — that’s why Design: pin rotation / break-glass (not shipped runbook) design matters. |
| Shadow traffic rollout? | Do not claim as BookMyShow SSL pinning + URLSession migration. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q6. How do you test networking security without flaky CI?
**Answer:**

> Protocol-wrap `NetworkSession` with fixture responses; `URLProtocol` subclass for integration-ish tests through real session config; fake `TokenStore` and refresher to drive 401→refresh→retry; assert single refresh under parallel 401s; assert whitelist rejects bad hosts before send; assert cancel doesn’t hit UI error path. For pin failures, confirm your generator hashes **SPKI DER** in unit tests against known fixtures — not raw SecKey export bytes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Staging smoke hits? | Optional; keep secrets out of fixtures. |
| Pin debug step 5? | Confirm pin generator uses SPKI DER per debugging workflow. |
| Observability? | Log path template, status, duration — correlate `X-Request-ID`; p50/p90 not averages (BookMyShow Firebase Performance traces). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What must you never say about BookMyShow SSL pinning + URLSession migration and security together?
**Answer:**

> Do **not** claim: shipped pin-rotation runbook, shadow traffic rollout, “pinning alone fixed crash-free,” “ATS is pinning,” or hashing `SecKeyCopyExternalRepresentation` as SPKI. **Do** claim: Ads migrated Alamofire → URLSession; enforced HTTPS; added SSL pinning; domain whitelist — first-party control on a high-traffic revenue module. Pair with Design: pin rotation / break-glass (not shipped runbook) rotation **design** when pushed on ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Whole app on URLSession? | Risk-based — Ads first where threat/value highest. |
| “Why not keep Alamofire?” | Ownership of pinning/whitelist and smaller dependency surface on that module. |
| Payment retry hook? | BookMyShow payment processing-status popup — no blind POST retry on networking SDK. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration; BookMyShow payment processing-status popup
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Next: [04-production-s4.md](04-production-s4.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is SPKI pinning and what must you NOT hash

**Ask yourself:** What is SPKI pinning and what must you NOT hash?

**Answer:** “**SPKI** = Subject Public Key Info — the DER-encoded structure inside the X.509 certificate describing the public key. Pin value is commonly `Base64(SHA256(spkiDER))`. Flow: TLS handshake → inspect server cert → extract SPKI DER → hash → compare to embedded allow-list (primary + backup pins). **Wrong:** hash raw bytes from `SecKeyCopyExternalRepresentation` and call it SPKI — that API exports key material in a key-type-specific format, not the SPKI DER blob; it breaks interoperability with standard pin generators.”

### Puzzle B — Where does SSL pinning hook in URLSession

**Ask yourself:** Where does SSL pinning hook in URLSession?

**Answer:** “Implement `URLSessionDelegate` method `urlSession(_:didReceive:completionHandler:)` for server trust challenges (`NSURLAuthenticationMethodServerTrust`). System presents server trust; you evaluate certificates in the chain; compute pin(s); compare to allow-list; call `completionHandler(.useCredential, credential)` on match or `.cancelAuthenticationChallenge` on mismatch — **fail closed**. At BMS Ads (BookMyShow SSL pinning + URLSession migration), pinning was added on the URLSession stack alongside HTTPS enforcement and domain whitelist after migrating off Alamofire.”

### Puzzle C — What is a domain whitelist and why Ads needed it

**Ask yourself:** What is a domain whitelist and why Ads needed it?

**Answer:** “Central builder validation: if `url.host` is not in `allowedHosts`, throw `hostNotAllowed` **before** the session sends bytes. Even with pinning, a CMS typo or malicious config could point API traffic at unexpected hosts — whitelist reduces misconfig risk. Ads modules face elevated “unexpected URL” pressure from third-party creative ecosystems; **API** hosts still deserve strict allow-lists separate from CDN image loads.”
