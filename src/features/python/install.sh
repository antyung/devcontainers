#!/usr/bin/env bash

set -exo pipefail

VERSION=${VERSION:-"3.12.0"}

function install_deps() {
    install \
        sudo \
        wget \
        software-properties-common \
        ca-certificates \
        xz-utils
}

function install() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends "$@"
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

function install_python() {
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get install -y -no-install-recommends python${VERSION%.0} python${VERSION%.0}-dev
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

function main() {
    install_deps
    install_python
}

main
