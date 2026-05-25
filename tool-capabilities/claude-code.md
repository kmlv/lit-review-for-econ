# Tool Capabilities — Claude Code

Last checked: 2026-05-25

## Role In This System

Claude leads scoping, screening judgment, reading synthesis, prose, and
argumentative coherence.

## Expected Capabilities

- Project file reading/writing.
- Slash-command style skills.
- Coordination through shared Markdown files.
- Subagent-style prompt specialization where available.
- Paper-folder install target: `.claude/skills/*.md` and `.claude/agents/*.md`.
- Preferred responsibilities here: scoping, search planning, screening,
  reading notes, synthesis judgment, prose, and review.

## Degraded Mode

If Codex is unavailable, Claude may run Stage 3 in manual/degraded mode using
open web or locally available tools. Record the degradation in
`lit-review/ASSUMPTIONS.md` and keep `SEARCH_LOG.md` explicit about which
backends were not available.

## Policy

- Refresh this document when Claude Code tool behavior changes.
- Record unavailable capabilities in the target paper folder's
  `lit-review/ASSUMPTIONS.md`.
