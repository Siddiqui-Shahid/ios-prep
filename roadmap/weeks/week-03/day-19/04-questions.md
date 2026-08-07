# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What does ATS protect you from? `(30–45s)`

**Answer:**

> App Transport Security is the system baseline that prefers HTTPS and blocks cleartext by default, pushing modern TLS configurations. It reduces accidental insecure transport. It is not pinning and it does not make you immune to every MITM scenario — compromised trust stores or hostile enterprise inspection are separate conversations. Exceptions in Info.plist are debt with an expiry plan.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is ATS the same as pinning? | No — ATS is the HTTPS/TLS baseline; pinning is an extra MITM defense you implement. |
| What about Info.plist exceptions? | Treat cleartext exceptions as debt with an expiry plan, not permanent product config. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Certificate pinning vs SPKI pinning? `(30–45s)`

**Answer:**

> Leaf certificate pinning breaks when the cert is reissued even if the key is unchanged. SPKI pinning hashes the Subject Public Key Info DER — so it can survive cert renewal when the same key is reused. Keys still change eventually, so you need a rotation design with backup pins. And SPKI means the DER structure hash — not raw SecKeyCopyExternalRepresentation bytes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why does leaf pinning break on renew? | Reissued leaf certs change even when the key is unchanged; SPKI pins the key material instead. |
| What exactly is SPKI? | The SHA-256 of Subject Public Key Info DER — not raw SecKey bytes. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q3. Where do you implement pinning on iOS? `(30–45s)`

**Answer:**

> In the URLSession delegate authentication challenge for server trust. I evaluate trust, extract the certificate’s SPKI DER, SHA-256 it, and compare against embedded pins for allowlisted hosts. Mismatch cancels the challenge for sensitive Ads or auth traffic. That’s the ownership we wanted when Ads moved onto URLSession.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which API surface? | URLSessionDelegate server-trust authentication challenge with evaluate + SPKI compare. |
| What on mismatch? | Cancel the challenge for allowlisted sensitive hosts — fail closed for Ads/auth traffic. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q4. Pin rotation strategy? `(45–60s)`

**Answer:**

> I’d ship a client build that already contains the new SPKI hash alongside the old one, then rotate the server key, watch pin-failure metrics, and retire the old pin later. I’d design a monitored break-glass path for emergencies. On Ads we shipped pinning and whitelist; this rotation playbook I’m describing as design judgment — Design: pin rotation / break-glass (not shipped runbook) — not as a claim I shipped the full ops runbook.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ship order for rotation? | Ship client with old+new pins first, rotate server key, watch failures, then retire the old pin. |
| Break-glass? | Design a monitored emergency path — label pin-rotation runbook as design unless you shipped it. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q5. Keychain vs UserDefaults? `(30–45s)`

**Answer:**

> UserDefaults is for non-sensitive preferences. Tokens, refresh credentials, and keys go in Keychain with appropriate accessibility — often AccessibleAfterFirstUnlock if background refresh matters — and I usually disable iCloud keychain sync for auth tokens. Putting a token in UserDefaults is a security bug, not a shortcut.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where do tokens live? | Keychain with deliberate accessibility; never put auth tokens in UserDefaults. |
| iCloud keychain sync? | Usually disable sync for auth tokens so they don’t roam unexpectedly. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Persist refresh token + theme + image cache — where? `(30–45s)`

**Answer:**

> Refresh token in Keychain, theme in UserDefaults, image files in Caches via FileManager with an NSCache memory layer for the session. That’s the persistence decision tree in miniature — sensitivity and lifetime drive the store, not convenience.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Map the three stores? | Refresh token → Keychain; theme → UserDefaults; image files → Caches (+ NSCache memory). |
| What drives the choice? | Sensitivity and lifetime — not which API is most convenient. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Why domain whitelisting with pinning? `(30–45s)`

**Answer:**

> Allowlisting limits which hosts the client will talk to and which identities we pin. Pinning random third-party hosts you don’t operate is how you inherit their cert rotation pain. On Ads we combined pinning with a domain whitelist so the revenue module only spoke to approved hosts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not pin every host? | You inherit third-party cert rotation pain; allowlist hosts you operate and pin those. |
| Ads module practice? | BookMyShow Ads combined pinning with a domain whitelist for approved hosts only. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q8. Biometric auth — what is stored? `(30–45s)`

**Answer:**

> The app doesn’t store the user’s face or fingerprint templates. LocalAuthentication confirms presence and can gate Keychain items via access control. Biometrics are a device-owner step-up, not the primary account identity. Fallback to passcode or fail-closed is an explicit product policy for high-risk actions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do you store face templates? | No — LocalAuthentication confirms presence and can gate Keychain items via access control. |
| Passcode fallback? | Explicit product policy: passcode fallback or fail-closed for high-risk actions. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. SQLite vs Core Data for offline feed? `(30–45s)`

**Answer:**

> For an offline feed with explicit queries I’d lean SQLite in WAL mode — concurrent readers, one writer, predictable SQL. Core Data wins when I want an object graph and Apple tooling. Either way, writes stay off the main thread. I wouldn’t drag Core Data in for a handful of preference booleans.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When prefer SQLite? | Simple offline feed / keyed blobs with light querying and clear ownership of the schema. |
| When Core Data? | Richer object graph, relationships, and change tracking — not as a default for every cache. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Jailbreak detection — worth it? `(30–45s)`

**Answer:**

> Client jailbreak signals are bypassable, so I treat them as defense-in-depth for high-risk apps, never as the only control. For payments-grade trust I’d rather combine server-side attestation and least privilege than invent a false sense of security from path checks alone — and I’d watch false positives that punish legitimate users.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Worth shipping jailbreak checks? | At best a soft signal; determined attackers bypass it — don’t treat it as real security. |
| What actually protects data? | Keychain, pinning, ATS, and least-privilege storage — not client-side jailbreak flags. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Why leave Alamofire for Ads? `(30–45s)`

**Answer:**

> Alamofire is fine for rapid CRUD, but Ads needed first-party ownership of the trust evaluation path — HTTPS, pinning, host allowlist — with a smaller dependency surface. URLSession gave us that control on a high-traffic revenue module. It’s threat-model driven, not ideology against libraries.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why URLSession for Ads? | Own the stack for pinning, whitelist, and interceptors instead of fighting a third-party client. |
| Was Alamofire always wrong? | No — leave it when you need session ownership for security controls you must implement. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q12. Encrypt local DB — when? `(30–45s)`

**Answer:**

> When the threat model says PII or financial data at rest matters — SQLCipher or strong file protection, with keys in Keychain or Secure Enclave–backed protection. I don’t encrypt everything by cargo cult; I match the store to sensitivity using the persistence decision tree.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When encrypt the DB? | When the store holds PII or tokens at rest and device theft / backup exposure matters. |
| What still isn’t enough? | Encryption without Keychain-backed keys and clear threat model is theater. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Timed set

**Q2, Q4, Q6** + **T1, T8**. Add persistence-tree recite. BookMyShow SSL pinning + URLSession migration STAR ≤3 min.  
Log: UD tokens, cert-only pins, SecKey-as-SPKI, rotation as Verified runbook slip.
