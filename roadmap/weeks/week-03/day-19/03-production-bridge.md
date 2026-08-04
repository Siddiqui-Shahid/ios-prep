# 03 — Production Bridge: S4 Pinning + S4-A1 Design

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S4** | Verified | Ads **Alamofire → URLSession**; **HTTPS**; **SSL pinning**; **domain whitelisting** |
| **S4-A1** | How I would apply it | **Pin rotation**, **backup pins**, staged **break-glass** as **design** — not “I shipped the ops runbook” |
| Learning-lab | Illustrative | SPKI notes, persistence router |

### Forbidden

- “I shipped the pin-rotation runbook / break-glass flag to production” as Verified
- “We hash SecKeyCopyExternalRepresentation as SPKI”
- “ATS is our pinning”
- “Pinning alone fixed app-wide CFS”
- Shadow-traffic rollout theater

## 2. Verified S4 — STAR (2–3 min)

### Opener

> “I’ll walk through migrating BookMyShow Ads networking from Alamofire to URLSession so we owned transport security on a revenue-critical module.”

### Situation / Task

Ads on Alamofire; need stronger first-party control — HTTPS, SSL pinning, domain allowlisting — and less dependency surface.

### Action

1. First-party **URLSession** path for Ads networking.
2. Enforced **HTTPS**.
3. **SSL pinning** via session trust evaluation — fail closed on mismatch for pinned hosts.
4. **Domain whitelist** — only approved hosts.
5. Treated pinning incomplete without ops mindset → see S4-A1 as design.

### Result

Reduced MITM exposure on high-traffic Ads module; clearer ownership of trust evaluation.

### Lesson

Pinning without rotation/backup/break-glass **design** creates self-inflicted outages.

> **Provenance:** Verified · S4 · Ads URLSession + HTTPS + pinning + whitelist

## 3. ≤20s line

> “I moved Ads off Alamofire onto URLSession with HTTPS, SSL pinning, and domain allowlisting — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.”

## 4. S4-A1 script (separate breath)

> “Backup pins, ship-before-rotate, staged exposure, monitored break-glass — that’s the design I’d insist on. I’m not claiming I shipped that full runbook; I’m claiming the controls we owned plus the operational design required to keep pinning safe.”

> **Provenance:** How I would apply it · S4-A1

## 5. Persistence recite (45s drill)

Recite the 7-row tree from foundations without notes. End with: “Tokens never in UserDefaults.”
