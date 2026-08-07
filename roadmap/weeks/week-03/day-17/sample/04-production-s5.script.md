# Audio script — Sample 04 — Firebase Performance traces (Q&A)
> Listen-only sample Q&A from `04-production-s5.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under BookMyShow Firebase Performance traces?

Next. Q1. What can you claim under BookMyShow Firebase Performance traces? Answer. Instrumented Firebase Performance traces around listing, checkout, and search. Reported p50 and p90, not averages — tails on weak devices and peak traffic stayed visible. Used traces to prioritise optimisation with PM and backend. Treated traces as observability across releases. You may not claim in-house APM S D K, invented ms SLAs, or “Leaks showed retain cycles” as Verified BMS workflow. Follow-ups. Provenance tag?: BookMyShow Firebase Performance traces · BookMyShow · Firebase Performance p50/p90. ≤20s line?: “I instrumented Firebase Performance for listing, checkout, and search — p50/p90 so release decisions followed real tails, not averages.”. What BookMyShow Firebase Performance traces is not?: MetricKit subscriber as personal shipped work without evidence..

## §1 Q2. Walk the BookMyShow Firebase Performance traces STAR spine

Next. Q2. Walk the BookMyShow Firebase Performance traces STAR spine Answer. Opener: Journey-level observability with Firebase Performance. S/T: Data-driven latency visibility on business-critical journeys — desk anecdotes insufficient at scale. Action: Traces on listing/checkout/search; p50/p90 reporting; PM/backend prioritisation; regression watch across releases. Result: Observability layer grounded in percentiles. Lesson: p90 average for user-perceived pain; lab attributes, field decides priority. Follow-ups. Situation scale signal?: Consumer app — “feels slow” insufficient for prioritisation.. Backend conversation example?: Checkout p90 high, CPU clean → network/backend investigation.. Release culture?: Traces as regression watch — Day 20 CI gates bridge..

## §2 Q3. Journey traces vs interceptor spans (BookMyShow Firebase Performance traces-A1)?

Next. Q3. Journey traces vs interceptor spans (BookMyShow Firebase Performance traces-A1)? Answer. Journey-level traces for product SLIs and PM conversations — clear start/stop tied to user outcome. Per-request interceptor spans for debugging A P I chatter — carefully, with cardinality hygiene. Label Design: BookMyShow Firebase Performance traces-A1 when describing placement judgment beyond Verified Firebase journey work. Follow-ups. Cardinality example?: URL templates /user/:id — not raw URLs with PII.. Unbounded interceptor risk?: Noise, cost, alert fatigue.. When add interceptor?: During targeted A P I chatter investigation — not default everywhere..

## §3 Q4. How do Audio streaming + server-driven splash (Aces), BookMyShow LE Bottom Sheet, and BookMyShow backend-driven header & search hook adjacent?

Next. Q4. How do Audio streaming + server-driven splash (Aces), BookMyShow LE Bottom Sheet, and BookMyShow backend-driven header & search hook adjacent? Answer. Audio streaming + server-driven splash (Aces) Verified: server-driven splash / cold-start product — TTI mindset, no fake ms. BookMyShow LE Bottom Sheet Verified: LE Bottom Sheet — 30%+ flows fewer full-screen navigations — UX performance. BookMyShow backend-driven header & search Verified: search debounce/cancel — pair with search journey traces. Keep BookMyShow Firebase Performance traces as hero observability story; adjacent hooks answer pivots. Follow-ups. BookMyShow LE Bottom Sheet one-liner?: Performance isn’t only CPU — fewer navigations cut stack cost.. BookMyShow backend-driven header & search search checklist?: Debounce, cancel in-flight, ignore stale results.. Collapse into one STAR?: No — match hook to question; BookMyShow Firebase Performance traces stays Firebase p50/p90 core..

## §4 Q5. What Instruments correctness do you say in perf interviews?

Next. Q5. What Instruments correctness do you say in perf interviews? Answer. “For abandoned VCs / retain cycles I use Memory Graph and Allocations. Leaks is for unreachable memory — cycles usually won’t show there.” Label as technical correctness — Applied/Learning when implying personal BMS triage unless you add evidence. Do not claim Leaks found cycles at BMS as Verified. Follow-ups. Why mention in perf day?: Interviewers blend memory + perf — correctness trap.. Pair with BookMyShow Firebase Performance traces?: Field p90 for priority; Graph/Allocations for lab memory attribution.. Day 03 depth?: A R C cycles — today only Instruments trap..

## §5 Q6. What anti-patterns must you refuse?

Next. Q6. What anti-patterns must you refuse? Answer. Average-only wins. FPS vanity without hitch rate/device class. Time Profiler on wait-bound latency. Single “performance score” instead of SLI set. Invented cold-start ms or internal alert thresholds as Verified facts. Follow-ups. Small SLI set to name?: Cold start p90, journey p90 (listing/checkout/search), hitch, crash free sessions — with hang gap (Day 18).. PM-friendly metric?: p90 checkout latency movement — not average.. Lab without field?: Insufficient for fleet-only regressions..

## §6 Q7. Give a full honest BookMyShow Firebase Performance traces + correctness answer

Next. Q7. Give a full honest BookMyShow Firebase Performance traces + correctness answer Answer. “I instrumented Firebase Performance on listing, checkout, and search with p50/p90 (BookMyShow Firebase Performance traces) — release and optimisation discussions followed tails, not averages. In lab, I attribute CPU with Time Profiler and hitches; for memory cycles I’d use Memory Graph and Allocations, not Leaks (Applied correctness). Field percentiles decide priority; Instruments names the bottleneck class.” Follow-ups. Verified portion?: Firebase traces, three journeys, p50/p90.. Applied portion?: Memory tool order when cycles suspected.. After this sample?:../04-questions.md,../05-exercises.md..
