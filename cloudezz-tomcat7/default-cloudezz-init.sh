#!/bin/sh

#!/bin/sh


#Copy the war file from mounted directory to tomcat webapps directory
if [ ! -z "$WAR_URL" ]
then
echo "Removing old war files and copying $WAR_URL to tomcat webapps folder" 
rm -r /var/lib/tomcat7/webapps/*
cd /var/lib/tomcat7/webapps/  && wget -q $WAR_URL
fi


if [ $RUN_BUILD_PACK == "true" ]
then
rm -r /opt/build-pack >/dev/null 2>/dev/null
wget -P /opt/build-pack/ https://github.com/cloudezz/cloudezz-tomcat7-build-pack/archive/master.zip  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/
unzip /opt/build-pack/master.zip -d /opt/build-pack/  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/ 
cd /opt/build-pack/cloudezz-tomcat7-build-pack-master && ant 
fi

echo "Starting tomcat server on port 8080"
CMD service tomcat7 restart && tail -f /var/lib/tomcat7/logs/catalina.out