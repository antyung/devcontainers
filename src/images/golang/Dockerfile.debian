# syntax=docker/dockerfile:1

FROM public.ecr.aws/w2u0w5i6/base/golang:1.22-bookworm AS base

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000
ARG HOME=/home/$USER
ENV HOME=/home/$USER \
    SHELL=/bin/bash \
    GOPATH=/home/$USER/go

ENV PATH="${GOPATH}/bin:${PATH}"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
    sudo git curl ca-certificates \
    && groupadd --gid $PRIMARY_GROUP_ID $USER \
    && useradd --system --uid $USER_ID --gid $PRIMARY_GROUP_ID -m $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && passwd -d $USER \
    && git config --system --add safe.directory '*' \
    && sudo mv /go "/home/$USER" \
    && sudo chown -R "${USER}:${USER}" "${GOPATH}" \
    && sudo chmod -R 775 "${GOPATH}"

FROM base AS final

USER root
