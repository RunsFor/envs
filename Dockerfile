ARG CENTOS_VERSION=7

FROM centos:7 as centos-7
RUN set -x \
    && yum -y install https://repo.ius.io/ius-release-el7.rpm \
    && yum -y install git224 cmake3 \
    && ln -s /usr/bin/cmake3 /usr/bin/cmake \
    && ln -s /usr/bin/ctest3 /usr/bin/ctest \
    && yum clean all

FROM centos:8 as centos-8
RUN set -x \
    && yum -y install git cmake \
    && yum clean all

FROM centos-${CENTOS_VERSION} as centos
RUN set -x \
    && yum -y install yum-utils \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
    && yum -y install docker-ce-cli python3-pip which unzip wget make \
    && pip3 install --no-cache-dir awscli \
    && yum clean all

FROM centos as cartridge-cli
ARG CARTRIDGE_CLI_VERSION=2.4.0
RUN set -x \
    && wget https://github.com/tarantool/cartridge-cli/releases/download/${CARTRIDGE_CLI_VERSION}/cartridge-cli-${CARTRIDGE_CLI_VERSION}.x86_64.rpm \
    && yum -y install cartridge-cli-${CARTRIDGE_CLI_VERSION}.x86_64.rpm
