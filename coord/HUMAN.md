# Questions For Kristian

Decisions the agents cannot resolve without you. Grouped per Codex's
review nit into **must-decide-before-design-approval** (block the
green-light on `DESIGN.md`) vs **MVP-defaultable** (we will commit to
a documented default and proceed if you are silent).

## Must decide before design approval

All design-approval blockers below were answered by Kristian on
2026-05-24:

- Q-01 Pipeline scope at v0.1: **yes**, approve v0.1 = stages 0-5
  (init -> scope -> plan -> fetch -> screen -> read); drafting and QA
  can land in v0.2.
- Q-02 Output style / target venue: **yes**, initial target is AEA
  family.
- Q-03 Output format: **yes**, primary output is `.tex` plus `.bib`.
- Q-05 Install model: **yes**, use a local `bootstrap-lit-review.sh`
  into each paper folder.
- Q-08 Repo identity: **yes**, initialize/push `lit-review-for-econ`
  to GitHub when ready.

## Open Design Requirement From Kristian

### Q-09 — Manual PDF download assist

Kristian notes that downloading papers from many platforms is often
difficult because sites block AI/scripted activity. The system should
include author intervention for manual PDF download, but minimize
friction.

Design requirement:

- Create a terminal/UI flow that presents clickable links and exact
  save-location instructions for papers requiring manual download.
- Prefer a simple artifact such as `lit-review/DOWNLOAD_QUEUE.md` plus
  expected paths under `lit-review/DOWNLOADS/`.
- The user experience should be: open link, download PDF, save/rename
  to expected path, rerun or let the pipeline detect the file.
- The pipeline should resume cleanly and record whether evidence came
  from full text, abstract only, or substitute paper versions.

## MVP-defaultable

### Q-03b — Literature sources & credentials

Confirm or veto the proposed backend stack: OpenAlex (primary, no key)
+ CrossRef (DOI canonicalizer) + Semantic Scholar (enrichment, free
key) + arXiv / RePEc / NBER (preprints) + your **Zotero** library as
source-of-truth that we augment, never overwrite.

Defaults if silent: as listed; Zotero integration off until you point
us at your library.

### Q-04 — PDF library & extraction

Where do PDFs live (Zotero storage / `~/Papers` / per-project
`papers/` / Google Drive)? Extraction tool default: `pdftotext`, opt-in
`pymupdf`, defer GROBID/marker.

Defaults if silent: per-project `papers/` for fetched PDFs;
`pdftotext`; do not touch your Zotero storage.

### Q-06 — Codex's runtime role

We proposed: Codex leads `fetch` (stage 3) + `.bib` mechanics of
`draft` (stage 7); Claude leads scoping, planning, screening,
reading, curating, drafting-prose, QA; either reviews the other.

Default if silent: as proposed.

### Q-07 — Where do questions to you surface?

- Inline in chat with the running agent.
- Appended to the paper folder's `coord/HUMAN.md`.
- A dedicated `lit-review/QUESTIONS.md` per paper.

Budget: ≤5 foundational questions at scoping, ≤3 blocker questions per
later stage; everything else → `lit-review/ASSUMPTIONS.md`.

Default if silent: all three channels, prioritized in the order above
(inline if a chat is live, otherwise `coord/HUMAN.md`, with mirror in
`lit-review/QUESTIONS.md`).

## Resolved

### 2026-05-24 — Core v0.1 defaults

- Q-01: v0.1 scope approved as stages 0-5 only.
- Q-02: initial style target approved as AEA family.
- Q-03: primary output approved as `.tex` + `.bib`.
- Q-05: install model approved as `bootstrap-lit-review.sh`.
- Q-08: repo should be initialized/pushed to GitHub when ready
  (public, remote `kmlv/lit-review-for-econ`).
- License: **MIT**.
- First target paper folder: synthetic
  `templates/paper-folder-lit-review/`, not Bribery.
- Tool-capability awareness (K-1): non-negotiable; refresh ≤30 days;
  see `DESIGN.md` §2.9 + §12.
