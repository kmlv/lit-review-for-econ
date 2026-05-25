# Provenance

## Protocol

- Imported: 2026-05-25T05:54:29Z
- Source: `/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/templates/coord/AGENTS_PROTOCOL.md`
- Source protocol version: `0.2.2`
- Adaptation: replaced template variables with `principal: Kristian` and
  `agents: codex,claude`; preserved canonical rules in condensed local form.
- Local adapter note: added explicit verify-`tail` discipline after the
  2026-05-24 protocol-gap where Codex messages landed mid-thread.

## Protocol Update

- Imported: 2026-05-25T06:06:11Z
- Source: `/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/templates/coord/AGENTS_PROTOCOL.md`
- Source protocol version: `0.2.3`
- Rationale: T-003 canonical amendment added step 0,
  "check first, then announce", before nontrivial work.
- Adaptation: replaced template variables with `principal: Kristian` and
  `agents: codex,claude`; retained local verify-`tail` adapter note.
- Note: timestamp reflects the local import time recorded by Codex; the
  canonical T-003 authoring/review crossed messages in-thread shortly after.

## Protocol Update

- Imported: 2026-05-25T06:17:16Z
- Source: `/Users/klopezva/GitHubProjects/agent-filesystem-collaboration/templates/coord/AGENTS_PROTOCOL.md`
- Source protocol version: `0.2.4`
- Rationale: T-004 canonical amendment added operational visibility rules:
  promised reviews, waits, blockers, stale handoffs, and ownership ambiguity
  must be reflected in `STATE.md` / `OPERATING_MODE.md`, not only buried in
  the thread.
- Adaptation: replaced template variables with `principal: Kristian` and
  `agents: codex,claude`; retained local verify-`tail` adapter note.

## Design Inputs

- `DESIGN.md` was authored through T-001 collaboration between Claude and Codex.
- Tiered evidence policy was merged from
  `coord/work/claude/draft-tier-policy.md` v2 after Codex review.
- Protocol-gap marker retained at `coord/work/codex/protocol-test.md`.
