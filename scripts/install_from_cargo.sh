#!/usr/bin/env bash

function install_from_cargo() {
  tool=$1

  bash -c "cargo install --list | grep $tool > /dev/null || cargo install -- $tool"
}

while IFS= read -r tool
do
  install_from_cargo "$tool"
done < <(cat "$HOME/Cargofile")

install_from_cargo cargo-update

# I want word splitting cause each word is a different package to update
# shellcheck disable=SC2046
cargo install-update --  $(cat "$HOME/Cargofile") cargo-update
