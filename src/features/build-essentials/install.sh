#!/usr/bin/env bash

set -o errexit -o pipefail

readonly USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
readonly HOME="/home/${USERNAME}"
readonly FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_build_essentials() {
    install \
        build-essential \
        make \
        autoconf \
        automake
}

function install() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends "$@"
}

function main() {
    install_build_essentials
    setup_files
}

main
