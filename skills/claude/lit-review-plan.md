---
name: lit-review-plan
description: Stage 2: turn lit-review/SCOPE.md into SEARCH_PLAN.md with queries, sources, landmarks, and review checkpoints.
---

# /lit-review-plan

Design anchors: `DESIGN.md` §3 stage 2, §5, and §7.

Use this skill after `/lit-review-scope` to create the retrieval plan.

## Inputs

- `lit-review/SCOPE.md`
- `lit-review/CONFIG.md`
- existing bibliography and must-cite seeds
- `tool-capabilities/*.md` when available

## Workflow

1. If `coord/` exists, claim `lit-review/SEARCH_PLAN.md`,
   `lit-review/ASSUMPTIONS.md`, and any stage thread notes.
2. Invoke or follow `lit-search-strategist`.
3. Build query bundles by construct, intervention, setting/population,
   identification method, outcomes, and seed-author/citation-chaining routes.
4. Name source backends and fallback routes. At v0.1 default to OpenAlex,
   CrossRef, arXiv, RePEc/IDEAS, NBER, and manual seed expansion.
5. Mark must-cite seeds as Tier 1 and specify how they will be verified.
6. Check the Author Alignment section in `SCOPE.md` and the open questions in
   `QUESTIONS.md`. Do not green-light Stage 3 fetch until the gate is answered,
   explicitly deferred by Kristian, or defaults are documented in
   `ASSUMPTIONS.md` and surfaced for reviewer approval.
7. Request cross-agent review and Kristian sign-off before heavy fetching.

## Done When

- `SEARCH_PLAN.md` contains executable queries and source order.
- Landmark/must-cite checks are explicit.
- Tiering defaults from `CONFIG.md` are referenced.
- The author-alignment gate is resolved, deferred, or assumption-backed with
  reviewer visibility.
- Stage 3 can run without guessing search strategy.
