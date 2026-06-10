#!/bin/bash

if [[ -z "$1" ]]; then
        echo "You must give search query" >&2
        exit 1
fi

TIME="--time $2"
if [[ -z "$2" ]]; then
        TIME=""
fi

ddgr --json "$1" $TIME --noprompt --noua | \
        jq -r '.[] | "Title: \"\(.title)\"\nSummary: \"\(.abstract)\"\nURL: \"\(.url)\"\n---\n"'
