#!/usr/bin/env bash

set -exo pipefail

function install_build_essentials() {
    debian_install \
        build-essential \
        make \
        autoconf \
        automake
}

function debian_install() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends "$@"
}

install_build_essentials
