# STAR Story Bank

Practice each story to **2–3 minutes**. Metrics only from your resume. Pick the story by interview topic tags.

---

## Quick picker

| Tag | Story IDs |
|---|---|
| Architecture / POP / Generics | S1, S9, S10 |
| Concurrency / races | S2 |
| SDUI / search | S3, S12 |
| Security / networking | S4 |
| Performance / observability | S5, S8 |
| Product delivery / UX | S6, S7 |
| Incidents / ownership | S8 |
| Migration / AI tooling | S9 |
| SDK / modularity | S10 |
| Real-time | S11 |
| AV / cold start | S12 |
| Hybrid UI / deeplinks | S13 |
| Platform upgrade | S14 |
| On-device AI | S15, S16 |

---

## S1 — Ads module refactor + HeroWidget (BookMyShow)

**Tags:** Architecture, POP, Generics, revenue-critical  
**Use when:** “Tell me about a hard technical project” / design patterns

**Situation/Task (~20s):**  
Highest-revenue Ads module needed a safer, reusable rendering path. Video ads inside a HeroWidget needed correct pause/play with lifecycle.

**Action (~90s):**
1. Refactored rendering around **protocol-oriented** ad component contracts + **generics** for a type-safe pipeline.
2. Built reusable **HeroWidget** with explicit pause/play tied to visibility / VC lifecycle.
3. Kept revenue paths behind clear protocols so new ad types didn’t fork the pipeline.
4. Coordinated with stakeholders on behavior without breaking fill rates.

**Result (~30s):**  
Shipped a maintainable, type-safe ads pipeline; lifecycle-correct video reduced wasted playback and UI glitches on a module that mattered for revenue.

**Lesson (~20s):**  
For revenue-critical UI, prefer POP + generics over inheritance trees; lifecycle is part of the product contract.

**Timed opener:**  
> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”

---

## S2 — Synchronised dictionaries (BookMyShow)

**Tags:** Concurrency, GCD, crash reduction  
**Use when:** Thread safety / race conditions / GCD vs actors

**Situation/Task:**  
Shared async state was hit from multiple queues → data races / intermittent crashes.

**Action:**
1. Introduced **synchronised dictionaries** gated by **GCD serial queues** (and read-write locks where read-heavy).
2. Standardized access API so call sites couldn’t touch raw storage.
3. Validated under concurrency stress and Crashlytics watch.

**Result:**  
Eliminated concurrent-access crashes in that shared state path; pattern reused where mutable maps were shared across async work.

**Lesson:**  
Serialize mutation at the boundary; don’t sprinkle locks ad hoc. Today I’d also evaluate a Swift `actor` for new code.

**Timed opener:**  
> “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.”

---

## S3 — Backend-driven header & search (BookMyShow)

**Tags:** SDUI, MVVM, networking UX  
**Use when:** Server-driven UI / search / debounce

**Situation/Task:**  
Main header needed to be CMS/backend-driven; search needed modern UX (debounce, state) aligned to MVVM.

**Action:**
1. Migrated header to a **generalised, protocol-driven** main-screen implementation.
2. Search: **debouncing**, explicit loading/empty/error state, MVVM binding.
3. Contracted APIs with backend so layout/content could change without app release for many cases.

**Result:**  
Faster content iteration on header; snappier, race-safer search UX.

**Lesson:**  
SDUI needs schema/versioning + client fallbacks — not just “render JSON.”

---

## S4 — SSL pinning + Alamofire → URLSession (BookMyShow)

**Tags:** Security, networking ownership  
**Use when:** MITM / ATS / URLSession design

**Situation/Task:**  
Ads networking stack on Alamofire; need stronger transport security and less dependency surface.

**Action (Verified):**
1. Migrated Ads pod networking to **URLSession**.
2. Enforced **HTTPS**, **SSL pinning**, **domain whitelisting**.

**How I would apply it (S4-A1 — design, not claimed as a shipped runbook):**  
Pin rotation with backup pins, staged rollout, and a controlled break-glass path so cert/key changes do not Sev-1 the app.

**Result:**  
Reduced MITM risk on a sensitive high-traffic module; simpler first-party networking control.

**Lesson:**  
Pinning without a rotation/ops design is incomplete — speak to break-glass as architecture judgment even when the resume only lists pinning + allowlist.

---

## S5 — Firebase Performance traces (BookMyShow)

**Tags:** Observability, performance culture  
**Use when:** How do you measure performance?

**Situation/Task:**  
Needed data-driven latency visibility across listing, checkout, search.

**Action:**
1. Instrumented **Firebase Performance** traces for key journeys.
2. Tracked **p50/p90** (not just averages).
3. Used traces to prioritize optimisation across releases.

**Result:**  
Observability layer for journey latency; conversations with PM/backend shifted from anecdotes to percentiles.

**Lesson:**  
p90 matters more than average for user-perceived jank under load.

---

## S6 — LE Bottom Sheet (BookMyShow)

**Tags:** Product delivery, UX, cross-functional  
**Use when:** Impact / collaboration with PM & Design

**Situation/Task:**  
Users took full-screen navigations for event overview too often.

**Action:**
1. Led **end-to-end** lightweight event-overview bottom sheet.
2. Aligned PM, Design, Backend on **API contracts** and content.
3. Shipped reusable component integrated into high-traffic flows.

**Result:**  
Reduced full-screen navigations for **30%+ of user flows** (resume metric).

**Lesson:**  
Small UI surfaces with clear contracts beat large rewrites for navigation pain.

---

## S7 — Payment processing-time popup (BookMyShow)

**Tags:** Checkout UX, state machine  
**Use when:** Payments / handling uncertainty

**Situation/Task:**  
Checkout delays caused drop-off and support load when users saw no status.

**Action:**
1. Designed lightweight popup for **real-time payment/booking processing status**.
2. Modeled clear states (processing / success / failure / timeout messaging).
3. Coordinated with backend signals for status updates.

**Result:**  
Reduced ambiguity during delays → less drop-off / support friction.

**Lesson:**  
In payments, communication of state is a feature; silent waiting is a bug.

---

## S8 — IMOC + crash-free at scale (BookMyShow)

**Tags:** Incidents, leadership, reliability  
**Use when:** Conflict / production fire / ownership

**Situation/Task:**  
Consumer app at **30+ lakh DAU**; need **99.95%+ crash-free** and fast P0/P1 response.

**Action:**
1. Crashlytics triage + structured crash workflows.
2. As **IMOC**, coordinated iOS, backend, QA for P0/P1 during high-traffic events.
3. Drove mitigations (feature guards, hotfix path, comms).

**Result:**  
Sustained high crash-free sessions; minimised downtime in peak events.

**Lesson:**  
Incident leadership is about clarity of owner, blast radius, and rollback — not hero debugging alone.

---

## S9 — Free Parking + Clean/MVVM + AI tooling (District)

**Tags:** Architecture migration, AI-assisted velocity  
**Use when:** Refactors / how you use AI / Clean Architecture

**Situation/Task:**  
Ship Free Parking billing adjustments; migrate patterns across MVVM and Clean with low regression risk.

**Action:**
1. Delivered Free Parking feature for billing adjustments; on-call production fixes.
2. Used **Context Engineering** (Cursor/Claude/Copilot) to accelerate migration decisions — not to skip design.
3. AI-assisted reviews + XCTest/XCUITest generation; structured logging for debug.

**Result:**  
Feature shipped; architectural migration progressed with velocity **and** review discipline.

**Lesson (critical for interviews):**  
AI accelerates once boundaries/protocols are clear. You still own architecture, tests, and regressions.

**Avoid saying:** “AI wrote the app.”  
**Prefer:** “I used AI inside a strict architectural envelope and review loop.”

---

## S10 — Stories SDK (Raw / Miami Heat)

**Tags:** SDK design, modularity, reuse  
**Use when:** Modularization / reusable frameworks

**Situation/Task:**  
Need Instagram-style fan Stories across client portfolio, not one-off UI.

**Action:**
1. Designed **standalone reusable Stories SDK**.
2. Clear public API, isolation from app-specific networking where possible.
3. Adopted across portfolio apps.

**Result:**  
One implementation leveraged by multiple NBA/WNBA apps → faster feature parity.

**Lesson:**  
SDK quality = API surface + versioning + independence from host app shortcuts.

---

## S11 — Live in-arena scoreboard (Raw / Miami Heat)

**Tags:** Real-time reliability  
**Use when:** Live updates / reliability under flaky networks

**Situation/Task:**  
In-arena live scoreboard must stay trustworthy during games.

**Action:**
1. Owned live updates path for match statistics.
2. Defensive UI for stale/partial data; reconnect / refresh strategy.
3. Prioritized correctness over flashy transitions.

**Result:**  
High-reliability live scoreboard experience for fans in-venue.

**Lesson:**  
Live UI is a state-machine problem; define stale vs live explicitly.

---

## S12 — Audio streaming + server-driven splash (Raw / Las Vegas Aces)

**Tags:** AVFoundation, cold start, SDUI  
**Use when:** Media / startup optimisation

**Situation/Task:**  
Live broadcast audio + slow/inflexible splash.

**Action:**
1. Integrated **audio streaming** for live broadcasts.
2. Revamped splash with **server-driven content** to cut cold-start latency / improve freshness.

**Result:**  
Richer live audio; faster, more flexible cold start content.

**Lesson:**  
Startup path is a product surface — measure time-to-interactive, not just time-to-first-frame vanity.

---

## S13 — SwiftUI↔UIKit + deeplinks + analytics/push (Raw / Memphis Grizzlies)

**Tags:** Hybrid UI, deeplinks, growth stack  
**Use when:** Interop / navigation / lifecycle

**Situation/Task:**  
Production NBA app needing modern UI with existing UIKit, plus growth tooling.

**Action:**
1. Architected key UI with **SwiftUI + UIKit interoperability**.
2. Deep linking + navigation/lifecycle handling.
3. Integrated **Mixpanel** + **Airship** (analytics + push).

**Result:**  
Shipped hybrid UI with production navigation and engagement stack.

**Lesson:**  
Interop costs (identity, lifecycle, hosting) must be designed — not bolted.

---

## S14 — Xcode 15 migration (Raw / Chicago Sky)

**Tags:** Platform upgrade, risk management  
**Use when:** Messy upgrade / zero regression

**Situation/Task:**  
Xcode 15 + SDK/API breakages across TicketMaster and other SDKs.

**Action:**
1. Led migration; catalogued breaking changes.
2. QA-driven **zero-regression checklist**.
3. Fixed deprecated APIs methodically; staged validation.

**Result:**  
Migration completed without regression fire drills.

**Lesson:**  
Upgrades are project-managed risk: inventory → fix → checklist → soak.

---

## S15 — FinTrack on-device RAG / Apple Intelligence (Personal)

**Tags:** On-device AI, privacy  
**Use when:** AI/ML on mobile / privacy-first design

**Situation/Task:**  
Expense tracker must stay local-first; AI coach without cloud LLM dependency.

**Action:**
1. Flutter app + Hive; biometric lock; no cloud sync of financial data.
2. `flutter_native_ai` bridge to **Apple Foundation Models** / Gemini Nano.
3. **BM25 offline RAG** over local spending index + deterministic rule fallback.

**Result:**  
Privacy-first Savings Coach with fail-soft path on unsupported devices; Play Store release ops (Crashlytics, Remote Config, AdMob).

**Lesson:**  
On-device AI = retrieval + fallback strategy, not just model calls.

---

## S16 — GymFlow TFLite MiniLM recommender (Personal)

**Tags:** Edge ML, RAG, fail-soft  
**Use when:** Embeddings / TFLite / hybrid systems

**Situation/Task:**  
Workout recommender without cloud LLM cost/latency/privacy issues.

**Action:**
1. INT8 **MiniLM TFLite** embeddings + WordPiece tokenizer in Dart.
2. Cosine similarity over exercise catalog; trainer routine as RAG context.
3. Fail-soft **TF-IDF** fallback.

**Result:**  
On-device recommendations with graceful degradation.

**Lesson:**  
Always design the “model missing / too slow / thermal” path.

---

## Behavioral quick answers (30–45s variants)

**Conflict:** Use S8 (IMOC) or S6 (cross-functional contracts) — disagreement resolved via data/API contract, not ego.  
**Failure:** Prefer a real miss (pin rotation risk, race you shipped, SDUI fallback gap) + what process changed.  
**Leadership without title:** S1, S6, S10, S14 — end-to-end ownership.  
**Why senior:** Scale (30L DAU), revenue module ownership, SDK reuse, incident coordination, architecture migration judgment.
