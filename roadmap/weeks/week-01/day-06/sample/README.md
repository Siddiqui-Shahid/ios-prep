# Day 06 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 06 modules. 
> Use this when you want DSA concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice approach scripts in [`../07-revision-qna.md`](../07-revision-qna.md) and timed solves in [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-approach-scripts.md](01-approach-scripts.md) | 60–90s opener: clarify → brute → optimize → edges | Foundations · Deep dive |
| [02-two-pointers-window.md](02-two-pointers-window.md) | Two pointers vs sliding window signals | Foundations · Deep dive |
| [03-strings-swift.md](03-strings-swift.md) | Swift String indexing, `[Character]` when needed | Foundations · Deep dive |
| [04-patterns-drills.md](04-patterns-drills.md) | Hash/prefix patterns, time/space speak, Week 1 core set | Foundations · Deep dive · code |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Search autocomplete | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Say-this-first | Clarify → brute → optimize → edges — **before** typing |
| Two pointers | Two indices, invariant, move the side that restores it |
| Sliding window | Expand right; shrink left when invariant breaks |
| Swift String | Not O(1) random index — say the cost if you convert |
| Communication | Process narration beats a silent clever trick |
| Week 1 minimum | 8 core problems in [`../01-foundations.md`](../01-foundations.md) §5 |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../07-revision-qna.md`](../07-revision-qna.md).
