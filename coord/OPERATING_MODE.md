# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **implementation**.
- Active task: T-006 — robustness/clarity polish before first real paper use.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: T-006 polish implemented, bootstrap validation passes,
  `git diff --check` passes, and Claude review has no blockers.
- Codex resume target: `--last`.

## Bounded File Set

- `coord/AGENTS_PROTOCOL.md`
- `coord/PROVENANCE.md`
- `coord/STATE.md`
- `coord/OPERATING_MODE.md`
- `README.md`
- `LICENSE`
- `bootstrap-lit-review.sh`
- `skills/claude/lit-review-init.md`
- `skills/codex/lit-review-init/SKILL.md`
- `agents/paper-scoper.md`
- `templates/paper-folder-lit-review/`
- `tool-capabilities/`

## Ownership

- codex: T-006 implementation complete; waiting on review.
- claude: T-006 reviewer; current visible wait is polish completeness review.

## Rules

- Verify thread tail after every append.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
