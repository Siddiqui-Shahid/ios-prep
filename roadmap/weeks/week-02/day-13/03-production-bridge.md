# 03 — Production Bridge: Honest DSA ↔ iOS Hooks

> Convert patterns into interview bridges **without** inventing “I shipped linked lists in Ads.”

## 1. Provenance map for today

| ID | Label | Exact claim you may make |
|---|---|---|
| Learning-lab | DSA chapter | Patterns + Swift in `code/` for interviews |
| **S4 mindset** | Soft bridge | Token refresh **waiters** are a queue of continuations awaiting one refresh (Day 09 / Verified S4 stack ownership mindset) |
| **S6** | Soft bridge | Navigation / sheet flows — LIFO back stack mental model; Verified metric **30%+** fewer full-screen navs for LE Bottom Sheet |
| **S13** | Soft bridge | Hybrid nav ownership — one router; stack discipline matters |
| **S12 adjacency** | Vocabulary only | Ring buffers appear in media buffering discussions — **not** “I built Aces audio as a ring buffer” |
| **S8** | Composure | Pivot mid-coding with calm ownership energy (IMOC culture) — don’t invent a DSA incident |

### Forbidden overclaims

- “We used linked lists for the feed.”  
- “I implemented LRU in production at BMS.” (unless you later add real evidence)  
- “Aces audio = my circular queue.”  
- Fake complexity wins as production metrics.

## 2. Structure → production bridge table

| Structure | Honest bridge | Interview line (≤20s) |
|---|---|---|
| Queue | Single-flight refresh waiters; serialise work | “I treat refresh waiters like a queue sharing one in-flight refresh — same FIFO mental model as BFS waiters.” |
| Stack | Nav back stack; undo; nested CMS parent stack | “UIKit nav is LIFO — same structure I’d use for parentheses matching.” |
| Deque / ring | Bounded buffers; sliding window max | “For bounded recent events I’d reach for a deque or ring — and I’d call out empty/full carefully.” |
| Linked list | Interview skill; LRU design interviews | “In Swift apps I prefer Array; I still practice pointer problems because machine rounds ask them.” |

## 3. Scripts

### Soft bridge — refresh waiters (S4 mindset)

> “On networking, concurrent 401s shouldn’t each refresh. Waiters line up — conceptually a queue — behind one refresh Task, then fan-out. That’s the same FIFO discipline as a BFS queue, applied to auth. The Verified work is the Ads URLSession security ownership; the waiter queue is the concurrency pattern we reason about in that layer.”

> **Provenance:** Learning-lab pattern · soft bridge to Verified · S4 / Day 09 single-flight

### Soft bridge — nav LIFO (S6 / S13)

> “Product navigation is a stack: push screens, pop on back. On LE Bottom Sheet we reduced full-screen pushes — Verified 30%+ fewer full-screen navigations — which is a product win on top of the same LIFO mental model.”

> **Provenance:** Verified · S6 · LE Bottom Sheet 30%+ · soft stack metaphor

### Honest LL answer

> “Linked lists rarely appear in my iOS UI code because Array has better locality and ergonomics. I use them in interviews for reverse/cycle/merge and when designing an LRU with a dict plus node list. I won’t pretend BMS Ads was a linked-list codebase.”

> **Provenance:** Learning-lab honesty

## 4. Interview line (≤20s) — day opener

> “For coding I’ll state structure and complexity first — for example monotonic stack O(n) — then write clean iterative Swift; and I’ll call out Array-as-queue costs when relevant.”

## 5. Tomorrow link — Mock #2

DSA today feeds composure, not the 5-min Ads/SDUI architecture talk. Still: choose **Ads or SDUI** track tonight so Day 14 isn’t cold.
