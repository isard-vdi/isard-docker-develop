FROM fedora:latest
MAINTAINER isard <info@isardvdi.com>

#ENV INSTALL_PATH /isard
#RUN mkdir -p $INSTALL_PATH
#WORKDIR $INSTALL_PATH

RUN dnf install wget gcc redhat-rpm-config python3-devel openssl-devel libvirt-devel git -y; dnf clean all
RUN git clone https://github.com/isard-vdi/isard.git
COPY ./dockers/engine/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

RUN dnf install openssh openssh-clients -y; dnf clean all
COPY ./dockers/engine/init.sh /
COPY ./dockers/engine/config /root/.ssh/

RUN dnf remove git; dnf clean all
WORKDIR /isard

#COPY . .
COPY ./dockers/isard.conf ./isard.conf

#CMD ./keys.sh;python3 /isard/run_engine.py
