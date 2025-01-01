#!/usr/bin/env bash

set -o errexit -o pipefail

FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_apt() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends sudo curl
}

function install_poetry() {
    if ! command -v poetry >/dev/null 2>&1; then
        curl -fsSL https://install.python-poetry.org | python3 -
    fi
}

function install_aws_sam_cli() {
    cat "${FEATURE_DIR}/files/pyproject.toml" >> "${POETRY_HOME}/pyproject.toml"
    chown root:root "${POETRY_HOME}/pyproject.toml"
    chmod 644 "${POETRY_HOME}/pyproject.toml"
    source "${POETRY_HOME}/venv/bin/activate"
    poetry install --directory "${POETRY_HOME}"
}

function main() {
    install_apt
    install_poetry
    install_aws_sam_cli
}

main
