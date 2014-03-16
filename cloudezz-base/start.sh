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

# print the private key on console so that the user can connect thru ssh
/opt/ssh-key-init.sh

if [ $GIT_URL ]
then
rm -r /cloudezz/app 
git clone $GIT_URL /cloudezz/app >/dev/null
fi

# start supervisord in daemon mode
supervisord -c /etc/supervisor.conf


if [ -e "/cloudezz/app/cloudezz-config/cloudezz-init.sh" ]
then
 echo " Started cloudezz init script..." 
 chmod +x /cloudezz/app/cloudezz-config/cloudezz-init.sh
 /cloudezz/app/cloudezz-config/cloudezz-init.sh
fi




