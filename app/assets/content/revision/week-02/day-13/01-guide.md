# Day 13 — DSA: Stack · Queue · Linked List

> Week 2 · Revision pass ~45–60 min  
> Full study: [weeks/week-02/day-13/](../../../weeks/week-02/day-13/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-13/sample/](../../../weeks/week-02/day-13/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Stack (LIFO) and queue (FIFO) — complexity and Swift footguns
- Monotonic stack, valid parentheses, min stack, two-stack queue
- Linked list classics: reverse, Floyd cycle, merge — with Swift honesty
- Agenda-first coding: spoken plan before typing
- Soft production bridges — without inventing “linked lists in the feed”

## 2. Concept refresh (simple)

### 2.1 Stack & queue

| Structure | Order | Swift note |
|---|---|---|
| **Stack** | LIFO | `Array` append/pop — O(1) amortized |
| **Queue** | FIFO | `removeFirst()` is **O(n)** — call it out |
| **Two-stack queue** | FIFO | **Amortized** O(1) — not strict every dequeue |

Navigation back stack is LIFO. Single-flight refresh waiters are FIFO continuations (soft BookMyShow SSL pinning + URLSession migration bridge).

### 2.2 Monotonic stack patterns

Valid parentheses, daily temperatures, next greater element — scan once, push/pop indices or values. State **monotonic** property gives O(n).

### 2.3 Linked lists in Swift apps

Interview skill + LRU design vocabulary — **not** everyday UITableView implementation. Prefer `Array` for locality and ergonomics in production UI code.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Array as queue | `removeFirst()` is **O(n)** — call it out or use two-stack / Deque |
| Two-stack queue | **Amortized** O(1) — not strict O(1) every dequeue |
| Linked list in Swift apps | Interview skill + LRU design — **not** everyday UITableView |
| Agenda-first | 2–3 min spoken plan **before** typing |
| BookMyShow SSL pinning + URLSession migration bridge | Refresh **waiters** = FIFO queue of continuations (soft, not shipped LL) |
| Forbidden | “We used linked lists for the feed” |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-13/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-02/day-13/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-02/day-13/sample/07-revision-qna.md) | Timed answers |

Suggested sample order: `01-stack-queue-basics` → `02-monotonic-patterns` → `03-linked-list-algos` → `04-production-bridges`.

## 4. Map to your work

**Soft bridge · BookMyShow SSL pinning + URLSession migration mindset:** Token refresh waiters queue behind one in-flight refresh — FIFO discipline, not a shipped linked-list module.  
**Soft bridge · BookMyShow LE Bottom Sheet:** Nav is LIFO; LE Bottom Sheet reduced full-screen pushes — verified **30%+** fewer full-screen navigations.  
**Soft bridge · Hybrid UI / deeplinks:** One router; stack discipline in hybrid nav.

**Interview line (≤20s):** “For coding I state structure and complexity first — monotonic stack O(n) — then write clean iterative Swift; linked lists are interview skill, not my UITableView default.”

→ [BookMyShow SSL pinning + URLSession migration Networking](../../stories/story-bank.md#s4--ads-networking-migration-bookmyshow) · [BookMyShow LE Bottom Sheet Bottom Sheet](../../stories/story-bank.md#s6--le-bottom-sheet-bookmyshow)

## 5. Flash prompts

1. Stack vs queue — one example each + complexity
2. Why `Array.removeFirst()` is a footgun
3. Two-stack queue — amortized vs strict O(1)
4. Monotonic stack — when and why O(n)
5. Reverse linked list — iterative vs recursive trade-off
6. Floyd cycle detection — fast/slow pointer intuition
7. Honest LL in Swift apps — interview vs production
8. Agenda-first opener before coding

## 6. Timed drills

| Drill | Budget |
|---|---|
| Valid parentheses (monotonic stack) | 15 min |
| Two-stack queue implement + complexity | 10 min |
| Reverse LL iterative | 10 min |
| Spoken agenda before any coding | 2–3 min |
| Soft BookMyShow SSL pinning + URLSession migration waiter bridge | 30s |

Expand from [sample cards](../../../weeks/week-02/day-13/sample/) and [07-revision-qna](../../../weeks/week-02/day-13/sample/07-revision-qna.md) answer points. Pick Ads or SDUI track tonight for Day 14.
