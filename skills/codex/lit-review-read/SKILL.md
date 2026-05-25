---
name: lit-review-read
description: Stage 5 helper for validating PDFs, hashing downloads, and creating grounded READING_NOTES with a key_findings block when evidence permits.
---

# lit-review-read

Design anchors: `DESIGN.md` §2.10, §2.11, §2.12, §3 stage 5, and §9.

Use when producing or validating structured notes from screened papers.

## Workflow

1. Read coordination files if present and claim the relevant
   `READING_NOTES/<citekey>.md`, `CANDIDATES.jsonl`, and queue entries.
2. Scan `lit-review/DOWNLOADS/` for expected PDFs and compute SHA-256 hashes.
3. For full-text notes, extract text with available tools and record extractor
   provenance.
4. Enforce the claim-level matrix: abstract-only evidence cannot support
   numerical, mechanism, heterogeneity, or policy claims.
5. **Findings extraction (§2.12)**: when `evidence_quality == full_text`
   AND `source_version == published`, emit a `key_findings` block at the
   top of the note body containing `headline_finding`, `direction`,
   `magnitude` (qualitative by default; numeric only when central +
   page-anchored), `mechanism` (if argued), `heterogeneity` (if relevant),
   and `caveats`. When evidence is below that bar, omit the block or set
   `findings_blocked_by_evidence_quality: true`. Never invent or infer
   findings from sub-full-text sources.
6. Update candidate `evidence_quality`, `source_version`, `pdf_sha256`, and
   `claim_levels_supported`.
7. Report unresolved Tier 1 blockers from `DOWNLOAD_QUEUE.md`.

Do not treat an abstract, metadata page, or substitute version as published
full text.
