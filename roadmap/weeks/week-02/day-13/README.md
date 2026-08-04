# Day 13 — DSA: Stack / Queue / Linked List

> Week 2 · Full study (self-contained) · ~5–6 hrs  
> Revision twin: [revision/weeks/week-02/day-13.md](../../../revision/weeks/week-02/day-13.md)

## Outcomes

By end of day, without notes, you can:

- Pick **Stack**, **Queue/Deque**, or **Linked List** (and know when Swift `Array` beats a linked list)
- State complexities for push/pop/enqueue/dequeue and classic patterns (monotonic stack, BFS queue, fast/slow)
- Deliver a crisp **2–3 min agenda-first coding approach** before typing Swift
- Implement worked solutions in `code/` (two-stack queue, min stack, reverse/cycle/merge list)
- Close one Week 2 theory gap without dropping Mock #2 prep tomorrow

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary (intern → senior)
2. `02-deep-dive.md` — patterns, complexities, Swift pitfalls, approach scripts (**embedded** — no LeetCode required to learn)
3. `03-production-bridge.md` — honest production bridges (refresh waiters, nav stacks)
4. `code/` — read and narrate the Swift before modifying
5. `04-questions.md` — cover full answers; speak from **Answer points**; compare
6. `05-exercises.md` — timed coding + speaking drills
7. Revision twin for flashcards / timed recall

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/](code/) |

## Provenance reminder

| Label | Meaning for today |
|---|---|
| **Learning-lab** | DSA patterns + Swift in `code/` — interview skill, not a shipped BMS feature |
| **Verified · S4 mindset** | Soft bridge: single-flight refresh **waiters** behave like a queue of continuations (Day 09) |
| **Verified · S6 / S13** | Soft bridge: nav / sheet back-stacks as LIFO mental models |
| **Verified · S12 adjacency** | Ring/circular buffer language adjacent to audio buffering — do not claim you shipped a ring-buffer audio engine |

Do **not** invent “I used linked lists in production UI” claims.

## Agenda opener (say this first in a coding round)

> “I’ll restate the problem, pick the structure and complexity, walk edges, then code iterative Swift — Array stack by default, and I’ll call out if Array-as-queue would be O(n).”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 40–50 |
| Deep dive + embedded patterns | 90–120 |
| Code narration | 45–60 |
| Production bridge | 15–20 |
| Questions (record 6–8) | 45–60 |
| Exercises (1 Easy + 1 Medium timed) | 45–60 |
| Week 2 catch-up (one weak day) | 45–60 |
| Revision twin skim | 15 |

## Source / version note

Swift 5+ / modern concurrency vocabulary OK when bridging to actors for hit-counter concurrency. Linked-list interview nodes are `class ListNode` — not Swift `Array`. Optional citations only at the end of `02-deep-dive.md` — this chapter is self-contained.
