ARG VERSION=latest
ARG SFTP_BASE_NAME=sftp-baseimage
FROM ${SFTP_BASE_NAME}:${VERSION}

MAINTAINER kuldeep.d.sharma

ADD . /tmp
WORKDIR /tmp
RUN mv sshd_config /etc/ssh/sshd_config \
    && awk '{ sub("\r$", ""); print }' run.sh > run \
	&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key 

EXPOSE 22

CMD ["/bin/bash", "run"]