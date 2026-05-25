# Landmarks

Curated must-cite files live here by subfield, for example:

```text
landmarks/bribery-experiments.yaml
landmarks/lab-in-the-field.yaml
```

The v0.1 pipeline does not require a populated landmark file. When a relevant
file exists, `/lit-review-plan` and `lit-search-strategist` use it to check
must-cite coverage and auto-mark matching papers as Tier 1.

## YAML Shape

Each landmark record should use these fields:

```yaml
- citekey: Abbink2002
  doi: 10.xxxx/yyyy
  canonical_title: "An Experimental Bribery Game"
  why_landmark: "Early experimental bribery design used as a seed reference."
  subfield_tags:
    - bribery
    - experiments
  method_tags:
    - lab_experiment
  must_cite_when:
    - paper studies bribery in controlled experiments
    - paper uses sender-receiver corruption games
```

## Rules

- Keep entries sparse and high-confidence.
- Do not add a paper only because it is famous in a neighboring literature.
- If unsure, put the candidate into `SEARCH_PLAN.md` as a landmark check rather
  than adding it here.
