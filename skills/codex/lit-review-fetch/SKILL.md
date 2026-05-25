---
name: lit-review-fetch
description: Stage 3 mechanical lead for metadata retrieval, dedupe, CANDIDATES.jsonl, SEARCH_LOG.md, and DOWNLOAD_QUEUE.md.
---

# lit-review-fetch

Design anchors: `DESIGN.md` §2.11, §3 stage 3, and §9.

Use when executing `SEARCH_PLAN.md` and normalizing literature candidates.

## Workflow

1. Read coordination files if present and claim `SEARCH_LOG.md`,
   `CANDIDATES.jsonl`, `DOWNLOAD_QUEUE.md`, and any download files touched.
2. Run metadata retrieval through available legal/open backends.
3. Normalize records with stable citekeys, DOI/OpenAlex IDs, authors, year,
   title, tier, `tier_history`, `fetch_policy`, `fetch_attempts`, `pdf_path`,
   `pdf_sha256`, `source_version`, `evidence_quality`,
   `claim_levels_supported`, `manual_queue`, and `manual_queue_reason`.
4. Deduplicate by DOI, OpenAlex ID, title/year, and author/title similarity.
5. Generate or update `DOWNLOAD_QUEUE.md` with direct links and manual save
   paths for blocked Tier 1 and opt-in Tier 2 items.
6. Validate JSONL records and report counts by tier/outcome.

Never log secret cookies, private tokens, or bypass attempts.
