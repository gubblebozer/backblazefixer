#!/bin/bash

for x in "$@"; do
    out=$(git diff "$x")
    if echo "$out" | grep -q 'old mode'; then
        mode=$(echo "$out" | grep 'old mode' | awk '{print $3}' | sed s/100//)
        chmod "$mode" "$x" || exit 1
        echo "$x: $mode"
    fi
done
