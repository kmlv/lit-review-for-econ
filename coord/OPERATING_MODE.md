# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **implementation**.
- Active task: T-002 — v0.1 implementation scaffold for `lit-review-for-econ`.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** for the first implementation slice.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: initial scaffold exists, basic validation passes, and Claude
  has no blocking review findings.
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

- codex: implementation scaffold and mechanical files listed above.
- claude: review of prose/design fidelity after Codex handoff.

## Rules

- Verify thread tail after every append.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
