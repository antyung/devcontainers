# devcontainers

[![Licence: MIT](https://img.shields.io/github/license/antyung/devcontainers)](https://github.com/antyung/devcontainers/blob/main/LICENSE)

This repository provides a customized [.devcontainer](https://code.visualstudio.com/docs/devcontainers/containers) setup, designed for use with [vscode](https://code.visualstudio.com/) and GitHub Codespaces.

The repository is configured to automatically update and rebuild Docker images using Dependabot. Dependabot monitors each Dockerfile and creates pull requests to update them when new versions are available.

[https://gallery.ecr.aws/w2u0w5i6](https://gallery.ecr.aws/w2u0w5i6)

## Overview

This repository is a rework from the original [devcontainers](https://github.com/devcontainers) project, and it utilizes:

- [**devcontainer templates**](https://github.com/devcontainers/templates): Dev Container Templates
- [**devcontainer features**](https://github.com/devcontainers/features): collection of Dev Container Features
- [**devcontainer images**](https://github.com/devcontainers/images): pre-built dev container images

The **`src`** folder contains customizations and configurations that layer on top of these resources.
