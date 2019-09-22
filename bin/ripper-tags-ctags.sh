#!/usr/bin/env bash

# From: https://github.com/tmm1/ripper-tags/issues/49#issuecomment-386535936

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -f)
    TAGS_FILE_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ $* = *"--append"* ]]; then
  cat ${TAGS_FILE_NAME} \
    | (cat && ripper-tags --exclude=vendor --ignore-unsupported-options -f - ${*/--append}) \
    | grep -v '^!_' \
    | sort \
    > tags~ && mv tags~ "${TAGS_FILE_NAME}"
else
  ripper-tags --recursive --exclude=vendor --ignore-unsupported-options $*
fi
