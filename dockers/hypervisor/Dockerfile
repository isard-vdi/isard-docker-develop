FROM alpine:latest
MAINTAINER isard <info@isard.com>
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add qemu-system-x86_64 libvirt netcat-openbsd libvirt-daemon dbus polkit qemu-img rsync wget
RUN ln -s /usr/bin/qemu-system-x86_64 /usr/bin/qemu-kvm
RUN apk add openssh curl
RUN ssh-keygen -A

RUN echo "root:isard" |chpasswd
RUN sed -i 's|[#]*PermitRootLogin prohibit-password|PermitRootLogin yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*ChallengeResponseAuthentication yes|ChallengeResponseAuthentication yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*UsePAM yes|UsePAM yes|g' /etc/ssh/sshd_config


RUN echo "listen_tls = 0" >> /etc/libvirt/libvirtd.conf; 
RUN echo 'listen_tcp = 1' >> /etc/libvirt/libvirtd.conf;

# libvirt configuration and certs
RUN echo 'spice_listen = "0.0.0.0"' >> /etc/libvirt/qemu.conf && \
echo 'spice_tls = 1' >> /etc/libvirt/qemu.conf && \
echo 'spice_tls_x509_cert_dir = "/etc/pki/libvirt-spice"' >> /etc/libvirt/qemu.conf
RUN mkdir -p /etc/pki/libvirt-spice
ADD auto-generate-certs.sh /
RUN chmod a+x /auto-generate-certs.sh


ADD customlibvirtpost.sh /customlibvirtpost.sh
RUN chmod a+x /customlibvirtpost.sh
ADD network.xml /network.xml

RUN mkdir /root/.ssh

EXPOSE 22
EXPOSE 16509
EXPOSE 5900-5950
EXPOSE 55900-55900

VOLUME ["/isard" ]

RUN apk add --update bash

RUN apk add supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]



