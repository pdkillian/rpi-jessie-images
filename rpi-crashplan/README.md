Crashplan Docker Image
===========

Based on Raspbian Jessie

To make easy use of supervisord, an inheriting Docker project should contain a file [SOME_NAME].conf and add that to /etc/supervisor/conf.d in the Dockerfile. Note that you can find examples of such files in this repositories projects.

Always start the instance by running CMD cd /opt && ./start.sh



