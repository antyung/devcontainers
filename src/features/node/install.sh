#!/usr/bin/env bash

set -exo pipefail

VERSION=${VERSION:-"20.18.1"}

function install_deps() {
    install \
        sudo \
        wget \
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

function install_node() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="linux-x64";;
        aarch64 | armv8*) ARCH="linux-arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    wget -q "https://nodejs.org/dist/v${VERSION}/node-v${VERSION}-${ARCH}.tar.xz" -P "/tmp"
    tar -xvf "/tmp/node-v${VERSION}-${ARCH}.tar.xz" -C "/tmp"
    mv /tmp/node-v${VERSION}-${ARCH}/bin/* /usr/local/bin
    mv /tmp/node-v${VERSION}-${ARCH}/lib/* /usr/local/lib
    rm -rf "/tmp/node-v${VERSION}-${ARCH}" "/tmp/node-v${VERSION}-${ARCH}.tar.xz"
    npm install -g pnpm typescript
}

function main() {
    install_deps
    install_node
}

main
