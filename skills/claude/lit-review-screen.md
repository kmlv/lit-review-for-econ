---
name: lit-review-screen
description: Stage 4: screen candidates into tiers, exclusions, and borderline review items.
---

# /lit-review-screen

Use this skill after `/lit-review-fetch` to produce a human-readable screening
summary and final v0.1 tier assignments.

## Inputs

- `lit-review/CANDIDATES.jsonl`
- `lit-review/SCOPE.md`
- `lit-review/CONFIG.md`
- abstracts/metadata and any available full-text snippets

## Workflow

1. If `coord/` exists, claim `SCREENED.md`, `CANDIDATES.jsonl`, and
   `ASSUMPTIONS.md`.
2. Invoke or follow `lit-screener`.
3. Apply the approved tier rubric: direct competitors, must-cites, theory
   foundations, same question/method/setting, citation signals, and exclusions.
4. Update `tier`, `tier_history`, `fetch_policy`, and screening reason in
   candidate records.
5. Write `SCREENED.md` grouped by Tier 1, Tier 2, Tier 3, Excluded, and
   Borderline.
6. Request cross-agent review for borderline rejects and demotions.

## Done When

- Every candidate has a tier or exclusion reason.
- Demotions from Tier 1 have reviewer ack or Kristian override.
- Borderline decisions are visible.
- Stage 5 has a prioritized reading queue.
