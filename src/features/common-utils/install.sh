#!/usr/bin/env bash

set -exo pipefail

function install_common_utils() {
    debian_install \
        apt-transport-https \
        apt-utils \
        bash-completion \
        bzip2 \
        ca-certificates \
        curl \
        git \
        gpg \
        gpg-agent \
        init-system-helpers \
        jq \
        less \
        lsb-release \
        lsof \
        nano \
        net-tools \
        openssh-client \
        procps \
        psmisc \
        rsync \
        strace \
        sudo \
        tree \
        unzip \
        vim \
        wget \
        xz-utils \
        zip \
        zsh
}

function debian_install() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends "$@"
}

install_common_utils
