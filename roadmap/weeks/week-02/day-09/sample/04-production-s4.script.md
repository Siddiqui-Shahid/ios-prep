# Audio script — Sample 04 — Production S4 and adjacent hooks (Q&A)
> Listen-only sample Q&A from `04-production-s4.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S4?

Next. Q1. What can you claim under Verified · S4? Answer. Verified S4: BookMyShow Ads networking migrated Alamofire → URLSession with enforced HTTPS, SSL pinning, and domain whitelisting on a high-traffic, revenue-adjacent module. Goal was first-party transport security ownership and reduced dependency surface — not “libraries are evil.” You may not claim shadow traffic rollout, a shipped pin-rotation runbook, or that pinning alone moved crash-free rate. Follow-ups. Provenance tag?: Verified · S4 · BookMyShow · Ads; HTTPS; SSL pinning; domain whitelist.. Result line?: Reduced MITM exposure; simplified networking ownership on Ads pod path.. Lesson line?: Pinning needs rotation design (S4-A1) or keys changing bricks the app..

## §1 Q2. What is the S4 STAR story in plain steps?

Next. Q2. What is the S4 STAR story in plain steps? Answer. Situation: Ads sat on Alamofire; revenue-adjacent module needed stronger control of transport security. Action: Introduced URLSession-backed client behind protocol boundaries; enforced HTTPS; added pinning via trust evaluation; added host whitelist in the builder; treated rotation as incomplete without ops mindset (S4-A1 design). Result: First-party security controls and smaller dependency surface on that path. Lesson: Security controls need operational paired thinking — backup pins and break-glass are design you insist on. Follow-ups. 60s version?: Problem → URLSession + HTTPS + pin + whitelist → MITM ↓ → rotation design lesson.. Parity tests?: Status mapping, decode, error fixtures through protocol boundary.. Observe what after rollout?: TLS failure metrics + Ads health metrics you already have — don’t invent shadow traffic..

## §2 Q3. How do you answer “what happens when the cert rotates?”

Next. Q3. How do you answer “what happens when the cert rotates?” Answer. Label S4-A1 — How I would apply it. Ship ≥2 backup SPKI pins so planned key transitions don’t hard-brick; know who generates pins from SPKI DER; stage pin changes with canary/phased release and watch TLS failure metrics; define monitored break-glass (build flag or remote config) that is time-boxed, not silent forever-off. Default remains fail-closed for MITM resistance. You’re claiming the control set shipped on Ads and the design you’d insist on — not a named production runbook unless verified. Follow-ups. Backup pins verified shipped?: No — S4-A1 design.. Break-glass verified?: No — design; monitored if ever used.. Stale pin after rotate?: Mass TLS failures — why backup pins matter in design..

## §3 Q4. How do you hook S3 search cancel without overclaiming S4?

Next. Q4. How do you hook S3 search cancel without overclaiming S4? Answer. When asked about cancellation UX, pivot to Verified S3: debounce and cancel in-flight search; ignore cancellation errors; prevent out-of-order apply — sibling beat to networking, not part of S4 Ads migration. Networking chapter supplies the mechanism (Task cancel, generation guards); search chapter supplies the product proof on BMS. Follow-ups. S3 provenance?: Verified · S3 · search debounce / M V V M state.. Async vs callback story?: Prefer async URLSession + Task cancel; legacy dataTask needs explicit cancel.. Day 08 link?: Debounce lives in ViewModel — transport doesn’t own keystroke timing..

## §4 Q5. How does S5 relate to the networking stack?

Next. Q5. How does S5 relate to the networking stack? Answer. Verified S5: Firebase Performance traces; speak p50/p90 culture, not vanity averages. Networking relates via path latency in interceptors vs journey-level traces (listing → checkout) — placement is judgment (S5-A1 if you discuss span ownership). Avoid double-counting the same request in both interceptor and journey spans. Follow-ups. Client timeout vs backend p99?: Misaligned timeouts create self-inflicted errors — coherent with backend SLOs.. S5-A1 label?: How I would apply it — journey vs interceptor span placement.. Invented latency %?: Forbidden on S5 and S4 alike..

## §5 Q6. What is the payment retry hook (S7)?

Next. Q6. What is the payment retry hook (S7)? Answer. When interviewers ask about retries on charge POSTs, cite Verified S 7 payment UX intent: networking S D K must not blindly retry payment POSTs after 401 or 5xx. Checkout needs idempotency keys and explicit status polling discipline — generic “retry all methods” interceptors are how you duplicate charges. Single-flight refresh may retry GETs once; POSTs opt in only with server contract. Follow-ups. 401 on payment POST?: Refresh once, retry only if idempotent contract allows.. Generic retry helper?: Never global on all HTTP methods.. Drop-off % invented?: Forbidden on S 7 — speak intent only..

## §6 Q7. What is the ≤20s interview line for Day 09 production?

Next. Q7. What is the ≤20s interview line for Day 09 production? Answer. “I moved Ads off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module — and I’d pair pinning with backup pins and a break-glass design so rotation doesn’t brick the app.” Expand to 90s high level design with single-flight refresh, cancel split, cache boundaries, and SPKI correctness if whiteboarding. Follow-ups. Weak “why URLSession?”: “Libraries bad.” — Strong: threat/value on Ads justified first-party control.. ATS enough alone?: Baseline HTTPS policy; pinning is extra identity for threat model.. Next day link?: Day 10 S D U I uses repository/offline cache; Day 09 whitelist mindset applies to action URLs.. Back to: README.md · Main questions:../04-questions.md.
