FROM centos:7 as centos-7
RUN set -x \
    && yum -y install https://repo.ius.io/ius-release-el7.rpm \
    && yum -y install yum-utils \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
    && yum makecache fast \
    && yum -y install git224 docker-ce-cli

FROM centos:8 as centos-8
RUN set -x \
    && yum -y install yum-utils \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
    && yum makecache fast \
    && yum -y install git docker-ce-cli