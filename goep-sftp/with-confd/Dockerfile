ARG OS_VERSION=18.04
ARG ACR
FROM ${ACR}/goebaseimage-ubuntu:${OS_VERSION}

ADD files/start.sh /start.sh
RUN apt-get install -y dos2unix && dos2unix /start.sh && chmod +x /usr/local/bin/confd /start.sh
ADD files/confd /etc/confd
ADD authorized_keys /tmp/authorized_keys

RUN echo '%appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER appuser

EXPOSE 22
ENTRYPOINT ["sudo", "/start.sh"]
#CMD ["bash","/start.sh"]
#USER appuser