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
   JEL/theme tags, inclusion/exclusion rules, must-cite seeds, and tier
   thresholds.
5. Ask Kristian at most five blocking questions. If a question is not blocking,
   record the default in `ASSUMPTIONS.md` and proceed.

## Done When

- `SCOPE.md` has enough detail for a search plan.
- Must-cite seeds are listed or the absence is explicit.
- Blocking questions are in `QUESTIONS.md` and, when coordinated, `coord/HUMAN.md`.
- No citations or claims have been invented.
