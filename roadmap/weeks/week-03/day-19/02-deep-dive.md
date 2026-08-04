# 02 — Deep Dive: Pinning, Rotation Design, Auth Persistence

---

## 1. Where pinning lives on iOS

```text
URLSessionDelegate
  → urlSession(_:didReceive:completionHandler:)
  → server trust challenge
  → evaluate trust + extract leaf/chain cert
  → compute SHA-256(SPKI DER)
  → compare to embedded allowlisted pins for that host
  → succeed or cancel (fail closed for sensitive APIs)
```

**Domain allowlist:** only pin / call hosts you own or tightly control. Don’t pin arbitrary CDNs you don’t operate — operational surprise.

---

## 2. SPKI extraction — correctness deep dive

### 2.1 Right mental model

1. Obtain certificate (SecCertificate)
2. Get **Subject Public Key Info** encoding (**DER**)
3. SHA-256 that DER blob
4. Compare to pinned hashes (often base64 or hex in config)

### 2.2 Common mistake

| Mistake | Why wrong |
|---|---|
| Hash `SecKeyCopyExternalRepresentation` bytes and call it SPKI | External representation is **not** the SPKI structure; pins won’t match real SPKI tooling / browsers |
| Pin leaf certificate DER only | Breaks on routine cert renew even when key unchanged |
| Copy random GitHub gist without verifying DER step | Silent wrong pins → false sense of security or instant outage |

**Interview correction script:**

> “If a snippet hashes SecKeyCopyExternalRepresentation and labels it SPKI, I’d reject it. SPKI pinning hashes the Subject Public Key Info DER from the certificate.”

---

## 3. S4-A1 — Pin ops as **design** (not shipped runbook claim)

When interviewers ask “what happens when cert/key rotates?”:

| Design element | Intent |
|---|---|
| **Backup pins** | Ship ≥2 acceptable SPKI hashes for planned key transition |
| **Ship client before server key rotate** | Never rotate server first against a single old pin |
| **Staged exposure** | Phased release; watch TLS/pin failure metrics |
| **Break-glass** | Monitored, time-boxed emergency path — not “silent forever off” |
| **Fail closed default** | Sensitive Ads/auth/payments: mismatch cancels challenge |

**Script fragment (honesty):**

> “On Ads we shipped pinning and whitelist on URLSession. Separately, as design, I’d require backup pins and a monitored break-glass plan — pinning without rotation thinking is an outage generator. I’m not claiming I shipped that full ops runbook; I’m claiming the control set we owned and the design I’d insist on.”

> **Provenance:** How I would apply it · S4-A1

### 3.1 Hard-fail vs soft-fail

| Mode | When | Risk |
|---|---|---|
| Hard-fail (cancel) | Ads, auth, payments | Outage if rotation weak — fix ops, don’t silent downgrade |
| Soft-fail / report only | Low sensitivity experiments | Silent security regression |

---

## 4. Why leave Alamofire for Ads (S4)

- Own `URLSession` trust challenges end-to-end
- Smaller dependency surface on revenue-adjacent module
- HTTPS + pinning + host allowlist as explicit policy
- Interceptors/refresh still designable on first-party client (Day 09)

---

## 5. Auth & biometric (client lens)

| Topic | Senior line |
|---|---|
| Access token | Short-lived; memory + Keychain as needed |
| Refresh token | **Keychain only**; `synchronizable` false typically |
| Refresh races | Single-flight actor (Day 09) — not security day primary but linked |
| Biometric | Step-up / unlock Keychain item — not primary identity |
| App Attest / DeviceCheck | Integrity for high-risk actions — mention, don’t overclaim shipped |
| Logout | Clear Keychain locally + server revoke |

**Obfuscation trap:** Base64 in UserDefaults is **not** security.

---

## 6. Persistence tree — worked examples

| Need | Choice | Why |
|---|---|---|
| Refresh token + theme + image cache | Keychain + UserDefaults + FileManager Caches (+ NSCache L1) | Sensitivity split |
| Offline feed with queries | SQLite WAL | Explicit SQL + concurrency |
| Complex object graph + CloudKit bias | Core Data | Tooling; still bg writes |
| Session decoded images | NSCache | Memory warnings |
| Shared mutable map | Actor / serial queue | Races (S2 / S2-A1) |
| Encrypted messages DB | SQLCipher + Keychain-wrapped key | Threat model |

**Re-embed full table** (same as foundations — muscle memory):

| Use case | Store | Key config |
|---|---|---|
| Structured queries | SQLite (WAL) | WAL + off-main writes |
| Object graph | Core Data | Background context writes |
| Secrets / tokens | Keychain | AfterFirstUnlock or stricter; no sync for auth |
| Simple prefs | UserDefaults | Non-sensitive only |
| Large media | FileManager Caches / App Support | Purgeable vs durable |
| In-session auto-evict | NSCache / LRU | Cost bounds |
| Concurrent in-session | Actor / serial queue | Isolation boundary |

---

## 7. Jailbreak / attestation (light)

- Client detection is bypassable — defense in depth only
- Never sole control for payments
- Prefer server attestation for high-risk when in scope
- False positives destroy UX — be careful

---

## 8. Trade-offs

| Choice | When | Cost |
|---|---|---|
| System trust only | Low-sensitivity public content | MITM via hostile trust scenarios still a risk |
| SPKI pinning | Payments, ads, auth APIs | Rotation ops burden |
| Backup pins | Production pinning | Must ship before primary rotates |
| Remote pin disable | Break-glass | Attack surface — protect config channel |
| Keychain | Secrets | Entitlement/migration pain |
| UserDefaults | UX prefs | Trivial exposure if misused for secrets |
| Pin all hosts | Never casually | Vendor CDN rotation nightmare |
| SQLCipher | Sensitive DB | Perf/complexity |

---

## 9. Failure modes

| Failure | Senior response |
|---|---|
| Cert renew bricked app | Expected without backup pins — S4-A1 design lesson |
| Wrong SPKI bytes | Audit pin generation pipeline |
| UD “encrypted” token | Move to Keychain; rotate |
| Soft-fail forever | Silent insecure fallback — refuse for Ads |
| Core Data for booleans | Decision tree discipline |

---

## 10. Pin failure incident script (60–90s)

> “Pin failure spike on Ads hosts — confirm with TLS error metrics and domain allowlist hits. Mitigate with staged break-glass only if designed and monitored — never silent forever-off. Ship a build with corrected/backup SPKI hashes generated from DER, not SecKey raw export. Communicate as Sev because revenue path is hard-fail by design. Postmortem: rotation checklist gaps.”

---

## 11. Persistence tree stress drills (embed again)

Recite without notes:

1. Refresh token → **Keychain**  
2. Dark mode flag → **UserDefaults**  
3. Offline orders query → **SQLite WAL**  
4. Ticket PDF user saved → **Application Support** (not Caches)  
5. Poster images session → **NSCache** + **Caches** files  
6. Shared in-flight map → **Actor** / serial queue  
7. Complex graph + tooling → **Core Data** bg writes  

**Wrong pairings to refuse:** token in UD · media in UD · Core Data for two booleans · secrets in NSCache.

---

## 12. Optional citations

- `mobile-security-privacy-engine.md`, `authentication-oauth-biometric.md`, cheatsheet storage tree
- Story S4

Self-contained without opens.
