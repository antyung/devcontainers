#!/usr/bin/env bash

set -o errexit -o pipefail

RELEASECLI_VERSION=v0.18.0

function install_apt() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="x86_64";;
        aarch64 | armv8*) ARCH="aarch64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo curl ca-certificates jq
    apt-get autoremove -y
    apt-get clean -y
    rm -rf /var/lib/apt/lists/*
}

function install_release_cli() {
    if type release-cli > /dev/null 2>&1; then
        echo "release-cli is not installed. Downloading and installing..."
        sudo curl -fsSL "https://gitlab.com/gitlab-org/release-cli/-/releases/${RELEASECLI_VERSION}/downloads/bin/release-cli-linux-${ARCH}" -o /usr/local/bin/release-cli
        sudo chmod +x /usr/local/bin/release-cli
        echo "release-cli installed successfully."
    else
        echo "release-cli is already installed."
    fi
}

function main() {
    install_apt
    install_release_cli
}

main
