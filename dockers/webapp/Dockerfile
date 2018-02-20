FROM python:3.5-slim
MAINTAINER isard <info@isard.com>

COPY setup_4.x /setup_4.x
RUN bash - setup_4.x

RUN apt-get install git -y
RUN git clone -b develop https://github.com/isard-vdi/isard
COPY requirements.pip3 /requirements.pip3
RUN pip3 install -r requirements.pip3

WORKDIR /isard/install
RUN npm install -g yarn
#RUN yarn --no-progress

WORKDIR /isard
RUN mv /isard/isard.conf.docker /isard/isard.conf

RUN apt-get autoremove && apt-get clean all
#RUN npm uninstall -g yarn

COPY init.sh /
