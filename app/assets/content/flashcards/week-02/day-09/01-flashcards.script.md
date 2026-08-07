# Audio script — Flashcards — URLSession Networking Layer
> Listen-only flashcard Q&A from `week-02.md`. Spoken answers.

## §0 Q1. Pipeline

Next. Pipeline? Answer. Endpoint → build → intercept → execute → decode → map errors.

## §1 Q2. Single-flight

Next. Single-flight? Answer. Many concurrent 401s share one refresh; retry originals once.

## §2 Q3. Async cancel

Next. Async cancel? Answer. URLSession.data(for:) participates in Task cancellation.

## §3 Q4. Callback cancel

Next. Callback cancel? Answer. Explicit task.cancel() + generation/stale guard.

## §4 Q5. ATS ≠ pinning

Next. A T S ≠ pinning? Answer. A T S is HTTPS baseline; pinning is extra identity check.

## §5 Q6. SPKI

Next. S P K I? Answer. Hash S P K I DER — not raw SecKeyCopyExternalRepresentation bytes.

## §6 Q7. BookMyShow SSL pinning + URLSession migration verified

Next. BookMyShow SSL pinning + URLSession migration verified? Answer. Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist.

## §7 Q8. Design: pin rotation / break-glass (not shipped runbook)

Next. Design: pin rotation / break-glass (not shipped runbook)? Answer. Pin rotation / backup pins / break-glass = design, not shipped runbook.
