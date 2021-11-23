#!/bin/bash

set -e

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

read -p "Sync?" yn
case $yn in
    [Yy]* ) rsync -avz --delete $REPO/ nas-rsync:/volume1/Shared/fedora-base/repo/
        ;;
    [Nn]* ) exit 2
        ;;
    * ) echo "Please answer [Yy]es or [Nn]o.";;
esac

