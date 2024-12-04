#!/usr/bin/env bash

set -o errexit -o pipefail

function install_apt() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo wget ca-certificates git
}

function install_miniconda() {
    mkdir -p /opt/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda3/miniconda.sh
    bash /opt/miniconda3/miniconda.sh -b -u -p /opt/miniconda3
    rm /opt/miniconda3/miniconda.sh
    export PATH="/opt/miniconda3/bin:/opt/miniconda3/sbin:$PATH"
}

function main() {
    install_apt
    install_miniconda
}

main
