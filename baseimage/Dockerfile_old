ARG OS_VERSION=latest
FROM centos:${OS_VERSION}

USER root

RUN \
    echo "## Yum update and system tools installation ##" \
    && sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf \
    && yum -y update \
    && yum -y install openssh wget unzip nc telnet curl tar zip git sudo cronie net-tools libunwind icu \
    && cd tmp \
    && wget -O azcopy.tar.gz https://aka.ms/downloadazcopylinux64 \
    && tar --no-same-owner -xvf azcopy.tar.gz \
    && ./install.sh\
    && echo "Create User: appuser and Directory app" \
    && groupadd -g 530 appuser \
    && useradd -u 530 -g 530 appuser \
    && echo "## Create applicative directories ##" \
    && mkdir /app \
    && mkdir -p /app/hmonline/scripts \
    && mkdir /app/hmonline/logs \
    && chown -R appuser:appuser /app/