# Raspberry Pi Dockerfile
# Based on resin/rpi-rasbian
# Augmented by pi/pibase
# Initial Commit 2016-09-28

FROM resin/rpi-raspbian:jessie-20160831
MAINTAINER Paul Killian

# Set locale
RUN locale-gen --no-purge en_US.UTF-8 
ENV LC_ALL en_US.UTF-8 
ENV DEBIAN_FRONTEND noninteractive

#create pi user
RUN useradd pi -s /bin/bash -m -g sudo -G sudo >/dev/null 2>/dev/null

# NOTE: Create base folder
RUN mkdir -p /pi 
RUN mkdir -p /opt/pi-config 
COPY pi-config /opt/pi-config 
RUN chmod +x -R /opt/pi-config/

#Update Base Image
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y --force-yes \
	nano \
	openssh-server \
	supervisor \
	fail2ban \
	wget \
	shellinabox
	
RUN apt-get autoremove
RUN apt-get autoclean
	
RUN mkdir /var/run/sshd 
RUN mkdir /root/.ssh 
RUN chmod 700 /root/.ssh 
RUN /usr/bin/ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa 
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys 

# Ensure correct permissions for root/.ssh and /etc/ssh/* 
RUN chmod 600 /root/.ssh/* 
RUN chmod 600 /etc/ssh/* 
RUN chown -Rf root:root /root/.ssh 
RUN chown -Rf root:root /etc/ssh/* 

RUN service shellinabox stop
ADD pi-config/shellinabox /etc/default/shellinabox

EXPOSE 22 4022

# Add supervisor config file
RUN mkdir -p /var/log/supervisor

# create directory for child images to store configuration in
RUN mkdir -p /etc/supervisor/conf.d

# add supervisor conf files that will start when supervisord starts
COPY supervisor/supervisor.conf /etc/supervisor.conf 
COPY supervisor/supervisor.conf /etc/supervisor/supervisor.conf 
COPY supervisor/conf.d /etc/supervisor/conf.d

# add default pi init shell script 
# The default is called only when the used defined init file is not there in /pi/app/pi-config/pi-init.sh
ADD default-pi-init.sh /opt/pi-config/default-pi-init.sh
RUN chmod +x /opt/pi-config/default-pi-init.sh

CMD cd /opt/pi-config && ./start.sh



