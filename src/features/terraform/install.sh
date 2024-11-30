#!/usr/bin/env bash

set -o errexit -o pipefail

TERRAFORM_VERSION=1.9.6
TERRAGRUNT_VERSION=0.67.14
TERRAFORMDOCS_VERSION=0.19.0

function install_apt() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="linux_amd64";;
        aarch64 | armv8*) ARCH="linux_arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo curl ca-certificates wget unzip make jq
    apt-get autoremove -y
    apt-get clean -y
    rm -rf /var/lib/apt/lists/*
}

function install_terraform() {
    cd /tmp
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${ARCH}.zip
    unzip /tmp/terraform_${TERRAFORM_VERSION}_${ARCH}.zip -d /tmp
    sudo mv /tmp/terraform /usr/local/bin/terraform
    sudo chmod +x /usr/local/bin/terraform
}

function install_terragrunt() {
    cd /tmp
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_${ARCH}
    sudo mv /tmp/terragrunt_${ARCH} /usr/local/bin/terragrunt
    sudo chmod +x /usr/local/bin/terragrunt
}

function install_terraform_docs() {
    cd /tmp
    wget https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORMDOCS_VERSION}/terraform-docs-v${TERRAFORMDOCS_VERSION}-${ARCH/_/-}.tar.gz
    tar -xvf terraform-docs-v${TERRAFORMDOCS_VERSION}-${ARCH/_/-}.tar.gz
    sudo mv /tmp/terraform-docs /usr/local/bin/terraform-docs
    sudo chmod +x /usr/local/bin/terraform-docs
}

function main() {
    install_apt
    install_terraform
    install_terragrunt
    install_terraform_docs
}

main
