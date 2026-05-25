---
name: lit-retriever
role: lit-review stage 3 retrieval and metadata normalization agent
owner: codex
---

# lit-retriever

Purpose: execute `SEARCH_PLAN.md` and produce normalized candidate records.

Design anchors: `DESIGN.md` §2.11, §3 stage 3, and §9.

Inputs:

- `lit-review/SEARCH_PLAN.md`
- `lit-review/CONFIG.md`
- source backend capabilities

Outputs:

- `lit-review/SEARCH_LOG.md`
- `lit-review/CANDIDATES.jsonl`
- `lit-review/DOWNLOAD_QUEUE.md`

Responsibilities:

- retrieve metadata and full-text leads through the tier-scoped source order:
  1. OpenAlex OA URL;
  2. CrossRef OA link;
  3. preprints and working papers: arXiv, SSRN, NBER, RePEc/IDEAS;
  4. author personal or institutional page;
  5. UCSC EZProxy cookie export when explicitly enabled;
  6. opt-in Browser MCP download assistance when explicitly enabled;
  7. manual queue for Kristian;
- record every backend/query/result count in `SEARCH_LOG.md`;
- deduplicate and normalize DOI, OpenAlex ID, authors, title, year, venue, and
  citekey;
- assign initial tier/fetch policy when scope gives enough signal;
- record `fetch_attempts` with outcome and access method;
- keep candidate records aligned with the v0.1 schema fields: `citekey`, `doi`,
  `openalex_id`, `title`, `authors`, `year`, `tier`, `tier_history`,
  `fetch_policy`, `fetch_attempts`, `pdf_path`, `pdf_sha256`,
  `source_version`, `evidence_quality`, `claim_levels_supported`,
  `manual_queue`, and `manual_queue_reason`;
- create friction-minimized manual download queue entries with clickable links,
  suggested save path, and short instructions for Kristian.

Guardrails:

- Never bypass access controls.
- Never log EZProxy cookie contents or private tokens.
- Tier 3 records do not trigger PDF attempts.
