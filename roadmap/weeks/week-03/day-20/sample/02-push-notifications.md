# Sample 02 — Push notifications (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Walk the push pipeline in order.

**Points to:** [Foundations · §2 Push pipeline](../01-foundations.md#2-push-pipeline)

**Answer:**

> **Permission** (contextual, not instant first launch) → **register for remote notifications** → **APNs device token** → upload to backend / **Airship** → campaign or transactional push → user **tap** → parse payload → **same DeepLinkRouter** as Universal Links. Foreground delivery uses different handlers but should still unify routing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Airship vs APNs? | Airship is engagement layer **on** APNs — segments, journeys; you still know APNs. |
| Token every launch? | Tokens change; **upsert** server-side on each register. |
| Silent push as cron? | Limited wake budget — don’t rely. |

---

### Q2. Why must push and Universal Links share one router?

**Points to:** [Foundations · §2](../01-foundations.md#2-push-pipeline) · [Deep dive · §2 Router architecture](../02-deep-dive.md#2-router-architecture)

**Answer:**

> Dual routers **drift** — campaign push opens checkout; https link 404s because tables diverged. Senior design: **DeepLinkParser → AppRoute → Coordinator** for UL, custom scheme, push tap, Spotlight optional. S13 lesson: interop costs must be designed; routing is shared discipline.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Payload carries what? | Small route id or URL — not full UI state. |
| Category actions? | Also map to AppRoute — same table. |
| Mixpanel in push path? | Analytics on screen event after route — complementary to Airship. |

---

### Q3. When should you ask for notification permission?

**Points to:** [Deep dive · §4 Push deep dive](../02-deep-dive.md#4-push-deep-dive)

**Answer:**

> **Contextual timing** — after user sees value (e.g. “notify me when tickets drop”), not instant first launch. Higher opt-in and better product trust. Pre-permission education screen optional. Never assume permission granted — handle denied gracefully.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provisional authorization? | Quiet delivery on iOS — know it exists; product decision. |
| Re-prompt after deny? | Settings deep link — can’t re-show system dialog. |
| Invent opt-in %? | **Forbidden** — don’t fabricate S13 metrics. |

---

### Q4. How do you handle APNs token lifecycle?

**Points to:** [Deep dive · §4](../02-deep-dive.md#4-push-deep-dive)

**Answer:**

> Register on launch; **upload token** to provider (Airship/backend). On reinstall/OS update token may change — **invalidate old** server-side. Handle **410 Unregistered** from provider — remove stale token from DB. Defensive: missing token ≠ crash.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Simulator push? | Limited; device testing for real flows. |
| Multiple devices per user? | Store many tokens per account. |
| Logout? | Unregister or invalidate token server-side. |

---

### Q5. What goes in the push payload, and how to decode safely?

**Points to:** [Foundations · §2](../01-foundations.md#2-push-pipeline) · [Deep dive · §4](../02-deep-dive.md#4-push-deep-dive)

**Answer:**

> Keep payload **small** — route id, deep link URL, collapse id, category. **Defensive decode** — malformed JSON must not crash app (protect **CFS**). On failure: safe home + metric. Rich media via **Notification Service Extension** — watch memory budgets.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Collapse id? | Replace related notifications — avoid spam stack. |
| Foreground presentation? | `willPresent` — decide banner/list/sound. |
| Full cart in payload? | Bad — route only; fetch server state. |

---

### Q6. Airship vs Mixpanel in the Grizzlies stack?

**Points to:** [Foundations · §2](../01-foundations.md#2-push-pipeline) · [Production bridge · S13](../03-production-bridge.md#2-verified-s13--star-23-min)

**Answer:**

> **Airship:** push delivery, segments, engagement campaigns — Verified S13 integration.  
> **Mixpanel:** product analytics, funnel events — also S13.  
> Complementary, **not synonyms**. Push tap → router → screen → Mixpanel event. Don’t claim you “built Airship.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S13 ≤20s line? | “Deeplinks and Airship push atop hybrid SwiftUI/UIKit, Mixpanel for analytics.” |
| Attribution in Airship? | Engagement; Mixpanel for in-app behavior — both can inform growth. |
| One vendor for all? | Possible but know layered responsibilities. |

---

### Q7. Push failure modes and senior responses?

**Points to:** [Deep dive · §8 Failure modes](../02-deep-dive.md#8-failure-modes)

**Answer:**

> | Failure | Response |
> | Push JSON crash | Defensive parse → home |
> | Dual routers drifted | Unify routing table |
> | Token stale | 410 handling, re-register |
> | Rich image OOM | Extension memory limits, downsample |
> Campaign works, UL broken | Same root cause often — router/AASA — fix holistically |

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CFS drop after push feature? | Pause rollout — IMOC (S8) |
| Test push E2E? | Device + sandbox/prod cert match |
| Next topic? | CI/CD — [03-ci-cd-actions.md](03-ci-cd-actions.md) |

---

Next: [03-ci-cd-actions.md](03-ci-cd-actions.md)
