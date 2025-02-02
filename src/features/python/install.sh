#!/usr/bin/env bash

set -o errexit -o pipefail

VERSION=${VERSION:-"3.12.0"}

function install_apt() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo ca-certificates software-properties-common
}

function install_python() {
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get install -y -no-install-recommends python${VERSION%.0} python${VERSION%.0}-dev
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

function main() {
    install_apt
    install_python
}

main
