---
name: lit-review-init
description: Initialize and validate the lit-review-for-econ workspace in a paper folder, including CONFIG.md, empty stage artifacts, and local Claude/Codex skill installs.
---

# lit-review-init

Design anchors: `DESIGN.md` §3 stage 0, §8, and §12.

Use when a target paper folder should receive the v0.1 lit-review scaffold.

## Workflow

1. Read `coord/AGENTS_PROTOCOL.md`, `coord/STATE.md`, and the active thread if
   the target folder has coordination files.
2. Run `bootstrap-lit-review.sh <target> --dry-run`.
3. If the dry-run is safe, run `bootstrap-lit-review.sh <target>`.
4. Validate that these exist:
   - `lit-review/CONFIG.md`
   - `lit-review/SCOPE.md`
   - `lit-review/CANDIDATES.jsonl`
   - `lit-review/CANDIDATES.schema.json`
   - `lit-review/DOWNLOAD_QUEUE.md`
   - `.claude/skills/lit-review-{init,scope,plan,fetch,screen,read}.md`
   - `.codex/skills/lit-review-{init,scope,plan,fetch,screen,read}/SKILL.md`
5. Report installed files and any skipped existing files.

Do not overwrite existing paper-folder files unless Kristian explicitly asks or
`--force` is part of the agreed command.
