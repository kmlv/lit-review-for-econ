# lit-review-for-econ

Reusable Claude + Codex skills and subagents for literature reviews in
experimental, behavioral, and microeconomics projects.

The system installs into a paper folder and creates a resumable
`lit-review/` workspace for:

```text
init -> scope -> plan -> fetch -> screen -> read -> curate -> draft -> QA
```

v0.1 implements the first slice:

```text
init -> scope -> plan -> fetch -> screen -> read
```

The first target is a synthetic paper folder generated from
`templates/paper-folder-lit-review/`.

## Design Principles

- Every stage writes named artifacts and can be resumed.
- Early scope includes an author-alignment gate for research questions,
  target fields/literatures, related-paper types, must-cites, and exclusions.
- Final citations must be grounded in `READING_NOTES/<citekey>.md`.
- PDF access is tiered:
  - Tier 1 essential papers require full text.
  - Tier 2 important papers attempt full text opportunistically.
  - Tier 3 related papers use metadata/abstract only.
- Manual download is first-class through `DOWNLOAD_QUEUE.md`.
- Authenticated access is opt-in and auditable; cookie contents are never
  logged.
- Agent capabilities are versioned under `tool-capabilities/`.
- **Findings disclosure** (DESIGN.md §2.12): the writer surfaces what cited
  papers found, not only what they studied. Findings narrated for papers
  central to the argument; peripheral cites may omit. Reported only from
  reading notes where `evidence_quality == full_text` AND
  `source_version == published`. Magnitudes default to qualitative; numbers
  only when central to the target paper.

See [DESIGN.md](DESIGN.md) for the full design.

Coordination is intentionally separate: paper folders that need Claude/Codex
handoffs should also install
[`agent-filesystem-collaboration`](https://github.com/BEX-KLAB/agent-filesystem-collaboration).

## Available Skills And Agents

| Stage | Claude skill | Codex skill | Primary agent | Main artifact |
|---:|---|---|---|---|
| 0 | `/lit-review-init` | `lit-review-init` | Claude/Codex | `CONFIG.md` |
| 1 | `/lit-review-scope` | `lit-review-scope` | `paper-scoper` | `SCOPE.md`, `QUESTIONS.md` |
| 2 | `/lit-review-plan` | `lit-review-plan` | `lit-search-strategist` | `SEARCH_PLAN.md` |
| 3 | `/lit-review-fetch` | `lit-review-fetch` | `lit-retriever` | `CANDIDATES.jsonl`, `SEARCH_LOG.md`, `DOWNLOAD_QUEUE.md` |
| 4 | `/lit-review-screen` | `lit-review-screen` | `lit-screener` | `SCREENED.md` |
| 5 | `/lit-review-read` | `lit-review-read` | `paper-reader` | `READING_NOTES/<citekey>.md` |

## Install Into A Paper Folder

Dry-run first:

```bash
./bootstrap-lit-review.sh /path/to/paper-folder --dry-run
```

Install:

```bash
./bootstrap-lit-review.sh /path/to/paper-folder
```

Overwrite only with explicit backups:

```bash
./bootstrap-lit-review.sh /path/to/paper-folder --force
```

The bootstrap creates:

- `lit-review/`
- `.claude/skills/lit-review-{init,scope,plan,fetch,screen,read}.md`
- `.claude/agents/{paper-scoper,lit-search-strategist,lit-retriever,lit-screener,paper-reader}.md`
- `.codex/skills/lit-review-{init,scope,plan,fetch,screen,read}/SKILL.md`
- `lit-review/INSTALL_LOG.md`

If the target folder does not have `coord/`, the bootstrap does not create one;
it prints a recommendation to install `agent-filesystem-collaboration`.

## Current Status

The v0.1 design is closed. The scaffold now installs stages 0-5:
`/lit-review-init`, `/lit-review-scope`, `/lit-review-plan`,
`/lit-review-fetch`, `/lit-review-screen`, and `/lit-review-read`.
