variable "DOCKER_IMAGE" {
  default = "ubuntu-base"
}

variable "DOCKER_IMAGE_TAG" {
  default = "latest"
}

variable "AWS_ECR_URI" {
  default = "public.ecr.aws/w2u0w5i6"
}

variable "DOCKER_IMAGE_GROUP" {
  default = "devcontainer"
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
  dockerfile = "Dockerfile.ubuntu"
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = []
}

target "build" {
  inherits = ["settings"]
  dockerfile = "Dockerfile.ubuntu"
  output = ["type=docker"]
  tags = [
    "${AWS_ECR_URI}/${DOCKER_IMAGE_GROUP}/${DOCKER_IMAGE}:latest",
    "${AWS_ECR_URI}/${DOCKER_IMAGE_GROUP}/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}",
  ]
}

target "push" {
  inherits = ["settings"]
  dockerfile = "Dockerfile.ubuntu"
  output = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = [
    "${AWS_ECR_URI}/${DOCKER_IMAGE_GROUP}/${DOCKER_IMAGE}:latest",
    "${AWS_ECR_URI}/${DOCKER_IMAGE_GROUP}/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}",
  ]
}
