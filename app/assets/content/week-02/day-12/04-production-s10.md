# Sample 04 — Stories SDK (Raw / Miami Heat) (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under Stories SDK (Raw / Miami Heat)?
**Answer:**

> You designed a **standalone reusable Stories SDK** with a **clear public API** and **isolation from app-specific networking where possible** via injectable boundaries. Drove adoption across **portfolio** apps (Raw / Miami Heat). Result: one implementation leveraged by multiple apps → faster feature parity. Lesson: SDK quality = API surface + versioning + independence from host shortcuts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “I built a reusable Stories SDK — clear public API and host isolation — so multiple NBA/WNBA portfolio apps shared one stories implementation.” |
| Invent install counts? | **Forbidden** — “portfolio” only, no fake N apps. |
| `@Observable` as Stories SDK (Raw / Miami Heat) claim? | Teaching for modern hosts — **not** verified resume API name. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What must you never invent for Stories SDK (Raw / Miami Heat)?
**Answer:**

> Do not invent exact install counts or latency percentages. Do not claim the SDK hardcodes Kingfisher/Alamofire as verified requirement. Do not conflate Stories SDK (Raw / Miami Heat) with District Free Parking + Clean/MVVM + AI tooling District AI tooling story. Do not claim Observation macros as a resume bullet for Stories SDK (Raw / Miami Heat). Stable page IDs and pause policy are senior **design** beats — label Learning-lab shape if illustrating API sketches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public API shape OK to sketch? | Learning-lab if labeled — entry player, data source, events. |
| Injectable loaders? | Design judgment aligned with “isolation from app networking” — honest. |
| Pause on background? | Lifecycle discipline — cousin to BookMyShow Ads pipeline + HeroWidget lifecycle; no invented Aces metrics. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. How should the Stories SDK public API be shaped?
**Answer:**

> Entry player, **DataSource protocol** (host supplies groups/pages), **ImageLoading / VideoLoading protocols** (injectable), event callbacks (`onOpen`, `onClose`, `onCTA`, `onPage`), theming hooks, versioned module boundary. Host gets callbacks for analytics and navigation — SDK does not hardcode host networking or push tickets VC internally.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not SDK own network? | Hosts differ; testability; verified isolation claim. |
| State machine? | idle → loading → playing ⇄ paused → finished (+ failed/retry). |
| UIKit-only host? | SwiftUI-first + UIHostingController façade for legacy. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How do identity and pause policy prove SDK quality?
**Answer:**

> **Stable page IDs** across progress updates — no UUID in body. Progress driven from **model timeline**, not scattered view timers. **Pause on disappear**, scene background, user hold — same lifecycle discipline as HeroWidget (BookMyShow Ads pipeline + HeroWidget lifecycle cousin). These are SDK correctness requirements, not optional polish.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Progress desync pushback? | Model timeline + stable identity — not more timers. |
| UUID ids pushback? | Never in body; stable model keys. |
| Hybrid UI / deeplinks hybrid host? | Identity/lifecycle sibling — hosting without design fails. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. How do interviewer pushes map to strong replies?
**Answer:**

> **Copy-paste UI?** Parity + bugfix cost; one SDK. **SDK own network?** Hosts differ; testability; isolation. **SwiftUI-only?** SwiftUI-first + UIKit hosting façade. **Progress desync?** Model timeline + stable identity. **UUID ids?** Never in body; stable model keys.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cross-app reuse challenges? | Theming, analytics hooks, media formats, nav/CTA exits, dependency versions — protocols + defaults. |
| 60s practice? | Portfolio need → SDK API + isolation → reuse → API quality lesson. |
| 3 min practice? | Add state machine, pause, identity, injectable loaders, hybrid note. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How does Stories SDK (Raw / Miami Heat) relate to other Week 2 stories?
**Answer:**

> **Hybrid UI / deeplinks:** hybrid hosts may embed SDK via UIHostingController — identity/lifecycle sibling. **BookMyShow Ads pipeline + HeroWidget lifecycle:** pause/play lifecycle cousin for media. **Stories SDK (Raw / Miami Heat)** is the product proof for modular reusable UI — Day 15 SPM deepens packaging, but Stories SDK (Raw / Miami Heat) is the interview story. Do not merge Stories SDK (Raw / Miami Heat) into District Free Parking + Clean/MVVM + AI tooling AI or invent portfolio metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Environment DI in SDK? | Prefer explicit injectable protocols over host AppModel in Environment. |
| Testing? | XCTest player model primary; UITests golden path open/close. |
| Full questions? | [07-revision-qna.md](07-revision-qna.md) for timed practice. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks; BookMyShow Ads pipeline + HeroWidget lifecycle; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

Back to: [README.md](README.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What must you never invent for Stories SDK (Raw / Miami Heat)

**Ask yourself:** What must you never invent for Stories SDK (Raw / Miami Heat)?

**Answer:** “Do not invent exact install counts or latency percentages. Do not claim the SDK hardcodes Kingfisher/Alamofire as verified requirement. Do not conflate Stories SDK (Raw / Miami Heat) with District Free Parking + Clean/MVVM + AI tooling District AI tooling story. Do not claim Observation macros as a resume bullet for Stories SDK (Raw / Miami Heat). Stable page IDs and pause policy are senior **design** beats — label Learning-lab shape if illustrating API sketches.”

### Puzzle B — How should the Stories SDK public API be shaped

**Ask yourself:** How should the Stories SDK public API be shaped?

**Answer:** “Entry player, **DataSource protocol** (host supplies groups/pages), **ImageLoading / VideoLoading protocols** (injectable), event callbacks (`onOpen`, `onClose`, `onCTA`, `onPage`), theming hooks, versioned module boundary. Host gets callbacks for analytics and navigation — SDK does not hardcode host networking or push tickets VC internally.”

### Puzzle C — How do identity and pause policy prove SDK quality

**Ask yourself:** How do identity and pause policy prove SDK quality?

**Answer:** “**Stable page IDs** across progress updates — no UUID in body. Progress driven from **model timeline**, not scattered view timers. **Pause on disappear**, scene background, user hold — same lifecycle discipline as HeroWidget (BookMyShow Ads pipeline + HeroWidget lifecycle cousin). These are SDK correctness requirements, not optional polish.”
