#!/bin/sh

set -eu

CACHE=/mnt/cache
REPO=/mnt/repo

mkdir -p $CACHE $REPO

if [ ! -d $REPO/objects ]; then
    ostree --repo=$REPO init --mode=archive-z2
fi

rpm-ostree compose tree --unified-core --cachedir=$CACHE --repo=$REPO ewk-desktop.yaml
