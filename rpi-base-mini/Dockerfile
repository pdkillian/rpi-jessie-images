# Raspberry Pi Dockerfile
# Based on resin/rpi-rasbian
# Augmented by pi/pibase
# Initial Commit 2016-09-28
# Revised 2016-09-29 to remove: fail2ban, shellinabox, fix locales, add: passwordless sudo for pi and dist-upgrade

FROM resin/rpi-raspbian:jessie-20160831
MAINTAINER Paul Killian

ENV DEBIAN_FRONTEND noninteractive 

#create pi user
RUN useradd pi -s /bin/bash -m -g sudo -G sudo >/dev/null 2>/dev/null
RUN echo "pi:raspberry" | chpasswd
RUN echo 'pi  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

# NOTE: Create base folder
RUN mkdir -p /pi 
RUN mkdir -p /opt/pi-config 
COPY pi-config /opt/pi-config 
RUN chmod +x -R /opt/pi-config/

#Update Base Image
RUN apt-get update && apt-get -y upgrade

#Install Software
RUN apt-get install -y --force-yes \
	nano \
	openssh-server \
	supervisor \
#	fail2ban \
#	shellinabox \
	wget \
	apt-transport-https \
	ca-certificates \
	locales

## Upgrade all packages
RUN apt-get dist-upgrade -y --no-install-recommends

#Remove anything lingering in past builds	
RUN apt-get autoremove && apt-get autoclean 
RUN rm -rf /tmp/* 
RUN rm -rf /var/tmp/*
RUN rm -rf /var/lib/apt/lists/*

# Fix Locale
RUN locale-gen en_US.UTF-8 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Create SSH keys
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

#RUN service shellinabox stop
#COPY pi-config/shellinabox /etc/default/shellinabox

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
COPY default-pi-init.sh /opt/pi-config/default-pi-init.sh
RUN chmod +x /opt/pi-config/default-pi-init.sh

RUN touch /var/log/auth.log && chmod 777 /var/log/auth.log

#SSH Port=22
EXPOSE 22

CMD cd /opt/pi-config && ./start.sh
