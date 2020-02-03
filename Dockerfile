FROM ubuntu:18.04


RUN apt-get update -qqy \
   && apt-get -qqy install maven \
   && rm -rf /var/lib/apt/lists/*

USER root

RUN mkdir -p /home/remoteuser/serenity-project

WORKDIR /home/remoteuser/serenity-project

