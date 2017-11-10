FROM fedora:latest
MAINTAINER isard <info@isardvdi.com>

RUN dnf install wget gcc redhat-rpm-config python3-devel openssl-devel libvirt-devel \
openssh openssh-clients git -y; dnf clean all
RUN git clone https://github.com/isard-vdi/isard.git
COPY ./dockers/engine/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

COPY ./dockers/engine/init.sh /
COPY ./dockers/engine/config /root/.ssh/

RUN dnf remove git; dnf clean all
WORKDIR /isard

COPY ./dockers/isard.conf ./isard.conf
COPY ./dockers/run_docker_engine.py ./run_docker_engine.py
