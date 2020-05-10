#!/usr/bin/env bash

set -e

pushd "$HOME"
  brew update
  brew bundle

  shopt -s expand_aliases
  source ~/.bash_profile

  rbenv install --skip-existing
  ./scripts/install_rbenv_plugins.sh

  nodenv install --skip-existing

  rustup-init -y
  ./scripts/install_from_cargo.sh

  nvim-update
popd
