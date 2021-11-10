#!/bin/bash

set -e

REPO=/volume2/fedora-base/repo
CACHE=/volume2/fedora-base/cache

sudo docker build -t fedora-build .

rm -rf "${REPO:?}"
mkdir -p $REPO $CACHE

sudo docker run --rm -ti --privileged --security-opt label=disable \
    -v $REPO:/mnt/repo \
    -v $CACHE:/mnt/cache \
    fedora-build
