# State

Last updated: 2026-05-25T06:17:16Z

Protocol: agent-filesystem-collaboration v0.2.4 local install, adapted from
`/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/templates/coord/AGENTS_PROTOCOL.md`.
Provenance recorded in `coord/PROVENANCE.md`.

Principal: Kristian (klopezva@ucsc.edu, UCSC).

## Repo Purpose

`lit-review-for-econ` is the development repo for reusable Claude + Codex
skills and subagents that perform high-quality literature review for
experimental, behavioral, and microeconomics papers. It installs into paper
folders through `bootstrap-lit-review.sh`.

## Active Tasks

- `T-001`: Design lit-review-for-econ skills + agents system.
  - Status: **closed**. Design v0 accepted; tiered evidence policy merged into
    `DESIGN.md`.
- `T-002`: v0.1 implementation scaffold.
  - Lead: codex.
  - Reviewer: claude.
  - Status: **blocked-on-review**. Initial scaffold committed locally; v0.2.3
    protocol reinstall applied after Claude T-003 handoff. Claude promised a
    T-002 review "in next message", but no T-002 review has landed at the
    thread tail yet.
  - Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
  - Scope: protocol upgrade, provenance, README, MIT license, bootstrap script,
    synthetic paper-folder template, initial init skills, paper-scoper agent,
    and tool-capability docs.
- `T-004`: Canonical protocol operational-visibility update.
  - Lead: codex.
  - Reviewer: claude.
  - Status: **implementation**. Global protocol bumped to v0.2.4 and local
    install updated; validation/review handoff pending.
  - Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`

## Approved Decisions

- v0.1 scope: stages 0-5 only.
- Initial style: AEA family.
- Output: `.tex` + `.bib`.
- Install: local `bootstrap-lit-review.sh`, idempotent, `--dry-run`, `--force`,
  backups, `INSTALL_LOG.md`.
- Runtime split: Codex leads retrieval/mechanical QA; Claude leads
  prose/judgment.
- Backends: OpenAlex + CrossRef no-key MVP; other sources capability-detected.
- PDF policy: tiered evidence policy in `DESIGN.md` §2.11.
- EZProxy: cookie export to `.secrets/ezproxy-cookies.txt`; never log cookie
  content.
- Browser MCP: opt-in per paper folder, default OFF, for download assistance.
- First target: synthetic `templates/paper-folder-lit-review/`.
- License: MIT.
- Public remote target: `kmlv/lit-review-for-econ` after initial scaffold.

## Workspace Notes

- Working directory: `/Users/klopezva/GitHubProjects/lit-review-for-econ`
- Git repo on `main` tracking `origin/main`; last local status check showed a
  clean branch before this protocol-gap update.
- Known protocol-gap: Codex once wrote messages mid-thread; agents now verify
  `tail` after appending.
- Known protocol-gap: reviewer promises must be reflected as visible
  blocked-on-review state if the promised review does not land promptly.
- v0.2.4 rule now makes this explicit: waits, blockers, stale promises, and
  ownership ambiguity must be visible in `STATE.md` / `OPERATING_MODE.md`.
