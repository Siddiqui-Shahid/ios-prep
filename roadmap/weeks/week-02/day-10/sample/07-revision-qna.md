# Sample 07 — Revision Q&A (day-10) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is server-driven UI? `(30–45s)`
**Answer:**

> Server-driven UI means the backend sends a structured schema for layout and content, and the client maps each type to a native SwiftUI or UIKit component through a registry. Actions are allowlisted. It’s not evaluating JavaScript from CMS, and it’s not ‘the whole app is a WebView.’ On BookMyShow we used that approach for a backend-driven main header so content could move faster without waiting on every release.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | BookMyShow’s backend-driven header maps schema nodes to native components via a registry — not a WebView shell. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. Core client components of an SDUI stack? `(45–60s)`
**Answer:**

> I’d describe a pipeline: parse the payload, run a schema version gate, resolve nodes through a ComponentRegistry, handle allowlisted actions, and keep a FallbackEngine for last-known-good or baked defaults. Analytics hooks validate events. The ViewModel owns fetch and cache state; the registry stays a pure mapping layer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Pipeline is parse → schema version gate → ComponentRegistry → allowlisted actions → FallbackEngine for last-known-good. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do you version the schema? `(60s)`
**Answer:**

> I version the schema and have the client declare a max-supported version. Additive fields are ignored by older clients. Breaking changes get a major bump with a dual-publish period. If the payload is too new, I reject to a safe fallback rather than crashing. Capability flags help the server avoid sending unsupported types. On BMS header work I’d insist on that discipline as design even when speaking carefully about what was named in production.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Client declares max-supported schema version; too-new payloads reject to fallback instead of crashing on unknown fields. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. Unknown component arrives in prod — what happens? `(45s)`
**Answer:**

> The registry skips the unknown node, emits a metric with the type name, and continues rendering siblings. We never crash on CMS strings. If skipping leaves a meaningless root — like a blank splash — we engage a hard fallback layout. Skipping without metrics is how broken contracts hide until users complain.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Skip unknown types with a metric and keep siblings; if the root is empty, show a hard fallback layout. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q5. Offline / fetch failure strategy? `(45–60s)`
**Answer:**

> On network or parse failure I show last-known-good from disk if present and within TTL; otherwise a baked native default. Optionally show a stale affordance if product needs honesty. Retry with backoff in the background. For splash specifically, cached content is critical so cold start isn’t held hostage by the network — that’s the Aces mindset.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | On fetch failure prefer last-known-good within TTL, else a baked default — Aces splash must not block cold start on a perfect CMS hit. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How did BMS header SDUI help the business? `(45s)`
**Answer:**

> It let content and layout on the main header iterate faster without waiting on App Store for many changes, behind a generalised protocol-driven client. That’s real product velocity. The limit is honest: new component types still require an app release to register native renderers.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Header content can iterate without App Store for many changes, but new native component types still need a client release. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. SDUI actions security? `(45–60s)`
**Answer:**

> Actions are allowlisted — open deeplink, open URL, refresh module — not arbitrary code. URLs go through domain policy; deeplinks go through the app router. Auth-sensitive actions re-check client-side. Never execute CMS scripts. It’s the same threat mindset as host whitelisting on networking day.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Allowlist actions like open deeplink or refresh; URLs still pass domain policy and never execute CMS scripts. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. When is SDUI a bad idea? `(45s)`
**Answer:**

> SDUI is a poor fit for highly interactive one-off UI, heavy custom animation, or surfaces that rarely change — and it’s dangerous if the team won’t invest in schema QA. Prefer hybrid: CMS slots inside native chrome. Revenue ads video often stays native for lifecycle guarantees — configure placement maybe, don’t SDUI the player.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Keep ad video players native for lifecycle guarantees — SDUI may configure placement, not own AVPlayer pause/play. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. How do analytics work in SDUI? `(45s)`
**Answer:**

> The payload can attach analytics event names and params, but the client validates them and injects common context like screen and app version. I don’t treat CMS as an unchecked PII pipe. Bad event names get dropped or mapped safely.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Validate CMS analytics names and inject screen/app context; drop bad event names rather than treating CMS as a PII pipe. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q10. Cold start + server splash — how do you think about metrics? `(45–60s)`
**Answer:**

> I care about time-to-interactive more than a vanity first-frame number. Splash should read cache quickly, attempt a short network refresh, and fall back to a default if slow. Blocking launch on a perfect CMS response is how you create slow launches. On Aces we made splash server-driven for flexibility and freshness — I won’t invent millisecond claims.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Optimize time-to-interactive: cache-first splash, short refresh window, then default — don’t invent millisecond claims. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q11. How do you test SDUI? `(45–60s)`
**Answer:**

> I use fixture schemas per version, registry unit tests, chaos payloads with unknown types, and snapshots for critical chrome. Contract tests with backend catch drift. UITests cover a few golden paths — not every CMS combination, because that matrix explodes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Fixture schemas, chaos unknown-type payloads, and a few golden-path UITests beat trying to UITest every CMS combination. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q12. SDUI vs feature flags vs A/B? `(45s)`
**Answer:**

> Feature flags toggle code paths. A/B assigns users to variants. SDUI changes layout and content through payloads. They’re often combined: a flag enables an SDUI surface, and CMS or experiment config supplies the variant layout. Don’t conflate the three in an interview.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Flags toggle code paths, A/B assigns users, SDUI supplies layout payloads — often combined, never conflated in an interview. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “What is server-driven UI?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Server-driven UI means the backend sends a structured schema for layout and content, and the client maps each type to a native SwiftUI or UIKit component through a registry. Actions are allowlisted. It’s not evaluating JavaScript from CMS, and it’s not ‘the whole app is a WebView.’ On BookMyShow we used that approach for a backend-driven main header so content could move faster without waiting on every release.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is server-driven UI |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “Core client components of an SDUI stack” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “I’d describe a pipeline: parse the payload, run a schema version gate, resolve nodes through a ComponentRegistry, handle allowlisted actions, and keep a FallbackEngine for last-known-good or baked defaults. Analytics hooks validate events. The ViewModel owns fetch and cache state; the registry stays a pure mapping layer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Core client components of an SDUI stack |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “How do you version the schema”. How do you diagnose? `(60–90s)`
**Answer:**

> “I version the schema and have the client declare a max-supported version. Additive fields are ignored by older clients. Breaking changes get a major bump with a dual-publish period. If the payload is too new, I reject to a safe fallback rather than crashing. Capability flags help the server avoid sending unsupported types. On BMS header work I’d insist on that discipline as design even when speaking carefully about what was named in production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you version the schema |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Unknown component arrives in prod — what happens”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “The registry skips the unknown node, emits a metric with the type name, and continues rendering siblings. We never crash on CMS strings. If skipping leaves a meaningless root — like a blank splash — we engage a hard fallback layout. Skipping without metrics is how broken contracts hide until users complain.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Unknown component arrives in prod — what happens |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “Offline / fetch failure strategy”? `(60–90s)`
**Answer:**

> “On network or parse failure I show last-known-good from disk if present and within TTL; otherwise a baked native default. Optionally show a stale affordance if product needs honesty. Retry with backoff in the background. For splash specifically, cached content is critical so cold start isn’t held hostage by the network — that’s the Aces mindset.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Offline / fetch failure strategy |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “How did BMS header SDUI help the business” and how you’d correct it? `(60–90s)`
**Answer:**

> “It let content and layout on the main header iterate faster without waiting on App Store for many changes, behind a generalised protocol-driven client. That’s real product velocity. The limit is honest: new component types still require an app release to register native renderers.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How did BMS header SDUI help the business |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “SDUI actions security?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Actions are allowlisted — open deeplink, open URL, refresh module — not arbitrary code. URLs go through domain policy; deeplinks go through the app router. Auth-sensitive actions re-check client-side. Never execute CMS scripts. It’s the same threat mindset as host whitelisting on networking day.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | SDUI actions security |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “When is SDUI a bad idea” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “SDUI is a poor fit for highly interactive one-off UI, heavy custom animation, or surfaces that rarely change — and it’s dangerous if the team won’t invest in schema QA. Prefer hybrid: CMS slots inside native chrome. Revenue ads video often stays native for lifecycle guarantees — configure placement maybe, don’t SDUI the player.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | When is SDUI a bad idea |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
