# 03 — Production Bridge: Stories SDK (S10)

> Interview stories without overclaiming.

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S10** | Verified | Designed **standalone reusable Stories SDK**; **clear public API**; **isolation from app-specific networking where possible**; adopted across **portfolio** apps (Raw / Miami Heat) |
| **S13** | Verified | Hybrid hosts may embed SDK via hosting — identity/lifecycle sibling |
| **S1** | Verified | Pause/play lifecycle cousin for media |
| Learning-lab | Illustrative | Player model / identity samples |

### Forbidden

- Invented install counts / “N apps” exact beyond “portfolio”
- “SDK hardcodes Kingfisher/Alamofire only” as verified
- Claiming SwiftUI Observation macros as a resume bullet for S10
- Conflating S10 tooling with S9 District AI story

## 2. S10 STAR (2–3 min)

### Opener (~10s)

> “I’ll walk through building a reusable Stories SDK — stable public API and host isolation — so multiple NBA/WNBA apps shared one Instagram-style stories implementation.”

### Situation / Task

Need Instagram-style fan Stories across a client portfolio — not one-off UI per app.

### Action

1. Designed a **standalone reusable Stories SDK**.  
2. Clear **public API**; **isolation from app-specific networking** where possible via injectable boundaries.  
3. Drove adoption across portfolio apps with shared implementation.

### Result

One implementation leveraged by multiple apps → faster feature parity.

### Lesson

SDK quality = API surface + versioning + independence from host app shortcuts. Stable identity/state for pages/progress is part of that quality.

> **Provenance:** Verified · S10 · Raw/Miami Heat · Stories SDK portfolio reuse

## 3. Technical beats you may elaborate (honest)

| Beat | How to speak |
|---|---|
| Public API | Entry player, data source, events — learning-lab shape OK if labeled illustrative |
| Injectable loaders | Design judgment aligned with “isolation from app networking” |
| Pause on background | Lifecycle discipline — cousin to S1; don’t invent Aces metrics |
| Stable page IDs | Senior SwiftUI correctness — teaching + SDK necessity |
| `@Observable` | Teaching for modern hosts; **not** a verified S10 resume API name |

## 4. Interview line ≤20s

> “I built a reusable Stories SDK — clear public API and host isolation — so multiple NBA/WNBA portfolio apps shared one stories implementation.”

## 5. Cross-app reuse challenges (speak as design)

Theming, analytics hooks, media formats, nav/CTA exits, dependency versions — solve with protocols + defaults. Modularization Week 3/Day 15 deepens SPM, but S10 is the product proof.

## 6. Interviewer pushes

| Push | Strong reply |
|---|---|
| “Why not copy-paste UI?” | Parity + bugfix cost; one SDK. |
| “Why not SDK own network?” | Hosts differ; testability; isolation claim. |
| “SwiftUI-only?” | SwiftUI-first + UIKit hosting façade for legacy. |
| “Progress desync?” | Model timeline + stable identity — not more view timers. |
| “UUID ids?” | Never in body; stable model keys. |

## 7. Practice

**60s:** portfolio need → SDK API + isolation → reuse → lesson API quality.  
**3 min:** add state machine, pause policy, identity, injectable image/video, hybrid host note.

## 8. Links

- Code: [code/](code/)
- Questions: [04-questions.md](04-questions.md)
- Revision: [../../../revision/weeks/week-02/day-12.md](../../../revision/weeks/week-02/day-12.md)
- Story: [S10](../../../stories/story-bank.md)#s10--stories-sdk-raw--miami-heat
