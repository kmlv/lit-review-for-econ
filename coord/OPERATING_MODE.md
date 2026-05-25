# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **review**.
- Active task: `T-010` author-alignment gate for early scoping.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: reusable design/templates/skills require early author
  alignment on research questions, fields/literatures, and related paper types;
  validation passes; Claude review clears or reports findings.
- Codex resume target: `--last`.

## Bounded File Set

- `coord/AGENTS_PROTOCOL.md`
- `coord/PROVENANCE.md`
- `coord/STATE.md`
- `coord/OPERATING_MODE.md`
- `coord/threads/2026-05-24-T-001-claude-important-task.md`
- `DESIGN.md`
- `README.md`
- `agents/paper-scoper.md`
- `skills/claude/lit-review-init.md`
- `skills/claude/lit-review-scope.md`
- `skills/claude/lit-review-plan.md`
- `skills/codex/lit-review-scope/SKILL.md`
- `skills/codex/lit-review-plan/SKILL.md`
- `templates/paper-folder-lit-review/lit-review/SCOPE.md`
- `templates/paper-folder-lit-review/lit-review/QUESTIONS.md`
- `templates/paper-folder-lit-review/lit-review/SEARCH_PLAN.md`
- `templates/paper-folder-lit-review/lit-review/ASSUMPTIONS.md`

## Ownership

- codex: awaiting T-010 review, ready to address findings.
- claude: reviewer for T-010.

## Rules

- Verify thread tail after every append.
- Coordinate in this project first when the active conversation is here, even
  when the work target is another repository.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
