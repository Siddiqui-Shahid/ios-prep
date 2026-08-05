# Sample 03 — Pinning, ATS, and whitelist (Q&A)

> Guided teaching. Security ladder without collapsing distinct controls.

---

### Q1. What is the security ladder and why not collapse rungs?

**Points to:** [Foundations · §10 Security ladder](../01-foundations.md#10-security-ladder-do-not-collapse-these) · [Deep dive · §8.3 ATS vs pinning](../02-deep-dive.md#83-ats-vs-pinning-again-with-ops)

**Answer:**

> Rungs: (1) HTTPS only — no cleartext API traffic. (2) ATS baseline — system policy preferring secure connections. (3) Default certificate validation via system trust. (4) Optional **pinning** — extra identity check for high-value traffic. (5) **Domain whitelist** — client only calls approved hosts. **ATS ≠ pinning.** ATS pushes TLS and blocks insecure cleartext; pinning says “among TLS servers, only these SPKI hashes/certs are acceptable for our API hosts.” You can have ATS without pinning; pinning without HTTPS is nonsense.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview trap? | “ATS is our pinning” — wrong; separate layers and failure modes. |
| Ads module why first-party? | Revenue-adjacent high volume; MITM risk; need session delegate ownership (S4). |
| Creative CDN URLs vs API hosts? | Whitelist API POST credentials hosts separately from image CDN loads. |

---

### Q2. What is SPKI pinning and what must you NOT hash?

**Points to:** [Foundations · §11 SPKI](../01-foundations.md#11-spki-in-one-honest-paragraph) · [Deep dive · §8.2 SPKI correctly](../02-deep-dive.md#82-spki-correctly)

**Answer:**

> **SPKI** = Subject Public Key Info — the DER-encoded structure inside the X.509 certificate describing the public key. Pin value is commonly `Base64(SHA256(spkiDER))`. Flow: TLS handshake → inspect server cert → extract SPKI DER → hash → compare to embedded allow-list (primary + backup pins). **Wrong:** hash raw bytes from `SecKeyCopyExternalRepresentation` and call it SPKI — that API exports key material in a key-type-specific format, not the SPKI DER blob; it breaks interoperability with standard pin generators.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cert pinning vs SPKI? | Cert pin breaks on reissue even with same key; SPKI survives reissue **only if same key pair reused**. |
| Pin generator alignment? | Ops must hash SPKI DER — same as `openssl dgst` workflows in rotation docs. |
| Forbidden resume claim? | “We hash SecKeyCopyExternalRepresentation as SPKI.” |

---

### Q3. Where does SSL pinning hook in URLSession?

**Points to:** [Deep dive · §8.1 Where it hooks](../02-deep-dive.md#81-where-it-hooks) · [Production bridge · §2 Verified S4](../03-production-bridge.md#2-verified-s4--star-you-can-deliver-23-min)

**Answer:**

> Implement `URLSessionDelegate` method `urlSession(_:didReceive:completionHandler:)` for server trust challenges (`NSURLAuthenticationMethodServerTrust`). System presents server trust; you evaluate certificates in the chain; compute pin(s); compare to allow-list; call `completionHandler(.useCredential, credential)` on match or `.cancelAuthenticationChallenge` on mismatch — **fail closed**. At BMS Ads (S4), pinning was added on the URLSession stack alongside HTTPS enforcement and domain whitelist after migrating off Alamofire.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debug with Charles? | Only on builds that disable pinning or use debug trust path — never weaken prod casually. |
| Pin mismatch user experience? | Request fails; security metric — don’t silently fall back to unpinned in prod without design. |
| Alamofire pinning? | Possible via session wiring — S4 moved to first-party delegate ownership. |

---

### Q4. What is a domain whitelist and why Ads needed it?

**Points to:** [Deep dive · §8.4 Domain whitelist](../02-deep-dive.md#84-domain-whitelist) · [Production bridge · §7 Threat model](../03-production-bridge.md#7-threat-model-for-ads-short)

**Answer:**

> Central builder validation: if `url.host` is not in `allowedHosts`, throw `hostNotAllowed` **before** the session sends bytes. Even with pinning, a CMS typo or malicious config could point API traffic at unexpected hosts — whitelist reduces misconfig risk. Ads modules face elevated “unexpected URL” pressure from third-party creative ecosystems; **API** hosts still deserve strict allow-lists separate from CDN image loads.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where in pipeline? | RequestBuilder before `session.data(for:)`. |
| Test? | Assert bad host never hits URLProtocol stub. |
| Tie to Day 10? | SDUI action URLs should also respect domain/deeplink policy. |

---

### Q5. What is S4-A1 and how do you speak pin rotation?

**Points to:** [Production bridge · §3 S4-A1](../03-production-bridge.md#3-s4-a1--pin-ops-as-design-speak-carefully) · [Deep dive · §8.3 ATS vs pinning ops](../02-deep-dive.md#83-ats-vs-pinning-again-with-ops)

**Answer:**

> **S4-A1** is **How I would apply it** — design judgment, not a verified shipped runbook. When interviewers ask “cert rotates?”, answer with **backup pins** (≥2 SPKI hashes), pin set ownership, staged/canary exposure, monitored **break-glass** (build flag or remote config, time-boxed), and fail-closed default. Pinning without rotation thinking is an outage generator when keys change. You shipped pinning on Ads (S4); you **design** rotation — don’t claim you shipped the full ops runbook unless verified later.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Script fragment? | “We shipped pinning and whitelist; separately I’d require backup pins and monitored break-glass — I’m not claiming the full ops runbook.” |
| “Did pinning break you?” | Honest: failure mode is outage — that’s why S4-A1 design matters. |
| Shadow traffic rollout? | Do not claim as Verified S4. |

---

### Q6. How do you test networking security without flaky CI?

**Points to:** [Deep dive · §10 Testing](../02-deep-dive.md#10-testing-without-flaky-ci) · [Deep dive · §14 Debugging workflow](../02-deep-dive.md#14-debugging-workflow)

**Answer:**

> Protocol-wrap `NetworkSession` with fixture responses; `URLProtocol` subclass for integration-ish tests through real session config; fake `TokenStore` and refresher to drive 401→refresh→retry; assert single refresh under parallel 401s; assert whitelist rejects bad hosts before send; assert cancel doesn’t hit UI error path. For pin failures, confirm your generator hashes **SPKI DER** in unit tests against known fixtures — not raw SecKey export bytes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Staging smoke hits? | Optional; keep secrets out of fixtures. |
| Pin debug step 5? | Confirm pin generator uses SPKI DER per debugging workflow. |
| Observability? | Log path template, status, duration — correlate `X-Request-ID`; p50/p90 not averages (S5). |

---

### Q7. What must you never say about S4 and security together?

**Points to:** [Production bridge · §1 Forbidden overclaims](../03-production-bridge.md#1-provenance-map-for-today) · [Production bridge · §9 Common pushes](../03-production-bridge.md#9-common-interviewer-pushes--honest-replies)

**Answer:**

> Do **not** claim: shipped pin-rotation runbook, shadow traffic rollout, “pinning alone fixed crash-free,” “ATS is pinning,” or hashing `SecKeyCopyExternalRepresentation` as SPKI. **Do** claim: Ads migrated Alamofire → URLSession; enforced HTTPS; added SSL pinning; domain whitelist — first-party control on a high-traffic revenue module. Pair with S4-A1 rotation **design** when pushed on ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Whole app on URLSession? | Risk-based — Ads first where threat/value highest. |
| “Why not keep Alamofire?” | Ownership of pinning/whitelist and smaller dependency surface on that module. |
| Payment retry hook? | S7 — no blind POST retry on networking SDK. |

---

Next: [04-production-s4.md](04-production-s4.md)
