FROM fedora:latest
MAINTAINER isard <info@isardvdi.com>

#ENV INSTALL_PATH /isard
#RUN mkdir -p $INSTALL_PATH
#WORKDIR $INSTALL_PATH

RUN dnf install wget gcc redhat-rpm-config python3-devel openssl-devel libvirt-devel git -y; dnf clean all
RUN git clone https://github.com/isard-vdi/isard.git
COPY ./engine/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

RUN dnf install openssh openssh-clients -y; dnf clean all
COPY ./engine/init.sh /
COPY ./engine/config /root/.ssh/

RUN dnf remove git; dnf clean all
WORKDIR /isard

#COPY . .
COPY ./isard.conf ./isard.conf

#CMD ./keys.sh;python3 /isard/run_engine.py
