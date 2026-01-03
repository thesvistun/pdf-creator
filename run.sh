#!/usr/bin/env bash
set -e

readonly M2_HOME="$HOME/.m2"
readonly FOP_HOME="$HOME/.fop"

[ ! -d $M2_HOME ] && mkdir -p $M2_HOME

[ ! -d $FOP_HOME ] && mkdir -p $FOP_HOME

docker run -it --rm \
    -u $(id -u):$(id -g) \
    -v $M2_HOME:/var/maven/.m2 \
    -v $FOP_HOME/.fop:/var/maven/.fop \
    -v $PWD:$PWD \
    -w $PWD \
    -e MAVEN_CONFIG=/var/maven/.m2 \
    maven:3.9-eclipse-temurin-21-alpine \
    mvn -Duser.home=/var/maven clean compile
