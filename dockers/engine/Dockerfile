FROM fedora:25
MAINTAINER isard <info@isardvdi.com>

RUN dnf install wget gcc redhat-rpm-config python3-devel openssl-devel libvirt-devel git openssh openssh-clients -y; dnf clean all
RUN git clone -b develop https://github.com/isard-vdi/isard.git

COPY ./dockers/engine/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3
COPY ./dockers/engine/init.sh /
COPY ./dockers/engine/config /root/.ssh/
RUN chmod 600 /root/.ssh/config
RUN dnf remove git -y; dnf clean all -y
WORKDIR /isard
RUN mv /isard/isard.conf.docker /isard/isard.conf
RUN dnf install openssh-clients -y
######## Only in development
#RUN pip3 install ipython
#RUN dnf install openssh-server passwd -y; dnf clean all
########
