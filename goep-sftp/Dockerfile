ARG VERSION=latest
#ARG SFTP_BASE_NAME=sftp-baseimage
ARG ACR
FROM ${ACR}/sftp-baseimage:${VERSION}

MAINTAINER kuldeep.d.sharma

ADD . /tmp
WORKDIR /tmp
RUN mv sshd_config /etc/ssh/sshd_config \
    && awk '{ sub("\r$", ""); print }' run.sh > run \
	&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && rm -rf /tmp/* \
    && touch new_file

EXPOSE 22
CMD ["/bin/bash", "run"]
USER appuser