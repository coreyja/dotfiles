#!/usr/bin/env bash

while IFS= read -r tool
do
  bash -c "cargo install --list | grep $tool > /dev/null || cargo install $1 -- $tool"
done < <(cat "$HOME/Cargofile")

cargo install-update $(cat "$HOME/Cargofile")
