# 04 — Questions (two-layer Q&A)

> **12 normal + 8 tricky**. SPKI DER · S4 vs S4-A1 · full persistence tree.

---

## Normal questions

### Q1. What does ATS protect you from? `(30–45s)`

**Answer points:** Accidental cleartext; weak TLS configs; baseline not full MITM defense.

**Full spoken answer:**
> “App Transport Security is the system baseline that prefers HTTPS and blocks cleartext by default, pushing modern TLS configurations. It reduces accidental insecure transport. It is not pinning and it does not make you immune to every MITM scenario — compromised trust stores or hostile enterprise inspection are separate conversations. Exceptions in Info.plist are debt with an expiry plan.”

**Common wrong answer:** “ATS means we’re pinned.”

**Provenance:** Learning-lab

---

### Q2. Certificate pinning vs SPKI pinning? `(30–45s)`

**Answer points:** Leaf breaks on renew; SPKI pins key material; still need rotation when keys change; SPKI = DER hash.

**Full spoken answer:**
> “Leaf certificate pinning breaks when the cert is reissued even if the key is unchanged. SPKI pinning hashes the Subject Public Key Info DER — so it can survive cert renewal when the same key is reused. Keys still change eventually, so you need a rotation design with backup pins. And SPKI means the DER structure hash — not raw SecKeyCopyExternalRepresentation bytes.”

**Provenance:** Verified · S4 · + SPKI teaching

---

### Q3. Where do you implement pinning on iOS? `(30–45s)`

**Answer points:** URLSessionDelegate server trust challenge; evaluate + compare SPKI; domain allowlist.

**Full spoken answer:**
> “In the URLSession delegate authentication challenge for server trust. I evaluate trust, extract the certificate’s SPKI DER, SHA-256 it, and compare against embedded pins for allowlisted hosts. Mismatch cancels the challenge for sensitive Ads or auth traffic. That’s the ownership we wanted when Ads moved onto URLSession.”

**Provenance:** Verified · S4

---

### Q4. Pin rotation strategy? `(45–60s)`

**Answer points:** Ship new pin before server rotate; old+new; break-glass design; monitor fail rates; label S4-A1.

**Full spoken answer:**
> “I’d ship a client build that already contains the new SPKI hash alongside the old one, then rotate the server key, watch pin-failure metrics, and retire the old pin later. I’d design a monitored break-glass path for emergencies. On Ads we shipped pinning and whitelist; this rotation playbook I’m describing as design judgment — S4-A1 — not as a claim I shipped the full ops runbook.”

**Common wrong answer:** “Rotate the server first; clients will catch up.”

**Provenance:** How I would apply it · S4-A1 · (Verified S4 shipped pins)

---

### Q5. Keychain vs UserDefaults? `(30–45s)`

**Answer points:** Secrets→Keychain; prefs→UD; never tokens in UD.

**Full spoken answer:**
> “UserDefaults is for non-sensitive preferences. Tokens, refresh credentials, and keys go in Keychain with appropriate accessibility — often AccessibleAfterFirstUnlock if background refresh matters — and I usually disable iCloud keychain sync for auth tokens. Putting a token in UserDefaults is a security bug, not a shortcut.”

**Provenance:** Learning-lab · auth persistence

---

### Q6. Persist refresh token + theme + image cache — where? `(30–45s)`

**Answer points:** Keychain / UserDefaults / FileManager Caches (+ NSCache); recite tree.

**Full spoken answer:**
> “Refresh token in Keychain, theme in UserDefaults, image files in Caches via FileManager with an NSCache memory layer for the session. That’s the persistence decision tree in miniature — sensitivity and lifetime drive the store, not convenience.”

**Provenance:** Learning-lab · embedded decision tree

---

### Q7. Why domain whitelisting with pinning? `(30–45s)`

**Answer points:** Limit pinned hosts; avoid CDNs you don’t control; reduce surprise failures.

**Full spoken answer:**
> “Allowlisting limits which hosts the client will talk to and which identities we pin. Pinning random third-party hosts you don’t operate is how you inherit their cert rotation pain. On Ads we combined pinning with a domain whitelist so the revenue module only spoke to approved hosts.”

**Provenance:** Verified · S4

---

### Q8. Biometric auth — what is stored? `(30–45s)`

**Answer points:** Not face template; LA unlocks Keychain / confirms presence; policy for passcode fallback.

**Full spoken answer:**
> “The app doesn’t store the user’s face or fingerprint templates. LocalAuthentication confirms presence and can gate Keychain items via access control. Biometrics are a device-owner step-up, not the primary account identity. Fallback to passcode or fail-closed is an explicit product policy for high-risk actions.”

**Provenance:** Learning-lab

---

### Q9. SQLite vs Core Data for offline feed? `(30–45s)`

**Answer points:** SQLite/WAL for explicit control; Core Data for graph+tooling; both off-main writes.

**Full spoken answer:**
> “For an offline feed with explicit queries I’d lean SQLite in WAL mode — concurrent readers, one writer, predictable SQL. Core Data wins when I want an object graph and Apple tooling. Either way, writes stay off the main thread. I wouldn’t drag Core Data in for a handful of preference booleans.”

**Provenance:** Learning-lab · decision tree

---

### Q10. Jailbreak detection — worth it? `(30–45s)`

**Answer points:** Defense-in-depth; bypassable; never sole control; server attestation for high-risk.

**Full spoken answer:**
> “Client jailbreak signals are bypassable, so I treat them as defense-in-depth for high-risk apps, never as the only control. For payments-grade trust I’d rather combine server-side attestation and least privilege than invent a false sense of security from path checks alone — and I’d watch false positives that punish legitimate users.”

**Provenance:** Learning-lab

---

### Q11. Why leave Alamofire for Ads? `(30–45s)`

**Answer points:** Ownership of trust/pinning; smaller dependency; URLSession enough.

**Full spoken answer:**
> “Alamofire is fine for rapid CRUD, but Ads needed first-party ownership of the trust evaluation path — HTTPS, pinning, host allowlist — with a smaller dependency surface. URLSession gave us that control on a high-traffic revenue module. It’s threat-model driven, not ideology against libraries.”

**Provenance:** Verified · S4

---

### Q12. Encrypt local DB — when? `(30–45s)`

**Answer points:** Sensitive PII/finance at rest; SQLCipher or file protect; keys in Keychain/SEP.

**Full spoken answer:**
> “When the threat model says PII or financial data at rest matters — SQLCipher or strong file protection, with keys in Keychain or Secure Enclave–backed protection. I don’t encrypt everything by cargo cult; I match the store to sensitivity using the persistence decision tree.”

**Provenance:** Learning-lab

---

## Tricky questions

### T1. Pinning broke production after cert renew. `(90–120s)`

**Trap:** Blame DevOps only / deny design failure.

**Answer points:** Predictable without backup pins + ship-before-rotate; break-glass + ship new SPKI; incident/comms; S4 shipped pins, rotation = S4-A1 design.

**Full spoken answer:**
> “That’s the predictable failure mode of pinning without backup pins and a ship-before-rotate sequence. I’d mitigate with break-glass if designed, ship a build containing the new SPKI, and treat it as an incident with comms. The lesson I cite from Ads work: we shipped pinning for MITM resistance, and rotation thinking has to be part of the design — which I frame as S4-A1 design judgment, not theater that I personally ran every ops runbook.”

**Provenance:** Verified · S4 · + S4-A1 design

---

### T2. UserDefaults for “obfuscated” token. `(90–120s)`

**Trap:** Base64 as security.

**Answer points:** Obfuscation ≠ protection; UD in plists/backups; move to Keychain; rotate + lint against UD secrets; Base64 = encoding.

**Full spoken answer:**
> “Obfuscation isn’t protection. UserDefaults lands in plists and backups; jailbroken or forensic access reads it trivially. Move tokens to Keychain, shorten access-token lifetime, rotate what leaked, and add review lint against UD secret keys. Base64 is encoding, not encryption.”

**Provenance:** Learning-lab

---

### T3. Pin all hosts including analytics. `(90–120s)`

**Trap:** Pin everything.

**Answer points:** Vendor rotation pain; pin owned critical surfaces + allowlist; commodity analytics on system trust unless threat model says otherwise; Ads whitelist = scoped.

**Full spoken answer:**
> “That’s an operational nightmare. Vendor endpoints rotate unpredictably. I pin critical surfaces we own — auth, payments, Ads APIs — with an allowlist, and leave commodity analytics on normal system trust unless there’s a specific threat model. BMS Ads whitelist was about scoped control, not pinning the universe.”

**Provenance:** Verified · S4 · judgment

---

### T4. MITM on public Wi-Fi — ATS alone enough? `(90–120s)`

**Trap:** Yes.

**Answer points:** ATS = config hygiene, not full MITM story; hostile/atypical trust still matter; pinning checks SPKI beyond “some CA”; avoid-Wi-Fi ≠ eng control.

**Full spoken answer:**
> “ATS helps configuration hygiene but isn’t a complete MITM story. Hostile networks plus compromised or atypical trust scenarios still matter for sensitive APIs. Pinning raises the bar for Ads and auth by checking SPKI identity beyond ‘some trusted CA signed this.’ Telling users to avoid public Wi-Fi is not an engineering control.”

**Provenance:** Verified · S4 · threat model

---

### T5. OAuth tokens in a modular app? `(90–120s)`

**Trap:** Feature modules stash tokens in UD.

**Answer points:** Auth module owns Keychain; TokenProviding protocol; single-flight refresh; modules never UD for secrets.

**Full spoken answer:**
> “A core Auth module owns Keychain. Features depend on a TokenProviding protocol. Refresh is single-flight so concurrent 401s don’t stampede. Modules never reach into UserDefaults for secrets. That’s Day 09 networking plus Day 15 modular boundaries meeting Day 19 persistence rules.”

**Provenance:** Learning-lab · architecture

---

### T6. Face ID fails → unlock secrets anyway? `(90–120s)`

**Trap:** Silent insecure fallback.

**Answer points:** Explicit policy; high-risk → fail-closed or passcode; never silent unlock on biometric error; log without PII.

**Full spoken answer:**
> “Policy must be explicit. For high-risk actions I may fail closed or require passcode fallback — never silently unlock secrets because biometrics erred. Log carefully without PII. Biometrics gate Keychain items; they don’t justify weakening storage.”

**Provenance:** Learning-lab

---

### T7. Pinning hard-fail vs crash-free pressure. `(90–120s)`

**Trap:** Always soft-fail to protect CFS vanity.

**Answer points:** Soft-fail → insecure transport risk; hard-fail on Ads/payments mismatch; invest in rotation so rare; mass fails = incident, not quiet CFS protect.

**Full spoken answer:**
> “Soft-fail can silently degrade to insecure transport. For Ads and payments I prefer hard-fail on pin mismatch, and I invest in rotation design so hard-fail is rare. Mass pin failures become an IMOC-style incident — mitigate with break-glass design and a fixed pin build — not a quiet security regression to keep a dashboard green.”

**Provenance:** S4 · S4-A1 · S8 crossover judgment

---

### T8. “Just use Core Data for everything.” `(90–120s)`

**Trap:** One store to rule them all.

**Answer points:** Walk persistence tree; prefs/secrets/media/queries differ; CD for 3 booleans = overkill; UD tokens = bug; sensitivity + access pattern.

**Full spoken answer:**
> “I’d walk the persistence decision tree. Prefs, secrets, media, and query workloads differ. Core Data for three booleans is complexity without benefit; UserDefaults for tokens is a security bug; SQLite WAL shines for explicit offline queries. Wrong store creates security or complexity failures. Sensitivity plus access pattern — not ideology.”

**Provenance:** Learning-lab · embedded tree

---

---

### Extra spoken — Recite the persistence tree `(45–60s)`

**Answer points:** Walk all 7 rows; end with tokens≠UD.

**Full spoken answer:**
> “Storage follows sensitivity and access pattern. Secrets and tokens go in Keychain with appropriate accessibility. Simple non-sensitive preferences go in UserDefaults — never tokens. Structured offline queries use SQLite in WAL mode off the main thread. Object graphs with Apple tooling lean Core Data with background writes. Large media uses FileManager — Caches if purgeable, Application Support if durable user data. In-session images use NSCache or an LRU. Concurrent in-session mutable state uses an actor or serial queue. I refuse one-store-for-everything answers.”

**Provenance:** Learning-lab · in-chapter decision tree

---

### Extra spoken — SPKI vs SecKey one-liner `(20s)`

**Answer points:** SPKI = Subject Public Key Info DER hash; ≠ SecKeyCopyExternalRepresentation bytes.

**Full spoken answer:**
> “SPKI pinning hashes the Subject Public Key Info DER from the certificate. Hashing SecKeyCopyExternalRepresentation bytes and calling it SPKI is a common mistake — those aren’t the same bytes.”

---

## Timed set

**Q2, Q4, Q6** + **T1, T8**. Add persistence-tree recite. S4 STAR ≤3 min.  
Log: UD tokens, cert-only pins, SecKey-as-SPKI, rotation as Verified runbook slip.
