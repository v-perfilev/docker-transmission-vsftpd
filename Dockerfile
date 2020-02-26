FROM ubuntu:18.04

# common setup
RUN apt update && \
    apt install -y software-properties-common

# install qbittorrent-nox
RUN add-apt-repository ppa:qbittorrent-team/qbittorrent-stable && \
    apt install -y qbittorrent-nox


