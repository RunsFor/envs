ARG CENTOS_VERSION=7

FROM centos:7 as centos-7
RUN set -x \
    && yum -y install https://repo.ius.io/ius-release-el7.rpm \
    && yum -y install git224

FROM centos:8 as centos-8
RUN set -x \
    && yum -y install git

FROM centos-${CENTOS_VERSION}
RUN set -x \
    && yum -y install yum-utils \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
    && yum -y install docker-ce-cli make python3-pip \
    && pip3 install --no-cache-dir awscli
