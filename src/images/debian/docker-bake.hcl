variable "DOCKER_IMAGE" {
  default = "debian"
}

variable "DOCKER_TAG" {
  default = "latest"
}

variable "GITHUB_USERNAME" {
  default = "antyung"
}

group "default" {
  targets = ["build"]
}

target "settings" {
  context = "."
  cache-from = [
    "type=gha"
  ]
  cache-to = [
    "type=gha,mode=max"
  ]
}

target "test" {
  inherits = ["settings"]
  dockerfile = "Dockerfile.debian"
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = []
}

target "build" {
  inherits = ["settings"]
  dockerfile = "Dockerfile.debian"
  output   = ["type=docker"]
  tags = [
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${DOCKER_IMAGE}:latest",
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${DOCKER_IMAGE}:${DOCKER_TAG}",
  ]
}

target "push" {
  inherits = ["settings"]
  dockerfile = "Dockerfile.debian"
  output   = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = [
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${DOCKER_IMAGE}:latest",
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${DOCKER_IMAGE}:${DOCKER_TAG}",
  ]
}
