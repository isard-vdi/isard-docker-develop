FROM python:3.5-slim
MAINTAINER isard <info@isard.com>

RUN dnf install npm git -y; dnf clean all;
RUN npm -g install bower

RUN git clone https://github.com/isard-vdi/isard

COPY ./docker/webapp/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

WORKDIR /isard/install
RUN bower install --allow-root

WORKDIR /isard
COPY ./docker/isard.conf ./isard.conf

RUN npm uninstall -g bower
RUN dnf remove git npm -y; dnf clean all

#CMD python3 /isard/run_webapp.py
