ARG OS_VERSION=latest
FROM centos:${OS_VERSION}

MAINTAINER kuldeep.d.sharma


RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf \
    && yum -y update \
    && yum -y install openssh-server openssh wget unzip nc telnet curl tar zip git sudo \
    && groupadd -g 500 appuser \
    && useradd -u 500 -g 500 appuser \
 #   && sed -i 's#HOME=/home#HOME=/data#g' /etc/default/useradd \
    && mkdir -p /var/run/sshd \
    && groupadd --system sftp
#cronie net-tools libunwind icu 

ADD . /root
WORKDIR /root
RUN mv sshd_config /etc/ssh/sshd_config \
    && awk '{ sub("\r$", ""); print }' run.sh > run
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

EXPOSE 22

CMD ["/bin/bash", "run"]