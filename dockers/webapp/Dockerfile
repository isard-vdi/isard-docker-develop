FROM alpine:3.8
MAINTAINER isard <info@isard.com>

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache
#RUN apk add --no-cache --virtual .pynacl_deps git build-base python3-dev libffi-dev openssl-dev 

RUN apk add --no-cache git py3-libvirt py3-paramiko py3-lxml py3-xmltodict py3-pexpect py3-openssl py3-bcrypt py3-gevent py3-flask py3-flask-login py3-netaddr py3-requests
#RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN git clone -b develop https://github.com/isard-vdi/isard
COPY requirements.pip3 /requirements.pip3
RUN pip3 install --no-cache-dir -r requirements.pip3
RUN mv /isard/isard.conf.docker /isard/isard.conf
#RUN rm -r /root/.cache

#RUN echo "Host isard-hypervisor \
#	StrictHostKeyChecking no" >/root/.ssh/config
#RUN chmod 600 /root/.ssh/config
RUN apk add --update bash
COPY init.sh /
CMD ["sh", "/init.sh"]
#CMD ["sh","/init.sh"]
#ENTRYPOINT ["/init.sh"]
