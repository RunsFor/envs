# syntax=docker/dockerfile:experimental

ARG CENTOS_VERSION=7
ARG IMAGE_TYPE=base
ARG BASE_TOOLS="which wget zip unzip docker-ce-cli python3-pip"
ARG BUILD_TOOLS="make gcc-c++ glibc-devel libstdc++-devel lua-devel \
                 autoconf automake libtool gcc curl-devel"

FROM centos:7 as centos-7
RUN set -x \
    && yum -y install https://repo.ius.io/ius-release-el7.rpm \
    && yum -y install git224 cmake3 yum-utils \
    && ln -s /usr/bin/cmake3 /usr/bin/cmake \
    && ln -s /usr/bin/ctest3 /usr/bin/ctest \
    && yum clean all

FROM centos:8 as centos-8
RUN set -x \
    && yum -y install yum-utils \
    && yum-config-manager --set-enabled powertools \
    && yum -y install git cmake \
    && yum clean all

FROM docker:dind as dind

FROM centos-${CENTOS_VERSION} as base
ARG BASE_TOOLS
RUN set -x \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
    && yum -y install ${BASE_TOOLS} \
    && yum clean all \
    && pip3 install --no-cache-dir awscli flake8

FROM base as build
ARG BUILD_TOOLS
RUN set -x \
    && yum -y install ${BUILD_TOOLS} \
    && yum clean all


FROM ${IMAGE_TYPE} as cartridge
ARG CARTRIDGE_CLI_VERSION=2.4.0
RUN yum -y install https://github.com/tarantool/cartridge-cli/releases/download/${CARTRIDGE_CLI_VERSION}/cartridge-cli-${CARTRIDGE_CLI_VERSION}.x86_64.rpm


FROM dind as cartridge-dind
ARG CARTRIDGE_CLI_VERSION=2.4.0
RUN set -x \
    && wget https://github.com/tarantool/cartridge-cli/releases/download/${CARTRIDGE_CLI_VERSION}/cartridge-cli-${CARTRIDGE_CLI_VERSION}.Linux.amd64.tar.gz \
    && tar xzf cartridge-cli-${CARTRIDGE_CLI_VERSION}.Linux.amd64.tar.gz -C /bin


FROM cartridge as tarantool
ARG TARANTOOL_VERSION=2.5
RUN set -x \
    && curl -L https://tarantool.io/release/${TARANTOOL_VERSION}/installer.sh | bash \
    && yum -y install tarantool \
    && tarantoolctl rocks install luacheck
ENV PATH="/.rocks/bin:${PATH}"
