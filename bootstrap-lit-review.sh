#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./bootstrap-lit-review.sh /path/to/paper-folder [--dry-run] [--force]

Installs the v0.1 lit-review scaffold and init skills into a paper folder.

Options:
  --dry-run   Print planned actions without writing files.
  --force     Back up existing files before replacing them.
USAGE
}

if [[ $# -lt 1 ]]; then
  usage
  exit 2
fi

TARGET=""
DRY_RUN=0
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      exit 2
      ;;
    *)
      if [[ -n "$TARGET" ]]; then
        echo "Only one target folder may be provided." >&2
        exit 2
      fi
      TARGET="$1"
      shift
      ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "Missing target folder." >&2
  usage
  exit 2
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(mkdir -p "$TARGET" && cd "$TARGET" && pwd)"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_PATH="$TARGET_DIR/lit-review/INSTALL_LOG.md"

say() {
  printf '%s\n' "$*"
}

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    say "[dry-run] $*"
  else
    "$@"
  fi
}

copy_file() {
  local src="$1"
  local dest="$2"
  local dest_dir
  dest_dir="$(dirname "$dest")"
  run mkdir -p "$dest_dir"

  if [[ -e "$dest" ]]; then
    if [[ "$FORCE" -ne 1 ]]; then
      say "Exists, skipping: $dest"
      return
    fi
    run cp "$dest" "$dest.backup.$STAMP"
  fi

  run cp "$src" "$dest"
}

copy_tree_file() {
  local rel="$1"
  copy_file "$ROOT_DIR/templates/paper-folder-lit-review/$rel" "$TARGET_DIR/$rel"
}

say "Installing lit-review scaffold"
say "  source: $ROOT_DIR"
say "  target: $TARGET_DIR"

run mkdir -p "$TARGET_DIR/lit-review/READING_NOTES"
run mkdir -p "$TARGET_DIR/lit-review/DOWNLOADS"
run mkdir -p "$TARGET_DIR/lit-review/.secrets"
run mkdir -p "$TARGET_DIR/.claude/skills"
run mkdir -p "$TARGET_DIR/.claude/agents"

CODEX_SKILLS=(
  lit-review-init
  lit-review-scope
  lit-review-plan
  lit-review-fetch
  lit-review-screen
  lit-review-read
)

CLAUDE_SKILLS=(
  lit-review-init
  lit-review-scope
  lit-review-plan
  lit-review-fetch
  lit-review-screen
  lit-review-read
)

CLAUDE_AGENTS=(
  paper-scoper
  lit-search-strategist
  lit-retriever
  lit-screener
  paper-reader
)

for skill in "${CODEX_SKILLS[@]}"; do
  run mkdir -p "$TARGET_DIR/.codex/skills/$skill"
done

copy_tree_file "lit-review/CONFIG.md"
copy_tree_file "lit-review/SCOPE.md"
copy_tree_file "lit-review/SEARCH_PLAN.md"
copy_tree_file "lit-review/SEARCH_LOG.md"
copy_tree_file "lit-review/CANDIDATES.jsonl"
copy_tree_file "lit-review/DOWNLOAD_QUEUE.md"
copy_tree_file "lit-review/SCREENED.md"
copy_tree_file "lit-review/ASSUMPTIONS.md"
copy_tree_file "lit-review/QUESTIONS.md"
copy_tree_file "lit-review/.gitignore"

for skill in "${CLAUDE_SKILLS[@]}"; do
  copy_file "$ROOT_DIR/skills/claude/$skill.md" "$TARGET_DIR/.claude/skills/$skill.md"
done

for skill in "${CODEX_SKILLS[@]}"; do
  copy_file "$ROOT_DIR/skills/codex/$skill/SKILL.md" "$TARGET_DIR/.codex/skills/$skill/SKILL.md"
done

for agent in "${CLAUDE_AGENTS[@]}"; do
  copy_file "$ROOT_DIR/agents/$agent.md" "$TARGET_DIR/.claude/agents/$agent.md"
done

if [[ "$DRY_RUN" -eq 1 ]]; then
  say "[dry-run] would write $LOG_PATH"
else
  mkdir -p "$(dirname "$LOG_PATH")"
  {
    echo "# Lit Review Install Log"
    echo
    echo "- installed_at_utc: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "- source_repo: $ROOT_DIR"
    echo "- source_git_commit: $(git -C "$ROOT_DIR" rev-parse --short HEAD 2>/dev/null || echo not-a-git-repo)"
    echo "- target: $TARGET_DIR"
    echo "- force: $FORCE"
    echo
    echo "Installed files:"
    echo
    echo "- lit-review/CONFIG.md"
    echo "- lit-review/SCOPE.md"
    echo "- lit-review/SEARCH_PLAN.md"
    echo "- lit-review/SEARCH_LOG.md"
    echo "- lit-review/CANDIDATES.jsonl"
    echo "- lit-review/DOWNLOAD_QUEUE.md"
    echo "- lit-review/SCREENED.md"
    echo "- lit-review/ASSUMPTIONS.md"
    echo "- lit-review/QUESTIONS.md"
    for skill in "${CLAUDE_SKILLS[@]}"; do
      echo "- .claude/skills/$skill.md"
    done
    for skill in "${CODEX_SKILLS[@]}"; do
      echo "- .codex/skills/$skill/SKILL.md"
    done
    for agent in "${CLAUDE_AGENTS[@]}"; do
      echo "- .claude/agents/$agent.md"
    done
  } > "$LOG_PATH"
fi

if [[ ! -d "$TARGET_DIR/coord" ]]; then
  say "Note: target has no coord/. Recommended next step:"
  say "  /Users/klopezva/GitHubProjects/agent-filesystem-collaboration/bootstrap.sh \"$TARGET_DIR\" --principal \"Kristian\" --agents codex,claude"
fi

say "Done."
