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
RUN sed -i "/jdk.tls.disabledAlgorithms=/ s/=.*/=TLSv1.3, SSLv3, RC4, MD5withRSA, DH keySize < 1024, EC keySize < 224, DES40_CBC, RC4_40, 3DES_EDE_CBC/" $(readlink -f /usr/bin/java | sed "s:bin/java::")/conf/security/java.security
USER root

RUN mkdir -p /home/remoteuser/serenity-project

WORKDIR /home/remoteuser/serenity-project

