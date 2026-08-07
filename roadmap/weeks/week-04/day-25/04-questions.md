# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. How do you approach a 3-hour machine round? `(30–45s)`

**Answer:**

> I clarify requirements and assumptions in the first fifteen minutes, say the layer plan aloud, then chase one end-to-end happy path before depth work like cache or a second component. I reserve the last thirty minutes for meaningful unit tests and I document cut lines instead of chasing polish. Graders should see a demoable core.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | First fifteen minutes: clarify pagination and cache, sketch Network→Repo→VM→View, then ship the list happy path before deepening cache. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do you paginate without duplicates or lost pages? `(45s)`

**Answer:**

> I pick cursor or page explicitly. New pages append; refresh replaces. An in-flight flag or Task prevents double fetch. Each request carries a generation token so late responses from an old refresh can’t append onto new state. Failures on page two keep page one visible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Bump a generation on refresh; drop a late page-2 response still tagged with gen 1 so it cannot append under gen-2 results. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What cache policy did you pick and why? `(30–45s)`

**Answer:**

> I chose stale-while-revalidate: show last-good memory cache immediately, then refresh. On refresh failure I keep stale and surface a non-blocking error. Price-critical fields would use a short TTL in production — I’ll call that out as a hardening step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Show the last-good movie list immediately, refresh in background, and on a 500 keep stale rows with a toast instead of blanking the UI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. SDUI unknown component — what should happen? `(30–45s)`

**Answer:**

> The factory switches on type; default returns a PlaceholderView and emits an analytics stub with the unknown type string. Unsupported schemaVersion shows a full-screen upgrade/fallback state instead of partial corruption. Nested unknown children can be skipped while siblings still render.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Unknown `type: "PromoCarouselV3"` renders a PlaceholderView and logs the type string instead of crashing the whole header. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How many tests are enough in 3 hours? `(30–45s)`

**Answer:**

> Three meaningful tests beat forty flaky ones: happy-path pagination or decode, a failure that preserves prior state, and either a cache hit or unknown-type fallback. If AI scaffolds test code, I still review assertions — District lesson.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | One test for page append, one for error keeping page 1, one for unknown SDUI type — and still review AI-scaffolded assertions before trusting them. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

## Tricky + sample architecture answers

## Suggested record set

## Additional two-layer prompts

### Q6. Cursor vs page number pagination — pick one `(45s)`

**Answer:**

> For production lists that churn, I prefer opaque cursors so inserts don’t shift pages. In a three-hour stub, page numbers are fine if I say the assumption and still guard in-flight and stale responses. I’ll note cursor migration as a hardening step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Prefer opaque cursors when the feed inserts live; page numbers are fine in a three-hour stub if you still guard in-flight and stale responses. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Where does caching live — ViewModel or Repository? `(45s)`

**Answer:**

> I keep cache policy in the repository so the ViewModel stays about UI state and pagination intent. That makes repository tests cover SWR without spinning up views, and matches Clean/MVVM seams I used in migrations.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Keep SWR memory cache in the repository so ViewModel only calls `loadNextPage()`/`refresh()` and cache tests don’t need SwiftUI. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

