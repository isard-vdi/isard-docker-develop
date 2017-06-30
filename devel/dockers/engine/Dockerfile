FROM fedora:latest
MAINTAINER isard <info@isardvdi.com>

RUN dnf install wget gcc redhat-rpm-config python3-devel openssl-devel libvirt-devel \
    git openssh openssh-clients -y; dnf clean all
RUN git clone https://github.com/isard-vdi/isard.git
COPY ./dockers/engine/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

COPY ./dockers/engine/init.sh /
COPY ./dockers/engine/config /root/.ssh/

RUN dnf remove git; dnf clean all
WORKDIR /isard

COPY ./dockers/isard.conf ./isard.conf


######## Only in development
RUN pip3 install ipython
RUN dnf install openssh-server passwd -y; dnf clean all
########
