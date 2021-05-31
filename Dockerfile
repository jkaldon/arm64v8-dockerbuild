FROM docker.io/arm64v8/alpine:3.13

# Image metadata
# git commit
LABEL org.opencontainers.image.revision="-"
LABEL org.opencontainers.image.source="https://github.com/jkaldon/arm64v8-dockerbuild/tree/master"

RUN apk add --no-cache \
             bash \
             docker

