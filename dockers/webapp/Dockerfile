FROM python:3.5-slim
MAINTAINER isard <info@isard.com>

RUN apt-get update; apt-get install git npm -y
RUN npm install -g bower
RUN git clone https://github.com/isard-vdi/isard

COPY ./dockers/webapp/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

WORKDIR /isard/install
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN bower install --allow-root

WORKDIR /isard
COPY ./dockers/isard.conf ./isard.conf
COPY ./dockers/run_docker_webapp.py ./run_docker_webapp.py
RUN apt-get purge git; apt-get autoremove;  apt-get clean all
RUN npm uninstall -g bower
