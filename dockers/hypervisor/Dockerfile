FROM fedora:25
ENV container docker
RUN dnf -y update && dnf clean all
RUN dnf -y install systemd && dnf clean all && \
(cd /lib/systemd/system/sysinit.target.wants/ && for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) && \
rm -f /lib/systemd/system/multi-user.target.wants/* && \
rm -f /etc/systemd/system/*.wants/* && \
rm -f /lib/systemd/system/local-fs.target.wants/* && \
rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
rm -f /lib/systemd/system/basic.target.wants/* && \
rm -f /lib/systemd/system/anaconda.target.wants/*
VOLUME [ “/sys/fs/cgroup” ]

#RUN dnf -y groupinstall "Virtualization" 
RUN dnf -y install libvirt-daemon-driver-* libvirt-daemon libvirt-daemon-kvm qemu-kvm libvirt-client libguestfs-tools python3-pip virt-install && dnf clean all

RUN ln -s /usr/bin/qemu-kvm /usr/libexec/qemu-kvm
RUN systemctl enable libvirtd; systemctl enable virtlockd 

RUN dnf install -y openssh-server && dnf clean all
#RUN dnf install -y openssh-clients

RUN echo "root:isard" |chpasswd
RUN systemctl enable sshd
RUN sed -i 's|[#]*PermitRootLogin no|PermitRootLogin yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*ChallengeResponseAuthentication no|ChallengeResponseAuthentication yes|g' /etc/ssh/sshd_config
RUN sed -i 's|UsePAM no|UsePAM yes|g' /etc/ssh/sshd_config
#RUN sed -i 's|[#]*HostKey /etc/ssh/ssh_host_ecdsa_key|#HostKey /etc/ssh/ssh_host_ecdsa_key|g' /etc/ssh/sshd_config
#RUN sed -i 's|[#]*HostKey /etc/ssh/ssh_host_ed25519_key|#HostKey /etc/ssh/ssh_host_ed25519_key|g' /etc/ssh/sshd_config

#html5 proxy
RUN mkdir -p /var/www/html
COPY html5/html /var/www/html
RUN dnf install nginx -y && dnf clean all
ADD html5/nginx.conf /etc/nginx/
RUN systemctl enable nginx;

ADD html5/requirements.pip3 /
RUN pip3 install -r requirements.pip3
ADD html5/start_proxy.py /
ADD html5/html5proxy.service /etc/systemd/system/
RUN systemctl enable html5proxy;

RUN echo "listen_tls = 0" >> /etc/libvirt/libvirtd.conf; 
RUN echo 'listen_tcp = 1' >> /etc/libvirt/libvirtd.conf;
#echo 'tls_port = "16514"' >> /etc/libvirt/libvirtd.conf; \ 
#echo 'tcp_port = "16509"' >> /etc/libvirt/libvirtd.conf; \
#echo 'auth_tcp = "none"' >> /etc/libvirt/libvirtd.conf

#RUN echo 'vnc_listen = "0.0.0.0"' >> /etc/libvirt/qemu.conf

#RUN echo 'LIBVIRTD_ARGS="--listen"' >> /etc/sysconfig/libvirtd

# libvirt configuration and certs
RUN echo 'spice_listen = "0.0.0.0"' >> /etc/libvirt/qemu.conf && \
echo 'spice_tls = 1' >> /etc/libvirt/qemu.conf && \
echo 'spice_tls_x509_cert_dir = "/etc/pki/libvirt-spice"' >> /etc/libvirt/qemu.conf
RUN mkdir -p /etc/pki/libvirt-spice
ADD generate-certs.service /usr/lib/systemd/system/generate-certs.service
ADD auto-generate-certs.sh /
RUN chmod a+x /auto-generate-certs.sh
RUN systemctl enable generate-certs

ADD customlibvirtpost.service /usr/lib/systemd/system/customlibvirtpost.service
ADD customlibvirtpost.sh /customlibvirtpost.sh
RUN chmod a+x /customlibvirtpost.sh
ADD network.xml /network.xml
RUN systemctl enable customlibvirtpost


RUN mkdir /root/.ssh
#RUN mkdir /isard
#RUN mkdir /isard/bases
#RUN mkdir /isard/groups
#RUN mkdir /isard/templates
#RUN mkdir /isard/isos

RUN export LIBGUESTFS_BACKEND=direct
EXPOSE 22
EXPOSE 16509
EXPOSE 5900-5950
EXPOSE 55900-55900

VOLUME [ "/sys/fs/cgroup", "/isard" ]

CMD ["/usr/sbin/init"]

