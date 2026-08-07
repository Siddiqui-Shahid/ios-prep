# Day 19 — Security: ATS, SSL Pinning, Keychain & Persistence

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-19/](../../../weeks/week-03/day-19/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-19/sample/](../../../weeks/week-03/day-19/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- **ATS** vs **pinning** — baseline HTTPS/TLS policy ≠ identity pin
- **SPKI pinning** mental model: SHA-256 of **Subject Public Key Info DER** — not raw `SecKeyCopyExternalRepresentation` bytes
- **BookMyShow SSL pinning + URLSession migration:** Ads **Alamofire → URLSession**, **HTTPS**, **SSL pinning**, **domain whitelist**
- **Design: pin rotation / break-glass (not shipped runbook)** pin rotation / backup pins / break-glass as **design judgment**, not “shipped runbook”
- Full **persistence decision tree** — pick store from sensitivity + access pattern

## 2. Concept refresh (simple)

### 2.1 ATS vs pinning

**ATS** enforces modern TLS on the system stack. **Pinning** verifies a specific public key or cert — defense-in-depth on top of ATS, not a substitute.

### 2.2 SPKI pinning

Hash the **SPKI DER** bytes from the certificate chain. Common sample-code mistake: hashing raw `SecKeyCopyExternalRepresentation` output — that is **not** SPKI DER.

### 2.3 Secrets and persistence

| Data | Store |
|---|---|
| Tokens, credentials | **Keychain only** — never UserDefaults |
| User prefs, flags | UserDefaults / plist |
| Large offline cache | File system / SQLite |
| Sensitive + sync needed | Keychain with access controls |

Pick the store from **sensitivity + access pattern** — not one tool for everything.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| ATS | System HTTPS/TLS baseline — **not** pinning |
| SPKI | Hash of **SPKI DER** — not `SecKeyCopyExternalRepresentation` raw bytes |
| **BookMyShow SSL pinning + URLSession migration** Verified | Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| **Design: pin rotation / break-glass (not shipped runbook)** | Rotation / backup / break-glass = **design judgment** — not “shipped runbook” |
| Tokens | **Keychain only** — never UserDefaults |
| Persistence | Pick store from sensitivity + access pattern — not one tool for everything |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-19/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-03/day-19/01-foundations.md) | Gaps |
| Deepen | [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) | Pinning in client HLD |
| Drill | [04-questions](../../../weeks/week-03/day-19/04-questions.md) | Timed answers |

## 4. Map to your work

**BookMyShow SSL pinning + URLSession migration:** BookMyShow Ads — migrated **Alamofire → URLSession** with **HTTPS**, **SSL pinning**, and **domain whitelist** on the revenue-critical ads path.  
**Design: pin rotation / break-glass (not shipped runbook):** Pin rotation, backup pins, staged break-glass — **design** you can defend, not a claim you shipped the ops runbook.

**Interview line (≤20s):** “On Ads I moved to URLSession with HTTPS, SPKI pinning, and a domain whitelist — and I treat rotation as a design conversation, not a hand-wavy ‘we pinned it’ answer.”

→ [BookMyShow SSL pinning + URLSession migration SSL Pinning](../../stories/story-bank.md#s4--ssl-pinning--alamofire--urlsession-bookmyshow)

## 5. Flash prompts

1. ATS in one sentence — what it is and isn’t
2. SPKI DER vs SecKey raw bytes — why the difference matters
3. Pinning failure mode — bad rotation vs MITM
4. Domain whitelist — why alongside pinning
5. Token storage — Keychain vs UserDefaults
6. Persistence tree — walk one worked example aloud
7. Biometric-gated secrets — Keychain access pattern
8. BookMyShow SSL pinning + URLSession migration verified scope — what you actually shipped
9. Design: pin rotation / break-glass (not shipped runbook) honesty — design, not runbook claim
10. Pin outage during rollout — mitigate first (link BookMyShow IMOC + crash-free at scale pause)

## 6. Timed drills

| Drill | Budget |
|---|---|
| ATS vs pinning | 45s |
| SPKI pinning mechanics | 60s |
| Persistence decision tree | 90s |
| Keychain vs UD for tokens | 30s |
| Pin rotation design (Design: pin rotation / break-glass (not shipped runbook)) | 90s |
| BookMyShow SSL pinning + URLSession migration ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-03/day-19/sample/) and [04-questions](../../../weeks/week-03/day-19/04-questions.md) answer points.
