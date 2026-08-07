# Audio script — Flashcards — Security: ATS, SSL Pinning, Keychain & Persistence
> Listen-only flashcard Q&A from `week-03.md`. Spoken answers.

## §0 Q1. ATS

Next. A T S? Answer. System HTTPS/TLS baseline — not pinning.

## §1 Q2. SPKI

Next. S P K I? Answer. Hash of S P K I DER — not SecKeyCopyExternalRepresentation raw bytes.

## §2 Q3. BookMyShow SSL pinning + URLSession migration

Next. BookMyShow SSL pinning + URLSession migration? Answer. Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist.

## §3 Q4. Design: pin rotation / break-glass (not shipped runbook)

Next. Design: pin rotation / break-glass (not shipped runbook)? Answer. Rotation / backup / break-glass = design judgment — not “shipped runbook”.

## §4 Q5. Tokens

Next. Tokens? Answer. Keychain only — never UserDefaults.

## §5 Q6. Persistence

Next. Persistence? Answer. Pick store from sensitivity + access pattern — not one tool for everything.
