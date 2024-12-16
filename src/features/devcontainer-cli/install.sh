#!/usr/bin/env bash

set -o errexit -o pipefail

function install_apt() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo g++
}


function install_devcontainercli() {
    pnpm install -g @devcontainers/cli
}

function main() {
    install_devcontainercli
}

main
