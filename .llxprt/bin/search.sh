#!/bin/bash

if [[ -z "$1" ]]; then
        echo "You must give search query" >&2
        exit 1
fi

COUNT="$2"
if [[ -z "$2" ]]; then
        COUNT="10"
fi

ddgr -n $COUNT --json "$1" --noprompt | \
        jq -r '.[] | "Title: \"\(.title)\"\nSummary: \"\(.abstract)\"\nURL: \"\(.url)\"\n---\n"' >/tmp/llxprt/search.txt
