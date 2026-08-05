# Audio script — Sample 04 — Production S2, S2-A1, and S3 hooks (Q&A)
> Listen-only sample Q&A from `04-production-s2.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S2?

Next. Q1. What can you claim under Verified · S2? Answer. At BookMyShow, shared async state hit synchronised dictionaries gated by G C D serial queues (and read-write locks where read-heavy). You introduced a closed access A P I so call sites could not touch raw storage. That eliminated concurrent-access crashes on that shared-state path — pattern reused where mutable maps were shared. Do not claim this alone produced app-wide 99.95% crash-free — that is S 8 reliability culture, not S 2’s scope. Follow-ups. ≤15s opener?: “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.”. What caused the crashes?: Unsynchronized dictionary mutation from multiple async contexts — data races.. Forbidden overclaim?: “S 2 alone gave us 99.95% crash free sessions.”.

## §1 Q2. What was the S2 fix, technically?

Next. Q2. What was the S2 fix, technically? Answer. Hide storage behind an A P I: writes on a serial queue, reads synchronized for a safe snapshot, RW lock where reads dominated. Call sites never touch the raw dictionary. Lesson: serialize mutation at the boundary — don’t sprinkle locks ad hoc. Trade-offs: sync reads can deadlock if misused on the same queue; extreme read contention may need strategy revisits. Follow-ups. Why closed A P I?: Prevents “just grab the dict” races at random call sites.. Validation?: Concurrency stress + Crashlytics watch for that failure mode.. Tie to Day 04?: Same serial-queue mental model — Day 05 adds actor alternative..

## §2 Q3. What is S2-A1, and what is it not?

Next. Q3. What is S2-A1, and what is it not? Answer. S 2-A1 is How I would apply it — not verified as org-wide BMS rewrite. For greenfield shared maps, expose the same safe get/set surface on a Swift actor so isolation is compiler-checked. Keep A P I ideas from S 2 (hide storage, serialize mutation); change implementation to language-native isolation. Pitfall shifts from queue.sync deadlock to actor reentrancy — train the team to re-validate after await. Follow-ups. Big-bang rewrite?: No — strangler at new module boundaries.. Generic constraints?: Key: Hashable & Sendable, Value: Sendable — see SafeDictActor.. Never return what?: Mutable interior reference callers can race on..

## §3 Q4. How do you pitch S2 → S2-A1 migration in 45–60 seconds?

Next. Q4. How do you pitch S2 → S2-A1 migration in 45–60 seconds? Answer. “Production fix was G C D serial-queue dictionaries — Verified S 2. For greenfield shared maps I’d use an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite stable modules for fashion — strangler-migrate at boundaries. Trade-off: reentrancy at await instead of sync deadlock — state must be re-validated after await.” Mention snapshot/get/remove A P I parity with SafeDictActor.swift. Follow-ups. Step 1 of strangler?: Don’t big-bang every call site in a revenue app.. Leave legacy when?: Stable G C D dict until a feature touch requires change.. Bridge A one-liner?: “Same boundary idea — compiler isolation, revalidate after await.”.

## §4 Q5. How does Verified · S3 tie to Task cancellation?

Next. Q5. How does Verified · S3 tie to Task cancellation? Answer. S3 at BookMyShow covers backend-driven header, search debounce, explicit loading/empty/error state, and M V V M. For Day 05 the slice is: debounce is not only sleep — cancel the previous in-flight Task so slower older responses cannot overwrite fresher results. Treat CancellationError as normal. Unstructured Task at U I/VM boundary + cooperative cancel on each query change. Follow-ups. Invent debounce ms from prod?: No — don’t invent specific constants.. @MainActor VM role?: U I state updates on main while search Tasks cancel and restart.. ≤20s line?: “Debounced and cancelled the previous Task so stale responses couldn’t win.”.

## §5 Q6. What must you never invent?

Next. Q6. What must you never invent? Answer. ✅ G C D synchronised dictionaries at BMS — Verified S 2. ✅ Search debounce / M V V M — Verified S3. ❌ Actor migration shipped org-wide at BMS — use S 2-A1 only. ❌ Specific debounce milliseconds from production. ❌ S 2 caused app-wide 99.95% crash free sessions alone. Check registry before you speak; label Verified vs How I would apply it out loud. Follow-ups. Actor rewrite claim?: S 2-A1 — design judgment, not resume fact.. crash free sessions metric?: S 8 culture — don’t attach to S 2 alone.. Registry path?: provenance/README.md.

## §6 Q7. How do S2 and actors compare in an interview table?

Next. Q7. How do S2 and actors compare in an interview table? Answer. | Legacy S 2 | Greenfield S 2-A1 | SafeDict + serial queue: actor SafeDict. sync get / async set on queue: await get / await set. Manual discipline: Compiler isolation. queue.sync deadlock risk: Reentrancy across await. Same boundary idea — different enforcement and pitfall class. Follow-ups. When keep G C D?: Legacy stable modules that work — wrap at edges.. When choose actor?: New shared mutable state.. Mixing both in one app?: Expected at BMS scale — strangler, not big-bang..

## §7 Q8. Give a full honest answer mixing S2, S2-A1, and S3

Next. Q8. Give a full honest answer mixing S2, S2-A1, and S3 Answer. “Shared maps at BookMyShow raced under async access — we fixed that with synchronised dictionaries on serial queues and a closed A P I, Verified S 2. For new modules I’d expose the same surface on a Swift actor — S 2-A1 — and train on reentrancy. Search UX used debounce with M V V M — Verified S3 — and the concurrency piece I care about is cancelling the previous Task so stale network responses don’t clobber newer queries. I don’t claim we rewrote every dictionary to actors org-wide.” Follow-ups. Where is Verified?: S 2 dictionary fix; S3 search/debounce/M V V M.. Where is applied?: S 2-A1 actor migration for greenfield.. After this sample?: SafeDictActor.swift, then../04-questions.md.. After this sample 1. Read SafeDictActor.swift line by line. 2. Speak from Answer points in../04-questions.md. 3. Do timed drills in../05-exercises.md.
