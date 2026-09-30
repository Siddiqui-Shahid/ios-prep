# How this 60–90 minute ride plan works

You travel **Mumbai → Pune → Mumbai**. Door-to-door can be many hours. **Study time on the journey is only about 60–90 minutes** (one focused block). The rest is noise, food, tickets, and rest. This guide is still **complete inside the app** — you should not need Google — but the **itinerary is 1–1.5 hours**, not eight hours of studying.

## What “done” means for one ride

In **60–90 minutes** you will:

1. Speak **iOS basics** you actually get asked: **ARC** (Automatic Reference Counting: Swift frees an object when nobody strongly owns it), value vs class, **MainActor** (the UI-thread actor).
2. Walk one **LLD** (Low-Level Design: classes, sequence of calls, `URLSession`, persistence) — a feed or checkout on paper.
3. Walk one **HLD** (High-Level Design: CDN, API, cache, consistency, mobile constraints) using the 45-minute agenda compressed.
4. Touch **one** of the **30 machine design questions** (the first-class section on Home) **or** a 10-minute prototype sketch.

Optional **+15 minutes overflow** only if the train is delayed and you still have focus: a second question from the 30.

## Keywords everywhere

Every jargon term is written as **the term** followed by a parenthesis. Example: **ARC** (Automatic Reference Counting: Swift’s memory management that tracks how many owners an object has so unused objects are freed).

## Travel context

| Reality | Rule |
|---|---|
| ~1–1.5h of real attention | Follow Trip A–E clocks. Stop when the block ends. |
| Ghat tunnels / weak signal | Everything is offline in this app. |
| Two directions per week | **A** outbound, **B** return. Rotate **C/D/E** next week. |
| Driver | Do not use this app. Passenger only. |

## How to use the app

1. Open **On this ride** — start with **Trip A or B** (the 60–90 min clock).
2. Jump to **iOS basics / LLD / HLD** only as the clock says — they are reference chapters, not a second 8-hour course.
3. Open **30 machine design questions** for the last 15–20 minutes.
4. Archived 4-week Q&A stays in **Library**. Do not start Week 1 on the train.

## 60–90 minute skeleton (all trips use this)

| Elapsed | Minutes | Block |
|---|---|---|
| 0:00–0:05 | 5 | Agenda out loud (20 seconds) + open today’s trip chapter |
| 0:05–0:20 | 15 | iOS basics: speak ARC, struct vs class, async/await vs GCD |
| 0:20–0:40 | 20 | LLD: draw View → ViewModel → Repository → URLSession → Store |
| 0:40–1:05 | 25 | HLD: 45-minute framework in 25 minutes + one product sketch |
| 1:05–1:25 | 20 | One machine-design question **or** a 10-min prototype sketch |
| 1:25–1:30 | 5 | Recap: 3 terms + 1 failure mode |
| (optional) +15 | 15 | Second question from the 30 |

If you only have **60 minutes**, drop the prototype and stop after one question.

## Spoken 20-second agenda

> “I have ninety minutes. Basics, then LLD of a feed client, then HLD of cache and pagination, then one machine-design question. I will timebox.”
