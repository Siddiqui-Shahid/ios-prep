# Sample 01 — Lifecycle hooks (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the UIViewController lifecycle order?
**Answer:**

> Say aloud: `init` → `loadView` → `viewDidLoad` → `viewWillAppear` → `viewIsAppearing` (iOS 17+) → `viewDidAppear` → layout callbacks → `viewWillDisappear` → `viewDidDisappear` → `deinit`. Load runs once per VC instance load. Appear/disappear run every time the screen becomes visible or leaves — including tab switches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is `viewIsAppearing`? | iOS 17+ appear-phase hook — between will and did appear. |
| When is `deinit` useful in DEBUG? | Logging to prove no retain cycle — not for critical production cleanup. |
| Custom container VC risk? | Must forward appearance transitions or child hooks never fire. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What belongs in `viewDidLoad` vs appear hooks?
**Answer:**

> **`viewDidLoad`:** one-time setup — add subviews, bind view model once, configure static UI. Do not assume final bounds; do not fire “forever” network here. **`viewWillAppear`:** refresh data every show — scores, headers, throttled refetch. **`viewDidAppear`:** analytics “screen viewed”; start players only when actually visible. **`viewWillDisappear`:** pause video, cancel in-flight search, stop ads playback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Heavy sync I/O on appear? | Avoid — blocks transition; async with cancel on disappear. |
| Analytics on `viewDidLoad` for tabs? | Wrong — tab may load off-screen; fire on didAppear when visible. |
| Layout-dependent snap? | `viewDidLayoutSubviews` when bounds are ready — use carefully to avoid loops. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is the tab bar “load once, appear many” trap?
**Answer:**

> Tab view controllers often load a child VC once but call appear/disappear every tab switch. If you fetch only in `viewDidLoad`, data goes stale forever when the user returns. Put refresh policy in appear hooks with caching or throttle (e.g. refetch if older than N seconds).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User opens Tab A then B then A — what reruns? | A: disappear when leaving; appear when returning. `viewDidLoad` does **not** rerun. |
| Is missing `viewDidLoad` recall a bug? | Often **feature** — VC retained in nav stack; repeatable work belongs in appear. |
| Background refresh while tab hidden? | Possible with policy, but UI bind should respect appear/disappear for players. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Where should HeroWidget pause/play tie in? (BookMyShow Ads pipeline + HeroWidget lifecycle)?
**Answer:**

> Revenue contract: visible enough → play; below threshold, disappear, or app background → pause. Implement with VC `viewWillDisappear` / `viewDidDisappear` for full-screen players, collection visibility % for in-feed ads, and background notifications as a third signal. Lifecycle is part of the product contract, not optional plumbing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview one-liner? | “For HeroWidget, lifecycle was part of the revenue contract — pause on disappear and offscreen.” |
| In-feed vs full-screen? | Full-screen: VC hooks. In-feed: visibility threshold on scroll. |
| Background without disappear? | App background notification still pauses — user left the app. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. What work should never wait for `deinit`?
**Answer:**

> Critical cleanup — timers, observers, players, network tasks — belongs in `viewWillDisappear` or explicit teardown. `deinit` proves retain cycles in DEBUG but may run late or never if something still holds the VC. Do not rely on it for user-visible behavior.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timer not invalidated? | Strong retain on target until `invalidate` — classic cycle (Day 03 recall). |
| NotificationCenter block API? | Store token; remove on disappear/deinit path. |
| `deinit` never runs — always a cycle? | No — VC may still be on stack, in cache, or presented. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How do custom containers break lifecycle?
**Answer:**

> If you swap child VCs in a custom container without forwarding `beginAppearanceTransition` / `endAppearanceTransition`, child `viewWillAppear` and pause/play logic never run. UINavigationController and UITabBarController do this for you; your clever container might not — analytics and media pause break silently.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in production? | Video plays offscreen; screen analytics double-count or never fire. |
| UIHostingController child? | Parent appear/disappear should inform nested player pause policies. |
| Fix? | Forward appearance like Apple’s container VCs, or use standard containers. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What should I be able to say after lifecycle foundations?
**Answer:**

> “UIKit separates one-time load from every-show appear work. Pause and cancel on disappear. Tabs load once but appear many — refresh on appear. For revenue video, visibility and VC lifecycle are the product contract. Custom containers must forward appearance or child hooks break.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-time vs every-show rule? | Setup in didLoad; refresh and analytics on appear; teardown on disappear. |
| BookMyShow Ads pipeline + HeroWidget lifecycle provenance? | HeroWidget pause/play tied to visibility / VC lifecycle. |
| Next topic? | Cells — reuse and prefetch — [02-cells-reuse-prefetch.md](02-cells-reuse-prefetch.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

Next: [02-cells-reuse-prefetch.md](02-cells-reuse-prefetch.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What belongs in `viewDidLoad` vs appear hooks

**Ask yourself:** What belongs in `viewDidLoad` vs appear hooks?

**Answer:** “**`viewDidLoad`:** one-time setup — add subviews, bind view model once, configure static UI. Do not assume final bounds; do not fire “forever” network here. **`viewWillAppear`:** refresh data every show — scores, headers, throttled refetch. **`viewDidAppear`:** analytics “screen viewed”; start players only when actually visible. **`viewWillDisappear`:** pause video, cancel in-flight search, stop ads playback.”

### Puzzle B — What is the tab bar “load once, appear many” trap

**Ask yourself:** What is the tab bar “load once, appear many” trap?

**Answer:** “Tab view controllers often load a child VC once but call appear/disappear every tab switch. If you fetch only in `viewDidLoad`, data goes stale forever when the user returns. Put refresh policy in appear hooks with caching or throttle (e.g. refetch if older than N seconds).”

### Puzzle C — Where should HeroWidget pause/play tie in? (BookMyShow Ads pipeline + HeroWidget

**Ask yourself:** Where should HeroWidget pause/play tie in? (BookMyShow Ads pipeline + HeroWidget lifecycle)?

**Answer:** “Revenue contract: visible enough → play; below threshold, disappear, or app background → pause. Implement with VC `viewWillDisappear` / `viewDidDisappear` for full-screen players, collection visibility % for in-feed ads, and background notifications as a third signal. Lifecycle is part of the product contract, not optional plumbing.”
