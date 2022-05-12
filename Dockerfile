FROM docker.io/arm64v8/alpine:3.15

# Image metadata
# git commit
LABEL org.opencontainers.image.revision="-"
LABEL org.opencontainers.image.source="https://github.com/jkaldon/arm64v8-dockerbuild/tree/master"

RUN apk add --no-cache \
             curl \
             openssl \
             screen \
             gnupg \
             bash \
             docker \
             git \
             vim && \
    curl 'https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3' | bash && \
    curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod a+x /usr/local/bin/kubectl

WORKDIR /root
