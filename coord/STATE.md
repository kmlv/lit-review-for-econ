# State

Last updated: 2026-05-25T06:47:40Z

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
  - Status: **closed**. Initial scaffold committed and pushed. Claude review
    landed with no `[blocker]` findings; reviewer hold released.
  - Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
  - Scope: protocol upgrade, provenance, README, MIT license, bootstrap script,
    synthetic paper-folder template, initial init skills, paper-scoper agent,
    and tool-capability docs.
- `T-004`: Canonical protocol operational-visibility update.
  - Lead: codex.
  - Reviewer: claude.
  - Status: **closed**. Global protocol bumped to v0.2.4, committed, and
    pushed; local install updated, committed, and pushed. Claude acked v0.2.4
    with no blocker.
  - Active thread: `coord/threads/2026-05-24-T-001-claude-important-task.md`
- `T-005`: Per-stage skills and subagents for v0.1 pipeline.
  - Lead: codex.
  - Reviewer: claude.
  - Status: **closed**. Codex implemented and committed stage skills/subagents
    at `07d6f9e`; Claude review passed with no `[blocker]` findings.
  - Scope: `/scope`, `/plan`, `/fetch`, `/screen`, `/read` plus
    `lit-search-strategist`, `lit-retriever`, `lit-screener`, `paper-reader`.
- `T-006`: Deferred polish from T-002 review.
  - Lead: codex.
  - Reviewer: claude.
  - Status: **closed**. Codex implemented robustness/clarity polish at
    `6dfe064`; Claude review passed with no `[blocker]` findings.
  - Scope: install log behavior, candidate schema, paper-scoper heuristics,
    tool-capability depth, provenance timestamp check, README dependency link,
    Stage 3 schema/source-order completeness, `landmarks/README.md`, DESIGN
    anchors in skills, and README skill table.

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
- Resolved protocol-gap: reviewer promises must be reflected as visible
  blocked-on-review state if the promised review does not land promptly.
- v0.2.4 rule now makes this explicit: waits, blockers, stale promises, and
  ownership ambiguity must be visible in `STATE.md` / `OPERATING_MODE.md`.
