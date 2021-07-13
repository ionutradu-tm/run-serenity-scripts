FROM ubuntu:18.04

RUN apt-get update -qqy \
   && apt-get -qqy install \
   maven \
   psmisc \
   tcpdump \
   openjdk-8-jdk \
   python3 \
   python3-pip \
   ruby-full \
   wget \
   && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY google-chrome.list /etc/apt/sources.list.d/google-chrome.list
RUN wget https://dl.google.com/linux/linux_signing_key.pub
RUN apt-key add linux_signing_key.pub
RUN  apt-get update -qqy \
    && apt-get -qqy install \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

COPY pom.xml /pom.xml
RUN cd /
RUN mvn verify clean --fail-never
RUN sed -i "/jdk.tls.disabledAlgorithms=/ s/=.*/=TLSv1.3, SSLv3, RC4, MD5withRSA, DH keySize < 1024, EC keySize < 224, DES40_CBC, RC4_40, 3DES_EDE_CBC/" $(readlink -f /usr/bin/java | sed "s:bin/java::")/conf/security/java.security
USER root

RUN mkdir -p /home/remoteuser/serenity-project
RUN chmod 0777 /tmp /dev/shm

WORKDIR /home/remoteuser/serenity-project

