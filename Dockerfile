FROM ubuntu:18.04

# environemt variables
ENV USERNAME=qbt \
    PASSWORD=qbt

# common setup
RUN apt update && \
    apt install -y software-properties-common

# install qbittorrent-nox
RUN add-apt-repository ppa:qbittorrent-team/qbittorrent-stable && \
    apt install -y qbittorrent-nox:

# install vsftpd
RUN apt install -y vsftpd && \
    mkdir -p /var/run/vsftpd/empty

# config and entrypoint
COPY config/vsftpd.conf /etc/
COPY config/entrypoint.sh /usr/sbin/
RUN chmod +x /usr/sbin/entrypoint.sh

# entrypoint
RUN /usr/sbin/entrypoint.sh
#CMD ["/usr/sbin/vsftpd","-obackground=NO"]
