# Sample 03 — Brief B: SDUI renderer (Q&A)

> Guided teaching. Practice **structure** for the 3hr SDUI brief — unknown fallback is the senior signal.

---

### Q1. What is Brief B asking for?
**Answer:**

> Server-driven UI renderer: JSON document of components (`type`, `props`, optional `children`) → native views. Support ≥**3** types (e.g. `text`, `image`, `button` / `vstack`). Unknown `type` → **safe fallback**. Include `schemaVersion` check. Unit-test decoding + unknown-type fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Clarify at 0:15? | Which 3 types minimum; nested depth; actions on button or display-only. |
| Crash on unknown? | **Never** — placeholder + analytics stub. |
| Cut lines? | CMS tooling, live reload, expression language, Figma parity. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What architecture in 90s?
**Answer:**

> JSON → **SDUIDocument** (Codable, schemaVersion) → **ComponentNode** enum/protocol + **factory** → **SDUIRenderer** → SwiftUI/UIKit. Unknown → PlaceholderView + log stub. Say: “Tests: decode fixture, three types, unknown doesn’t throw. Cut: actions DSL, live reload.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| enum vs protocol? | enum faster in 3 hrs; protocol if extensibility story. |
| Recursive render? | vstack children — DFS-shaped (Day 22 nod). |
| Feature flag? | Optional — default fallback leaf. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Must-have acceptance for Brief B?
**Answer:**

> **(1)** Decode sample JSON. **(2)** Render ≥3 types. **(3)** Unknown type does **not** crash — placeholder + analytics stub. **(4)** Nested children for one container. **(5)** Tests: decoder + factory fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| schemaVersion mismatch? | Fail-soft — fallback document or empty state; say policy. |
| Missing props? | Default values — don’t force-unwrap. |
| Deep nesting? | Optional max-depth guard — design nod to BookMyShow backend-driven header & search/BookMyShow IMOC + crash-free at scale. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q4. Decode + factory — what to whiteboard?
**Answer:**

> `SDUIDocument { schemaVersion, root: ComponentDTO }`. DTO: `type`, `props`, `children`. Factory `switch type` → `.text`, `.image`, `.vstack`, `default: .unknown(type)`. Renderer never force-unwraps. Maps to Day 22 serialize reversibility + Day 24 SDUI versioning instinct.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Props typing? | `[String: String]` interview-simple; say production would typed decode. |
| Unknown analytics? | Stub logger — `unknown_component(type)` event. |
| Codable polymorphism? | DTO + factory simpler than nested enums in 3 hrs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How do unknown components connect to production BookMyShow backend-driven header & search?
**Answer:**

> Backend-driven header/search — unknown CMS component types must **not** crash app. Same fail-soft as Brief B placeholder. ≤20s: “Machine round SDUI slice mirrors shipped instinct: contracts, fallbacks, observable state.” **Do not claim** the 3hr project is BookMyShow production code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Audio streaming + server-driven splash (Aces) splash? | Server-driven schema flexibility + client resilience. |
| schemaVersion? | Like API versioning — reject or degrade gracefully. |
| STAR timing? | Hooks only — full BookMyShow backend-driven header & search on Day 26. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Meaningful tests for Brief B?
**Answer:**

> `test_decodeSampleJSON`, `test_rendersTextImageVStack`, `test_unknownTypeMapsToPlaceholder`, optional `test_schemaVersionMismatch`. Test **decoder + factory** — renderer smoke optional. Unknown path must not throw.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Snapshot tests? | Weak alone — decoding tests pass bar. |
| Fixture JSON in bundle? | Clean pattern for test target. |
| Nested vstack test? | One fixture with children — acceptance #4. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Brief B trade-offs?
**Answer:**

> SwiftUI `AnyView` faster than UIKit factory in 3 hrs — say assumption. Recursive render depth unbounded → mention iterative or max-depth **design**. Actions DSL and live reload are cut lines. Figma pixel parity loses to safe decode + 3 types.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pick B if? | Weaker on SDUI — Day 27 SD prep ROI. |
| Connect Brief A? | List can host SDUI cells — out of scope unless surplus. |
| Debrief? | Sample 04. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [04-debrief-structure.md](04-debrief-structure.md) · or run Brief B in [`../05-exercises.md`](../05-exercises.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What architecture in 90s

**Ask yourself:** What architecture in 90s?

**Answer:** “JSON → **SDUIDocument** (Codable, schemaVersion) → **ComponentNode** enum/protocol + **factory** → **SDUIRenderer** → SwiftUI/UIKit. Unknown → PlaceholderView + log stub. Say: “Tests: decode fixture, three types, unknown doesn’t throw. Cut: actions DSL, live reload.”

### Puzzle B — Must-have acceptance for Brief B

**Ask yourself:** Must-have acceptance for Brief B?

**Answer:** “**(1)** Decode sample JSON. **(2)** Render ≥3 types. **(3)** Unknown type does **not** crash — placeholder + analytics stub. **(4)** Nested children for one container. **(5)** Tests: decoder + factory fallback.”

### Puzzle C — Decode + factory — what to whiteboard

**Ask yourself:** Decode + factory — what to whiteboard?

**Answer:** “`SDUIDocument { schemaVersion, root: ComponentDTO }`. DTO: `type`, `props`, `children`. Factory `switch type` → `.text`, `.image`, `.vstack`, `default: .unknown(type)`. Renderer never force-unwraps. Maps to Day 22 serialize reversibility + Day 24 SDUI versioning instinct.”
