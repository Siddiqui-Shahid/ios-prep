# Audio script — Revision guide — URLSession Networking · Refresh · Pinning
> Listen-only revision day guide from `day-09.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: A clean networking pipeline: endpoint → build → intercept → execute → decode → map errors Single-flight token refresh: many concurrent 401s share one refresh; retry originals once Task cancellation with async/await vs callback APIs.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Pipeline shape

Next. 2.1 Pipeline shape. Endpoint describes path/method/body → builder assembles URLRequest → interceptors attach auth/headers → execute via URLSession → decode DTO → map to typed domain errors. Keep transport out of ViewModels.

## §3 2.2 Refresh + cancel

Next. 2.2 Refresh + cancel. Single-flight: first 401 starts refresh; concurrent callers enqueue as waiters (FIFO continuations); one refresh completes; fan-out retries originals once — no refresh stampede. Cancellation: URLSession.data(for:) participates in Task cancellation. Callback APIs need explicit task.cancel() plus generation/stale guards.

## §4 2.3 Security layers

Next. 2.3 Security layers. 2.3 Security layers.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. Suggested sample order: 01-networking-layer → 02-refresh-and-cancel → 03-pinning-security → 04-production-s4.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow SSL pinning + URLSession migration: BookMyShow Ads — migrated Alamofire → URLSession; enforced HTTPS, SSL pinning, domain whitelisting on a revenue-critical module. Design: pin rotation / break-glass (not shipped runbook): Pin rotation, backup pins, break-glass as design judgment — not a shipped ops runbook. Interview line (≤20s): “I migrated Ads networking to URLSession so we owned transport security — HTTPS, pinning, and a domain whitelist on a high-traffic revenue path.” → BookMyShow SSL pinning + URLSession migration Ads networking.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. Networking pipeline end-to-end in one breath 2. Single-flight refresh — why not one refresh per 401? 3. Async cancel vs callback cancel 4. A T S vs pinning vs whitelist — three different jobs.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
