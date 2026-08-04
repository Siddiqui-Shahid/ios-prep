# 04 — Questions + Sample Architecture Answers (two-layer)

> Debrief / proctor style. Cover full answer; speak from points.

---

## Normal questions

### Q1. How do you approach a 3-hour machine round? `(30–45s)`

**Answer points:** Clarify → agenda → vertical slice → second requirement → tests → known gaps · demoability

**Agenda opener:**  
> “Clarify, slice, test, document cuts.”

**Full spoken answer:**  
> “I clarify requirements and assumptions in the first fifteen minutes, say the layer plan aloud, then chase one end-to-end happy path before depth work like cache or a second component. I reserve the last thirty minutes for meaningful unit tests and I document cut lines instead of chasing polish. Graders should see a demoable core.”

**Common wrong answer:**  
> Pixel-perfect UI first.

**Follow-up:** What do you cut first?  
**Provenance:** Learning-lab method

---

### Q2. How do you paginate without duplicates or lost pages? `(45s)`

**Answer points:** Cursor vs page · append-only · in-flight guard · ignore stale responses (generation token)

**Full spoken answer:**  
> “I pick cursor or page explicitly. New pages append; refresh replaces. An in-flight flag or Task prevents double fetch. Each request carries a generation token so late responses from an old refresh can’t append onto new state. Failures on page two keep page one visible.”

**Provenance:** Soft Verified · S3 list UX

---

### Q3. What cache policy did you pick and why? `(30–45s)`

**Answer points:** Name SWR / TTL / memory-only · stale shown · refresh error keeps stale

**Full spoken answer:**  
> “I chose stale-while-revalidate: show last-good memory cache immediately, then refresh. On refresh failure I keep stale and surface a non-blocking error. Price-critical fields would use a short TTL in production — I’ll call that out as a hardening step.”

**Provenance:** Learning-lab · Applied design

---

### Q4. SDUI unknown component — what should happen? `(30–45s)`

**Answer points:** Fallback view · don’t crash · log type · schema version gate · optional skip children

**Full spoken answer:**  
> “The factory switches on type; default returns a PlaceholderView and emits an analytics stub with the unknown type string. Unsupported schemaVersion shows a full-screen upgrade/fallback state instead of partial corruption. Nested unknown children can be skipped while siblings still render.”

**Provenance:** Soft Verified · S3; Applied · S3-A1 shape

---

### Q5. How many tests are enough in 3 hours? `(30–45s)`

**Answer points:** Happy pagination or decode · one failure · one unknown/cache hit · quality over count · AI tests still need review (S9)

**Full spoken answer:**  
> “Three meaningful tests beat forty flaky ones: happy-path pagination or decode, a failure that preserves prior state, and either a cache hit or unknown-type fallback. If AI scaffolds test code, I still review assertions — District lesson.”

**Provenance:** Verified · S9 judgment

---

## Tricky + sample architecture answers

### T1. “Your cache served stale event prices — defend.” `(90–120s)`

**Answer points:** TTL + SWR · price-critical bypass · pull-to-refresh · last-updated · no cross-user cache · 30L hardening note

**Full spoken answer:**  
> “For the machine round I optimized perceived performance with SWR on a generic list. In production at consumer scale I’d classify fields: price and seat availability get short TTL or bypass cache, pull-to-refresh is obvious, UI shows last-updated, and caches are keyed per user/session. Stale generic metadata is acceptable; stale money is not. I’d document that split in the README as the next hardening step.”

**Provenance:** Learning-lab + soft S8/S3 judgment · no fake incident

---

### T2. “Why not generate the whole app with AI?” `(90–120s)`

**Answer points:** Scaffold OK · own architecture/edges/tests · explain every line · District accelerator not author of record

**Full spoken answer:**  
> “AI can scaffold boilerplate, but I own architecture, edge cases, and tests, and I must explain every line to the proctor. Same District rule — accelerator inside a review bar, not author of record.”

**Provenance:** Verified · S9

---

### T3. “You didn’t finish image loading — fail?” `(90–120s)`

**Answer points:** Pre-declared cut line · core works · placeholders · honesty > spiraling

**Full spoken answer:**  
> “Image pipeline was an explicit cut line at minute twenty. Core pagination and cache work; cells use placeholders. In production I’d plug a shared image loader — I’ve owned lifecycle-sensitive media in ads HeroWidget work — but finishing images here would have traded away tests.”

**Provenance:** Soft Verified · S1 media lifecycle nod · learning-lab cuts

---

### T4. “Show concurrency bugs in your pager.” `(90–120s)`

**Answer points:** Request generation id · cancel on refresh · MainActor state · no out-of-order append · S2 high-level

**Full spoken answer:**  
> “ViewModel holds a monotonic requestID. Each fetch captures the id; only matching ids commit. Refresh cancels the in-flight Task. State mutations hop to MainActor. I won’t append page N+1 from a stale task after a reset. That’s the same class of discipline as serializing shared mutable maps — don’t let concurrent writers corrupt state.”

**Provenance:** Soft Verified · S2

---

### Sample architecture card — Brief A (2–3 min spoken)

**Answer points:** layers · fake repo first · SWR · pagination guards · 3 tests · cut lines

**Full spoken answer:**  
> “I’ll use SwiftUI List bound to a ListViewModel with explicit loading, empty, and error. The ViewModel talks only to a ListRepository protocol. Today the live object composes a stub remote and an in-memory SWR cache so I can demo offline-ish revisit. Pagination uses page index with an in-flight guard and a generation token. Tests cover append page two, failed page two keeping page one, and cache hit returning stale before refresh. Cut lines: images, Diffable animations, disk codec, auth.”

### Sample architecture card — Brief B (2–3 min spoken)

**Answer points:** Codable document · schemaVersion · factory · 3 types · fallback · nested stack · tests

**Full spoken answer:**  
> “JSON decodes into SDUIDocument with schemaVersion. A factory maps type strings to an enum of text, image, and vstack. Renderer walks nodes recursively for children. Unknown types become PlaceholderView plus a log stub. Old schema versions fail closed to a safe screen. Tests decode a fixture, assert three component types, and assert unknown type doesn’t throw. Cut lines: actions DSL, live reload, expression binding.”

---

## Suggested record set

Q1, Q2, Q4 + T1, T4 + one sample architecture card for your chosen brief.


---

## Additional two-layer prompts

### Q6. Cursor vs page number pagination — pick one `(45s)`

**Answer points:** Cursor stable under inserts · Page simpler stub · Say assumption

**Full spoken answer:**  
> “For production lists that churn, I prefer opaque cursors so inserts don’t shift pages. In a three-hour stub, page numbers are fine if I say the assumption and still guard in-flight and stale responses. I’ll note cursor migration as a hardening step.”

**Provenance:** Learning-lab

---

### Q7. Where does caching live — ViewModel or Repository? `(45s)`

**Answer points:** Repository owns cache policy · VM owns UI state · testable seam

**Full spoken answer:**  
> “I keep cache policy in the repository so the ViewModel stays about UI state and pagination intent. That makes repository tests cover SWR without spinning up views, and matches Clean/MVVM seams I used in migrations.”

**Provenance:** Soft Verified · S9

---

### T5. “Proctor asks you to add auth mid-round.” `(90s)`

**Answer points:** Acknowledge · park behind protocol · don’t derail slice · document

**Full spoken answer:**  
> “I’d introduce an AuthProviding dependency on the remote data source, stub a static token now, and document real refresh as out of scope. I won’t rebuild the pager to chase auth unless the brief made it acceptance-critical.”

**Provenance:** Learning-lab honesty
