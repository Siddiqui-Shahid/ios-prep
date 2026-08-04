# 01 — Foundations: Transport Security & Persistence

---

## 0. North star

**ATS is the floor; pinning is an extra identity check on sensitive hosts; secrets live in Keychain; pick storage from a decision tree — not one tool for everything.**

---

## 1. Transport security stack

```text
ATS (HTTPS / TLS defaults / no cleartext by default)
  → System certificate chain trust
  → Optional Pinning (SPKI hash match in URLSession delegate)
  → Domain allowlist (only call / pin known hosts)
```

| Layer | What it does | What it is not |
|---|---|---|
| **ATS** | Blocks accidental cleartext; modern TLS expectations | MITM-proofing / pinning |
| **System trust** | CA chain validation | App-defined identity pin |
| **Pinning** | Embedded pin must match | A substitute for HTTPS |
| **Allowlist** | Limits hosts you talk to | Global “pin the internet” |

**ATS exceptions** in Info.plist are **debt** — justify (legacy partner) + expiry plan. Never ship “Allow Arbitrary Loads” casually in prod.

---

## 2. Pinning modes (first pass)

| Mode | Pins | Pros | Cons |
|---|---|---|---|
| Certificate (leaf) | Exact cert | Simple | Breaks on routine renew |
| **SPKI / public key** | Key hash | Survives cert reissue **if key reused** | Still need rotation when keys change |

### SPKI correctness (memorize)

```text
SPKI pin = SHA-256( SubjectPublicKeyInfo DER bytes )
```

| Correct | Incorrect |
|---|---|
| Hash SPKI DER from the certificate | Treat `SecKeyCopyExternalRepresentation` raw bytes as SPKI |
| Prefer SPKI over leaf for renew resilience | “Pinning = ATS” |

**Say aloud:** “SPKI is the hash of the Subject Public Key Info DER — not the raw bytes from SecKeyCopyExternalRepresentation. That’s a common sample-code mistake.”

---

## 3. Full persistence decision tree (EMBEDDED — recite this)

> Quote this table in interviews. It lives **in-chapter** so you are not dependent on opening the cheatsheet.

| Use case | Store | Key config / notes |
|---|---|---|
| Structured data, complex queries | **SQLite (WAL)** | `PRAGMA journal_mode=WAL;` concurrent readers + one writer; off main thread |
| Object graph / Apple ecosystem bias | **Core Data** | `NSPersistentContainer`; **background context for writes** |
| Secrets, tokens, keys | **Keychain** | `kSecAttrAccessibleAfterFirstUnlock` (or stricter); prefer `synchronizable = false` for auth tokens |
| Simple preferences / flags | **UserDefaults** | **Non-sensitive only** — never tokens |
| Large binary / media | **FileManager** `/Caches` or `/Application Support` | Caches **purgeable**; user data → Application Support |
| In-session, auto-evict | **NSCache / LRU** | Memory-pressure aware; cost bounds (e.g. image bytes) |
| Concurrent in-session state | **Actor** / serial queue | Race-free shared mutation boundary |

### Hard rules

1. **Tokens ≠ UserDefaults** (plist/backups/jailbreak exposure)
2. PII at rest → encrypt when threat model requires (SQLCipher / file protection; keys in Keychain/SEP)
3. Don’t invent Core Data for three booleans
4. Caches can vanish — never sole source of truth for irreplaceable user data
5. Main thread: no heavy SQLite/Core Data writes

### Recite opener (≤20s)

> “It depends on sensitivity and access pattern — secrets in Keychain, prefs in UserDefaults, media in FileManager, queries in SQLite WAL or Core Data for graphs, NSCache for session images, actors for concurrent in-session state.”

---

## 4. Keychain vs UserDefaults (zoom)

| | Keychain | UserDefaults |
|---|---|---|
| For | Tokens, secrets, keys | Theme, flags, non-sensitive prefs |
| Protection | System keychain item ACLs | Essentially plaintext plist |
| Speed | Slightly slower; still ms-class reads | Fast |
| Sync | Can sync if enabled — **disable** for auth tokens usually | Backups may include |

Biometrics: `LocalAuthentication` + `SecAccessControl` unlocks a Keychain item — you do **not** store Face templates in your app.

---

## 5. BMS production proof (preview)

Migrated Ads **Alamofire → URLSession**; enforced **HTTPS**, **SSL pinning**, **domain whitelisting**.

Pin **rotation / backup / break-glass** → speak as **S4-A1 design**, not Verified shipped runbook.

Full STAR in [`03-production-bridge.md`](03-production-bridge.md).

---

## 6. Glossary

| Term | Meaning |
|---|---|
| ATS | App Transport Security |
| SPKI | Subject Public Key Info |
| MITM | Man-in-the-middle |
| Break-glass | Emergency pin/disable path (must be designed carefully) |
| Allowlist / whitelist | Approved hosts only |
| WAL | Write-Ahead Logging (SQLite) |
| SEP | Secure Enclave Processor |

---

## 7. Teach-back

1. ATS ≠ pinning  
2. SPKI DER hash ≠ SecKey raw export  
3. Full persistence table (7 rows)  
4. S4 shipped vs S4-A1 design  

Next: [`02-deep-dive.md`](02-deep-dive.md).
