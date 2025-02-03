package tests

import (
	"context"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/testcontainers/testcontainers-go"
)

var GolangBase = struct {
	DOCKER_IMAGE       string
	DOCKER_IMAGE_TAG   string
	AWS_ECR_URI        string
	DOCKER_IMAGE_GROUP string
}{
	DOCKER_IMAGE:       "golang-base",
	DOCKER_IMAGE_TAG:   "latest",
	AWS_ECR_URI:        "public.ecr.aws/w2u0w5i6",
	DOCKER_IMAGE_GROUP: "devcontainer",
}

func TestContainerBuildGolangBase(t *testing.T) {
	ctx := context.Background()
	container, e := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: testcontainers.ContainerRequest{
			FromDockerfile: testcontainers.FromDockerfile{
				Context:       "../src/images/" + GolangBase.DOCKER_IMAGE + "/",
				Dockerfile:    "Dockerfile.debian",
				KeepImage:     false,
				PrintBuildLog: true,
			},
		},
		Started: true,
	})
	require.NoError(t, e)
	testcontainers.CleanupContainer(t, container)
}

func TestContainerPullGolangBase(t *testing.T) {
	ctx := context.Background()
	container, e := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: testcontainers.ContainerRequest{
			Image: GolangBase.AWS_ECR_URI + "/" + GolangBase.DOCKER_IMAGE_GROUP + "/" + GolangBase.DOCKER_IMAGE + ":" + GolangBase.DOCKER_IMAGE_TAG,
		},
		Started: false,
	})
	require.NoError(t, e)
	testcontainers.CleanupContainer(t, container)
}
