#!/bin/bash
PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '^/mnt/c/' | paste -sd:)

BR_PATH="$(pwd)/../.buildroot"
EXTERNAL_PATH="$(pwd)"
cd "$BR_PATH"
make BR2_EXTERNAL="$EXTERNAL_PATH" "$@"
