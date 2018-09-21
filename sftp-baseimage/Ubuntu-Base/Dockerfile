ARG OS_VERSION
FROM ubuntu:${OS_VERSION}
RUN apt-get update \
    && apt-get install -y wget openssh-server netcat tar sudo net-tools git \
    && groupadd -g 500 appuser \
    && useradd -u 500 -g 500 appuser
ADD confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd