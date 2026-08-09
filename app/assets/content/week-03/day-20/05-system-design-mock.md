# Sample 05 — System-design mock: Push Notification System (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/push-notification-system.md`](../../../../ios-system-design/docs/push-notification-system.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 20 — Parallel SD Push (deeplink/CI sister).

---

### Q1. Interviewer: “Design Push Notification System.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Token lifecycle** and **Silent push + deferred**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Display + silent + BG processing?
> 2. Token register every launch?
> 3. Deep link on open?
> 4. Payload ≤4KB OK?
> 5. Out: rich NSE deep dive, chat WS?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Token lifecycle; display/silent; router on tap; APNs fanout backend sketch; out: NSE deep, WS chat.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> App ↔ Device token API ↔ Push Service ↔ APNs HTTP/2. Client: register, display, silent ≤30s, route.
> **Load:** payload ≤4KB; silent ~3/hr; priority 10 vs 5; collapse-id.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Same as deeplink? | Tap → same DeepLinkRouter. |
| CI/CD? | Mention phased release — don’t boil CI unless asked. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> `PUT /v1/devices/{userId}/push-token`, DELETE invalidate. Server→APNs. Client handles UNNotification.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 410 Unregistered? | Invalidate token server-side. |
| Denied permission? | Settings CTA — don’t spam. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q5. Deep dive 1 — Token lifecycle?

**Answer:**

> Register every launch; rotate on change; dedupe server-side; multi-device.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Logout? | DELETE token binding. |
| Sandbox vs prod? | Correct APNs env — classic footgun. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q6. Deep dive 2 — Silent push + deferred?

**Answer:**

> Silent ≤30s work; throttle; fallback BGAppRefresh. Deferred install links sister to deeplink doc.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| iOS throttling? | Expect coalescing — design resilient sync. |
| Security? | Don’t put secrets in payload. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> Delivery, CTR (labeled ranges only), invalidate on 410. Kill: stop campaign; collapse-id.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | Grizzlies push via Airship/Mixpanel routing discipline. |
| Invent open rates? | Forbidden as personal fact. |

**How can I relate to my case:**
- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.
> **Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |
| Invented crash-free %? | Forbidden — use resume-backed numbers or label as target. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

