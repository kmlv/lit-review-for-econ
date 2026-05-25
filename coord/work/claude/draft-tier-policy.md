# Draft — §2.11 Tiered Evidence Policy (v2, with Codex's refinements)

Owner: claude. Status: **converged** with Codex (acks at thread
2026-05-25T05:24:58Z, 05:26:56Z, 05:37:34Z) and Kristian (D4=A, D5=opt-in
default OFF). Ready to merge into `DESIGN.md` §2.11. Supersedes v1.

## §2.11 Tiered Evidence Policy (proposed binding text)

Every candidate paper carries a **tier** that determines (a) how the
retriever sources the full text, (b) which kinds of claims the writer
may later make about it, and (c) whether the paper surfaces in
`DOWNLOAD_QUEUE.md`.

In prose: `essential`, `important`, `related`. In machine records:
`tier: 1 | 2 | 3`.

### Tier table

| Tier | Prose name | `fetch_policy` (machine) | Default `evidence_quality` target | Note depth | In `DOWNLOAD_QUEUE.md`? |
|------|------------|---------------------------|-----------------------------------|-----------|--------------------------|
| **1** | essential | `full_text_required` | `full_text` | Long structured note: question, design, sample, identification, key estimates with `(p. NN)`, robustness, limitations, relevance | **Mandatory.** Stage 5 cannot complete without it (or an explicit Kristian override in `coord/HUMAN.md`). |
| **2** | important | `opportunistic` | `full_text` preferred; `abstract_only` permitted with cross-reference verification | Mid-depth note: as much of the Tier-1 structure as the available evidence supports | **Opt-in.** Stage 5 can complete without it; reader records the gap. |
| **3** | related | `metadata_only` | `abstract_only` from metadata API | Short context note: claim summary from abstract, why-relevant tag, one-paragraph max | **No.** |

The legal source order for `full_text_required` is assertive but
explicitly ethical (see "Fetch order" below). `metadata_only` never
attempts a PDF fetch.

### Tier assignment (D1)

Tiers are set at multiple points, all logged into `tier_history`:

1. `scope-must-cite` — Kristian flags up to ~10 must-cite landmark
   papers in `SCOPE.md` during stage 1. These are automatically
   Tier 1.
2. `screener` — `/lit-review-screen` (stage 4) applies the configured
   rubric (see below) to every other candidate.
3. `promotion-from-reading` — `/lit-review-read` (stage 5) may upgrade
   a tier when full-text reading reveals greater centrality than the
   screener assumed. **Promotion** is unilateral by the reader.
   **Demotion** requires reviewer ack (the other agent) or Kristian
   override (`coord/HUMAN.md`), because demoting hides evidence.

### Screener tier rubric (configurable, no universal thresholds)

`SCOPE.md` may override any value here. The rubric below is the
default; Codex's nit (citation count not universal) is honored.

A candidate is **Tier 1** if any of:

- Listed as `must_cite` in `landmarks/<subfield>.yaml` for an active
  subfield tag.
- Cited `>= scope.tier1_seed_citation_threshold` times in seed papers
  (default 3, configurable per paper in `SCOPE.md`).
- Direct empirical competitor: same intervention/instrument/setting
  and same primary outcome as the target paper.
- Theoretical foundation explicitly invoked in the target paper's
  identification strategy.

A candidate is **Tier 2** if any of:

- Same broad question, different setting or method.
- Methodologically adjacent (same identification toolkit applied to a
  different question).
- Citation-count signal above `scope.tier2_citation_threshold`
  (default 100 on OpenAlex; configurable; can be `null` to disable).

Else **Tier 3**: contextual, framing, or motivational reference.

Ties go to the higher tier.

### `fetch_policy` semantics (D2/D3/D4/D5)

#### `full_text_required` (Tier 1)

The retriever tries sources in this legal-and-ethical order, recording
each attempt as a `fetch_attempts` entry:

1. OpenAlex `oa_url` (open-access version, no auth) → `access_method: oa`.
2. CrossRef `link` (publisher-provided OA link) → `access_method: oa`.
3. arXiv / SSRN / NBER / RePEc / IDEAS preprint URL by DOI or title
   match → `access_method: preprint`.
4. Author personal page (Google Scholar `eprint` link / OpenAlex
   `host_venue` if institutional repository) → `access_method:
   author_page`.
5. **UCSC EZProxy via cookie export** (if `CONFIG.md` opted in;
   `lit-review/.secrets/ezproxy-cookies.txt` gitignored; expiry
   detection by 302→login redirect; cookie content never logged) →
   `access_method: ezproxy_browser`.
6. **Browser MCP "download assistance"** (if `CONFIG.md` opted in;
   default OFF) — opens authenticated pages, detects PDF/download
   buttons, prompts Kristian on ambiguous access. Writes audit line
   to `SEARCH_LOG.md`: URL, ts, result category, whether Kristian had
   to act. → `access_method: ezproxy_browser` or `manual_library`.
7. If still missing → escalate to `DOWNLOAD_QUEUE.md` (mandatory
   section); stage 5 blocks on this paper until Kristian places a PDF
   at `lit-review/DOWNLOADS/<citekey>.pdf` OR explicitly overrides via
   `coord/HUMAN.md`. → `access_method: manual_library` once delivered;
   `manual_queue_reason` recorded.

If a substitute version (working paper / earlier journal version) is
the only obtainable copy, `evidence_quality = substitute_version` and
`source_version = working_paper | preprint | accepted_ms`; the writer
is constrained per the taxonomy below.

#### `opportunistic` (Tier 2)

Try steps 1–4 above. **Skip** EZProxy and browser MCP unless
`CONFIG.md` explicitly enables
`opportunistic_use_authenticated = true`.

If steps 1–4 fail:

- If `CONFIG.md.tier2_queue_when_blocked = true` (default): add to
  `DOWNLOAD_QUEUE.md` opt-in section; stage 5 can still complete the
  paper as abstract-only.
- The reader produces an abstract-only note (`evidence_quality =
  abstract_only`) and limits its later use per claim taxonomy.

#### `metadata_only` (Tier 3)

No PDF attempts. The retriever records the abstract from OpenAlex (or
other metadata API) and stage 5 produces a short context note only.

### `claim_level_allowed` taxonomy (D3)

The writer is constrained by the intersection of `evidence_quality`
and the claim level it intends to assert. The QA agent enforces this.

Eight claim levels, from least to most demanding:

1. `bibliographic_context` — "This paper exists, in this venue."
2. `topic_presence` — "The literature has explored topic Y."
3. `method_or_design_summary` — "Smith uses X identification strategy
   in setting Z."
4. `empirical_result` — "Smith finds effect Y on outcome Z."
5. `numerical_effect` — "Smith reports a 12 pp effect with SE 0.03."
6. `mechanism` — "Smith argues the effect operates via channel M."
7. `heterogeneity` — "Smith reports effects vary by subgroup K."
8. `policy_implication` — "Smith concludes policy P should be enacted."

#### Writer/QA constraints by `evidence_quality` × claim level

| `evidence_quality` | 1 bib | 2 topic | 3 method | 4 result | 5 num | 6 mech | 7 het | 8 policy |
|--------------------|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| `full_text`        | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| `substitute_version` (`source_version` ∈ {working_paper, preprint, accepted_ms}) | ✅ | ✅ | ✅ | ✅ if version clearly matches | ⚠ only if version clearly matches | ✅ | ⚠ | ⚠ |
| `abstract_only`    | ✅ | ✅ | ✅ only if abstract explicitly states design | ⚠ requires corroborating full-text secondary source | ❌ | ❌ | ❌ | ❌ |
| `none`             | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

Legend: ✅ allowed · ⚠ allowed with explicit corroboration / version
match · ❌ refused at draft time.

QA stage 8 emits `[blocker]` for any violation; writer self-censors
during draft.

### Promotion / demotion mechanism (D2)

`CANDIDATES.jsonl` carries a `tier_history` array:

```jsonc
"tier_history": [
  { "ts": "...", "from": null, "to": 3, "actor": "screener", "reason": "..." },
  { "ts": "...", "from": 3, "to": 1, "actor": "paper-reader",
    "reason": "direct empirical competitor on outcome X discovered in §2" }
]
```

Promotion is unilateral by the actor. Demotion requires either:

- a reviewer `ack: true` message in the active thread, or
- a Kristian override in `coord/HUMAN.md`.

The retriever re-runs the new `fetch_policy` on promoted candidates.

### `CANDIDATES.jsonl` schema (final)

```jsonc
{
  "citekey": "Smith2019",
  "doi": "10.xxxx/yyyy",
  "openalex_id": "W...",
  "title": "...",
  "authors": [{"family": "Smith", "given": "J."}],
  "year": 2019,

  "tier": 1,
  "tier_history": [{"ts": "...", "from": null, "to": 1, "actor": "screener", "reason": "..."}],
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
tier_history:
  - { ts: "...", from: null, to: 1, actor: "scope-must-cite", reason: "..." }
evidence_quality: full_text
source_version: published
extractor: pdftotext
extractor_version: "5.x"
pdf_path: "lit-review/DOWNLOADS/Smith2019.pdf"
pdf_sha256: "abc123..."
pages_read: "1-32"
access_method: oa
claim_levels_supported: [1, 2, 3, 4, 5, 6, 7, 8]
---
```

### `DOWNLOAD_QUEUE.md` UX (refinement of §9)

Single file, **tier-sorted**, with a "skip this for now" marker on
each item so Kristian can keep moving without editing JSON:

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
    without it; the writer will not be allowed to use any claim level
    above `topic_presence`.

## Tier 2 — important — opt-in (can skip; abstract-only path available)

- [ ] **Jones2021** — "..."
  - ...
  - `[ ] skip-this-for-now`

## Substitutes available

- [x] **Brown2020** — using working paper version
  `lit-review/DOWNLOADS/Brown2020_wp.pdf`. Re-verify if you can get
  the published version to enable claim levels 5/7.
```

### Tool-capabilities tracked for §2.11

- `tool-capabilities/playwright-mcp.md` — Browser MCP capability,
  default OFF, opt-in via `CONFIG.md.enable_browser_mcp = true`,
  scoped to "download assistance".
- `tool-capabilities/ucsc-ezproxy.md` — UCSC EZProxy cookie-export
  workflow, expiry detection, `.secrets/` hygiene, never-log-cookies
  rule.

---

## Merge plan to `DESIGN.md`

1. Add §2.11 (the prose above, excluding the metadata wrapper) after
   §2.10.
2. Edit §2.8 to reference §2.11 (manual PDF flow is now tier-scoped).
3. Edit §3 stage 3 row to mention `tier`/`fetch_policy` consumption +
   `tier_history`.
4. Edit §4 artifact tree to mention new `CANDIDATES.jsonl` fields and
   `.secrets/` folder.
5. Edit §9 (manual-PDF assist) to be tier-sorted with skip marker.
6. Edit §10 layout to add `tool-capabilities/playwright-mcp.md` and
   `tool-capabilities/ucsc-ezproxy.md`.
7. Post `type: iteration-stop` to thread closing T-001 design phase.
