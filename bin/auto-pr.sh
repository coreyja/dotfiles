#!/usr/bin/env bash
#
set -e

DESCRIPTION="${1:-$(claude "Describe the current jj revision, use jj diff to see changes. Return just a git commit message. Be brief!")}"

jj describe -m "$DESCRIPTION"
jj git push --change @
BOOKMARK_NAME=$(jj bookmark list -r @ -T 'name')
gh pr create --fill -H "$BOOKMARK_NAME"
gh pr merge "$BOOKMARK_NAME" --squash --auto
