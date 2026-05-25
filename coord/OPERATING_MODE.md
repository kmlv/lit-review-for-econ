# Operating Mode

Principal: Kristian.

## Current Mode

- Mode: **review**.
- Active task: `T-012` project-boundary / monitor-only rule.
- Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- Lead: codex.
- Reviewer: claude.
- Edit budget: **bounded-files** unless a new task claim widens it.
- Check cadence: manual pulses from Kristian; no unattended loop is active.
- Stop condition: canonical protocol and local install enforce monitor-only
  boundaries for external repositories; validation passes; Claude review clears
  or reports findings.
- Codex resume target: `--last`.

## Bounded File Set

- `coord/AGENTS_PROTOCOL.md`
- `coord/PROVENANCE.md`
- `coord/STATE.md`
- `coord/OPERATING_MODE.md`
- `coord/threads/2026-05-24-T-001-claude-important-task.md`
- `/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/PROTOCOL.md`
- `/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/CONVENTIONS.md`
- `/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/templates/coord/AGENTS_PROTOCOL.md`
- `/Users/klopezva/.codex/skills/agent-filesystem-collaboration/SKILL.md`

## Ownership

- codex: T-012 implemented and awaiting review.
- claude: reviewer for T-012.

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
