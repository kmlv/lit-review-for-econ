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
- Final citations must be grounded in `READING_NOTES/<citekey>.md`.
- PDF access is tiered:
  - Tier 1 essential papers require full text.
  - Tier 2 important papers attempt full text opportunistically.
  - Tier 3 related papers use metadata/abstract only.
- Manual download is first-class through `DOWNLOAD_QUEUE.md`.
- Authenticated access is opt-in and auditable; cookie contents are never
  logged.
- Agent capabilities are versioned under `tool-capabilities/`.

See [DESIGN.md](DESIGN.md) for the full design.

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
- `.claude/skills/lit-review-init.md`
- `.codex/skills/lit-review-init/SKILL.md`
- `lit-review/INSTALL_LOG.md`

If the target folder does not have `coord/`, the bootstrap does not create one;
it prints a recommendation to install `agent-filesystem-collaboration`.

## Current Status

Implementation scaffold in progress. The v0.1 design is closed; usable runtime
behavior begins with `/lit-review-init`.
