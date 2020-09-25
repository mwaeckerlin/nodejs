#!/bin/sh

if test -z "$START"; then
    for loc in {.,dist,build}/{index,main,start,server}.js; do
        if test -d "$loc"; then
            START="$loc"
        fi
    done
fi

node "$START"
