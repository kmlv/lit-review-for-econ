---
name: lit-review-screen
description: Stage 4 helper for applying the tier rubric and producing SCREENED.md.
---

# lit-review-screen

Use when screening candidates after metadata retrieval.

## Workflow

1. Read coordination files if present and claim `SCREENED.md` plus
   `CANDIDATES.jsonl`.
2. Parse candidate records with a JSONL-aware workflow.
3. Apply the approved Tier 1/2/3 rubric from `DESIGN.md` and `CONFIG.md`.
4. Update `tier`, `tier_history`, `fetch_policy`, and screening reasons.
5. Write `SCREENED.md` grouped by tier, excluded, and borderline.
6. Flag demotions and borderline rejects for review.

Keep machine records and human summary synchronized.
