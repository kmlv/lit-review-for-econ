---
name: lit-review-init
description: Initialize the lit-review-for-econ workspace in a paper folder.
---

# /lit-review-init

Design anchors: `DESIGN.md` §3 stage 0, §8, and §12.

Use this skill when a paper folder needs the v0.1 lit-review workspace.

Steps:

1. Read `coord/AGENTS_PROTOCOL.md`, `coord/STATE.md`, and the active thread if
   the target folder has `coord/`.
2. Inspect the paper folder for `.tex`, `.bib`, `papers/`, and existing
   `lit-review/`.
3. If the workspace is absent, run or ask Codex to run
   `bootstrap-lit-review.sh <paper-folder>`.
4. Fill `lit-review/CONFIG.md` with known paper paths, language, style, and
   available retrieval backends.
5. Draft initial `lit-review/SCOPE.md`, populate its Author Alignment section,
   and ask at most five early alignment questions for Kristian to confirm the
   research questions, target literatures/fields, related-paper types,
   must-cite landmarks, and exclusions.

Do not invent citations. Do not modify a paper manuscript during init.
