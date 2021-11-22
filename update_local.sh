#!/bin/bash

set -e

# REPO=/volume1/Shared/fedora-base/repo
# CACHE=/volume1/Shared/fedora-base/cache
REPO=.tmp/repo
CACHE=.tmp/cache

podman build -t fedora-build .

rm -rf "${REPO:?}"
mkdir -p $REPO $CACHE

podman run --rm -ti --privileged --security-opt label=disable \
    -v $REPO:/mnt/repo:Z \
    -v $CACHE:/mnt/cache:Z \
    fedora-build

podman run --rm -ti -p 8000:8000 -v $PWD/.tmp:/serve:z jdkelley/simple-http-server
