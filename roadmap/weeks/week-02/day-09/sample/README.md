# Day 09 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 09 modules.  
> Use this when you want concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../04-questions.md`](../04-questions.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-networking-layer.md](01-networking-layer.md) | Layer shape, endpoints, interceptors, typed errors | Foundations · Deep dive |
| [02-refresh-and-cancel.md](02-refresh-and-cancel.md) | Single-flight refresh, cancellation, cache split | Deep dive · code |
| [03-pinning-security.md](03-pinning-security.md) | ATS vs pinning, SPKI, whitelist, threat model | Foundations · Deep dive |
| [04-production-s4.md](04-production-s4.md) | Verified S4 Ads migration + S4-A1 design language | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Pipeline | Endpoint → build → intercept → execute → decode → map errors |
| Single-flight | Many concurrent 401s share **one** refresh; retry originals **once** |
| Async cancel | `URLSession.data(for:)` participates in `Task` cancellation |
| Callback cancel | Explicit `task.cancel()` + generation/stale guard |
| ATS ≠ pinning | ATS is HTTPS baseline; pinning is extra identity check |
| SPKI | Hash **SPKI DER** — not raw `SecKeyCopyExternalRepresentation` bytes |
| S4 verified | Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| S4-A1 | Pin rotation / backup pins / break-glass = **design**, not shipped runbook |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 09 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
