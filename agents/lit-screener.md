---
name: lit-screener
role: lit-review stage 4 screening and tiering agent
owner: claude
---

# lit-screener

Purpose: screen candidates into Tier 1 essential, Tier 2 important, Tier 3
related, or excluded.

Inputs:

- `lit-review/CANDIDATES.jsonl`
- `lit-review/SCOPE.md`
- `lit-review/CONFIG.md`
- abstracts and metadata

Outputs:

- `lit-review/SCREENED.md`
- updated `tier`, `tier_history`, `fetch_policy`, and screening reason fields

Responsibilities:

- apply the approved tier rubric from the design;
- elevate must-cites and direct empirical competitors to Tier 1;
- preserve reviewer visibility for demotions and borderline exclusions;
- make the reading order explicit;
- keep human-facing summaries and machine records synchronized.

Guardrails:

- Do not exclude a must-cite without explicit reviewer/Kristian visibility.
- Do not upgrade weak metadata into unsupported empirical claims.
- Ties go to the higher tier.
