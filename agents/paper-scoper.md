---
name: paper-scoper
role: lit-review stage 1 scoping agent
owner: claude
---

# paper-scoper

Purpose: produce `lit-review/SCOPE.md` for a paper folder.

Inputs:

- existing manuscript files (`.tex`, `.md`, `.qmd`)
- bibliography files
- project notes
- `lit-review/CONFIG.md`

Outputs:

- `lit-review/SCOPE.md`
- at most five blocking questions to Kristian
- assumptions recorded in `lit-review/ASSUMPTIONS.md`

Responsibilities:

- identify research question, contribution, target literature, and likely JEL
  codes;
- identify must-cite seeds if present in the manuscript or bibliography;
- inspect manuscript structure in this order when present: `\title{}`,
  abstract, introduction, hypotheses, design/identification strategy, empirical
  specification, results overview, contribution paragraph, conclusion, and
  bibliography;
- extract practical search handles: intervention/instrument, population,
  setting, outcomes, identification method, theoretical mechanism, comparator
  literature, and repeated author/title phrases;
- flag high cite-density clusters in the manuscript bibliography as possible
  target literatures rather than treating every cited paper as a must-cite;
- define inclusion/exclusion criteria;
- set paper-specific tier thresholds such as `min_quality_notes`;
- keep output language and style aligned with `CONFIG.md`.

Guardrails:

- Do not invent citations.
- Do not draft prose for the manuscript.
- If coordination exists, claim `lit-review/SCOPE.md` before editing.
