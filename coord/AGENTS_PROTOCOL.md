---
protocol_name: agent-filesystem-collaboration
protocol_version: 0.2.2
principal: Kristian
agents: codex,claude
---

# Agent Filesystem Collaboration Protocol

This repository uses `coord/` as the shared coordination surface for AI agents.
Read this file, `coord/STATE.md`, `coord/OPERATING_MODE.md`, and the active
thread before nontrivial work.

## Required Loop

1. Read `coord/STATE.md`.
2. Read `coord/OPERATING_MODE.md`.
3. Read the active thread listed in `STATE.md`, if any.
4. Before nontrivial edits, append a `claim` or `status` message to the active
   thread with lead, scope, and owned files.
5. Work only inside your claimed scope.
6. Do not overwrite another agent's work.
7. Report validation and open questions in the thread.
8. Ask for cross-review on important changes.
9. Escalate unresolved decisions to `coord/HUMAN.md`.

## Directory Roles

- `coord/STATE.md`: fast project/task snapshot.
- `coord/OPERATING_MODE.md`: current lead, reviewer, cadence, and pause/stop
  state.
- `coord/HUMAN.md`: queue for decisions only Kristian can make.
- `coord/threads/`: append-only coordination conversations.
- `coord/work/<agent>/`: scratch, storyboards, audit notes, drafts. Other
  agents may read these files for transparency, but only the owning agent
  writes there unless a thread message explicitly hands off ownership.
- `coord/memory/`: optional shared cross-agent memory; not authoritative
  project state.

## Thread Message Format

**Append new messages to the END of the thread file.** Do not insert messages at
the top, middle, or above a prior message. After editing, `tail` must show the
newest message.

Append messages with frontmatter:

```markdown
---
from: codex
to: claude
ts_utc: 2026-05-07T21:49:00Z
type: claim|proposal|review|ack|status|decision|handoff|iteration-start|iteration-check|iteration-stop|stale-ping|protocol-gap|protocol-test|reconcile
ack: false
task: T-001
lead: codex
thread_rev_seen: 12
thread_rev: 13
files_owned:
  - path/or/glob
---

TL;DR: one sentence.

Body.

- Codex
```

Use UTC ISO-8601 timestamps. Append order is authoritative for message order.
Timestamps are for audit, but file order defines causal ordering.

## Concurrency Safeguards

For nontrivial coordination messages, include `thread_rev_seen`, the count of
prior frontmatter blocks observed before writing. `thread_rev` may record the
expected post-append revision, but it is informational because races can make it
stale.

After appending, re-read the thread tail. If another message landed after your
read and changes your assumptions, append `type: reconcile`.

The hot shared coordination files are `coord/STATE.md`,
`coord/OPERATING_MODE.md`, `coord/PROVENANCE.md`, and
`coord/AGENTS_PROTOCOL.md`. Before editing a hot file, record a preflight note
in the active thread with `file`, `sha256_before`, and `thread_rev_seen`; after
editing, report `sha256_after`. `coord/work/<agent>/` files are write-owned by
their agent and do not need hot-file preflight.

## Local Adapter Note

This repo had a protocol gap on 2026-05-24: Codex appended messages by patching
against repeated markers, which inserted them mid-thread. Until all agents use a
safer append primitive, every agent must verify `tail` after writing a thread
message and must not patch against generic repeated signatures such as
`- Claude` or `- Codex`.

## Ownership

For nontrivial edits, declare ownership before editing. Ownership can be a file,
directory, task, or responsibility area. If ownership overlaps, coordinate in
the thread before editing.

Release ownership with `type: handoff`, `type: iteration-stop`, or task
closure.

## Reviews

Use these labels:

- `[blocker]`: must be addressed before merge/commit.
- `[suggestion]`: recommended but not blocking.
- `[nit]`: minor style/detail.

Authors respond with accepted, rejected-because, or deferred. A clean review
cycle means the reviewer posts `type: review` with no `[blocker]` findings and
the lead acknowledges it.

`ack: false` means the message awaits acknowledgement from the `to:` recipient.
Because threads are append-only, acknowledge by appending a new response message
with `ack: true`; do not edit prior messages to flip the field.

## Disagreement

If two rounds do not converge, stop debating and add the decision to
`coord/HUMAN.md`.

## Iteration Mode

Iteration mode is optional. Required fields live in `coord/OPERATING_MODE.md`:
active task, lead and reviewer, active thread, check cadence, stop condition,
edit budget, Codex resume target if any, and file ownership.

Use `type: iteration-start` when entering iteration mode, `type:
iteration-check` for periodic updates, and `type: iteration-stop` when the stop
condition is met.

Edit budgets:

- `read-only`: inspect and report only.
- `proposal-only`: edit only `coord/` artifacts.
- `bounded-files`: edit only listed `files_owned`.
- `implementation`: broader implementation allowed, still constrained by active
  task and ownership.

## Heartbeat Asymmetry

Some agents can self-wake or loop; others only respond when invoked by Kristian
or external tooling. Be honest about that.

- If an agent can monitor on a timer, it may check the active thread at the
  configured cadence.
- If an agent cannot self-wake, it responds on the next invocation.
- If an agent is needed but appears stale, append `type: stale-ping`.
- If `coord/OPERATING_MODE.md` contains `Codex resume target`, an external
  wrapper may run `coord-codex-pulse.sh` to resume Codex with the active thread.

## Quality Rules

- Read before writing.
- Keep threads append-only.
- Verify `tail` after writing thread messages.
- Keep `STATE.md` concise.
- Do not import project-specific artifacts from other repositories unless they
  are protocol templates explicitly named in the active thread or
  `coord/PROVENANCE.md`.
- Record approved external protocol imports in `coord/PROVENANCE.md`.
- Announce every nontrivial coordination action in the active thread in the same
  turn.
- Do not commit or push unrelated WIP.
- Prefer evidence: command output summaries, screenshots, diffs, citations.
- Do not call Kristian "human" in project-facing prose. Template-inherited
  filenames such as `coord/HUMAN.md` are exempt.
