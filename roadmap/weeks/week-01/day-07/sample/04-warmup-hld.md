# Sample 04 — Warm-up pool & Social Feed HLD (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. Name five warm-up topics you must have ready?
**Answer:**

> Default mock set: (1) struct vs class, (2) COW, (3) weak vs unowned, (4) serial vs concurrent, (5) thread-safe dictionary. Alternate: POP in ads, main-queue deadlock, actor isolation, Sendable, Task cancellation. IDs W1–W12 in 04 — speak from Answer points, compare to full answer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Budget per def? | ~45–60s; safe dict design up to 60–90s. |
| All 12 before mock? | Skim 04; drill misses from flashcards. |
| Actor isolation warm-up? | One sentence: only one task mutates actor state at a time. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Actor isolation — warm-up answer shape?
**Answer:**

> An **actor** serializes access to its mutable state — callers use `await`. Compiler enforces isolation instead of manual queue discipline. Contrast with GCD SafeDict: external serial queue vs language-supported isolation. Mention reentrancy only if follow-up asks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs class + lock? | Actor integrates with async/await; fewer forgotten lock paths. |
| MainActor? | UI-bound actor — common in SwiftUI/UIKit bridges. |
| Deep follow-up? | Reentrancy after await — deep pool D1. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Sendable — what do you say in 45s?
**Answer:**

> **Sendable** marks types safe to share across concurrency domains — no unsynchronized mutable shared state. Value types often auto-Sendable; classes need careful design. `@unchecked Sendable` is an escape hatch — ethics question in deep pool. Tie to passing data into Tasks and actors.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `@unchecked Sendable`? | You promise thread safety — deep pool ethics. |
| NSDictionary Sendable? | Legacy reference types — often not without wrapping. |
| Interview depth? | Definition + one example (struct model vs mutable class). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Social Feed HLD — what is the prompt?
**Answer:**

> “Design the **client side** of a social/listing feed for a large consumer app — BookMyShow-scale. Clarify first, then high-level design only — no full LLD.” 20 min block. Honesty: design skill exercise; tie ads slots to **BookMyShow Ads pipeline + HeroWidget lifecycle instinct** only; cite **BookMyShow IMOC + crash-free at scale** for scale when asked “how big.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Client only? | Yes — API consumption, caching, UI list — not backend microservices LLD. |
| Incomplete OK? | Interviewer cuts at 20 min — note gaps in retro. |
| Invent metrics? | No fake latency SLAs — clarify with interviewer. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. What clarifying questions should you ask?
**Answer:**

> Ask ~4–6 before drawing boxes: organic vs **ads mixing** rules? **Pagination** (cursor vs offset)? **Offline / stale** content OK? Image/video **autoplay**? Realtime invalidation vs pull-to-refresh? Approximate **DAU / latency** targets? (May cite 30L+ DAU as Verified **BookMyShow IMOC + crash-free at scale** scale — do not invent new numbers.)

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cursor vs offset? | Cursor stable for live feeds; offset breaks on inserts. |
| Ads mixing? | Slot injection without forking feed pipeline — BookMyShow Ads pipeline + HeroWidget lifecycle instinct. |
| Skip clarify? | Weak signal — looks like guessing requirements. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. HLD bullets — caching and scroll?
**Answer:**

> **API:** cursor pagination request/response. **Caching:** memory + disk tiers; TTL / invalidation sketch. **Images:** prefetch ahead; **cancel in-flight** when cell scrolls off screen. **Concurrency:** never block main; debounce/cancel duplicate fetches. **Failure:** empty, error, retry states. **Ads:** inject slots without duplicating entire feed pipeline.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel on scroll away? | Same instinct as BookMyShow backend-driven header & search debounce / cancel in-flight — light metaphor. |
| Memory pressure? | Trim distant pages from memory cache. |
| Scorecard row? | MockScorecard “Mini SD — Social Feed” checks these areas. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Task cancellation — warm-up tie-in?
**Answer:**

> Swift Tasks cancel **cooperatively** — check `Task.isCancelled` at await boundaries; propagate cancellation to URLSession work. Feed use case: user scrolls fast → cancel stale image loads. Do not claim a specific BMS metric — describe the pattern.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs GCD cancel? | No automatic kill — cooperative for both. |
| Structured concurrency? | Child tasks cancel with parent scope. |
| Feed HLD link? | Prefetch + cancel pair is the client-side win. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Back to: [README.md](README.md) · Full mock: [`../02-deep-dive.md`](../02-deep-dive.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — Actor isolation — warm-up answer shape

**Ask yourself:** Actor isolation — warm-up answer shape?

**Answer:** “An **actor** serializes access to its mutable state — callers use `await`. Compiler enforces isolation instead of manual queue discipline. Contrast with GCD SafeDict: external serial queue vs language-supported isolation. Mention reentrancy only if follow-up asks.”

### Puzzle B — Sendable — what do you say in 45s

**Ask yourself:** Sendable — what do you say in 45s?

**Answer:** “**Sendable** marks types safe to share across concurrency domains — no unsynchronized mutable shared state. Value types often auto-Sendable; classes need careful design. `@unchecked Sendable` is an escape hatch — ethics question in deep pool. Tie to passing data into Tasks and actors.”

### Puzzle C — Social Feed HLD — what is the prompt

**Ask yourself:** Social Feed HLD — what is the prompt?

**Answer:** “Design the **client side** of a social/listing feed for a large consumer app — BookMyShow-scale. Clarify first, then high-level design only — no full LLD.” 20 min block. Honesty: design skill exercise; tie ads slots to **BookMyShow Ads pipeline + HeroWidget lifecycle instinct** only; cite **BookMyShow IMOC + crash-free at scale** for scale when asked “how big.”
