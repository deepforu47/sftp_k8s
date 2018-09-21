ARG OS_VERSION=18.04
ARG ACR
FROM ${ACR}/goebaseimage-ubuntu:${OS_VERSION}

ADD files/start.sh /start
RUN awk '{ sub("\r$", ""); print }' /start > /start.sh && chmod +x /usr/local/bin/confd /start.sh
ADD files/confd /etc/confd
ADD authorized_keys /tmp/authorized_keys

EXPOSE 22
CMD ["/start.sh"]