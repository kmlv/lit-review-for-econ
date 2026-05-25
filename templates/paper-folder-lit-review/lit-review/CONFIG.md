# Lit Review Config

status: initialized
output_format: tex
style_profile: AEA
language: Spanish
technical_terms_language: English

paths:
  bib_target: null
  paper_tex: null
  pdf_downloads: lit-review/DOWNLOADS
  ezproxy_cookies: lit-review/.secrets/ezproxy-cookies.txt

sources:
  openalex: enabled
  crossref: enabled
  semantic_scholar: capability_detect
  zotero: disabled_until_configured
  arxiv: enabled
  repec: enabled
  nber: enabled

retrieval:
  enable_ezproxy_cookie_export: false
  enable_browser_mcp: false
  opportunistic_use_authenticated: false
  tier2_queue_when_blocked: true

screening:
  tier1_seed_citation_threshold: 3
  tier2_citation_threshold: 100
  min_quality_notes: null

question_budget:
  scoping: 5
  per_later_stage: 3
