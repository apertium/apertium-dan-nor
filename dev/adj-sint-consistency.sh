#!/bin/bash

# Run from apertium-dan-nor and redirect output to file, e.g.
#
# $ dev/adj-sint-consistency.sh > fixed-bi.dix
#
# Expects nno/nob monolinguals to be in the same parent dir as
# apertium-dan-nor.


set -e -u

trap 'rm -rf "${d}"' EXIT
d=$(mktemp -d -t adj-sint-consistency.sh.XXXXXXXXXXX)

for l in dan nno nob; do
    lt-expand ../apertium-$l/apertium-$l.$l.dix |grep '<pst>'|grep '<adj>'|sort -u > "$d"/mono.$l
    grep    '<sint>' "$d"/mono.$l |sed 's/<.*//;s/.*://' |sort -u >"$d"/mono.$l.sint
    grep -v '<sint>' "$d"/mono.$l |sed 's/<.*//;s/.*://' |sort -u >"$d"/mono.$l.adj
done

gawk                     \
    -v lsf="$d"/mono.dan.sint \
    -v laf="$d"/mono.dan.adj \
    -v rnsf="$d"/mono.nno.sint \
    -v rnaf="$d"/mono.nno.adj \
    -v rbsf="$d"/mono.nob.sint \
    -v rbaf="$d"/mono.nob.adj '
BEGIN {
    while(getline<lsf)ls[$0]++
    while(getline<laf)la[$0]++
    while(getline<rnsf)rs["nno"][$0]++
    while(getline<rnaf)ra["nno"][$0]++
    while(getline<rbsf)rs["nob"][$0]++
    while(getline<rbaf)ra["nob"][$0]++
}
{l=$0; sub(/.*<l>/,"",l); sub(/(<s|<\/l>).*/, "", l); sub(/<b\/>/, " ", l)}
{r=$0; sub(/.*<r>/,"",r); sub(/(<s|<\/r>).*/, "", r); sub(/<b\/>/, " ", r)}
/<section/{section++}
           {vr="nob"}  # if unmarked, assume exists in both
/ vr="nno"/{vr="nno"}

section && /<par n="(adj_sint|adj)(:adj_sint|:adj)?"/ {
    par=""
    if(l in ls && r in rs[vr]) {
        par="adj_sint"
    }
    else if(l in la && r in rs[vr]) {
        par="adj:adj_sint"
    }
    else if(l in ls && r in ra[vr]) {
        par="adj_sint:adj"
    }
    else if(l in la && r in ra[vr]) {
        par="adj"
    }
    if(par) sub(/par n="adj[^"]*/, "par n=\""par)
}
{print}
' apertium-dan-nor.dan-nor.dix
