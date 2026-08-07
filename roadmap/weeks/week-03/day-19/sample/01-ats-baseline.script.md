# Audio script — Sample 01 — ATS & transport baseline (Q&A)
> Listen-only sample Q&A from `01-ats-baseline.md`. Spoken answers and follow-ups.

## §0 Q1. What is ATS, in plain words?

Next. Q1. What is ATS, in plain words? Answer. App Transport Security (ATS) is Apple’s default policy that blocks accidental cleartext HTTP and pushes modern TLS expectations. It is the floor for transport — not a substitute for certificate pinning or a guarantee against MITM in hostile trust scenarios. Think: “HTTPS by default, no casual plaintext.” Follow-ups. Does ATS stop all MITM?: No. A device with a trusted rogue CA can still pass system chain validation. Pinning is an extra identity check on sensitive hosts.. Is ATS the same as pinning?: No. ATS ≠ pinning — say this aloud in interviews.. Where is ATS configured?: Info.plist exceptions and defaults; system enforces at the network layer..

## §1 Q2. What is the full transport security stack?

Next. Q2. What is the full transport security stack? Answer. Stack bottom to top: ATS (HTTPS/TLS defaults) → system certificate chain trust → optional SPKI pinning in URLSession delegate → domain allowlist (only call/pin known hosts). Each layer adds policy; none replaces the layer below. Follow-ups. What does system trust do?: Validates the server cert against Apple’s trusted CA store.. What does allowlist add?: Limits which hosts you talk to or pin — operational control, not global “pin the internet.”. Can you skip HTTPS if you pin?: No. Pinning is not a substitute for HTTPS..

## §2 Q3. What are ATS exceptions, and how should you treat them?

Next. Q3. What are ATS exceptions, and how should you treat them? Answer. ATS exceptions in Info.plist (e.g. allowing arbitrary loads or domain-specific cleartext) are technical debt. Justify each one — legacy partner, migration plan, expiry date. Never ship “Allow Arbitrary Loads” casually in production. Senior stance: exceptions need an owner and a sunset. Follow-ups. When might an exception be acceptable?: Short-lived migration from HTTP partner with a dated removal plan — not “we were in a hurry.”. Interview red flag?: “We disabled ATS globally” with no threat-model story.. Better fix than exception?: Move endpoint to HTTPS; proxy through your backend..

## §3 Q4. What is a domain allowlist, and why pair it with pinning?

Next. Q4. What is a domain allowlist, and why pair it with pinning? Answer. A domain allowlist restricts which hosts the app calls or pins. You only pin hosts you own or tightly control. Pairing allowlist + pinning prevents accidental calls to unvetted CDNs and keeps pin rotation scoped. Don’t pin arbitrary third-party CDNs you don’t operate — vendor cert rotation becomes your outage. Follow-ups. Allowlist without pinning?: Still useful — limits blast radius of misconfigured clients.. Pin every host?: Never casually. Pin sensitive, owned APIs (ads, auth, payments).. BMS Ads example?: BookMyShow SSL pinning + URLSession migration: domain whitelist alongside HTTPS and SSL pinning on URLSession..

## §4 Q5. ATS vs pinning vs system trust — quick contrast?

Next. Q5. ATS vs pinning vs system trust — quick contrast? Answer. ATS: blocks cleartext; sets TLS expectations — baseline policy. System trust: CA chain validation — standard HTTPS. Pinning: app-defined SPKI hash must match — extra identity check on sensitive APIs. Allowlist: only approved hosts. Senior line: “ATS is the floor; pinning is an extra check on sensitive hosts.” Follow-ups. “ATS is our pinning”?: Wrong. Forbidden claim in this chapter.. Low-sensitivity public JSON?: System trust + ATS may suffice; threat-model dependent.. Ads/revenue APIs?: Pin + allowlist + fail closed — BookMyShow SSL pinning + URLSession migration pattern..

## §5 Q6. What should I say in a ≤20s transport opener?

Next. Q6. What should I say in a ≤20s transport opener? Answer. “ATS gives us HTTPS-by-default and modern TLS — that’s the baseline, not pinning. On sensitive modules like Ads we moved to URLSession with HTTPS, SSL pinning, and a domain allowlist so we own trust evaluation end-to-end. Pinning without rotation thinking is an outage generator — that’s separate design work.” Follow-ups. Mention Alamofire?: Yes for BookMyShow SSL pinning + URLSession migration: migrated Alamofire → URLSession for trust-challenge ownership.. Lead with ATS on behavioral Q?: Start with what shipped (BookMyShow SSL pinning + URLSession migration); ATS as context layer.. Cleartext in debug only?: Still document; don’t leak to prod builds..

## §6 Q7. What transport mistakes fail senior interviews?

Next. Q7. What transport mistakes fail senior interviews? Answer. Top fails: (1) “ATS = pinning,” (2) pinning without HTTPS, (3) pinning every CDN, (4) soft-fail forever on Ads/auth (silent security regression), (5) ATS exceptions with no expiry plan. Correct stance: layered policy, fail closed on sensitive paths, ops mindset for rotation. Follow-ups. Soft-fail pinning when?: Low-sensitivity experiments only — never revenue/auth by default.. MITM on corporate proxy?: Real-world edge; design fail-closed vs break-glass explicitly.. Next topic?: SPKI mechanics — 02-ssl-pinning-spki.md..
