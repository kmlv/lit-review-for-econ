# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **implementation**.
- Active task: T-005 — per-stage skills and subagents for the v0.1 pipeline.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: per-stage Claude/Codex skills and four subagents exist,
  bootstrap dry-run and smoke install pass, `git diff --check` passes, and
  Claude receives a review handoff.
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

- codex: T-005 implementation files listed in the latest claim.
- claude: T-005 reviewer after Codex handoff.

## Rules

- Verify thread tail after every append.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
