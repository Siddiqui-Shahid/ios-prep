# 03 — Production Bridge: Stories SDK (S10)

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S10** | Verified | Designed standalone reusable Stories SDK; clear public API; isolation from host shortcuts; adopted across portfolio (NBA/WNBA apps); live scoreboard is adjacent Raw ownership but separate story (S11) |
| **S1** | Soft | Ads module POP+Generics — module boundary mindset |
| **S9** | Soft | Clean/MVVM + tests — module testability culture |
| **S4** | Soft | Packaging vs architecture — Ads networking ownership lived behind a module boundary |
| **S13** | Soft | Hosting SDK UI in UIKit hosts |
| Learning-lab | Sketches | `code/` Package + DI |

### Forbidden

- Invented “N apps × M% faster” without evidence  
- “I open-sourced Stories internally as Needle” unless true  
- Collapsing S10 and S11 into one claim carelessly  

## 2. Verified S10 — STAR (2–3 min)

### Opener (~10s)

> “I’ll walk through designing Stories as a standalone SDK so multiple NBA/WNBA apps could share one implementation.”

### S/T (~20s)

Need Instagram-style fan Stories across the client portfolio — not one-off UI per app.

### Action (~90s)

1. Designed a **standalone reusable Stories SDK** with a deliberate public API surface.  
2. Kept **isolation** from app-specific networking shortcuts — hosts inject content/analytics/loaders.  
3. Hid internals; exposed entry points, callbacks, errors.  
4. Drove **adoption across portfolio apps** so feature parity didn’t mean copy-paste.  
5. Treated versioning/API stability as part of quality (lesson).

### Result (~20–30s)

One implementation leveraged by multiple apps → faster feature parity across the portfolio.

### Lesson (~15–20s)

SDK quality = API surface + versioning + independence from host app shortcuts.

> **Provenance:** Verified · S10 · Raw / Miami Heat · Stories SDK portfolio reuse

## 3. Interview line (≤20s)

> “I shipped Stories as a standalone SDK with a clear public API and injected host dependencies — one module, multiple apps, no copy-paste forks.”

## 4. Applied extensions (speak carefully)

| Topic | Line |
|---|---|
| Image loader | Host injects `ImageLoading` so portfolio shares one cache policy (Day 16 bridge) |
| UIKit host | UIHostingController façade; deeplink exits via host router (S13) |
| Theming | Protocolised tokens — don’t hardcode Heat colors in SDK |

> **Provenance:** How I would apply it · extend S10 boundaries (design detail)

## 5. Adjacent hooks

**S1:** Ads as revenue module with POP API — modularization of behavior even if packaging was pod-era.  
**S9:** Independently testable modules; AI stays inside architecture envelope.  
**S4:** Don’t confuse CocoaPods vs SPM with “is the Ads boundary clean?”
