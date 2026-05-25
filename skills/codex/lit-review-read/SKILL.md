---
name: lit-review-read
description: Stage 5 helper for validating PDFs, hashing downloads, and creating grounded READING_NOTES.
---

# lit-review-read

Use when producing or validating structured notes from screened papers.

## Workflow

1. Read coordination files if present and claim the relevant
   `READING_NOTES/<citekey>.md`, `CANDIDATES.jsonl`, and queue entries.
2. Scan `lit-review/DOWNLOADS/` for expected PDFs and compute SHA-256 hashes.
3. For full-text notes, extract text with available tools and record extractor
   provenance.
4. Enforce the claim-level matrix: abstract-only evidence cannot support
   numerical, mechanism, heterogeneity, or policy claims.
5. Update candidate `evidence_quality`, `source_version`, `pdf_sha256`, and
   `claim_levels_supported`.
6. Report unresolved Tier 1 blockers from `DOWNLOAD_QUEUE.md`.

Do not treat an abstract, metadata page, or substitute version as published
full text.
