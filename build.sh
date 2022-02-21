#!/bin/sh
set -x

DOCKER_TAG=alpine3.13-1

docker build --progress plain -t "jkaldon/arm64v8-dockerbuild:${DOCKER_TAG}" .

docker push "jkaldon/arm64v8-dockerbuild:${DOCKER_TAG}"

