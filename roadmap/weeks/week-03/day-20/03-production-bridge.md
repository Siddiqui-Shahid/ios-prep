# 03 — Production Bridge: S13 Grizzlies + BMS CI

## 1. Provenance map

| ID / claim | Label | Exact claim |
|---|---|---|
| **S13** | Verified | Grizzlies: **SwiftUI↔UIKit**; **deeplinks**; **Mixpanel**; **Airship** |
| **BMS CI** | Verified (resume) | **GitHub Actions** automation for build/lint/**TestFlight** |
| **S9** | Verified | AI tooling / Context Engineering judgment — assist ≠ own |
| **S8** | Verified | Soft bridge — pause on CFS during rollout |

### Forbidden

- Invented CTR %, opt-in %, or “zero release incidents”
- Claiming you built Airship itself
- “AI approved the release”

## 2. Verified S13 — STAR (2–3 min)

### Opener

> “I’ll cover hybrid SwiftUI/UIKit navigation on the Grizzlies app with production deeplinks and the Airship/Mixpanel engagement stack.”

### Situation / Task

NBA consumer app needing modern UI atop existing UIKit, plus growth tooling — deeplinks, analytics, push.

### Action

1. Architected key surfaces with **SwiftUI + UIKit interoperability** — hosting/lifecycle designed, not bolted.
2. Deep linking + navigation/lifecycle handling into a coherent routing approach.
3. Integrated **Mixpanel** (analytics) and **Airship** (push/engagement).

### Result

Shipped hybrid UI with production navigation and engagement stack.

### Lesson

Interop costs — identity, lifecycle, hosting — must be designed. Push and Universal Links should share one routing table.

> **Provenance:** Verified · S13 · Raw / Memphis Grizzlies

## 3. Interview lines

**S13 ≤20s:**  
> “On Grizzlies I owned deeplinks and Airship push atop hybrid SwiftUI/UIKit navigation, with Mixpanel for analytics.”

**BMS CI ≤20s:**  
> “At BookMyShow I automated GitHub Actions for build, lint, and TestFlight so releases weren’t a manual ceremony.”

**Combined ≤25s:**  
> “On Grizzlies I shipped deeplinks and Airship on hybrid UI; at BMS I automated GitHub Actions into TestFlight — entrypoints and release trains as one reliability story.”

## 4. AI review breath (S9)

> “We used AI-assisted PR review to catch regressions faster; humans still owned architecture and security calls.”

> **Provenance:** Verified · S9 · judgment
