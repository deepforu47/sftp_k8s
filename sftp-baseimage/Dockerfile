ARG OS_VERSION=latest
FROM centos:${OS_VERSION}

MAINTAINER kuldeep.d.sharma


RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf \
    && yum -y update \
    && yum -y install openssh-server openssh wget unzip nc telnet curl tar zip git sudo rsyslog\
    && groupadd -g 500 appuser \
    && useradd -u 500 -g 500 appuser \
    && mkdir -p /var/run/sshd