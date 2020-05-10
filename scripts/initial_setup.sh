#!/usr/bin/env bash

set -e

printf "********\nThis is the INITIAL setup script.\n********\nIf you are running this on an already setup machine stop NOW. The following is NOT written to be idempotent to any idempotency is by accident.\n\nEnter any character to agree and continue with the setup" && read -n 1

pushd "$HOME"
  printf "We are now in your home directory which is $(pwd)"

  git init
  git remote add origin https://github.com/coreyja/dotfiles.git

  git fetch origin master
  git reset --hard origin/master

  ./scripts/setup.sh # This is idempotent, so breaking it out to a new script
popd
