FROM ubuntu:22.04
    
ARG DEBIAN_FRONTEND=noninteractive


RUN dpkg --add-architecture i386 
RUN apt-get update -y
RUN apt-get install -y libc6:i386 libstdc++6:i386

RUN apt-get update \
    && apt-get install -y \
    wget \
    nano \
    curl \
    unzip \
    zip \
    libstdc++6 \
    tzdata \
    ca-certificates \
    locales \
    git \
    proxychains4 \
    && useradd -d /home/container -m container

RUN locale-gen ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_ALL ru_RU.UTF-8

ENV TERM=xterm

#timezone fix
ENV TZ=Europe/Moscow
RUN ln -fs /usr/share/zoneinfo/US/Pacific-New /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
