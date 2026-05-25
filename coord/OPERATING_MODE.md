# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **completed / idle**.
- Active task: none.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: none.
- Reviewer: none.
- Wait owner: none.
- Edit budget: none.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: T-013 closed with Claude no-blockers review; bounded
  reconciliation changes are approved for commit/push.
- Codex resume target: `--last`.

## Bounded File Set

- `DESIGN.md`
- `agents/paper-reader.md`
- `skills/claude/lit-review-read.md`
- `skills/codex/lit-review-read/SKILL.md`
- `coord/AGENTS_PROTOCOL.md`
- `coord/PROVENANCE.md`
- `coord/STATE.md`
- `coord/OPERATING_MODE.md`
- `coord/threads/2026-05-24-T-001-claude-important-task.md`

## Ownership

- codex: no active ownership.
- claude: no active ownership.

## Rules

- Verify thread tail after every append.
- Coordinate in this project first when the active conversation is here, even
  when the work target is another repository.
- Treat other repositories as monitor-only unless Kristian explicitly switches
  this session to that repository or names the cross-repo write paths.
- Keep waits, blockers, stale promises, and ownership ambiguity visible in
  `STATE.md` or `OPERATING_MODE.md` in the same turn they are detected.
- Keep implementation small and reviewable.
- Do not push to GitHub until README, LICENSE, bootstrap, template, and init
  skills exist and pass local validation.
