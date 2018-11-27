FROM marvambass/nginx-ssl-secure
MAINTAINER isard <info@isard.com>

COPY *.pem /etc/nginx/external/
COPY isard.conf /etc/nginx/external/
RUN mkdir /errors
ADD errors/* /errors/
