---
name: lit-review-fetch
description: Stage 3: retrieve metadata, normalize candidate records, and maintain the manual PDF download queue.
---

# /lit-review-fetch

Design anchors: `DESIGN.md` §2.11, §3 stage 3, and §9.

Use this skill after `/lit-review-plan` to populate `SEARCH_LOG.md`,
`CANDIDATES.jsonl`, and `DOWNLOAD_QUEUE.md`.

Claude may run this in degraded/manual mode, but Codex is the preferred lead for
API calls, normalization, dedupe, and file audits.

## Workflow

1. If `coord/` exists, claim `SEARCH_LOG.md`, `CANDIDATES.jsonl`,
   `DOWNLOAD_QUEUE.md`, and downloaded files you will touch.
2. Read `SEARCH_PLAN.md`, `CONFIG.md`, and the tiered evidence policy.
3. Use open/legal metadata routes first. Record each backend/query in
   `SEARCH_LOG.md`.
4. Write one JSON object per candidate after the header in `CANDIDATES.jsonl`.
   Include `citekey`, `doi`, `openalex_id`, `title`, `authors`, `year`,
   `tier`, `tier_history`, `fetch_policy`, `fetch_attempts`, `pdf_path`,
   `pdf_sha256`, `source_version`, `evidence_quality`,
   `claim_levels_supported`, `manual_queue`, and `manual_queue_reason`.
5. For blocked Tier 1 full texts, add clickable/manual instructions in
   `DOWNLOAD_QUEUE.md` with suggested save path and tried links. Do not bypass
   access controls.

## Done When

- Candidate records are deduped by DOI/OpenAlex/title similarity.
- Tier 1 blocked items are visible in `DOWNLOAD_QUEUE.md`.
- Tier 2 failures degrade to opt-in queue or abstract-only according to config.
- No cookie contents, private tokens, or authenticated URLs are logged.
