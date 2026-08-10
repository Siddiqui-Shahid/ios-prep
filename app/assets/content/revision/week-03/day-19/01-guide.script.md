# Audio script — Revision guide — Security: ATS, SSL Pinning, Keychain & Persistence
> Listen-only revision day guide from `day-19.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: A T S vs pinning — baseline HTTPS/TLS policy ≠ identity pin S P K I pinning mental model: SHA-256 of Subject Public Key Info DER — not raw SecKeyCopyExternalRepresentation bytes BookMyShow SSL pinning + URLSession migration: Ads Alamofire → URLSession, HTTPS, SSL pinning, domain whitelist.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 ATS vs pinning

Next. 2.1 ATS vs pinning. A T S enforces modern TLS on the system stack. Pinning verifies a specific public key or cert — defense-in-depth on top of A T S, not a substitute.

## §3 2.2 SPKI pinning

Next. 2.2 SPKI pinning. Hash the S P K I DER bytes from the certificate chain. Common sample-code mistake: hashing raw SecKeyCopyExternalRepresentation output — that is not S P K I DER.

## §4 2.3 Secrets and persistence

Next. 2.3 Secrets and persistence. Pick the store from sensitivity + access pattern — not one tool for everything.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow SSL pinning + URLSession migration: BookMyShow Ads — migrated Alamofire → URLSession with HTTPS, SSL pinning, and domain whitelist on the revenue-critical ads path. Design: pin rotation / break-glass (not shipped runbook): Pin rotation, backup pins, staged break-glass — design you can defend, not a claim you shipped the ops runbook. Interview line (≤20s): “On Ads I moved to URLSession with HTTPS, S P K I pinning, and a domain whitelist — and I treat rotation as a design conversation, not a hand-wavy ‘we pinned it’ answer.” → BookMyShow SSL pinning + URLSession migration SSL Pinning.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. A T S in one sentence — what it is and isn’t 2. S P K I DER vs SecKey raw bytes — why the difference matters 3. Pinning failure mode — bad rotation vs MITM 4. Domain whitelist — why alongside pinning.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
