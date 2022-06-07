#!/bin/bash

do_chmod=0

for x in "$@"; do
    if [[ "$x" == "+x" ]]; then
        do_chmod=1
        continue
    fi
    if [ -x "$x" ]; then
        if (( DEBUG )); then
            echo "$x: is already executable, skipping"
        fi
        continue
    fi
    if ! out=$(file "$x"); then
        >&2 echo "$x: failed 'file'"
        exit 1
    fi
    if echo "$out" | grep -q executable; then
        if (( do_chmod )); then
            if ! chmod +x "$x"; then
                echo "$out: FAILED TO FIX"
                exit 1
            else
                echo "$out: FIXED"
            fi
        else
            echo "$out: WOULD FIX"
        fi
    elif (( DEBUG )); then
        echo "$out, skipping"
    fi
done
