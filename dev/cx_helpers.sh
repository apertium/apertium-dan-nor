#!/bin/bash

# source this file for some handy helpers

declare API="https://en.wikipedia.org/w/api.php"

cx_get_translations () {
    local -r lang1=$1 lang2=$2
    curl -sS "${API}?action=query&list=cxpublishedtranslations&format=json&from=${lang1}&to=${lang2}"\
        | jq -r '.result.translations|map(select(.publishedDate>="20160122000000"))|map(.translationId)|.[]'
    # They only started collecting parallel text after January 22nd, 2016; thus the filter
}

cx_translations_get_text () {
    local -r transid=$1
    curl -sS "${API}?action=query&list=contenttranslationcorpora&format=json&translationid=${transid}&striphtml=true"
}

cx_all_pairs () {
    langs=( "$@" )
    for l1 in "${langs[@]}"; do
        for l2 in "${langs[@]}";do
            [[ $l1 = "$l2" ]] && continue
            echo "=== $l1-$l2 ==="
            cx_get_translations "$l1" "$l2"| while read -r; do
                cx_translations_get_text "$REPLY" \
                    | jq ".query.contenttranslationcorpora.sections
                             | .[]?
                             | { $l1 :.source.content, $l2 :.user.content, mt:.mt.content}"
            done
        done
    done
}

# source dev/cx_helpers.sh && cx_all_pairs da no nb nn sv
