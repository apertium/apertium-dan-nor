#!/bin/bash

set -e -u

lang1=dan
#lang2=nno or nob

basepair=$lang1-nor
basename=apertium-$basepair

current_vcs () {
    local dir
    dir="$(realpath "$PWD")" || return 1
    local vcs prevdir=""
    while [[ ${dir} != "/" && -n ${dir} && ${dir} != ${prevdir} ]]; do
        for vcs in git svn; do
            if [[ -d "$dir/.$vcs" ]]; then
                echo "$vcs"
                return 0
            fi
        done
        prevdir=${dir}
        cd ..
	dir="$(realpath "$PWD")" || return 1
    done
    return 1
}
vc=$(current_vcs)

cd "$(dirname "$0")/.."

make -j4 langs

echo "Translating changes from $vc diff:"

declare -i e=0

eval $(grep ^AP_SRC config.log)

for lang2 in nno nob; do
    if lang2=nno; then
        AP_SRC2key=AP_SRC2n
    else
        AP_SRC2key=AP_SRC2b
    fi
    AP_SRC2="${!AP_SRC2key}"
    $vc diff "${AP_SRC1}"/apertium-$lang1.$lang1.dix | awk -F'lm="|"' '$2{print $2}' | apertium -d . $lang1-$lang2-dgen | grep '[#@/]' && (( e++ ))
    $vc diff "${AP_SRC2}"/apertium-$lang2.$lang2.dix | awk -F'lm="|"' '$2{print $2}' | apertium -d . $lang2-$lang1-dgen | grep '[#@/]' && (( e++ ))
    $vc diff $basename.$basepair.dix | awk -F'<l>|</l>' '{gsub(/<s [^>]*>/,"")} $2{print $2}' | apertium -d . $lang1-$lang2-dgen | grep '[#@/]' && (( e++ ))
    $vc diff $basename.$basepair.dix | awk -F"<r>|</r>" '{gsub(/<s [^>]*>/,"")} $2{print $2}' | apertium -d . $lang2-$lang1-dgen | grep '[#@/]' && (( e++ ))


    if [[ $e -eq 0 ]]; then
        echo "Uncommitted changes to $lang1.dix, $lang2.dix and $lang1-$lang2.dix appear testvoc clean; go ahead and commit."
    else
        echo "Uh-oh, there appear to be inconsistencies in your uncommitted changes. Please fix before committing."
    fi
done
