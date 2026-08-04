# Day 19 — Security: ATS, SSL Pinning, Keychain & Persistence

> Week 3 · Revision twin · Full study: [weeks/week-03/day-19/](../../../weeks/week-03/day-19/)

## 1. Outcome

- ATS ≠ pinning
- **SPKI = SHA-256(Subject Public Key Info DER)** — **not** `SecKeyCopyExternalRepresentation` bytes
- **Verified · S4 only** for shipped: Ads URLSession + HTTPS + pinning + domain whitelist
- **S4-A1** rotation / backup / break-glass = **design**, not shipped runbook claim
- Recite **full persistence decision tree** (below)

## 2. Persistence decision tree (FULL — memorize)

| Use case | Store | Notes |
|---|---|---|
| Structured queries | **SQLite (WAL)** | Off-main writes; concurrent readers |
| Object graph | **Core Data** | Background context writes |
| Secrets / tokens | **Keychain** | AfterFirstUnlock or stricter; no sync for auth |
| Simple prefs | **UserDefaults** | Non-sensitive **only** — never tokens |
| Large media | **FileManager** Caches / App Support | Caches purgeable |
| In-session auto-evict | **NSCache / LRU** | Memory-pressure aware |
| Concurrent in-session | **Actor** / serial queue | Race-free boundary |

## 3. Pinning revision

```text
ATS → system trust → SPKI pin (delegate) → domain allowlist
```

Rotation design (S4-A1): backup pins → ship client before server key rotate → staged → monitored break-glass → fail closed for Ads.

## 4. Map to work

**S4 ≤20s:** “Moved Ads off Alamofire onto URLSession with HTTPS, SSL pinning, and domain allowlisting — and I’d pair pinning with backup pins and break-glass as design.”

## 5. Drill

**N:** Q2 cert vs SPKI · Q4 rotation (label S4-A1) · Q6 persistence split · Q5 Keychain vs UD  
**T:** T1 renew bricked app · T8 Core Data for everything · T2 UD obfuscated token

## 6. Flashcards

| Front | Back |
|---|---|
| SPKI | DER hash · Trap: SecKey raw · Prod: S4 |
| S4 vs S4-A1 | Shipped pins · Design rotation · Trap: runbook claim |
| ATS | Baseline HTTPS · Trap: equals pinning · Prod: no cleartext |
| Tokens | Keychain · Trap: UD/base64 · Prod: auth |
| Tree opener | Sensitivity + access pattern · Trap: one store · Prod: table |

## 7. Timed drill

Q2, Q4, Q6 + T1, T8. Recite 7-row tree once.
