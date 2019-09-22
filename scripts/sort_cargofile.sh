#!/usr/bin/env bash

set -e

sort Cargofile > Cargofile.tmp
mv Cargofile.tmp Cargofile
