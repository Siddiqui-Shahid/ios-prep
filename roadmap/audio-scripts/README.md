# Audio scripts — format guide

Spoken scripts are a **listen-only audiobook** of each chapter.

## Listener assumption

Assume the listener is **only listening** (walking, eyes closed, phone in pocket).

- Do **not** say “look at the screen”, “in the text”, “follow along visually”
- Explain every idea fully in speech, from the basics
- Narrate code and diagrams in plain words (not syntax dumps)
- Keep the same ideas and coverage as the markdown chapter

## Style

- **Very simple English** — short sentences (about 8–16 words when possible)
- Everyday words first; then the Swift term
- For each idea: what it is → why it matters → example in words → what to remember
- **No slang** (avoid unexplained “north star”, “alright”, “trip-up”)
- If a heading uses a hard phrase, explain it once in plain words

## Resume-safe shortforms

Keep shortforms that appear on the resume (spell for the ear):

- `U I`, `A I`, `P O P`, `A P I`, `G C D`, `M V V M`, `S D K`, `S D U I`, `U I kit`, `Swift U I`

Expand uncommon ones (do **not** leave unexplained letter-soup):

- `PAT` → “protocol with associated type”
- `COW` → “copy on write”
- `DTO` → “data transfer object”
- `ARC` → “automatic reference counting”

## Location

```
roadmap/weeks/week-NN/day-DD/01-foundations.script.md
```

```bash
python3 app/scripts/generate_scripts.py
./app/scripts/sync_content.sh
```

## File shape

```markdown
# Audio script — 01 Foundations
> Listen-only audiobook. Simple English. Basic explanations. Does not assume a screen.

## §0 Introduction
Next. Introduction.
...
```

## Rules

1. Self-contained for ears — no visual references
2. Same coverage as the chapter; depth from basics, not jargon
3. Expand tables into sentences; narrate code by meaning
4. Questions: speak Answer points, then the Full spoken answer
5. Preserve Verified vs How I would apply it honesty
6. Simplicity check must pass (no unexplained PAT, no “on screen”)
