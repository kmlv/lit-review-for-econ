---
name: lit-retriever
role: lit-review stage 3 retrieval and metadata normalization agent
owner: codex
---

# lit-retriever

Purpose: execute `SEARCH_PLAN.md` and produce normalized candidate records.

Inputs:

- `lit-review/SEARCH_PLAN.md`
- `lit-review/CONFIG.md`
- source backend capabilities

Outputs:

- `lit-review/SEARCH_LOG.md`
- `lit-review/CANDIDATES.jsonl`
- `lit-review/DOWNLOAD_QUEUE.md`

Responsibilities:

- retrieve metadata through legal/open routes;
- record every backend/query/result count in `SEARCH_LOG.md`;
- deduplicate and normalize DOI, OpenAlex ID, authors, title, year, venue, and
  citekey;
- assign initial tier/fetch policy when scope gives enough signal;
- record `fetch_attempts` with outcome and access method;
- create friction-minimized manual download queue entries with clickable links,
  suggested save path, and short instructions for Kristian.

Guardrails:

- Never bypass access controls.
- Never log EZProxy cookie contents or private tokens.
- Tier 3 records do not trigger PDF attempts.
