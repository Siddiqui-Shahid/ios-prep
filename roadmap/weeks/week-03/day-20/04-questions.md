# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

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

### Q7. Outline a mobile CI pipeline. `(45–60s)`

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

### Q11. Secure a `/checkout` deep link. `(30–45s)`

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

## Tricky questions

## Timed set

**Q3, Q7, Q10** + **T1, T5**. Hybrid UI / deeplinks STAR + 45s CI elevator.
