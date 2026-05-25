---
name: lit-review-plan
description: Stage 2 helper for constructing SEARCH_PLAN.md from scope, seeds, and configured backends.
---

# lit-review-plan

Use when turning `lit-review/SCOPE.md` into an executable search plan.

## Workflow

1. Read coordination files if present and claim `lit-review/SEARCH_PLAN.md`.
2. Extract constructs, settings, methods, outcomes, seed authors, and must-cites.
3. Build query bundles and backend list for OpenAlex, CrossRef, arXiv,
   RePEc/IDEAS, NBER, and configured fallbacks.
4. Check that Tier 1 must-cites have explicit retrieval routes.
5. Ask for cross-agent review before Stage 3 fetch if coordination is active.

Prefer structured query tables over prose-only plans.
