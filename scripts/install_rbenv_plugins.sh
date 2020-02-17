#!/usr/bin/env bash

set -e

function clone_or_pull() {
  CLONE_URL="$1"
  DIR="$2"
  git clone "$1" "$2" 2> /dev/null || (pushd "$2"; git pull; popd)
}

clone_or_pull https://github.com/ianheggie/rbenv-binstubs.git "$(rbenv root)/plugins/rbenv-binstubs"
clone_or_pull https://github.com/rbenv/rbenv-default-gems.git "$(rbenv root)/plugins/rbenv-default-gems"

# bundle install --binstubs .bundle/bin
