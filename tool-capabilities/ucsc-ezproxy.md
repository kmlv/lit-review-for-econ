# Tool Capabilities — UCSC EZProxy

Last checked: 2026-05-25

## Status

Optional and opt-in. v0.1 supports cookie export to:

```text
lit-review/.secrets/ezproxy-cookies.txt
```

The `.secrets/` directory must be gitignored. Cookie contents must never be
logged.

## Expiry Handling

If retrieval detects a login redirect or expired session, write a prompt to the
paper folder's `coord/HUMAN.md` when present, or to `lit-review/QUESTIONS.md`.
