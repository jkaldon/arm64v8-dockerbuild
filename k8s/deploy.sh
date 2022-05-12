#!/bin/sh

helm upgrade docker-build --install ./ -f values.yaml
