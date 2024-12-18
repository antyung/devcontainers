#!/usr/bin/env bash

set -o errexit -o pipefail

VERSION=${VERSION:-"20.18.1"}

function install_apt() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="linux-x64";;
        aarch64 | armv8*) ARCH="linux-arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo wget ca-certificates xz-utils
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

function install_node() {
    wget -q "https://nodejs.org/dist/v${VERSION}/node-v${VERSION}-${ARCH}.tar.xz" -P "/tmp/node-v${VERSION}-${ARCH}.tar.xz"
    tar -xvf "/tmp/node-v${VERSION}-${ARCH}.tar.xz" -C "/tmp/node-v${VERSION}-${ARCH}"
    mv /tmp/node-v${VERSION}-${ARCH}/bin/* /usr/local/bin
    mv /tmp/node-v${VERSION}-${ARCH}/lib/* /usr/local/lib
    rm -rf "/tmp/node-v${VERSION}-${ARCH}" "/tmp/node-v${VERSION}-${ARCH}.tar.xz"
    corepack enable
    corepack prepare pnpm@latest --activate
}

function main() {
    install_apt
    install_node
}

main
