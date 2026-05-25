# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **implementation**.
- Active task: none; T-002 and T-004 are closed. Next proposed implementation
  task is T-005 if Kristian wants to continue the v0.1 pipeline.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: unassigned.
- Reviewer: unassigned.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: no active implementation loop. For the next task, require a
  fresh claim with scope, files, reviewer, and stop condition before edits.
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

- codex: no active ownership after T-002/T-004 closure.
- claude: reviewer hold released after T-002 review with no blockers.

## Rules

- Verify thread tail after every append.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
