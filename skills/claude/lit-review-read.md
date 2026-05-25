---
name: lit-review-read
description: Stage 5: create grounded READING_NOTES for screened papers, respecting evidence quality and manual PDF gaps. Extracts a key_findings block when evidence supports it.
---

# /lit-review-read

Design anchors: `DESIGN.md` §2.10, §2.11, §2.12, §3 stage 5, and §9.

Use this skill after `/lit-review-screen` to produce structured reading notes.

## Inputs

- `lit-review/SCREENED.md`
- `lit-review/CANDIDATES.jsonl`
- `lit-review/DOWNLOADS/`
- `lit-review/DOWNLOAD_QUEUE.md`

## Workflow

1. If `coord/` exists, claim the relevant `READING_NOTES/<citekey>.md`,
   `CANDIDATES.jsonl`, and queue entries.
2. Invoke or follow `paper-reader`.
3. For each Tier 1 paper, require full text or explicit Kristian override.
4. For Tier 2, prefer full text but allow abstract-only notes with restricted
   claim levels. For Tier 3, keep notes short and metadata-based.
5. Record identification strategy, setting, treatment/variation, outcomes,
   estimator/design, results, mechanisms, limitations, relevance, and quoted
   anchors with page or section references when full text is available.
6. **Findings extraction (§2.12)**: when the read is `evidence_quality ==
   full_text` AND `source_version == published`, emit a `key_findings`
   block at the top of the note body with `headline_finding`, `direction`,
   `magnitude` (qualitative by default; numeric only when central + page
   anchored), `mechanism` (if argued), `heterogeneity` (if relevant), and
   `caveats`. When the source is below the full-text + published bar —
   including `substitute_version`, `abstract_only`, `none`, or full text
   from a working-paper/preprint/accepted-MS/unknown version — **omit**
   `key_findings` or flag `findings_blocked_by_evidence_quality: true`.
   Never infer findings from weaker evidence.
7. Update `evidence_quality`, `source_version`, `pdf_sha256`, and
   `claim_levels_supported`.

## Done When

- Notes exist for the agreed Tier 1/Tier 2 reading set.
- `key_findings` block present where evidence permits; omitted/flagged
  otherwise.
- Unsupported claim levels are not asserted.
- Manual download blockers remain visible in `DOWNLOAD_QUEUE.md`.
- The folder is ready for v0.2 curation/drafting with findings the
  writer can surface narratively.
