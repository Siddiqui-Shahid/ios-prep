# 04 — Questions (two-layer Q&A)

> **12 normal + 8 tricky**. S13 Airship/deeplinks · BMS Actions→TestFlight.

---

## Normal questions

### Q1. Universal Links vs custom URL schemes? `(30–45s)`

**Answer points:** AASA domain proof vs hijackable schemes; prefer UL for consumer.

**Full spoken answer:**
> “Universal Links use https with an AASA file that associates your domain to your app IDs and paths — stronger against hijacking and better web interop. Custom schemes are easy but other apps can register the same scheme. For consumer apps I prefer Universal Links publicly and keep schemes as legacy fallback.”

**Provenance:** Verified · S13 · deeplinks

---

### Q2. What is an AASA file? `(30–45s)`

**Answer points:** JSON at well-known path; appIDs + paths; HTTPS; cache pitfalls.

**Full spoken answer:**
> “apple-app-site-association is a JSON document served over HTTPS at the well-known path listing application identifiers and path patterns. The OS uses it to decide whether an https link opens your app. CDN caching and Apple’s cache mean AASA mistakes can take a while to clear — so debugging is systematic, not vibes.”

**Provenance:** Learning-lab

---

### Q3. Deep link on cold start — race? `(30–45s)`

**Answer points:** Queue until coordinator/DI ready; then route; fallback home.

**Full spoken answer:**
> “On cold start the link can arrive before the navigation graph and DI are ready. I enqueue the pending route and flush once the root coordinator is live. If the path is invalid I fall back to home and emit a metric. Routing into a half-built stack is how you get crashes and blank screens.”

**Provenance:** Verified · S13 · navigation/lifecycle

---

### Q4. How do pushes open a screen? `(30–45s)`

**Answer points:** Payload carries route; tap → same DeepLinkRouter as UL.

**Full spoken answer:**
> “The notification payload carries a route identifier or URL. On tap I hand that to the same DeepLinkRouter Universal Links use — one table, two entrypoints. That way Airship campaigns and https links can’t drift. Defensive decoding protects crash-free if marketing ships malformed JSON.”

**Provenance:** Verified · S13 · Airship + deeplinks

---

### Q5. APNs token lifecycle? `(30–45s)`

**Answer points:** Register; upload; refresh on reinstall/OS; invalidate old.

**Full spoken answer:**
> “I register for remote notifications, receive the APNs device token, and upsert it to the provider — Airship or our backend. Tokens change across reinstall and some OS events, so I refresh regularly. When APNs reports unregistered, I invalidate server-side so we don’t fan out to dead tokens forever.”

**Provenance:** Learning-lab · (+ S13 Airship context)

---

### Q6. Why Airship instead of raw APNs only? `(30–45s)`

**Answer points:** Segmentation, journeys, creative tooling; still APNs underneath.

**Full spoken answer:**
> “Airship sits on top of APNs and gives segmentation, automation, and campaign tooling marketing needs. I still understand raw APNs — tokens, priorities, payloads — because vendors don’t remove failure modes. On Grizzlies we integrated Airship for push/engagement alongside Mixpanel for analytics.”

**Provenance:** Verified · S13

---

### Q7. Outline a mobile CI pipeline. `(45–60s)`

**Answer points:** PR build/test/lint → archive/sign → TestFlight → phased + monitors; dSYM.

**Full spoken answer:**
> “PRs run GitHub Actions for lint, build, and unit tests on macOS runners. Main cuts an archived, signed build uploaded to TestFlight, then phased App Store release. Gates include tests, binary size, dSYM upload, and pause criteria on crash-free or perf regressions. At BookMyShow we automated Actions into TestFlight to remove manual release ceremony.”

**Provenance:** BMS CI · Verified resume automation

---

### Q8. What did automation fix vs manual releases? `(30–45s)`

**Answer points:** Human signing/upload variance; standardizes build/lint/TF.

**Full spoken answer:**
> “Manual trains vary by who remembers signing steps and upload checklists. Actions standardizes build, lint, and TestFlight upload so the path is repeatable. Humans still own rollout judgment and stop criteria — automation removes toil, not responsibility.”

**Provenance:** BMS CI

---

### Q9. Feature flags vs release train? `(30–45s)`

**Answer points:** Train ships binary; flags decouple exposure; together enable safe rollout.

**Full spoken answer:**
> “The release train ships a binary on a cadence. Feature flags decide who sees risky surfaces inside that binary. Together you can pause exposure without waiting solely on App Review. CFS drops at ten percent phased should pause the train — flags and IMOC complete the story.”

**Provenance:** Learning-lab · + S8 crossover

---

### Q10. Hybrid SwiftUI/UIKit + deeplink footgun? `(30–45s)`

**Answer points:** Hosting VC identity; nav stack ownership; double lifecycle; design coordinator.

**Full spoken answer:**
> “Hosting controllers change identity and lifecycle in ways that break naive push/pop assumptions. Deeplinks need a coordinator that owns the real stack across UIKit and SwiftUI islands. On Grizzlies we designed interop deliberately — bolting UIHostingController ad hoc is how deeplinks land on the wrong screen.”

**Provenance:** Verified · S13

---

### Q11. Secure a `/checkout` deep link. `(30–45s)`

**Answer points:** Auth gate; server cart truth; validate params; ignore spoofed prices.

**Full spoken answer:**
> “Checkout links must pass an auth gate. The server remains authoritative for cart and price — query parameters never set what you pay. I validate and sanitize params, and I don’t auto-confirm destructive actions from a link alone.”

**Provenance:** Learning-lab · payments-adjacent

---

### Q12. AI on PRs — how describe? `(30–45s)`

**Answer points:** Accelerates regression review; humans own architecture/security; S9.

**Full spoken answer:**
> “AI-assisted review speeds catching obvious regressions and diff noise. Humans still own architecture, security, and product trade-offs. I frame it as Context Engineering and assistive tooling — never ‘the model approved so we shipped.’”

**Provenance:** Verified · S9

---

## Tricky questions

### T1. Universal Links open Safari instead of app. `(90–120s)`

**Trap:** “iOS bug.”

**Answer points:** Checklist AASA/HTTPS/content-type; team+bundle+paths+entitlements; CDN/Apple cache; user Safari preference; verify after fix.

**Full spoken answer:**
> “I run a checklist: AASA HTTPS reachability and content-type, team ID and bundle match, path patterns, associated domain entitlements, CDN/Apple cache delay, and user preference to open in Safari. Systematic debug beats shrugging. After an AASA fix I expect cache lag — I verify with controlled opens and server logs.”

**Provenance:** Learning-lab

---

### T2. Push deep link crashes on malformed JSON. `(90–120s)`

**Trap:** Trust marketing payload.

**Answer points:** Payloads untrusted; defensive decode + schema version; no force-unwrap; home on failure; same router as UL; protect CFS.

**Full spoken answer:**
> “Payloads are untrusted input. I defensively decode, version the schema, never force-unwrap, and route to home on failure. A marketing typo must not move crash-free. Same router as Universal Links, same validation mindset. That protects the CFS bar we care about operationally.”

**Provenance:** S13 · + S8 CFS culture

---

### T3. Two routers drifted. `(90–120s)`

**Trap:** Duplicate switch statements forever.

**Answer points:** Push/UL = entrypoints only; one DeepLinkRouter + AppRoute table; duplication causes drift; modules register via interfaces.

**Full spoken answer:**
> “Push and Universal Links are entrypoints only. One DeepLinkRouter and one AppRoute table own behavior. Duplication is how checkout works from a banner and 404s from an https campaign. Module feature builders register routes through interfaces — Day 15 modular thinking.”

**Provenance:** Learning-lab · S13 lesson

---

### T4. CI green but TestFlight crash-loops. `(90–120s)`

**Trap:** “Tests enough.”

**Answer points:** Release ≠ Debug; entitlements/symbols/races; TF smoke + dSYMs; unit tests ≠ signing proof; S2 race classes still matter.

**Full spoken answer:**
> “Release compiler settings, missing entitlements, stripped symbols, and concurrency races show up outside Debug. I smoke on TestFlight, keep dSYMs, and compare Release vs Debug flags. Green unit tests never proved entitlements or real signing. Race classes like shared maps — S2 thinking — still matter in Release.”

**Provenance:** Learning-lab · + S2 reasoning optional

---

### T5. Phased release CFS drops at 10%. `(90–120s)`

**Trap:** Continue to 100%.

**Answer points:** Pause immediately; IMOC + bisect version/flags; disable path / hotfix; stop criteria required; CFS = ops bar at BMS scale.

**Full spoken answer:**
> “Pause immediately. Enter IMOC, bisect version and feature flags, disable the bad path, hotfix if needed. CI/CD without stop criteria is a conveyor belt into an incident. At BMS scale we treated crash-free as an operational bar — continuing to one hundred percent would be malpractice.”

**Provenance:** Verified · S8 · + BMS CI gates

---

### T6. Deferred deep link attributes wrong user. `(90–120s)`

**Trap:** Fingerprinting forever / overclaim.

**Answer points:** Probabilistic + privacy-constrained; expiry windows; don’t overclaim; prefer post-login when identity matters; no infinite fingerprint retention.

**Full spoken answer:**
> “Deferred attribution is probabilistic and privacy-constrained. I use expiry windows, avoid overclaiming certainty, and prefer routing after first-party login when identity matters. Infinite retention of install fingerprints is both a privacy and correctness smell.”

**Provenance:** Learning-lab

---

### T7. Secrets in GitHub Actions. `(90–120s)`

**Trap:** Commit profiles/p12.

**Answer points:** Encrypted secrets / match-style store; least-privilege ASC keys; rotate on exposure; never log; p12 in repo = incident.

**Full spoken answer:**
> “Signing material lives in encrypted secrets or a match-style private store, least-privilege App Store Connect keys, rotation on exposure, and never logged. Committing a p12 is an incident. Automation should reduce secret sprawl, not paste certs into the repo.”

**Provenance:** Learning-lab · CI security

---

### T8. Marketing wants `myapp://` everywhere. `(90–120s)`

**Trap:** Refuse without options / accept hijack risk silently.

**Answer points:** Prefer UL for public campaigns; explain scheme hijack risk; schemes as legacy fallback; migrate gradually; one route table either way (S13).

**Full spoken answer:**
> “I prefer Universal Links for public campaigns and explain hijack risk of custom schemes. I offer schemes as transitional fallback for legacy and migrate campaigns gradually. On Grizzlies we lived in a practical mix while designing routing so either entrypoint still hit one table.”

**Provenance:** Verified · S13 · judgment

---

## Timed set

**Q3, Q7, Q10** + **T1, T5**. S13 STAR + 45s CI elevator.
