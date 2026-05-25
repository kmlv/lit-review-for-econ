# Tool Capabilities — Codex

Last checked: 2026-05-25

## Role In This System

Codex leads retrieval mechanics, filesystem scaffolding, schema validation,
BibTeX mechanics, file audits, and mechanical QA.

## Available Capabilities In This Workspace

- Local filesystem reads/writes in the workspace.
- Shell commands through `exec_command`.
- Patch-based file edits.
- Web browsing when current information is needed.
- Browser/Chrome/computer-use plugins may be available depending on session.
- File-based collaboration through `coord/`.
- Paper-folder install target: `.codex/skills/<skill>/SKILL.md`.
- Preferred responsibilities here: bootstrap, retrieval mechanics, JSONL/schema
  validation, dedupe, hashing, BibTeX mechanics, and file audits.

## Policy

- Prefer structured files and schemas over prose parsing.
- Verify thread tail after appending coordination messages.
- Record degraded capabilities in `lit-review/ASSUMPTIONS.md` or
  `SEARCH_LOG.md`.
