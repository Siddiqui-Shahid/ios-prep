# Day 19 — Security: ATS, SSL Pinning, Keychain & Persistence

> Week 3 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-03/day-19.md](../../../revision/weeks/week-03/day-19.md)

## Outcomes

By end of day, without notes, you can:

- Explain **ATS** vs **pinning** (baseline policy ≠ identity pin)
- Implement mental model of **SPKI pinning**: SHA-256 of **Subject Public Key Info DER** — **not** raw `SecKeyCopyExternalRepresentation` bytes
- Deliver **Verified · S4** only for what shipped: Ads **Alamofire → URLSession**, **HTTPS**, **SSL pinning**, **domain whitelist**
- Speak **S4-A1** pin rotation / backup pins / break-glass as **design**, not “I shipped the ops runbook”
- Recite the full **persistence decision tree** (embedded in this chapter)

## How to study

1. [`01-foundations.md`](01-foundations.md) — ATS, Keychain, **full persistence tree**
2. [`02-deep-dive.md`](02-deep-dive.md) — SPKI mechanics, rotation design, auth client lens
3. [`03-production-bridge.md`](03-production-bridge.md) — S4 STAR + S4-A1 honesty
4. [`code/`](code/) — SPKI notes + persistence router sketch
5. [`sample/07-revision-qna.md`](sample/07-revision-qna.md)
6. [`05-exercises.md`](05-exercises.md)
7. Revision twin

## Critical correctness

| Claim | Truth |
|---|---|
| ATS | System HTTPS/TLS baseline — **not** pinning |
| SPKI | Hash of **SPKI DER** |
| `SecKeyCopyExternalRepresentation` | Raw key bytes ≠ SPKI DER — **common sample-code mistake** |
| **S4** Verified | HTTPS + pinning + domain whitelist on Ads URLSession migration |
| **S4-A1** | Rotation / backup / break-glass = **design judgment** |
| Tokens | **Keychain only** — never UserDefaults |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Provenance

| Label | Use |
|---|---|
| **Verified · S4** | Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelisting |
| **How I would apply it · S4-A1** | Pin rotation, backup pins, staged break-glass as design |
| Learning-lab | Code / persistence tree teaching |

## Agenda opener

> “I’ll cover ATS baseline, SPKI pinning with rotation as design, Keychain vs UD, then the full persistence decision tree — closing with the Ads URLSession migration.”
