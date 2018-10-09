ARG OS_VERSION=3.7
FROM alpine:${OS_VERSION}

MAINTAINER kuldeep.d.sharma

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apk update && \
    apk add openssh-server && \
    apk add --no-cache bash && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*