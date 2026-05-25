# lit-review-for-econ — Design v0 (draft)

> Status: **proposal-only**. Authored by Claude, reviewed by Codex through
> [`coord/threads/2026-05-24-T-001-claude-important-task.md`](coord/threads/2026-05-24-T-001-claude-important-task.md).
> Kristian approved the core v0.1 defaults on 2026-05-24; remaining details
> are tracked in [`coord/HUMAN.md`](coord/HUMAN.md).

## 1. What this repo produces

A reusable Claude + Codex system — versioned Markdown **skills** and
prompt-driven **subagents** — that, when installed in a paper folder
(e.g. `bribery-experiment-umbrella-repo/03_proposal_and_paper/`), takes
that paper from "research-the-folder" all the way to a **lit-review
section** at world-class RA / coauthor quality, for experimental,
behavioral, and microeconomics work. It is protocol-aware: when the
target folder has `coord/`, the system claims files, opens threads,
posts reviews, and respects ownership per the
`agent-filesystem-collaboration` protocol.

## 2. Non-negotiable quality bar

1. **Citation grounding.** Every claim in the final draft maps to a
   `READING_NOTES/<citekey>.md` that quotes the source with page or
   section anchor.
2. **No invented cites.** The drafting agent refuses to emit
   `\cite{foo}` unless `READING_NOTES/foo.md` exists.
3. **Identification fidelity.** When summarizing a cited paper, the
   agent must correctly restate the identification strategy (RCT, IV,
   natural experiment, structural, lab, field, descriptive) and never
   upgrade correlation to causation.
4. **Landmark coverage.** Per-subfield curated must-cite lists
   (`landmarks/<subfield>.yaml`) are consulted; absences are flagged
   as `[blocker]`.
5. **Bilingual.** `SCOPE.md` declares output language and
   quote/paraphrase policy. Default for Kristian's projects: Spanish
   prose with English preserved for technical terms.
6. **Restartable.** Every stage reads/writes named files; nothing
   relies on in-memory state. Anyone (agent or human) can pick up
   between stages.
7. **Partial use.** Each stage is invocable on its own without running
   the whole pipeline.
8. **Human-in-the-loop PDF access (tier-scoped — see §2.11).** The
   system expects that publishers and search platforms may block
   automated AI download activity. PDF acquisition is **tiered**:
   Tier 1 (essential) papers try a legal-and-ethical source order
   (OA → preprints → author page → UCSC EZProxy → opt-in Browser MCP)
   before escalating to the manual download queue; Tier 2 (important)
   papers attempt only open routes and fall back to abstract-only when
   blocked; Tier 3 (related) papers never attempt a PDF. See §2.11
   for the full tiered evidence policy.
9. **Tool-capability awareness.** The system tracks what each AI
   coding agent in the wider ecosystem can do today (Claude Code,
   Codex, Gemini CLI, and similar) and **almost always** reaches for
   the most modern capability available — slash commands, MCP servers,
   sub-agents, hooks, cowork/teams, browser tools, search APIs.
   Per-agent capability files under `tool-capabilities/` are refreshed
   periodically (default ≤30 days) and the active stack version is
   recorded in each paper's `CONFIG.md` for reproducibility. Falls back
   gracefully and logs degradation when a chosen capability is not
   available in the active agent. See §12.
10. **No invented citations, sharpened.** Beyond §2.2: every reading
    note records identification strategy, population/setting,
    treatment/variation, outcome, estimator/design, main result,
    limitations, and relevance. Abstract-only papers are marked and
    cannot support fine-grained empirical claims. Unsupported claims
    in the draft are downgraded or removed, never patched with a
    convenient post-hoc citation. **Findings reported in the draft
    must come from a `key_findings` block of a reading note for a
    paper at `evidence_quality == full_text` AND `source_version ==
    published`** — see §2.12. The writer never infers findings from
    a substitute_version, non-published full-text copy, abstract_only,
    or absent reading note.
11. **Tiered evidence policy (binding — see §2.11).** Every candidate
    paper carries a `tier ∈ {1 essential, 2 important, 3 related}`
    that determines `fetch_policy ∈ {full_text_required, opportunistic,
    metadata_only}` and the `claim_level_allowed` set the writer may
    later use. Demotion of tier requires reviewer ack or Kristian
    override; promotion is unilateral by the reader.
12. **Findings disclosure (binding — see §2.12).** The lit review
    must report what cited papers **found**, not only what they
    studied. The writer surfaces empirical findings narratively
    for cited papers central to the argument; peripheral or
    distant cites may stay without findings as a judgment call to
    maximize logical and narrative clarity. Findings reported
    only when `evidence_quality == full_text` AND
    `source_version == published`; weaker evidence, including
    `substitute_version`, non-published full-text copies, and
    `abstract_only` records, does not contribute findings (claim
    level 1-3 only). Magnitudes default to qualitative; specific
    numbers are reported only when high-relevance to the target
    paper's contribution.

## 2.11. Tiered Evidence Policy (binding)

Every candidate paper carries a **tier** that determines (a) how the
retriever sources the full text, (b) which kinds of claims the writer
may later make about it, and (c) whether the paper surfaces in
`DOWNLOAD_QUEUE.md`. In prose use `essential` / `important` /
`related`; in machine records use `tier: 1 | 2 | 3`.

### Tier table

| Tier | Prose | `fetch_policy` (machine) | Target `evidence_quality` | Note depth | In `DOWNLOAD_QUEUE.md`? |
|------|-------|---------------------------|---------------------------|-----------|--------------------------|
| **1** | essential | `full_text_required` | `full_text` | Long structured: question, design, sample, identification, key estimates with `(p. NN)`, robustness, limitations, relevance | **Mandatory.** Stage 5 cannot complete without it (or Kristian override in `coord/HUMAN.md`). |
| **2** | important | `opportunistic` | `full_text` preferred; `abstract_only` permitted with cross-reference verification | Mid-depth: as much of Tier-1 structure as the evidence supports | **Opt-in.** Stage 5 can complete without it; reader records the gap. |
| **3** | related | `metadata_only` | `abstract_only` from metadata API | Short context note: claim summary, why-relevant, one paragraph max | **No.** |

### Tier assignment (D1)

Tiers are set at three points, all logged into `tier_history`:

1. `scope-must-cite` — Kristian flags up to ~10 must-cite landmarks in
   `SCOPE.md` during stage 1 → auto-Tier 1.
2. `screener` — stage 4 applies the rubric below (configurable per
   paper).
3. `promotion-from-reading` — stage 5 may upgrade when full-text
   reading reveals greater centrality. **Promotion** is unilateral
   by the reader; **demotion** requires reviewer ack or Kristian
   override.

#### Screener rubric (configurable; no universal thresholds)

A candidate is **Tier 1** if any of:

- Listed as `must_cite` in `landmarks/<subfield>.yaml`.
- Cited `>= scope.tier1_seed_citation_threshold` times in seed papers
  (default 3; configurable; can be `null`).
- Direct empirical competitor on the same intervention/instrument/
  setting and same primary outcome.
- Theoretical foundation explicitly invoked in the target paper's
  identification strategy.

A candidate is **Tier 2** if any of:

- Same broad question, different setting or method.
- Methodologically adjacent (same identification toolkit, different
  question).
- Citation-count signal above `scope.tier2_citation_threshold`
  (default 100 OpenAlex; configurable; `null` disables).

Else **Tier 3**. Ties go to the higher tier.

### `fetch_policy` semantics

#### `full_text_required` (Tier 1)

Legal-and-ethical source order, each attempt recorded as a
`fetch_attempts` entry with `access_method`:

1. OpenAlex `oa_url` → `oa`.
2. CrossRef OA link → `oa`.
3. arXiv / SSRN / NBER / RePEc / IDEAS preprint by DOI/title →
   `preprint`.
4. Author personal page → `author_page`.
5. **UCSC EZProxy via cookie export** (opt-in in `CONFIG.md`;
   `lit-review/.secrets/ezproxy-cookies.txt` gitignored; expiry
   detected via 302→login redirect; cookie content never logged) →
   `ezproxy_browser`.
6. **Browser MCP "download assistance"** (opt-in in `CONFIG.md`;
   default OFF; scoped to opening pages and detecting PDF/download
   buttons; audit line to `SEARCH_LOG.md`) →
   `ezproxy_browser | manual_library`.
7. If still missing → `DOWNLOAD_QUEUE.md` mandatory section; stage 5
   blocks; `manual_queue_reason` recorded.

If only a substitute version is obtained, `evidence_quality =
substitute_version` and `source_version` records which version
(`working_paper | preprint | accepted_ms | unknown`).

#### `opportunistic` (Tier 2)

Try steps 1–4. Skip steps 5–6 unless
`CONFIG.md.opportunistic_use_authenticated = true`. On failure either
add to opt-in queue (`CONFIG.md.tier2_queue_when_blocked = true` by
default) or produce an `abstract_only` note.

#### `metadata_only` (Tier 3)

No PDF attempts. Abstract pulled from the metadata API. Short context
note only.

### `claim_level_allowed` taxonomy (D3)

The writer is constrained by the intersection of `evidence_quality`
and the claim level it intends to assert. Eight levels:

1. `bibliographic_context` — the paper exists in this venue.
2. `topic_presence` — the literature has explored topic Y.
3. `method_or_design_summary` — Smith uses X identification in Z.
4. `empirical_result` — Smith finds effect Y on outcome Z.
5. `numerical_effect` — Smith reports a 12 pp effect (SE 0.03).
6. `mechanism` — Smith argues the effect operates via channel M.
7. `heterogeneity` — Smith reports effects vary by subgroup K.
8. `policy_implication` — Smith concludes policy P should be enacted.

| `evidence_quality` | 1 bib | 2 topic | 3 method | 4 result | 5 num | 6 mech | 7 het | 8 policy |
|--------------------|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| `full_text` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| `substitute_version` | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `abstract_only` | ✅ | ✅ | ⚠ if abstract states design | ⚠ corroborated | ❌ | ❌ | ❌ | ❌ |
| `none` | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

Legend: ✅ allowed · ⚠ allowed with corroboration / version match ·
❌ refused at draft time. QA stage 8 emits `[blocker]` on any
violation; the writer self-censors during draft.

For claim levels 4-8, `full_text` means `evidence_quality == full_text`
**and** `source_version == published`. A full-text working paper, preprint,
accepted manuscript, or unknown version is treated as `substitute_version`
until the published version is obtained or Kristian records an explicit
override in `coord/HUMAN.md`.

### Promotion / demotion (D2)

`CANDIDATES.jsonl` carries `tier_history` as an array of
`{ts, from, to, actor, reason}`. Promotion: unilateral by the actor.
Demotion: reviewer `ack: true` in active thread OR Kristian override
in `coord/HUMAN.md`.

The retriever re-runs the new `fetch_policy` on promoted candidates.

### `CANDIDATES.jsonl` schema (final, machine-readable)

```jsonc
{
  "citekey": "Smith2019",
  "doi": "10.xxxx/yyyy",
  "openalex_id": "W...",
  "title": "...",
  "authors": [{"family": "Smith", "given": "J."}],
  "year": 2019,

  "tier": 1,
  "tier_history": [
    {"ts": "...", "from": null, "to": 1, "actor": "screener", "reason": "..."}
  ],
  "fetch_policy": "full_text_required",

  "fetch_attempts": [
    {
      "backend": "openalex_oa_url",
      "ts": "...",
      "outcome": "ok | 404 | blocked | paywall | login_required | captcha_or_bot_check | terms_block | manual_required",
      "access_method": "oa | preprint | author_page | manual_library | ezproxy_browser | abstract_only",
      "url": "..."
    }
  ],

  "pdf_path": "lit-review/DOWNLOADS/Smith2019.pdf | null",
  "pdf_sha256": "abc123... | null",
  "source_version": "published | working_paper | preprint | accepted_ms | unknown",

  "evidence_quality": "full_text | substitute_version | abstract_only | none",
  "claim_levels_supported": [1, 2, 3, 4, 5, 6, 7, 8],

  "manual_queue": false,
  "manual_queue_reason": "blocked | paywall | no_pdf_found | login_required | ambiguous_version | null"
}
```

### `READING_NOTES/<citekey>.md` frontmatter (final)

```yaml
---
citekey: Smith2019
doi: 10.xxxx/yyyy
tier: 1
evidence_quality: full_text
source_version: published
extractor: pdftotext
extractor_version: "5.x"
pdf_path: lit-review/DOWNLOADS/Smith2019.pdf
pdf_sha256: abc123...
pages_read: "1-32"
access_method: oa
claim_levels_supported: [1, 2, 3, 4, 5, 6, 7, 8]
---
```

### `DOWNLOAD_QUEUE.md` UX

Tier-sorted with a `skip-this-for-now` toggle per item so Kristian
can keep moving without editing JSON. See §9 for the full UX.

## 2.12. Findings Disclosure (binding)

The lit review must tell the reader **what cited papers found**, not
only what they studied. A review that explains topics, designs, and
methods without surfacing results leaves the reader knowing the
questions but not the answers. This section makes findings disclosure
a first-class output.

### Reader side (stage 5, `paper-reader`)

Every reading note for a paper with `evidence_quality == full_text`
**and** `source_version == published` MUST include a `key_findings`
block at the top of the note body, covering:

- `headline_finding`: 1–2 sentences naming the main empirical
  result the paper is most cited for.
- `direction`: positive | negative | null | mixed (qualitative,
  per main outcome).
- `magnitude`: qualitative descriptor (e.g. "substantial",
  "modest", "near-zero") by default. Specific numbers ONLY when
  the paper's effect size is central to its contribution AND
  the note records a `(p. NN)` anchor for the quote.
- `mechanism`: 1 sentence if the paper argues for a specific
  channel; omit if not.
- `heterogeneity`: 1 sentence if the paper reports key subgroup
  variation relevant to the target paper; omit if not.
- `caveats`: external-validity limits, identification caveats,
  or other discipline the author flags.

For all records below `evidence_quality == full_text` **and**
`source_version == published` — including `substitute_version`,
`abstract_only`, `none`, and full-text working-paper/preprint/accepted-MS
copies — the `key_findings` block is **omitted** (or left explicitly empty
with a `findings_blocked_by_evidence_quality: true` flag). These papers
contribute only at claim level 1–3 per §2.11 unless Kristian records an
explicit override in `coord/HUMAN.md`.

### Writer side (stage 7, `lit-writer` — v0.2)

The writer applies **judgment-based granularity**:

- Findings are surfaced **narratively** for cited papers central to
  the literature/argument. Default: include findings for any paper
  doing real argumentative work in the prose.
- Peripheral, contextual, or distant cites may be mentioned by
  topic/method only; findings can be omitted as a deliberate
  judgment call to **maximize logical and narrative clarity** (per
  Kristian, 2026-05-25).
- Findings are **mostly qualitative** ("audits substantially reduced
  missing expenditures"). Specific numerical magnitudes are reported
  only when they materially shape the target paper's positioning.
- Records below the full-text + published bar: writer cites for
  topic/method/positioning only. **Never report findings from these.**
  If a substitute or non-published full-text paper has highly relevant
  content, the writer flags it for re-acquisition rather than reporting
  findings from that source.
- Verb tense: past tense for what authors found, present tense for
  the design/method ("Abbink et al. (2002) **introduce** a repeated
  bribery game and **find** that…"). Standard econ-review register.

### QA side (stage 8, `lit-reviewer-qa`)

QA verifies:

- Every paragraph that asserts a finding cites a paper with
  `evidence_quality == full_text` AND `source_version ==
  published`. Mismatch → `[blocker]`.
- Numerical magnitudes in prose match the `(p. NN)`-anchored quote
  in the corresponding reading note's `key_findings.magnitude`
  field. Mismatch → `[blocker]`.
- Findings prose does not exceed what the paper itself claims (no
  upgrading correlation to causation, no inferring mechanism the
  paper doesn't argue).
- The judgment call to omit findings for a peripheral cite is
  acceptable; the QA does not require findings for every cite,
  only that findings, when present, are correctly grounded.

## 3. Pipeline

Inside a paper folder, work lives under `lit-review/`. Each stage has
one skill, one output artifact, and a "done-when" checklist.

| # | Skill                  | Owner agent          | Output under `lit-review/`                    |
|---|------------------------|----------------------|-----------------------------------------------|
| 0 | `/lit-review-init`     | claude               | `CONFIG.md`                                   |
| 1 | `/lit-review-scope`    | `paper-scoper`       | `SCOPE.md` (+ at most 5 questions to Kristian)|
| 2 | `/lit-review-plan`     | `lit-search-strategist` | `SEARCH_PLAN.md`                          |
| 3 | `/lit-review-fetch`    | `lit-retriever`      | `SEARCH_LOG.md` + `CANDIDATES.jsonl` (consumes `tier`/`fetch_policy`, logs `fetch_attempts` + `tier_history`) + `DOWNLOAD_QUEUE.md` |
| 4 | `/lit-review-screen`   | `lit-screener`       | `SCREENED.md`                                 |
| 5 | `/lit-review-read`     | `paper-reader`       | `READING_NOTES/<citekey>.md`                  |
| 6 | `/lit-review-curate`   | `lit-curator`        | `SYNTHESIS.md` + `OUTLINE.md`                 |
| 7 | `/lit-review-draft`    | `lit-writer`         | `DRAFT.tex` (or `.qmd`/`.md`) + `lib.bib`     |
| 8 | `/lit-review-qa`       | `lit-reviewer-qa`    | `QA.md`                                       |

`/lit-review-full` chains 1→8 with confirmation gates after 2, 4, 6.

### Stage gates

- During 1 (`SCOPE.md`): **author-alignment gate**. After the
  first manuscript/bibliography pass, ask Kristian to confirm the
  inferred research questions, target literatures/fields, related-paper
  types, must-cite landmarks, and explicit exclusions. Do this before
  treating the scope as final. If Kristian is unavailable, record the
  inferred defaults in `ASSUMPTIONS.md`; Stage 3 fetch should not begin
  until the gate is answered, explicitly deferred by Kristian, or made
  visible for reviewer approval.
- After 2 (`SEARCH_PLAN.md`): cross-agent review + Kristian sign-off
  on must-cite landmarks and the author-alignment gate.
- After 4 (`SCREENED.md`): cross-agent review of borderline rejects.
- After 6 (`OUTLINE.md`): Kristian sign-off on narrative arc + gap.
- After 7 (`DRAFT.tex`): cross-agent review + Kristian read-through.

## 4. Artifact tree (inside a paper folder)

```text
lit-review/
  CONFIG.md            # style, language, paths, sources, Zotero, .bib target, tier thresholds, enable_browser_mcp, opportunistic_use_authenticated, tier2_queue_when_blocked
  .secrets/
    ezproxy-cookies.txt  # gitignored; UCSC EZProxy auth cookies; expiry detected, never logged
  SCOPE.md             # RQ, author-alignment status, hypotheses, identification, contribution, JEL, seeds, must_cite (auto-Tier 1)
  SEARCH_PLAN.md       # queries, sources, time window, must-cite landmarks
  SEARCH_LOG.md        # what we ran, when, against which backends, result counts, browser MCP audit lines
  CANDIDATES.jsonl     # canonical records with tier, tier_history, fetch_policy, fetch_attempts, pdf_sha256, source_version, evidence_quality, claim_levels_supported, access_method, manual_queue_reason
  DOWNLOAD_QUEUE.md    # tier-sorted manual queue (Tier 1 mandatory / Tier 2 opt-in / Substitutes), with skip-this-for-now markers
  DOWNLOADS/           # expected landing folder for manually saved PDFs
  SCREENED.md          # human-facing summary of CANDIDATES.jsonl tier/status/reason
  READING_NOTES/
    <citekey>.md       # structured note with evidence_quality, source_version, extractor provenance, claim_levels_supported in frontmatter
  SYNTHESIS.md         # clusters + gap statement
  OUTLINE.md           # paragraph plan with proposed cites
  DRAFT.tex|qmd|md     # the generated section (writer constrained by claim_level × evidence_quality matrix)
  lib.bib              # generated/updated bib, merge plan into paper's bib
  QA.md                # claim-to-source audit, claim_level enforcement, landmark check, formatting
  ASSUMPTIONS.md       # documented defaults when Kristian was not asked
```

## 5. Subagents

- `paper-scoper` — reads the paper folder, drafts `SCOPE.md`, asks ≤5
  author-alignment/scoping questions.
- `lit-search-strategist` — produces `SEARCH_PLAN.md` with keyword
  bundles, JEL codes, seed authors, must-cite landmarks.
- `lit-retriever` — executes the plan against configured backends,
  dedups, normalizes; produces `SEARCH_LOG.md`, `CANDIDATES.jsonl`, and
  a manual `DOWNLOAD_QUEUE.md` when PDF access needs Kristian.
- `lit-screener` — abstract triage with explicit rubric and tiering.
- `paper-reader` — single-paper structured note. This is the quality
  bottleneck; it must access the actual PDF text.
- `lit-curator` — clusters notes, synthesizes the gap, designs the
  narrative arc.
- `lit-writer` — drafts the section in the configured style, emits
  `.bib` entries.
- `lit-reviewer-qa` — claim-to-source audit, landmark coverage,
  identification-claim accuracy, formatting.

## 6. Runtime division of labor

- **Codex leads**: stage 3 (`fetch`) and the `.bib` mechanics of stage
  7 — API calls, DOI normalization, dedupe, BibTeX generation, PDF
  lookup, plus schema validation of `CANDIDATES.jsonl`, file audits,
  and mechanical QA in stage 8. CLI/API ergonomics favor Codex.
- **Claude leads**: stages 1, 2, 4, 5, 6, 7-prose, 8 (argumentative
  coherence, claim-to-source audit).
- **Either reviews the other**. Kristian can override per task. Either
  agent must be able to run the full pipeline solo in a degraded mode
  if the other is unavailable, recording the degradation in
  `ASSUMPTIONS.md`.

## 7. Coordination contract

When the target folder has `coord/`:

1. Read `coord/AGENTS_PROTOCOL.md`, `STATE.md`, `OPERATING_MODE.md`,
   and the active thread before any nontrivial action.
2. Each stage opens or appends to a `coord/threads/lit-review-<stage>-….md`
   thread with a `claim` listing every file it will touch under
   `lit-review/`.
3. Stages 2, 4, 6, 7 close with a `[suggestion]` checkpoint requesting
   a cross-agent pass. Stage 8 is itself a `review`.
4. Each stage allows ≤3 blocker questions to Kristian; otherwise it
   documents the chosen default in `ASSUMPTIONS.md` and proceeds.
5. Decisions only Kristian can make → `coord/HUMAN.md` of the paper
   folder.

## 8. Install model (proposed)

A `bootstrap-lit-review.sh` in this repo drops, into the target paper
folder:

- `.claude/skills/lit-review-*` and `.codex/skills/lit-review-*`
  (canonical sources versioned here under `skills/`);
- `lit-review/CONFIG.md` seeded from defaults + Kristian's per-paper
  answers;
- if `coord/` is absent, suggests running
  `agent-filesystem-collaboration/bootstrap.sh` first.

The bootstrap is **idempotent and dry-run capable** (`--dry-run`,
`--force`). It never overwrites existing `.claude/skills/`,
`.codex/skills/`, `lit-review/`, or `coord/` files without `--force`
plus a per-file backup, and it writes
`lit-review/INSTALL_LOG.md` recording: source repo commit, list of
installed files, timestamp, selected defaults, and the active
tool-stack snapshot (per §12).

Mirrors `agent-filesystem-collaboration/bootstrap.sh` in style.

## 9. Manual PDF download assist (tier-scoped — see §2.11)

Automated metadata retrieval is in scope; automated PDF download is
**tier-scoped** per §2.11. Tier 1 (essential) papers try a legal-and-
ethical source order before escalating to the queue; Tier 2 attempt
only open routes and fall back to abstract-only; Tier 3 never attempt
a PDF.

When `/lit-review-fetch` or `/lit-review-read` cannot obtain a PDF
through the Tier 1 source order, it adds an item to
`lit-review/DOWNLOAD_QUEUE.md`. The queue is **tier-sorted** and each
item supports a `skip-this-for-now` toggle so Kristian can keep
moving without editing JSON.

Queue UX:

```markdown
# Download Queue

> Auto-generated by /lit-review-fetch. Update by downloading the PDF
> to the suggested path; pipeline detects on next run.

## Tier 1 — essential — mandatory (block stage 5 until resolved)

- [ ] **Smith2019** — "Bribery in Lab Experiments"
  - DOI: 10.xxxx/yyyy
  - Tried: openalex_oa_url(404), arxiv(no-match), ezproxy(blocked-403)
  - `manual_queue_reason`: paywall
  - Save to: `lit-review/DOWNLOADS/Smith2019.pdf`
  - Links: [Publisher](...) · [Scholar](...) · [UCSC proxy](...)
  - `[ ] skip-this-for-now` — toggle to `[x]` to make stage 5 proceed
    without it; writer will not be allowed to use claim levels above
    `topic_presence` (see §2.11 claim taxonomy).

## Tier 2 — important — opt-in (can skip; abstract-only path available)

- [ ] **Jones2021** — "..."
  - `[ ] skip-this-for-now`

## Substitutes available

- [x] **Brown2020** — using working paper version
  `lit-review/DOWNLOADS/Brown2020_wp.pdf`. Re-verify if you can get
  the published version to enable claim levels 5/7.
```

The reader stage scans `lit-review/DOWNLOADS/`, computes
`pdf_sha256`, and resumes automatically when the expected file
appears. It records `evidence_quality`, `source_version`, and
`access_method` (per §2.11 schema) into both `CANDIDATES.jsonl` and
each note's frontmatter. The pipeline must not silently treat
abstract-only evidence as full-text evidence — the writer is
constrained by the §2.11 claim-level × evidence-quality matrix and QA
stage 8 enforces it.

Browser MCP, when enabled in `CONFIG.md`, is scoped to "download
assistance" (open authenticated pages, detect PDF/download buttons,
record outcome) — never to bypass access controls. Every browser MCP
action writes an audit line to `SEARCH_LOG.md` with URL, ts, result
category, and whether Kristian had to act.

## 10. Repo layout (this repo)

```text
lit-review-for-econ/
  DESIGN.md                  # this file
  README.md                  # pending
  bootstrap-lit-review.sh    # pending; idempotent + dry-run
  skills/
    claude/                  # Claude Code skills (one MD per slash command)
    codex/                   # Codex skills (one SKILL.md per command)
  agents/                    # prompt + frontmatter per subagent
  landmarks/                 # structured must-cite YAML per subfield
  style-profiles/            # AEA, EE, JEEA, etc.
  tool-capabilities/         # claude-code.md, codex.md, gemini-cli.md, playwright-mcp.md, ucsc-ezproxy.md (last-checked dates)
  templates/
    paper-folder-lit-review/ # the lit-review/ scaffold that gets dropped in
  coord/                     # this repo's own collaboration thread
```

## 11. v0.1 MVP (first ship)

Stages 0–5 only. Deliverable for a paper folder: a fully populated
`READING_NOTES/` + an augmented `.bib`, ready for Kristian (or v0.2) to
draft from. Drafting (6, 7) and QA (8) land in v0.2 after v0.1
artifacts prove out in the Bribery paper folder.

Approved v0.1 defaults from Kristian on 2026-05-24:

- v0.1 includes stages 0-5 only.
- Primary output format is `.tex` + `.bib`.
- Initial style target is AEA family.
- Paper folders consume the system via `bootstrap-lit-review.sh`.
- Initialize/push `lit-review-for-econ` to GitHub when ready.

## 12. Multi-agent tool-capability awareness

The system tracks what each AI coding agent in the wider ecosystem can
do **today** and prefers the most modern tooling **almost every time**
(per Kristian's directive on 2026-05-24). Tracked agents include:

- **Claude Code** — CLI + IDE, Agent SDK, sub-agents, MCP servers,
  hooks, cowork/teams, skills, scheduled wake-ups, IDE extensions.
- **Codex** — CLI, file-based collaboration via the
  `agent-filesystem-collaboration` protocol, plus future native tools.
- **Gemini CLI** and other parallel CLIs/SDKs as they reach feature
  parity.

### `tool-capabilities/<agent>.md`

One file per agent, with: capabilities checklist (e.g. browser tool,
WebSearch, MCP server X, slash-command Y), version/date last verified,
and "use for" pointers from this repo's skills/agents.

### Refresh policy

`/lit-review-init` reads `tool-capabilities/*.md`, warns when any file
is older than the configured threshold (default 30 days), and offers
to run a refresh pass. Stages may also opt in to a per-run capability
re-check when the pipeline is about to use a fast-moving capability
(e.g. a new search MCP).

### Reproducibility

The active tool-stack snapshot (agent name + version + capabilities
used) is recorded in the per-paper `CONFIG.md` and in
`INSTALL_LOG.md`. When a capability becomes unavailable on a re-run,
the pipeline falls back gracefully and logs the degradation to
`SEARCH_LOG.md` and `ASSUMPTIONS.md` — never silently.

### Guardrails

- New capabilities are adopted only if a fallback exists for agents
  that don't yet support them, or if Kristian opts in to a hard
  dependency.
- Tool choices are not buried in code; they live in `CONFIG.md` and
  in each agent's capability file.

## 13. Open decisions

For **Codex** (in the active thread, C-1..C-7 — addressed in his
22:19 review).
For **Kristian** (in `coord/HUMAN.md`, regrouped into resolved vs
remaining details).
