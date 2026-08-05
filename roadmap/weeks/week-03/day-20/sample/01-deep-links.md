# Sample 01 — Deep links & Universal Links (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Universal Links vs custom URL scheme — when which?

**Points to:** [Foundations · §1 Deep linking pipeline](../01-foundations.md#1-deep-linking-pipeline)

**Answer:**

> **Universal Links (`https://`):** domain association via **AASA** — opens app when installed, falls back to web in Safari; more secure than schemes.  
> **Custom scheme (`myapp://`):** easier setup but **hijackable** by other apps; fine for legacy/internal.  
> Production consumer apps: prefer Universal Links for marketing and email links.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why hijackable? | iOS doesn’t uniquely bind custom schemes to one app. |
| https in Notes app? | Universal Link if AASA valid; else Safari. |
| Both in one app? | Yes — route both through **one router**. |

---

### Q2. What is AASA, and what can go wrong?

**Points to:** [Foundations · §1](../01-foundations.md#1-deep-linking-pipeline) · [Deep dive · §1 Universal Links debugging](../02-deep-dive.md#1-universal-links-debugging-checklist)

**Answer:**

> **apple-app-site-association** JSON at `https://domain/.well-known/apple-app-site-association` — lists **appIDs** (`TEAMID.bundle`) and **paths**. Must be HTTPS with correct content-type. **CDN/OS caching** can delay fixes after you deploy AASA changes. Size limits apply — keep file lean.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Link opens Safari not app? | Checklist: AASA reachable, appID, paths, entitlements, cache delay, user preference. |
| “iOS bug” first answer? | **Trap** — verify AASA and entitlements first. |
| Path excluded? | Link won’t open app even if domain matches. |

---

### Q3. Describe the deep link pipeline end-to-end.

**Points to:** [Foundations · §1](../01-foundations.md#1-deep-linking-pipeline) · [Deep dive · §2 Router architecture](../02-deep-dive.md#2-router-architecture)

**Answer:**

> `https://` or `myapp://` → **Scene / onOpenURL** → **DeepLinkParser** (validate, match) → typed **AppRoute** → **AuthGate** if needed → **AppCoordinator.navigate** OR **PendingDeepLinkStore.enqueue** if nav not ready. One table for every entrypoint.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why typed enum route? | Parser produces `AppRoute`; coordinator doesn’t parse strings ad hoc. |
| Invalid link? | Safe home + metric — don’t crash on bad params. |
| Dual routers problem? | Push vs UL drift — checkout works from one, 404s from other. |

---

### Q4. What is the cold-start race, and how do you fix it?

**Points to:** [Foundations · §1](../01-foundations.md#1-deep-linking-pipeline) · [code/DeepLinkQueue.swift](../code/DeepLinkQueue.swift)

**Answer:**

> Link arrives **before** DI, auth, or navigation stack is ready → don’t navigate into nil coordinator. **Queue** the parsed intent in `PendingDeepLinkStore`; **flush** when root UI and coordinator are warm. Invalid routes → home + log. Same pattern for deferred first-launch attribution.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Flush trigger? | Root VC ready, session restored, coordinator injected. |
| Multiple queued links? | Policy: latest wins, or FIFO — state explicitly. |
| Push tap same queue? | Yes — same router mindset. |

---

### Q5. What security rules apply to URL parameters?

**Points to:** [Foundations · §1](../01-foundations.md#1-deep-linking-pipeline) · [Deep dive · §6 Secure checkout link](../02-deep-dive.md#6-secure-checkout-link)

**Answer:**

> **Validate** params; **auth-gate** checkout and account routes; **never trust URL for price or user authority** — server is authoritative for cart/price. Ignore spoofed query prices. Confirm destructive actions. Deep links are **intent**, not proof of entitlement.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `?price=0.01` in link? | Display nothing until server confirms. |
| Logged-out checkout link? | Auth gate → login → resume queued route. |
| Open redirect in web fallback? | Sanitize web paths in AASA. |

---

### Q6. Hybrid SwiftUI/UIKit — what does routing need?

**Points to:** [Deep dive · §2 Router architecture](../02-deep-dive.md#2-router-architecture) · [Production bridge · S13](../03-production-bridge.md#2-verified-s13--star-23-min)

**Answer:**

> **Coordinator owns stack identity** — don’t bolt `UIHostingController` without lifecycle plan. S13 Grizzlies: SwiftUI surfaces hosted in UIKit (or reverse) with designed interop. Router targets coordinator APIs, not raw view controller class names scattered in features.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SwiftUI NavigationStack vs UIKit? | Pick ownership model; router stays above both. |
| State restoration? | Coordinator + route enum aids restore. |
| S13 one-liner? | “Deeplinks and Airship atop hybrid SwiftUI/UIKit navigation.” |

---

### Q7. Deferred deep links — what to claim honestly?

**Points to:** [Deep dive · §3 Deferred deep links](../02-deep-dive.md#3-deferred-deep-links)

**Answer:**

> Post-install attribution: first launch fetches **pending route** with **expiry** (industry often ~days, not forever). Privacy and probabilistic matching limits — don’t overclaim certainty. Prefer first-party login then route when identity matters. Same router flushes when ready.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forever pending route? | Bad — expire and fall back to home. |
| Branch/Adjust internals? | Know concept; don’t invent CTR %. |
| Organic install? | No deferred route — native onboarding. |

---

Next: [02-push-notifications.md](02-push-notifications.md)
