# Sample 04 — Production S10 Stories SDK (Q&A)

> Guided teaching. Separates **Verified** resume facts from **Learning-lab** demos so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S10?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map) · [§2 S10 STAR](../03-production-bridge.md#2-s10-star-23-min)

**Answer:**

> You designed a **standalone reusable Stories SDK** with a **clear public API** and **isolation from app-specific networking where possible** via injectable boundaries. Drove adoption across **portfolio** apps (Raw / Miami Heat). Result: one implementation leveraged by multiple apps → faster feature parity. Lesson: SDK quality = API surface + versioning + independence from host shortcuts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “I built a reusable Stories SDK — clear public API and host isolation — so multiple NBA/WNBA portfolio apps shared one stories implementation.” |
| Invent install counts? | **Forbidden** — “portfolio” only, no fake N apps. |
| `@Observable` as S10 claim? | Teaching for modern hosts — **not** verified resume API name. |

---

### Q2. What must you never invent for S10?

**Points to:** [Production bridge · §1 Forbidden](../03-production-bridge.md#1-provenance-map) · [§3 Technical beats](../03-production-bridge.md#3-technical-beats-you-may-elaborate-honest)

**Answer:**

> Do not invent exact install counts or latency percentages. Do not claim the SDK hardcodes Kingfisher/Alamofire as verified requirement. Do not conflate S10 with S9 District AI tooling story. Do not claim Observation macros as a resume bullet for S10. Stable page IDs and pause policy are senior **design** beats — label Learning-lab shape if illustrating API sketches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public API shape OK to sketch? | Learning-lab if labeled — entry player, data source, events. |
| Injectable loaders? | Design judgment aligned with “isolation from app networking” — honest. |
| Pause on background? | Lifecycle discipline — cousin to S1; no invented Aces metrics. |

---

### Q3. How should the Stories SDK public API be shaped?

**Points to:** [Deep dive · §7 Public API sketch](../02-deep-dive.md#public-api-sketch) · [Production bridge · §3 Technical beats](../03-production-bridge.md#3-technical-beats-you-may-elaborate-honest)

**Answer:**

> Entry player, **DataSource protocol** (host supplies groups/pages), **ImageLoading / VideoLoading protocols** (injectable), event callbacks (`onOpen`, `onClose`, `onCTA`, `onPage`), theming hooks, versioned module boundary. Host gets callbacks for analytics and navigation — SDK does not hardcode host networking or push tickets VC internally.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not SDK own network? | Hosts differ; testability; verified isolation claim. |
| State machine? | idle → loading → playing ⇄ paused → finished (+ failed/retry). |
| UIKit-only host? | SwiftUI-first + UIHostingController façade for legacy. |

---

### Q4. How do identity and pause policy prove SDK quality?

**Points to:** [Deep dive · §7 Why not hardcode networking](../02-deep-dive.md#why-not-hardcode-networking) · [Foundations · §4 Stories SDK implication](../01-foundations.md#4-identity--the-senior-differentiator)

**Answer:**

> **Stable page IDs** across progress updates — no UUID in body. Progress driven from **model timeline**, not scattered view timers. **Pause on disappear**, scene background, user hold — same lifecycle discipline as HeroWidget (S1 cousin). These are SDK correctness requirements, not optional polish.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Progress desync pushback? | Model timeline + stable identity — not more timers. |
| UUID ids pushback? | Never in body; stable model keys. |
| S13 hybrid host? | Identity/lifecycle sibling — hosting without design fails. |

---

### Q5. How do interviewer pushes map to strong replies?

**Points to:** [Production bridge · §6 Interviewer pushes](../03-production-bridge.md#6-interviewer-pushes)

**Answer:**

> **Copy-paste UI?** Parity + bugfix cost; one SDK. **SDK own network?** Hosts differ; testability; isolation. **SwiftUI-only?** SwiftUI-first + UIKit hosting façade. **Progress desync?** Model timeline + stable identity. **UUID ids?** Never in body; stable model keys.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cross-app reuse challenges? | Theming, analytics hooks, media formats, nav/CTA exits, dependency versions — protocols + defaults. |
| 60s practice? | Portfolio need → SDK API + isolation → reuse → API quality lesson. |
| 3 min practice? | Add state machine, pause, identity, injectable loaders, hybrid note. |

---

### Q6. How does S10 relate to other Week 2 stories?

**Points to:** [Production bridge · §5 Cross-app reuse](../03-production-bridge.md#5-cross-app-reuse-challenges-speak-as-design) · [README · Provenance](../README.md#provenance-reminder)

**Answer:**

> **S13:** hybrid hosts may embed SDK via UIHostingController — identity/lifecycle sibling. **S1:** pause/play lifecycle cousin for media. **S10** is the product proof for modular reusable UI — Day 15 SPM deepens packaging, but S10 is the interview story. Do not merge S10 into S9 AI or invent portfolio metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Environment DI in SDK? | Prefer explicit injectable protocols over host AppModel in Environment. |
| Testing? | XCTest player model primary; UITests golden path open/close. |
| Full questions? | [`../04-questions.md`](../04-questions.md) for timed practice. |

---

Back to: [README.md](README.md)
