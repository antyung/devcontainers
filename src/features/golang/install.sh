#!/usr/bin/env bash

set -o errexit -o pipefail

VERSION=${VERSION:-"1.22.10"}

function install_apt() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="amd64";;
        aarch64 | armv8*) ARCH="arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo wget ca-certificates xz-utils
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

function install_golang() {
    wget -q "https://go.dev/dl/go${VERSION}.linux-${ARCH}.tar.gz" -P "/tmp"
    tar -xvf "/tmp/go${VERSION}.linux-${ARCH}.tar.gz" -C "/tmp"
    sudo mv /tmp/go /usr/local
    rm -rf "/tmp/go${VERSION}.linux-${ARCH}.tar.gz"
}

function main() {
    install_apt
    install_golang
}

main
