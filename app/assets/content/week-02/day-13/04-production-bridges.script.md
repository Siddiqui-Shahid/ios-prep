# Audio script — Sample 04 — Production story bridges (Q&A)
> Listen-only sample Q&A from `04-production-bridges.md`. Spoken answers and follow-ups.

## §0 Q1. What production claims are allowed for Day 13 DSA?

Next. Q1. What production claims are allowed for Day 13 DSA? Answer. Learning-lab: patterns + Swift in code/ for interviews. Soft bridges only: BookMyShow SSL pinning + URLSession migration mindset — refresh waiters as FIFO queue of continuations (Day 09). BookMyShow LE Bottom Sheet/Hybrid U I / deeplinks — nav back stack as LIFO mental model; Verified 30%+ nav metric for LE sheet. Audio streaming + server-driven splash (Aces) adjacency — ring buffer vocabulary for media, not “I built Aces ring engine.” BookMyShow I M O C + crash-free at scale — composure pivot energy, not a D S A incident story. Follow-ups. Forbidden?: “We used linked lists for the feed”; fake LRU in prod at BMS; fake complexity wins as metrics.. Verified D S A feature?: None — interview skill chapter.. Tomorrow link?: D S A feeds composure for Mock #2 — pick Ads or S D U I track tonight..

## §1 Q2. How do refresh waiters bridge to a queue? (BookMyShow SSL pinning + URLSession migration mindset)?

Next. Q2. How do refresh waiters bridge to a queue? (BookMyShow SSL pinning + URLSession migration mindset)? Answer. Concurrent 401s shouldn’t each refresh independently. Waiters line up behind one refresh Task — conceptually a FIFO queue of continuations — then fan-out when refresh completes. Same discipline as BFS queue, applied to auth. Verified work is Ads URLSession security ownership (BookMyShow SSL pinning + URLSession migration); waiter queue is the concurrency pattern you reason about in that layer — label Learning-lab / soft bridge. Follow-ups. ≤20s line?: “Refresh waiters share one in-flight refresh — FIFO mental model like a BFS queue of continuations.”. Stampede failure?: N×401 → N refresh calls — single-flight fixes.. Mock #2 tricky?: Refresh stampede + pin outage leadership — Day 14..

## §2 Q3. How does navigation bridge to a stack? (BookMyShow LE Bottom Sheet / Hybrid UI / deeplinks)?

Next. Q3. How does navigation bridge to a stack? (BookMyShow LE Bottom Sheet / Hybrid UI / deeplinks)? Answer. Product navigation is LIFO: push screens, pop on back. LE Bottom Sheet reduced full-screen pushes — Verified 30%+ fewer full-screen navigations (BookMyShow LE Bottom Sheet). Hybrid apps still need one router — stack discipline matters when deeplinks push (Hybrid U I / deeplinks). Metaphor supports intuition; don’t claim UIKit literally implements parentheses matching. Follow-ups. Sheet vs push?: Sheet cuts nav fatigue for shallow overview — BookMyShow LE Bottom Sheet product win.. Dual stacks?: Anti-pattern — one owner (Day 11).. Undo stack?: Same LIFO — valid parentheses cousin..

## §3 Q4. What is the honest linked-list interview answer?

Next. Q4. What is the honest linked-list interview answer? Answer. “Linked lists rarely appear in my i O S U I code because Array has better locality and ergonomics. I use them in interviews for reverse/cycle/merge and when designing an LRU with a dict plus node list. I won’t pretend BMS Ads was a linked-list codebase.” Provenance: Learning-lab honesty. Follow-ups. LRU design interview?: Hash map + doubly linked list — legitimate LL use case.. UITableView?: Array-backed — not LL nodes.. When Array beats LL?: Random access, cache, Swift algorithms — almost always in U I..

## §4 Q5. What is the Day 13 opener line?

Next. Q5. What is the Day 13 opener line? Answer. “For coding I’ll state structure and complexity first — for example monotonic stack O(n) — then write clean iterative Swift; and I’ll call out Array-as-queue costs when relevant.” Pair with universal agenda: restate, brute, optimize, edges, then code. Follow-ups. Array removeFirst?: Call out O(n) or name alternative.. Two-stack queue?: Say amortized O(1).. Record practice?: 07-revision-qna — speak 6–8 answers..

## §5 Q6. How does DSA composure help in mixed interviews?

Next. Q6. How does DSA composure help in mixed interviews? Answer. Interviewer pivots coding → S D U I mid-problem: park state (“I have prev/curr wired through node 3…”), answer S D U I with versioning + unknown skip (Day 10 / BookMyShow backend-driven header & search), offer to resume coding. Shows calm ownership (BookMyShow I M O C + crash-free at scale I M O C energy) without inventing a D S A production incident. Also: pick one weak Week 2 day for 45–60m catch-up — still finish timed D S A drill. Follow-ups. Weak on hybrid?: Day 11 + Hybrid U I / deeplinks opener.. Weak on identity?: Day 12 + Stories S D K (Raw / Miami Heat) opener.. Mock #2 tonight?: Choose Ads or S D U I architecture track..

## §6 Q7. What should I do after Day 13 sample?

Next. Q7. What should I do after Day 13 sample? Answer. Finish timed drills in../05-exercises.md — one Easy + one Medium. Record 6–8 answers from 07-revision-qna.md. Choose Ads or S D U I for tomorrow’s Mock #2. Skim../../day-14/sample/ for mock format and architecture spines. Follow-ups. Skip D S A for mock prep?: No — composure matters; don’t let basics block.. Week 2 catch-up?: One weak day only — don’t skip today’s drill.. Revision twin?: revision/weeks/week-02/day-13.md.
