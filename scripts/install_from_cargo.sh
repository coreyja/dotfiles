#!/usr/bin/env bash

while IFS= read -r tool
do
  bash -c "cargo install $1 -- $tool"
done < <(cat "$HOME/Cargofile")
