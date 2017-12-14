FROM python:3.5-slim
MAINTAINER isard <info@isard.com>

COPY ./dockers/webapp/setup_4.x /setup_4.x
RUN bash - setup_4.x
RUN apt-get install git -y
RUN npm install -g yarn
RUN git clone -b develop https://github.com/isard-vdi/isard

COPY ./dockers/webapp/requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

WORKDIR /isard/install
#RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN yarn

WORKDIR /isard
COPY ./dockers/isard.conf ./isard.conf
COPY ./dockers/run_docker_webapp.py ./run_docker_webapp.py

RUN apt-get purge git; apt-get autoremove;  apt-get clean all
RUN npm uninstall -g yarn

#ADD ./config/host_name /isard/install/viewer-certs/host_name
