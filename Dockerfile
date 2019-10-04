FROM python:3.6-slim-stretch
# We choose an Python image based on :
# - Debian 9, slim version
# - Python 3.6
# See here for all Python images : https://hub.docker.com/_/python

# Pipenv install
#
# Warnings : this container is explicitely configured for Dev environments
#  - pipfile --dev option
RUN apt update -y \
    && pip install --upgrade pip \
    && pip install pipenv

# Node setup
# 
# We must use a procedure that match with:
# - Debian 9, slim version
# - Node 8
# See on docker hub (https://hub.docker.com/_/node) for corresponding tag "8-stretch-slim" which code is :
# https://github.com/nodejs/docker-node/blob/8c0a9f2c144904631cf783bdd57b4a19300e6b1f/8/stretch-slim/Dockerfile

ENV NODE_VERSION 8.14.0
ENV ARCH x64
WORKDIR /tmp
RUN buildDeps='xz-utils' \
    && apt install -y ca-certificates curl wget gnupg dirmngr $buildDeps --no-install-recommends \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && apt-get purge -y --auto-remove $buildDeps \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Tools install
RUN apt install -y zip
