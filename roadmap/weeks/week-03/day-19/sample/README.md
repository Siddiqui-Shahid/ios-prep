# Day 19 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 19 modules. 
> Use this when you want security and persistence as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../07-revision-qna.md`](../07-revision-qna.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](../01-foundations.md) |
| Deep dive | [02-deep-dive.md](../02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](../03-production-bridge.md) |
| Questions | [07-revision-qna.md](../07-revision-qna.md) |
| Exercises | [05-exercises.md](../05-exercises.md) |
| Code | [code/SPKIPinningNotes.swift](../code/SPKIPinningNotes.swift) · [code/PersistenceDecision.swift](../code/PersistenceDecision.swift) |

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-ats-baseline.md](01-ats-baseline.md) | ATS, transport stack, allowlist, exceptions | Foundations · Deep dive |
| [02-ssl-pinning-spki.md](02-ssl-pinning-spki.md) | SPKI DER, rotation design, S4 vs S4-A1 | Foundations · Deep dive · Production bridge |
| [03-keychain-secrets.md](03-keychain-secrets.md) | Keychain vs UserDefaults, tokens, biometrics | Foundations · Deep dive |
| [04-persistence-tree.md](04-persistence-tree.md) | Full 7-row decision tree + worked examples | Foundations · Deep dive |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Security / pinning | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| ATS | System HTTPS/TLS baseline — **not** pinning |
| SPKI | Hash of **SPKI DER** — not `SecKeyCopyExternalRepresentation` raw bytes |
| **S4** Verified | Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| **S4-A1** | Rotation / backup / break-glass = **design judgment** — not “shipped runbook” |
| Tokens | **Keychain only** — never UserDefaults |
| Persistence | Pick store from sensitivity + access pattern — not one tool for everything |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../07-revision-qna.md`](../07-revision-qna.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 19 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
