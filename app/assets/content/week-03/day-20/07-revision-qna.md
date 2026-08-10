# Sample 07 — Revision Q&A (day-20) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Universal Links vs custom URL schemes? `(30–45s)`
**Answer:**

> Universal Links use https with an AASA file that associates your domain to your app IDs and paths — stronger against hijacking and better web interop. Custom schemes are easy but other apps can register the same scheme. For consumer apps I prefer Universal Links publicly and keep schemes as legacy fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why prefer Universal Links? | HTTPS identity + AASA association beats custom schemes that any app can claim. |
| When keep a custom scheme? | Legacy interop or fallback when Universal Links aren’t available yet. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What is an AASA file? `(30–45s)`
**Answer:**

> apple-app-site-association is a JSON document served over HTTPS at the well-known path listing application identifiers and path patterns. The OS uses it to decide whether an https link opens your app. CDN caching and Apple’s cache mean AASA mistakes can take a while to clear — so debugging is systematic, not vibes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where does AASA live? | On your HTTPS domain at the well-known path; Apple fetches and caches it. |
| What goes wrong? | Wrong teamID/bundleID paths, CDN misconfig, or stale Apple cache after fixes. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Deep link on cold start — race? `(30–45s)`
**Answer:**

> On cold start the link can arrive before the navigation graph and DI are ready. I enqueue the pending route and flush once the root coordinator is live. If the path is invalid I fall back to home and emit a metric. Routing into a half-built stack is how you get crashes and blank screens.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cold-start race pattern? | Queue the link until auth + root UI are ready, then route once — don’t navigate into a half-built stack. |
| Duplicate delivery? | Dedupe by link id/timestamp so push + UL don’t open the same screen twice. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How do pushes open a screen? `(30–45s)`
**Answer:**

> The notification payload carries a route identifier or URL. On tap I hand that to the same DeepLinkRouter Universal Links use — one table, two entrypoints. That way Airship campaigns and https links can’t drift. Defensive decoding protects crash-free if marketing ships malformed JSON.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Payload shape? | Carry a typed route / deep-link id, not a raw VC class name baked into the payload. |
| Foreground vs cold? | Same router as Universal Links; only the entry point (notification vs UL) differs. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. APNs token lifecycle? `(30–45s)`
**Answer:**

> I register for remote notifications, receive the APNs device token, and upsert it to the provider — Airship or our backend. Tokens change across reinstall and some OS events, so I refresh regularly. When APNs reports unregistered, I invalidate server-side so we don’t fan out to dead tokens forever.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When refresh the token? | On launch and when APNs invalidates; always re-register after reinstall. |
| Where store it? | Send to your backend keyed by user/device; treat rotation as expected, not an error. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Why Airship instead of raw APNs only? `(30–45s)`
**Answer:**

> Airship sits on top of APNs and gives segmentation, automation, and campaign tooling marketing needs. I still understand raw APNs — tokens, priorities, payloads — because vendors don’t remove failure modes. On Grizzlies we integrated Airship for push/engagement alongside Mixpanel for analytics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What does Airship buy? | Audience segmentation, journeys, and ops tooling beyond raw APNs transport. |
| What do you still own? | Token lifecycle, deep-link routing, and permission UX in the app. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Outline a mobile CI pipeline? `(45–60s)`
**Answer:**

> PRs run GitHub Actions for lint, build, and unit tests on macOS runners. Main cuts an archived, signed build uploaded to TestFlight, then phased App Store release. Gates include tests, binary size, dSYM upload, and pause criteria on crash-free or perf regressions. At BookMyShow we automated Actions into TestFlight to remove manual release ceremony.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minimum CI stages? | Build, unit/UI smoke, signing, dSYM upload, and artifact retention per build. |
| Why automate releases? | Removes manual signing/upload variance that caused release-day failures. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What did automation fix vs manual releases? `(30–45s)`
**Answer:**

> Manual trains vary by who remembers signing steps and upload checklists. Actions standardizes build, lint, and TestFlight upload so the path is repeatable. Humans still own rollout judgment and stop criteria — automation removes toil, not responsibility.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What broke manually? | Human error on certificates, missing dSYMs, and inconsistent build numbers. |
| What automation fixed? | Repeatable signed builds with symbol upload baked into the same pipeline. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Feature flags vs release train? `(30–45s)`
**Answer:**

> The release train ships a binary on a cadence. Feature flags decide who sees risky surfaces inside that binary. Together you can pause exposure without waiting solely on App Review. CFS drops at ten percent phased should pause the train — flags and IMOC complete the story.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Flags vs train? | Release train ships binary cadence; flags decouple feature exposure without a new binary. |
| Kill-switch use? | Prefer remote flags for fast mitigation when the risky path is already in production. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q10. Hybrid SwiftUI/UIKit + deeplink footgun? `(30–45s)`
**Answer:**

> Hosting controllers change identity and lifecycle in ways that break naive push/pop assumptions. Deeplinks need a coordinator that owns the real stack across UIKit and SwiftUI islands. On Grizzlies we designed interop deliberately — bolting UIHostingController ad hoc is how deeplinks land on the wrong screen.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid deeplink footgun? | UIKit router and SwiftUI stack disagree on who’s presenting — links land on the wrong host. |
| Mitigation? | Single ownership of navigation: one router, one stack of record for deep links. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q11. Secure a `/checkout` deep link? `(30–45s)`
**Answer:**

> Checkout links must pass an auth gate. The server remains authoritative for cart and price — query parameters never set what you pay. I validate and sanitize params, and I don’t auto-confirm destructive actions from a link alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How secure /checkout? | Require auth, validate signed params, and refuse open redirects into payment without session. |
| Unsigned query params? | Treat as untrusted input — never authorize money movement from a bare deep link alone. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. AI on PRs — how describe? `(30–45s)`
**Answer:**

> AI-assisted review speeds catching obvious regressions and diff noise. Humans still own architecture, security, and product trade-offs. I frame it as Context Engineering and assistive tooling — never ‘the model approved so we shipped.’

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How describe AI on PRs? | Assistive review for nits and patterns — humans still own architecture and security calls. |
| What not to claim? | Don’t claim AI merge bots replace code owners or catch all production risks. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “Universal Links vs custom URL schemes?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Universal Links use https with an AASA file that associates your domain to your app IDs and paths — stronger against hijacking and better web interop. Custom schemes are easy but other apps can register the same scheme. For consumer apps I prefer Universal Links publicly and keep schemes as legacy fallback.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Universal Links vs custom URL schemes |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “What is an AASA file” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “apple-app-site-association is a JSON document served over HTTPS at the well-known path listing application identifiers and path patterns. The OS uses it to decide whether an https link opens your app. CDN caching and Apple’s cache mean AASA mistakes can take a while to clear — so debugging is systematic, not vibes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is an AASA file |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “Deep link on cold start — race”. How do you diagnose? `(60–90s)`
**Answer:**

> “On cold start the link can arrive before the navigation graph and DI are ready. I enqueue the pending route and flush once the root coordinator is live. If the path is invalid I fall back to home and emit a metric. Routing into a half-built stack is how you get crashes and blank screens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Deep link on cold start — race |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “How do pushes open a screen”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “The notification payload carries a route identifier or URL. On tap I hand that to the same DeepLinkRouter Universal Links use — one table, two entrypoints. That way Airship campaigns and https links can’t drift. Defensive decoding protects crash-free if marketing ships malformed JSON.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do pushes open a screen |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “APNs token lifecycle”? `(60–90s)`
**Answer:**

> “I register for remote notifications, receive the APNs device token, and upsert it to the provider — Airship or our backend. Tokens change across reinstall and some OS events, so I refresh regularly. When APNs reports unregistered, I invalidate server-side so we don’t fan out to dead tokens forever.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | APNs token lifecycle |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “Why Airship instead of raw APNs only” and how you’d correct it? `(60–90s)`
**Answer:**

> “Airship sits on top of APNs and gives segmentation, automation, and campaign tooling marketing needs. I still understand raw APNs — tokens, priorities, payloads — because vendors don’t remove failure modes. On Grizzlies we integrated Airship for push/engagement alongside Mixpanel for analytics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why Airship instead of raw APNs only |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Outline a mobile CI pipeline.?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “PRs run GitHub Actions for lint, build, and unit tests on macOS runners. Main cuts an archived, signed build uploaded to TestFlight, then phased App Store release. Gates include tests, binary size, dSYM upload, and pause criteria on crash-free or perf regressions. At BookMyShow we automated Actions into TestFlight to remove manual release ceremony.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Outline a mobile CI pipeline. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “What did automation fix vs manual releases” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Manual trains vary by who remembers signing steps and upload checklists. Actions standardizes build, lint, and TestFlight upload so the path is repeatable. Humans still own rollout judgment and stop criteria — automation removes toil, not responsibility.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What did automation fix vs manual releases |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
