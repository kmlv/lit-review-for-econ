---
protocol_name: agent-filesystem-collaboration
protocol_version: 0.2.4
principal: Kristian
agents: codex,claude
---

# Agent Filesystem Collaboration Protocol

This repository uses `coord/` as the shared coordination surface for AI agents.
Read this file, `coord/STATE.md`, `coord/OPERATING_MODE.md`, and the active thread before nontrivial work.

## Required Loop

0. **On receiving a new task — check first, then announce.** Before any
   nontrivial work, verify whether another agent is already working on
   overlapping scope:

   - Read `coord/STATE.md` for active tasks and their leads.
   - Read `coord/OPERATING_MODE.md` for current ownership and the
     bounded-files set.
   - Skim recent thread messages for unresolved `claim` / `status`
     entries without a closing `iteration-stop` or `handoff`.
   - Check `coord/claims/` if the task-management module is installed.

   Then:

   - If an overlap exists, post a `type: status` or `type: handoff`
     coordinating before starting. Do not pre-empt the other agent.
   - If no overlap, post a `type: claim` announcing the scope, files,
     stop condition, and expected reviewer **before** the first
     nontrivial edit.

   This applies whether the task arrived via chat, an
   `OPERATING_MODE.md` flip, a `HUMAN.md` resolution, or an in-flight
   handoff. Never start nontrivial work silently.

1. Read `coord/STATE.md`.
2. Read `coord/OPERATING_MODE.md`.
3. Read the active thread listed in `STATE.md`, if any.
4. Before nontrivial edits, append a `claim` or `status` message to the active
   thread with lead, scope, and owned files.
5. Work only inside your claimed scope.
6. Do not overwrite another agent's work.
7. Report validation and open questions in the thread.
8. Keep operational state visible: if work is waiting on a promised review,
   blocked by another agent, stale beyond cadence, or dependent on a
   handoff/ETA, update `coord/STATE.md` or `coord/OPERATING_MODE.md` in the
   same turn so Kristian can see who has the ball without reading the whole
   thread.
9. Ask for cross-review on important changes.
10. Escalate unresolved decisions to `coord/HUMAN.md`.

## Directory Roles

- `coord/STATE.md`: fast project/task snapshot, including visible
  blocked/waiting states.
- `coord/OPERATING_MODE.md`: current lead, reviewer, cadence, wait ownership,
  and pause/stop state.
- `coord/HUMAN.md`: queue for decisions only Kristian can make.
- `coord/threads/`: append-only coordination conversations.
- `coord/work/<agent>/`: scratch, storyboards, audit notes, drafts. Other agents may read these files for transparency, but only the owning agent writes there unless a thread message explicitly hands off ownership.
- `coord/memory/`: optional shared cross-agent memory; not authoritative project state. Private agent memory belongs in the agent-specific memory system, not here.

## Thread Message Format

**Append new messages to the END of the thread file.** Do not insert messages at the top of the file, in the middle, or above any prior message. After editing, `head` of the file shows the oldest content and `tail` shows the newest. New messages always go at the bottom.

Append messages with frontmatter:

```markdown
---
from: codex
to: claude
ts_utc: 2026-05-07T21:49:00Z
type: claim|proposal|review|ack|status|decision|handoff|iteration-start|iteration-check|iteration-stop|stale-ping|protocol-gap|reconcile
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

Use UTC ISO-8601 timestamps. Append order is authoritative for message order. Append order = file order from top to bottom: the first message is at the top of the file, each new message is appended below all previous messages, and the last message is at the bottom. Timestamps are for audit and should be distinct when practical, but file order, not the `ts_utc` value, defines causal ordering between messages.

Thread filenames should follow `YYYY-MM-DD-T-NNN-slug.md` when a task id exists, so threads remain sortable.

## Concurrency Safeguards

Threads are append-only, but agents can still race on stale reads. For
nontrivial coordination messages, include `thread_rev_seen`, the count of prior
frontmatter blocks observed before writing. `thread_rev` may record the expected
post-append revision, but it is informational because races can make it stale.

After appending a nontrivial message, re-read the thread tail. If another
message landed after your read and changes your assumptions, append
`type: reconcile` summarizing the crossed messages and what must be revisited.

The hot shared coordination files are `coord/STATE.md`,
`coord/OPERATING_MODE.md`, `coord/PROVENANCE.md`, and
`coord/AGENTS_PROTOCOL.md`. Before editing a hot file, record a preflight note
in the active thread with `file`, `sha256_before`, and `thread_rev_seen`; after
editing, report `sha256_after`. `coord/work/<agent>/` files are write-owned by
their agent and do not need hot-file preflight.

During iteration windows, the lead is the single writer for hot shared files.
The reviewer proposes hot-file changes in the thread unless ownership is
explicitly handed off.

## Ownership

For nontrivial edits, declare ownership before editing. Ownership can be a file,
directory, task, or responsibility area. If ownership overlaps, coordinate in the
thread before editing.

Claims can be thread messages in v1. Separate claim files are optional only when
race risk is high. Ownership is the union of open claims for the same agent and
task; later narrower messages do not release earlier ownership unless they
explicitly say so. Release ownership with `type: handoff`, `type:
iteration-stop`, or task closure.

## Optional Task Management

For parallel or multitask projects, install the task-management module:

- `coord/BOARD.md`: the visible queue for Backlog, Doing, Review, and Done.
- `coord/claims/`: one claim file per active task/scope.
- `coord/templates/`: short task, claim, decision, and peer-review templates.
- `coord/decisions/`: durable decision records.
- `coord/reviews/`: substantial or closing peer-review artifacts.
- `coord/retros/`: optional lessons learned after coordination-heavy tasks.

When installed, every nontrivial user request becomes either a `BOARD.md` task
or is explicitly attached to an existing task. Before touching project files
outside `coord/`, an agent must have either a claim file or a thread claim that
names the files or scope. If two or more tasks are active, use claim files
rather than thread-only claims.

`Done` requires: claimed scope complete, checks recorded, latest peer review has
no blockers, no visible blocked/waiting state remains, and durable decisions
recorded when they affect future analysis, writing, or implementation.

Keep at most three tasks active across Doing and Review unless the principal
explicitly approves a higher cap. Additional requests go to Backlog until an
active task closes or is paused.

`STATE.md` remains the fast snapshot. `BOARD.md` is the multitask queue. If they
conflict, `BOARD.md` plus active claim files are authoritative for task list and
ownership.

## Reviews

Use these labels:

- `[blocker]`: must be addressed before merge/commit.
- `[suggestion]`: recommended but not blocking.
- `[nit]`: minor style/detail.

Authors respond with accepted, rejected-because, or deferred. A clean review
cycle means the reviewer posts `type: review` with no `[blocker]` findings and
the lead acknowledges it. If a reviewer promises a review or ETA and it does not
land before the agreed cadence or next Kristian check, the lead must mark the
task `blocked-on-review` or `waiting-on-reviewer` in
`STATE.md`/`OPERATING_MODE.md` and file `type: protocol-gap` if this was not
already visible.

`ack: false` means the message awaits acknowledgement from the `to:` recipient. Because threads are append-only, acknowledge by appending a new response message with `ack: true`; do not edit prior messages to flip the field.

## Disagreement

If two rounds do not converge, stop debating and add the decision to
`coord/HUMAN.md`.

## Heartbeats

When agents are actively coordinating and waiting on each other, they should
check or append at the agreed cadence. Automation is optional. The protocol must
still work when agents only wake on user invocation.

### Iteration Mode

Iteration mode is an optional operating mode for unattended or lightly
supervised collaboration.

Required fields live in `coord/OPERATING_MODE.md`:

- active task;
- lead and reviewer;
- active thread;
- check cadence;
- next check due;
- stop condition;
- edit budget;
- Codex resume target, if Codex should be resumed by an external wrapper;
- file ownership.
- active loop drivers, if any, with agent, mechanism, cadence, started_at,
  stop_condition, persistence, and last_seen_thread_rev.

Use `type: iteration-start` when entering iteration mode, `type:
iteration-check` for periodic updates, and `type: iteration-stop` when the stop
condition is met. Closed threads stay in `coord/threads/`; `coord/STATE.md` stops pointing to them. Add a final `type: handoff`, `type: decision`, or `type: iteration-stop` message summarizing the resolution.

Before `iteration-stop`, verify: canonical source is clean if touched; local
provenance is updated; no pending `ack: false` message is directed at the lead;
the latest review has no `[blocker]`; the reviewer's latest message is acked by
the lead; and active loop drivers are stopped or explicitly allowed to expire.

Edit budgets:

- `read-only`: inspect and report only.
- `proposal-only`: edit only `coord/` artifacts.
- `bounded-files`: edit only listed `files_owned`.
- `implementation`: broader implementation allowed, but still constrained by
  the active task and ownership.

### Heartbeat Asymmetry

Some agents can self-wake or loop; others only respond when invoked by the
principal or external tooling. The protocol must be honest about that.

- If an agent can monitor on a timer, it may check the active thread at the
  configured cadence.
- If an agent cannot self-wake, it responds on the next invocation.
- If an agent is needed but appears stale, append `type: stale-ping` to the
  active thread with `to:` and `waiting_since:`.
- If `coord/OPERATING_MODE.md` contains `Codex resume target`, an external
  wrapper may run `coord-codex-pulse.sh` to resume Codex with the active thread.

Kristian should only need to intervene for `coord/HUMAN.md` items, visible
`blocked-*` / `waiting-*` states, `stale-ping` re-invocation, or stop-condition
decisions.

If Kristian finds himself repeatedly brokering messages that agents should read
from the thread, or asking "where are we?" because a wait/blocker is only
implicit in the thread, file `type: protocol-gap`.

Avoid no-op thread appends during scheduled loops; they clutter the audit trail.
It is acceptable to update local liveness counters in `coord/OPERATING_MODE.md`
when there is no substantive thread message to add.

## Quality Rules

- Read before writing.
- Keep threads append-only.
- Verify `tail` after writing thread messages. This local adapter note follows
  the 2026-05-24 protocol-gap where Codex messages landed mid-thread after
  patching against repeated signatures.
- Keep `STATE.md` concise, but never hide active waits, blockers, stale
  promises, or ownership ambiguity for brevity.
- Do not import files, decisions, threads, work notes, memory files, examples, adapters, reviews, retros, or other project-specific artifacts from other repositories unless they are protocol templates explicitly named in the active thread or in `coord/PROVENANCE.md`.
- Apply reusable protocol improvements to the canonical protocol source first, then update project-local installations from a recorded source commit or tag. Treat local-only reusable protocol changes as a review `[blocker]`.
- Record approved external protocol imports in `coord/PROVENANCE.md`.
- Announce every nontrivial coordination action in the active thread in the
  same turn, including starting or stopping loops, scheduling jobs, editing
  `coord/` files, changing operating mode, or beginning work outside `coord/`.
  This keeps agents working from shared state instead of stale local context.
- Do not commit or push unrelated WIP.
- Commit per coherent task.
- Prefer evidence: command output summaries, screenshots, diffs, citations.
- Do not call the principal "human" in project-facing prose when a name is
  configured. Use "Kristian" here. Template-inherited filenames such as `coord/HUMAN.md` are exempt.
- If unsure whether a decision belongs to the principal, ask in the thread or
  add it to `coord/HUMAN.md`.
