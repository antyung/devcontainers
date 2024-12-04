#!/usr/bin/env bash

set -o errexit -o pipefail

USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
HOME="/home/${USERNAME}"
FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_apt() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="x86_64";;
        aarch64 | armv8*) ARCH="aarch64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo curl ca-certificates gpg gpg-agent unzip
}

function install_aws_cli() {
    cd "${HOME}"
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o ./awscliv2.zip
    cat "${FEATURE_DIR}/files/public-key" > ./public-key
    gpg --import ./public-key
    curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip.sig -o ./awscliv2.sig
    gpg --verify ./awscliv2.sig ./awscliv2.zip
    unzip ./awscliv2.zip
    sudo ./aws/install
    rm -rf ./awscliv2.zip ./awscliv2.sig ./public-key ./aws
}

function main() {
    install_apt
    install_aws_cli
}

main
