# Raspberry Pi Crashplan Dockerfile
# Initial Commit 2016-09-28

FROM pdkillian/rpi-supervisor-base:latest
MAINTAINER Paul Killian

# Copy Config files in
COPY pi-config /opt/pi-config 
RUN chmod +x -R /opt/pi-config/

#Update Base Image
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y --force-yes \
	oracle-java8-jdk \
	libjna-java \
	wget \
	grep \
	cpio \
	gzip 

RUN apt-get autoremove && apt-get autoclean
	
RUN \
	mkdir -p /tmp/pi && \
	cd /tmp/pi/ && \
	wget https://download.code42.com/installs/linux/install/CrashPlan/CrashPlan_4.7.0_Linux.tgz && \
	tar zxvf CrashPlan_4.7.0_Linux.tgz

COPY install.sh /tmp/pi/crashplan-install/

RUN 	cd /tmp/pi/crashplan-install && \
	sudo ./install.sh

COPY my.service.xml /opt/crashplan/crashplan/conf/my.service.xml

#COPY start_crashplan.sh /opt/pi-config/start_crashplan.sh
#CMD chmod +x /opt/pi-config/start_crashplan.sh

#COPY crashplan.conf /etc/supervisor/conf.d/

EXPOSE 4243

VOLUME /mnt/data/backup

# Add custom pi init shell script 
# The default is called only when the used defined init file is not there in /pi/app/pi-config/pi-init.sh
COPY pi-init.sh /pi/app/pi-config/pi-init.sh
RUN chmod +x /pi/app/pi-config/pi-init.sh

CMD cd /opt/pi-config && ./start.sh
