# Sample 03 — Keychain & secrets (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Keychain vs UserDefaults — when which?

**Points to:** [Foundations · §4 Keychain vs UserDefaults](../01-foundations.md#4-keychain-vs-userdefaults-zoom) · [Foundations · §3 Hard rules](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this)

**Answer:**

> **Keychain:** tokens, secrets, cryptographic keys — protected by system ACLs.  
> **UserDefaults:** theme, flags, non-sensitive preferences — essentially plaintext plist.  
> **Hard rule:** **Tokens ≠ UserDefaults.** Plist backups and jailbreak tooling expose UD; Keychain is the correct store for auth material.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Speed difference? | Keychain slightly slower; still ms-class — irrelevant for tokens. |
| “Base64 in UserDefaults”? | **Obfuscation, not security.** Move to Keychain; rotate if exposed. |
| Dark mode flag? | UserDefaults — correct pairing. |

---

### Q2. Where do access and refresh tokens live?

**Points to:** [Deep dive · §5 Auth & biometric](../02-deep-dive.md#5-auth--biometric-client-lens)

**Answer:**

> **Refresh token:** **Keychain only**; typically `synchronizable = false` for auth tokens.  
> **Access token:** short-lived; memory + Keychain as needed for relaunch.  
> **Logout:** clear Keychain locally **and** server revoke. Never stash either token in UserDefaults “for convenience.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why disable iCloud sync for auth? | Cross-device token leakage and unexpected restore behavior. |
| Refresh races? | Single-flight actor (Day 09) — linked, not primary security day topic. |
| PII in UD? | Same rule — sensitive data belongs in Keychain or encrypted stores. |

---

### Q3. What Keychain accessibility should you mention?

**Points to:** [Foundations · §3 Full persistence tree](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this) · [Foundations · §4](../01-foundations.md#4-keychain-vs-userdefaults-zoom)

**Answer:**

> Common choice: **`kSecAttrAccessibleAfterFirstUnlock`** — available after first device unlock post-reboot. Stricter options when threat model requires (e.g. passcode-gated). Match accessibility to UX: background refresh vs maximum lockdown. Keys wrapping encrypted DBs also live in Keychain/SEP.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When stricter than AfterFirstUnlock? | High-value secrets, enterprise policy, step-up auth flows. |
| Biometric templates in app? | **No** — Face ID unlocks Keychain items via LocalAuthentication; you don’t store templates. |
| Migration pain? | Keychain entitlements and item migration — plan app updates carefully. |

---

### Q4. How do biometrics fit the auth model?

**Points to:** [Deep dive · §5 Auth & biometric](../02-deep-dive.md#5-auth--biometric-client-lens) · [Foundations · §4](../01-foundations.md#4-keychain-vs-userdefaults-zoom)

**Answer:**

> Biometrics are **step-up / unlock Keychain item** — not primary identity by themselves. Pattern: `LocalAuthentication` + `SecAccessControl` on a Keychain item. User still has server-side session/token model. Don’t claim you “store Face ID in the app.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| App Attest / DeviceCheck? | Integrity signals for high-risk actions — mention, don’t overclaim shipped. |
| Biometric bypass on jailbreak? | Client checks are bypassable — defense in depth only. |
| Payments sole control? | Never client-only — server attestation when in scope. |

---

### Q5. What goes wrong if tokens sit in UserDefaults?

**Points to:** [Deep dive · §9 Failure modes](../02-deep-dive.md#9-failure-modes) · [Foundations · §3 Hard rules](../01-foundations.md#3-full-persistence-decision-tree-embedded--recite-this)

**Answer:**

> Tokens in UserDefaults are readable from plist backups, debugging, and many jailbreak scenarios. Interview line: “UD ‘encrypted’ token” → move to Keychain and rotate. This is a **P0 security fix**, not a style preference. Same chapter forbids inventing that BMS stored prod tokens in UD unless verified.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| NSUserDefaults in iCloud backup? | Backups may include prefs — another exposure path. |
| Keychain on simulator vs device? | Behavior differs; test on device for auth flows. |
| NSCache for tokens? | **Wrong** — evictable, not secret store. |

---

### Q6. How does Keychain fit the networking HLD?

**Points to:** [Deep dive · §5](../02-deep-dive.md#5-auth--biometric-client-lens) · [Deep dive · §6 Persistence worked examples](../02-deep-dive.md#6-persistence-tree--worked-examples)

**Answer:**

> In a networking layer diagram: **Token store (Keychain)** sits beside URLSession/cache/reachability. Interceptors read access token from memory/Keychain; refresh writes back to Keychain on success. Features never touch UserDefaults for secrets. Ads URLSession path (S4) assumes this split.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor for refresh + Keychain? | Actor coordinates single-flight; Keychain persists result. |
| Multiple accounts? | Keychain service/account keys per user — design explicitly. |
| Watch/extension sharing? | Access groups — advanced; mention if asked. |

---

### Q7. Keychain teach-back in one breath?

**Points to:** [Foundations · §7 Teach-back](../01-foundations.md#7-teach-back) · [Production bridge · §5 Persistence recite](../03-production-bridge.md#5-persistence-recite-45s-drill)

**Answer:**

> “Secrets, tokens, and keys live in Keychain with appropriate accessibility — never UserDefaults. Prefs and flags live in UserDefaults. Biometrics unlock Keychain items; they aren’t stored in the app. Logout clears Keychain and revokes server-side. End every persistence answer with: **tokens never in UserDefaults.**”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Encrypted SQLite key? | Keychain-wrapped key + SQLCipher when threat model requires. |
| kSecAttrSynchronizable true for auth? | Usually **false** for auth tokens. |
| Next topic? | Full persistence tree — [04-persistence-tree.md](04-persistence-tree.md). |

---

Next: [04-persistence-tree.md](04-persistence-tree.md)
