#!/usr/bin/env bash

set -e

printf "********\nThis is the INITIAL setup script.\n********\nIf you are running this on an already setup machine stop NOW. The following is NOT written to be idempotent so any idempotency is by accident.\n\nEnter any character to agree and continue with the setup" && read -rn 1

pushd "$HOME"
  printf "We are now in your home directory which is %s" "$(pwd)"

  git init
  git symbolic-ref HEAD refs/heads/💜
  git remote add origin https://github.com/coreyja/dotfiles.git

  git fetch origin 💜 
  git reset --hard origin/💜 

  ./scripts/setup.sh # This is idempotent, so breaking it out to a new script
popd
