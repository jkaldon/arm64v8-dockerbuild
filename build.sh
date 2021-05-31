#!/bin/sh
set -x

docker run --rm --privileged linuxkit/binfmt:v0.8
docker buildx build --progress plain --no-cache --pull --platform linux/arm64 -t jkaldon/arm64v8-dockerbuild:alpine3.13 --push .
