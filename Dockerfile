FROM ubuntu:18.04


RUN apt-get update -qqy \
   && apt-get -qqy install \
   maven \
   psmisc \
   tcpdump \
   openjdk-8-jdk \
   && rm -rf /var/lib/apt/lists/*

COPY pom.xml /pom.xml
RUN cd /
RUN mvn verify clean --fail-never

USER root

RUN mkdir -p /home/remoteuser/serenity-project

WORKDIR /home/remoteuser/serenity-project

