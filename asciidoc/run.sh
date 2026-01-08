#!/usr/bin/env bash
set -e

docker run -it \
    -u $(id -u):$(id -g) \
    -v $PWD:/documents/ \
    asciidoctor/docker-asciidoctor:1.101 \
    asciidoctor-pdf --theme custom-theme.yml sample.adoc
