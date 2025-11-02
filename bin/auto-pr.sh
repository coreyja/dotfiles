#!/usr/bin/env bash
set -euo pipefail

# Parse flags
AUTO_MERGE=true
DRY_RUN=false
while [[ $# -gt 0 ]]; do
  case $1 in
    --no-merge) AUTO_MERGE=false; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    --) shift; break ;;
    *) break ;;
  esac
done

DESCRIPTION="${1:-$(claude "Generate git commit message from jj diff. Brief!")}"

# Single Claude call for both tasks
RESULT=$(claude -p "
1. Describe jj revision: '$DESCRIPTION'
2. Find Linear ticket and determine push strategy
3. Execute: jj describe -m '$DESCRIPTION' && (push with ticket branch OR jj git push --change @)
4. Return JSON: {\"bookmark\": \"branch-name\", \"ticket\": \"LIN-123 or null\"}
")

BOOKMARK_NAME=$(echo "$RESULT" | jq -r '.bookmark')
[[ -z "$BOOKMARK_NAME" || "$BOOKMARK_NAME" == "null" ]] && {
  echo "❌ Failed to get bookmark name"
  exit 1
}

echo "✓ Bookmark: $BOOKMARK_NAME"

if [[ "$DRY_RUN" == true ]]; then
  echo "🔍 Dry run - would create PR for $BOOKMARK_NAME"
  exit 0
fi

# Check if PR already exists
if gh pr view "$BOOKMARK_NAME" &>/dev/null; then
  echo "ℹ️  PR already exists"
  gh pr view "$BOOKMARK_NAME"
  exit 0
fi

gh pr create --fill -H "$BOOKMARK_NAME"

if [[ "$AUTO_MERGE" == true ]]; then
  gh pr merge "$BOOKMARK_NAME" --squash --auto
  echo "✓ Auto-merge enabled"
fi
