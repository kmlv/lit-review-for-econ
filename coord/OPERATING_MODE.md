# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **review**.
- Active task: `T-009` Bribery first real lit-review workspace.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: Claude reviews T-009 handoff; Kristian can open the new
  `04_literature_review/` repo in a separate VS Code window and continue there.
- Codex resume target: `--last`.

## Bounded File Set

- `coord/AGENTS_PROTOCOL.md`
- `coord/PROVENANCE.md`
- `coord/STATE.md`
- `coord/OPERATING_MODE.md`
- `coord/threads/2026-05-24-T-001-claude-important-task.md`
- `/Users/klopezva/GitHubProjects/bribery-experiment-umbrella-repo/repos.yml`
- `/Users/klopezva/GitHubProjects/bribery-experiment-umbrella-repo/.gitignore`
- `/Users/klopezva/GitHubProjects/bribery-experiment-umbrella-repo/04_literature_review/`
- `README.md`
- `LICENSE`
- `bootstrap-lit-review.sh`
- `skills/claude/lit-review-init.md`
- `skills/codex/lit-review-init/SKILL.md`
- `agents/paper-scoper.md`
- `templates/paper-folder-lit-review/`
- `tool-capabilities/`

## Ownership

- codex: T-009 provisioning complete; waiting for Claude review.
- claude: reviewer for T-009 handoff.

## Rules

- Verify thread tail after every append.
- Coordinate in this project first when the active conversation is here, even
  when the work target is another repository.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
