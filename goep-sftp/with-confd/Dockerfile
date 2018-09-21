ARG OS_VERSION=18.04
FROM goebaseimage-ubuntu:${OS_VERSION}

ADD files/start.sh /start.sh
RUN chmod +x /usr/local/bin/confd /start.sh
ADD files/confd /etc/confd
ADD authorized_keys /tmp/authorized_keys

EXPOSE 22
CMD ["/start.sh"]