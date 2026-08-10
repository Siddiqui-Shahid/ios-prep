# Audio script — Sample 04 — Synchronised dictionaries & actor SafeDict design (Q&A)
> Listen-only sample Q&A from `04-production-s2.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under BookMyShow synchronised dictionaries?

Next. Q1. What can you claim under BookMyShow synchronised dictionaries? Answer. “At BookMyShow, shared async state was hitting dictionaries from multiple places. We gated them with G C D serial queues — and read-write locks where reads dominated. I introduced a closed access A P I so call sites couldn’t touch the raw storage. That killed concurrent-access crashes on that shared-state path, and we reused the pattern where mutable maps were shared. What I don’t claim: that this alone produced app-wide 99.95% crash-free. That’s I M O C and crash-free culture at scale — different scope.” Follow-ups. ≤15s opener?: “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.”. What caused crashes?: “Unsynchronized dictionary mutation from multiple async contexts — data races.”. Forbidden overclaim?: “‘Synchronised dictionaries alone gave us 99.95% crash free sessions.’”.

## §1 Q2. What was the fix, technically?

Next. Q2. What was the fix, technically? Answer. “Hide storage behind an A P I. Writes go on a serial queue. Reads sync for a safe snapshot. RW lock where reads dominated. Call sites never touch the raw dictionary. Lesson: serialize mutation at the boundary — don’t sprinkle locks everywhere. Trade-offs: sync reads can deadlock if you misuse the same queue; extreme read contention may need a different strategy.” Follow-ups. Why closed A P I?: “Stops ‘just grab the dict’ races at random call sites.”. Validation?: “Concurrency stress plus Crashlytics watch for that failure mode.”. Tie to Day 04?: “Same serial-queue mental model. Day 05 adds the actor alternative.”.

## §2 Q3. What is Design: actor SafeDict — and what is it not?

Next. Q3. What is Design: actor SafeDict — and what is it not? Answer. “That’s ‘how I would apply it’ — not a verified org-wide BMS rewrite. For greenfield shared maps, I’d expose the same safe get/set surface on a Swift actor so isolation is compiler-checked. Keep the A P I idea from synchronised dictionaries — hide storage, serialize mutation — change the implementation to language-native isolation. The pitfall shifts from queue.sync deadlock to actor reentrancy. I’d train the team to re-validate after await.” Follow-ups. Big-bang rewrite?: “No — strangler at new module boundaries.”. Generics?: “Key: Hashable & Sendable, Value: Sendable — see SafeDictActor.”. Never return what?: “A mutable interior reference callers can race on.”.

## §3 Q4. Pitch S2 → actor migration in 45–60 seconds?

Next. Q4. Pitch S2 → actor migration in 45–60 seconds? Answer. “Production fix was G C D serial-queue dictionaries — BookMyShow synchronised dictionaries. For greenfield shared maps I’d use an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite stable modules for fashion — strangler-migrate at boundaries. Trade-off: reentrancy at await instead of sync deadlock — state must be re-validated after await.” Mention snapshot/get/remove A P I parity with SafeDictActor.swift. Follow-ups. Step 1 of strangler?: “Don’t big-bang every call site in a revenue app.”. Leave legacy when?: “Stable G C D dict until a feature touch requires change.”. Bridge one-liner?: “Same boundary idea — compiler isolation, revalidate after await.”.

## §4 Q5. How does BookMyShow search tie to Task cancellation?

Next. Q5. How does BookMyShow search tie to Task cancellation? Answer. “Backend-driven header & search at BookMyShow covers the header, search debounce, clear loading/empty/error state, and M V V M. For Day 05 the slice is: debounce is not only sleep — cancel the previous in-flight Task so a slower older response can’t overwrite fresher results. Treat CancellationError as normal. Unstructured Task at the U I/VM boundary, cooperative cancel on each query change.” Follow-ups. Invent debounce ms?: “No — don’t invent production constants.”. MainActor VM?: “U I state on main while search Tasks cancel and restart.”. ≤20s line?: “Debounced and cancelled the previous Task so stale responses couldn’t win.”.

## §5 Q6. What must you never invent?

Next. Q6. What must you never invent? Answer. “I can say: G C D synchronised dictionaries at BMS. Search debounce and M V V M from backend-driven header & search. I cannot say: we shipped an org-wide actor rewrite — that’s design-only SafeDict. I don’t invent debounce milliseconds. I don’t hang 99.95% crash free sessions on the dictionary fix alone. Check provenance before you speak, and label verified vs how-I-would-apply it out loud.” Follow-ups. Actor rewrite claim?: “Design: actor SafeDict — judgment, not resume fact.”. crash free sessions metric?: “I M O C + crash-free culture — don’t attach to dictionaries alone.”. Registry?: provenance/README.md.

## §6 Q7. How do you compare GCD SafeDict vs actor SafeDict?

Next. Q7. How do you compare GCD SafeDict vs actor SafeDict? Answer. “Legacy: SafeDict plus serial queue, sync get / async set, manual discipline, sync-deadlock risk. Greenfield design: actor SafeDict, await get / await set, compiler isolation, reentrancy across await. Same boundary idea — hide storage, one writer path — different enforcement and different pitfall.” Follow-ups. When keep G C D?: “Legacy stable modules that work — wrap at edges.”. When choose actor?: “New shared mutable state.”. Mixing both?: “Expected at BMS scale — strangler, not big-bang.”.

## §7 Q8. Full honest answer mixing all three stories?

Next. Q8. Full honest answer mixing all three stories? Answer. “Shared maps at BookMyShow raced under async access — we fixed that with synchronised dictionaries on serial queues and a closed A P I. For new modules I’d expose the same surface on a Swift actor — design, not shipped org-wide — and train on reentrancy. Search UX used debounce with M V V M, and the concurrency piece I care about is cancelling the previous Task so stale network responses don’t clobber newer queries. I don’t claim we rewrote every dictionary to actors.” Follow-ups. What’s verified?: “Dictionary race fix; search debounce / M V V M.”. What’s applied judgment?: “Actor SafeDict for greenfield.”. After this?: SafeDictActor.swift, then 07-revision-qna.md..

## §8 Q9. Give the full S2 STAR in about two minutes?

Next. Q9. Give the full S2 STAR in about two minutes? Answer. “Situation: shared maps were read and written from multiple async contexts, which caused intermittent crashes. Task: stop the races on that path. Action: we hid storage behind a synchronised-dictionary A P I — writes on a serial queue, reads synchronized for a safe snapshot, reader-writer where reads dominated. Call sites never touched the raw dictionary. Result: that race class went away on that path; we reused the pattern where mutable maps were shared. Trade-off: sync reads can deadlock if you misuse the same queue, and heavy read contention may need another strategy. Today, for greenfield modules, I’d consider a Swift actor with the same A P I surface. I don’t claim this alone produced app-wide crash-free percent.” Follow-ups. ≤15s opener only?: “We had races on shared dictionaries — serial-queue design and trade-offs vs actors.”. Lesson in one line?: “Serialize mutation at the boundary — don’t sprinkle locks ad hoc.”.

## §9 Q10. Speak the three short bridges — GCD, cancel, settings?

Next. Q10. Speak the three short bridges — GCD, cancel, settings? Answer. “Bridge A — G C D to actors: we serialized dictionary access with G C D. Actors are the language-native equivalent for new code: same boundary idea, compiler isolation, but revalidate after await. Bridge B — cancellation: unstructured Tasks need ownership. In search I store the Task and cancel on each query change so cancellation is product behavior, not an afterthought. Bridge C — settings humility: under Swift 6 checking when enabled, Sendable and isolation violations become errors. Default MainActor isolation is a setting, not something I assert as universal.” Follow-ups. Which bridge for migration question?: “A — S 2 to S 2-A1.”. Which for search?: “B — S3 cancel.”. Which when they say ‘Swift 6 does X’?: “C — when enabled.”.
