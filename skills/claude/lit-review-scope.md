---
name: lit-review-scope
description: Stage 1: scope a paper folder's literature review and produce lit-review/SCOPE.md.
---

# /lit-review-scope

Design anchors: `DESIGN.md` §3 stage 1 and §7.

Use this skill after `/lit-review-init` to define the literature-review scope.

## Inputs

- `lit-review/CONFIG.md`
- manuscript files (`.tex`, `.md`, `.qmd`) and project notes
- existing `.bib` files and cited seeds
- `coord/` files if present

## Workflow

1. If `coord/` exists, read the protocol/state/thread and claim
   `lit-review/SCOPE.md`, `lit-review/QUESTIONS.md`, and
   `lit-review/ASSUMPTIONS.md`.
2. Invoke or follow `paper-scoper`.
3. Inspect title, abstract, intro, hypotheses, design/identification sections,
   conclusion, bibliography, and appendices when present.
4. Draft `SCOPE.md` with research question, contribution, target literatures,
   JEL/theme tags, inclusion/exclusion rules, must-cite seeds, tier thresholds,
   and Author Alignment status.
5. Run the early author-alignment gate: ask Kristian at most five questions to
   confirm the research questions, target literatures/fields, related-paper
   types to include or de-emphasize, must-cite landmarks, and adjacent
   literatures to exclude.
6. If Kristian is unavailable, record defaults in `ASSUMPTIONS.md`, leave the
   gate as pending or explicitly deferred, and make the assumptions visible for
   reviewer approval before Stage 3 fetch.

## Done When

- `SCOPE.md` has enough detail for a search plan.
- Must-cite seeds are listed or the absence is explicit.
- Author Alignment is answered, explicitly deferred by Kristian, or documented
  in `ASSUMPTIONS.md` for reviewer approval.
- Blocking questions are in `QUESTIONS.md` and, when coordinated, `coord/HUMAN.md`.
- No citations or claims have been invented.
