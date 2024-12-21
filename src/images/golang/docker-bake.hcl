variable "GITHUB_USERNAME" {
  default = "antyung"
}

variable "IMAGE" {
  default = "golang"
}

variable "DOCKER_TAG" {
  default = "latest"
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
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = []
}

target "build" {
  inherits = ["settings"]
  output   = ["type=docker"]
  tags = [
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${IMAGE}:latest",
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${IMAGE}:${DOCKER_TAG}",
  ]
}

target "push" {
  inherits = ["settings"]
  output   = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = [
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${IMAGE}:latest",
    "ghcr.io/${GITHUB_USERNAME}/devcontainers/${IMAGE}:${DOCKER_TAG}",
  ]
}
