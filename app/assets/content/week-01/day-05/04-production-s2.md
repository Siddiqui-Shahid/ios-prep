# Sample 04 — Production S2, S2-A1, and S3 hooks (Q&A)

> Guided teaching. Separates **Verified** resume facts from **How I would apply it** design judgment so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S2?

**Points to:** [Production bridge · §1 Verified · S2](../03-production-bridge.md#1-verified--s2--synchronised-dictionaries-bookmyshow) · [Foundations · §1 Why this day exists](../01-foundations.md#1-why-this-day-exists)

**Answer:**

> At BookMyShow, shared async state hit **synchronised dictionaries** gated by **GCD serial queues** (and read-write locks where read-heavy). You introduced a **closed access API** so call sites could not touch raw storage. That eliminated concurrent-access crashes **on that shared-state path** — pattern reused where mutable maps were shared. **Do not** claim this alone produced app-wide 99.95% crash-free — that is S8 reliability culture, not S2’s scope.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤15s opener? | “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.” |
| What caused the crashes? | Unsynchronized dictionary mutation from multiple async contexts — data races. |
| Forbidden overclaim? | “S2 alone gave us 99.95% CFS.” |

---

### Q2. What was the S2 fix, technically?

**Points to:** [Production bridge · Action](../03-production-bridge.md#action-what-you-can-claim) · [Deep dive · §4.3 GCD row](../02-deep-dive.md#43-actor-vs-class--lock-vs-gcd-serial-queue)

**Answer:**

> Hide storage behind an API: writes on a **serial queue**, reads synchronized for a safe snapshot, **RW lock** where reads dominated. Call sites never touch the raw dictionary. Lesson: **serialize mutation at the boundary** — don’t sprinkle locks ad hoc. Trade-offs: `sync` reads can deadlock if misused on the same queue; extreme read contention may need strategy revisits.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why closed API? | Prevents “just grab the dict” races at random call sites. |
| Validation? | Concurrency stress + Crashlytics watch for that failure mode. |
| Tie to Day 04? | Same serial-queue mental model — Day 05 adds actor alternative. |

---

### Q3. What is S2-A1, and what is it not?

**Points to:** [Production bridge · §2 How I would apply it · S2-A1](../03-production-bridge.md#2-how-i-would-apply-it--s2-a1--actor-migration-for-greenfield) · [code · SafeDictActor.swift](../code/SafeDictActor.swift)

**Answer:**

> **S2-A1** is **How I would apply it** — not verified as org-wide BMS rewrite. For **greenfield** shared maps, expose the same safe get/set surface on a Swift **`actor`** so isolation is compiler-checked. Keep API ideas from S2 (hide storage, serialize mutation); change implementation to language-native isolation. Pitfall shifts from `queue.sync` deadlock to **actor reentrancy** — train the team to re-validate after `await`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Big-bang rewrite? | **No** — strangler at new module boundaries. |
| Generic constraints? | `Key: Hashable & Sendable`, `Value: Sendable` — see SafeDictActor. |
| Never return what? | Mutable interior reference callers can race on. |

---

### Q4. How do you pitch S2 → S2-A1 migration in 45–60 seconds?

**Points to:** [Production bridge · 45–60s applied answer](../03-production-bridge.md#45-60s-applied-answer) · [Production bridge · Strangler strategy](../03-production-bridge.md#strangler-strategy-say-this-if-asked-how-do-you-migrate)

**Answer:**

> “Production fix was GCD serial-queue dictionaries — Verified S2. For greenfield shared maps I’d use an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite stable modules for fashion — strangler-migrate at boundaries. Trade-off: reentrancy at await instead of sync deadlock — state must be re-validated after await.” Mention snapshot/get/remove API parity with [`SafeDictActor.swift`](../code/SafeDictActor.swift).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Step 1 of strangler? | Don’t big-bang every call site in a revenue app. |
| Leave legacy when? | Stable GCD dict until a feature touch requires change. |
| Bridge A one-liner? | “Same boundary idea — compiler isolation, revalidate after await.” |

---

### Q5. How does Verified · S3 tie to Task cancellation?

**Points to:** [Production bridge · §3 Verified · S3](../03-production-bridge.md#3-verified--s3--search-debounce-and-task-cancellation) · [Deep dive · §3.3 Search debounce](../02-deep-dive.md#33-search-debounce-s3-hook)

**Answer:**

> S3 at BookMyShow covers backend-driven header, **search debounce**, explicit loading/empty/error state, and MVVM. For Day 05 the slice is: debounce is not only sleep — **cancel the previous in-flight Task** so slower older responses cannot overwrite fresher results. Treat `CancellationError` as normal. Unstructured Task at UI/VM boundary + cooperative cancel on each query change.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent debounce ms from prod? | **No** — don’t invent specific constants. |
| `@MainActor` VM role? | UI state updates on main while search Tasks cancel and restart. |
| ≤20s line? | “Debounced and cancelled the previous Task so stale responses couldn’t win.” |

---

### Q6. What must you never invent?

**Points to:** [Production bridge · §4 What not to invent](../03-production-bridge.md#4-what-not-to-invent) · [Day 05 README · Provenance](../README.md#provenance-reminder)

**Answer:**

> ✅ GCD synchronised dictionaries at BMS — Verified S2. ✅ Search debounce / MVVM — Verified S3. ❌ Actor migration shipped org-wide at BMS — use S2-A1 only. ❌ Specific debounce milliseconds from production. ❌ S2 caused app-wide 99.95% CFS alone. Check registry before you speak; label Verified vs How I would apply it out loud.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor rewrite claim? | S2-A1 — design judgment, not resume fact. |
| CFS metric? | S8 culture — don’t attach to S2 alone. |
| Registry path? | [`provenance/README.md`](../../../../provenance/README.md) |

---

### Q7. How do S2 and actors compare in an interview table?

**Points to:** [Production bridge · Migration pitch table](../03-production-bridge.md#migration-pitch-interview-ready) · [Deep dive · §4.3](../02-deep-dive.md#43-actor-vs-class--lock-vs-gcd-serial-queue)

**Answer:**

> | Legacy S2 | Greenfield S2-A1 |
> |---|---|
> | `SafeDict` + serial queue | `actor SafeDict` |
> | `sync` get / async set on queue | `await get` / `await set` |
> | Manual discipline | Compiler isolation |
> | `queue.sync` deadlock risk | Reentrancy across `await` |
> Same **boundary** idea — different enforcement and pitfall class.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When keep GCD? | Legacy stable modules that work — wrap at edges. |
| When choose actor? | New shared mutable state. |
| Mixing both in one app? | Expected at BMS scale — strangler, not big-bang. |

---

### Q8. Give a full honest answer mixing S2, S2-A1, and S3

**Points to:** [Production bridge · §5 Ready-to-speak bridges](../03-production-bridge.md#5-ready-to-speak-bridges-keep-short) · [Foundations · §6 90s production bridge](../01-foundations.md#6-what-good-sounds-like-in-an-interview-preview)

**Answer:**

> “Shared maps at BookMyShow raced under async access — we fixed that with synchronised dictionaries on serial queues and a closed API, Verified S2. For new modules I’d expose the same surface on a Swift actor — S2-A1 — and train on reentrancy. Search UX used debounce with MVVM — Verified S3 — and the concurrency piece I care about is cancelling the previous Task so stale network responses don’t clobber newer queries. I don’t claim we rewrote every dictionary to actors org-wide.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified? | S2 dictionary fix; S3 search/debounce/MVVM. |
| Where is applied? | S2-A1 actor migration for greenfield. |
| After this sample? | [`SafeDictActor.swift`](../code/SafeDictActor.swift), then [`../04-questions.md`](../04-questions.md). |

---

## After this sample

1. Read [SafeDictActor.swift](../code/SafeDictActor.swift) line by line.
2. Speak from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Do timed drills in [`../05-exercises.md`](../05-exercises.md).
