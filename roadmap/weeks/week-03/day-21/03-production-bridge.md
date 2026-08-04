# 03 — Production Bridge: Which Story for Which Prompt

## 1. Prompt A — SDUI

| Story | Use |
|---|---|
| **S3** | Backend-driven header; search debounce/MVVM — primary SDUI proof |
| **S12** | Server-driven splash / cold-start product surface |
| **S6** | Optional: lightweight LE sheet for 30%+ flows — product UX, not whole engine |
| **S3-A1** | Applied: schema versioning + unknown-component fallback design |

**≤20s grounding line:**  
> “I’ll ground this in patterns I’ve shipped — protocol-driven backend header/search and server-driven splash — then generalise the engine cleanly.”

## 2. Prompt B — Networking + pinning

| Story | Use |
|---|---|
| **S4** | Alamofire → URLSession; HTTPS; pinning; domain whitelist |
| **S4-A1** | Rotation/backup/break-glass as **design** |
| **S5** | Firebase Performance p50/p90 journeys |
| **S2** | Only if token/shared-map races — **path-scoped**, not sole CFS |

**≤20s grounding line:**  
> “I’ll ground this in Ads URLSession ownership with HTTPS, pinning, and allowlisting — plus percentile latency culture — then generalise the client.”

## 3. Ops vocabulary (both)

- **30L+ DAU** scale context  
- **99.95%+ CFS** + IMOC pause (S8)  
- Journey **p50/p90** (S5)  
- Never fabricate QPS or drop-off %

## 4. Forbidden mash-ups

| Slip | Fix |
|---|---|
| S2 caused CFS | Contributor only |
| S4-A1 “we shipped runbook” | Design label |
| SecKey = SPKI | DER hash |
| Averages only in ops | Percentiles |
