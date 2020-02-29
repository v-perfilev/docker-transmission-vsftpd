FROM ubuntu:18.04

# default environemt variables
ENV USERNAME="user" \
    PASSWORD="pass"

# common setup
RUN apt-get update && \
    apt-get install -y software-properties-common

# install vsftpd
RUN apt-get install -y vsftpd && \
    mkdir -p /var/run/vsftpd/empty

# install transmission
RUN add-apt-repository ppa:transmissionbt/ppa && \
    apt-get update && \
    apt-get install -y transmission-cli transmission-common transmission-daemon

RUN cp -R /etc/transmission-daemon /root/.config/ && \
    sed -i 's%CONFIG_DIR="/var/lib/transmission-daemon/info"%CONFIG_DIR="/root/.config/transmission-daemon"%g' /etc/default/transmission-daemon && \
    sed -i 's%USER=debian-transmission%USER=root%g' /etc/init.d/transmission-daemon

# config and entrypoint
COPY config/vsftpd.conf /etc/
COPY config/settings.json /root/.config/transmission-daemon/
COPY config/entrypoint.sh /usr/sbin/
RUN chmod +x /usr/sbin/entrypoint.sh

EXPOSE 21
EXPOSE 21100-21110
EXPOSE 8080

# entrypoint
ENTRYPOINT /usr/sbin/entrypoint.sh
