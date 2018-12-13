FROM marvambass/nginx-ssl-secure
MAINTAINER isard <info@isard.com>

COPY isard.conf /etc/nginx/conf.d/
RUN mkdir /errors
ADD errors/* /errors/
COPY dh.pem /
COPY auto-generate-certs.sh /opt
COPY entrypoint.sh /opt/
RUN chmod 744 /opt/*
