# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **implementation**.
- Active task: `T-008` current-project-first coordination rule.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: canonical protocol v0.2.5 and this repo's local install
  encode current-project-first coordination, validation passes, commits/pushes
  land, and Claude has a review handoff.
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

- codex: owns T-008 protocol/local coordination files until review handoff.
- claude: reviewer for T-008; no edits to claimed files unless handed off.

## Rules

- Verify thread tail after every append.
- Coordinate in this project first when the active conversation is here, even
  when the work target is another repository.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
