#!/bin/sh

# restart Fail2Ban service to avoid dos attack thru ssh
echo "Starting fail2ban service"
service fail2ban restart >/dev/null

# start Shell in a box service only when the webshell env is set to true
if [ $WEB_SHELL ]
then
	echo "Starting shellinabox service"
	service shellinabox reload >/dev/null
fi

if [ $GIT_URL ]
then
	rm -r /pi/app 
	git clone $GIT_URL /pi/app >/dev/null
fi

#write environment variables
env | grep _ >> /etc/environment
 
# start supervisord in daemon mode
# fix based on http://stackoverflow.com/questions/14479894/stopping-supervisord-shut-down
unlink /var/run/supervisor.sock 2> /dev/null
unlink /tmp/supervisor.sock 2> /dev/null
service supervisor start


if [ -e "/pi/app/pi-config/pi-init.sh" ]
then
	echo "Started pi init script..." 
	chmod +x /pi/app/pi-config/pi-init.sh
	/pi/app/pi-config/pi-init.sh
else
	if [ -e "/opt/pi-config/default-pi-init.sh" ]
	then
		echo "Started default pi init script..." 
		chmod +x /opt/pi-config/default-pi-init.sh
		/opt/pi-config/default-pi-init.sh
	fi	
fi




