docker-base
===========

Based on Raspbian Jessie

Supervisord is a linux process manager . It allows us to start containers with e.g.

    multiple processes
    a deamon / background process
    launch groups of processes in a specific order
    
To make easy use of supervisord, an inheriting Docker project should contain a file [SOME_NAME].conf and add that to /etc/supervisor/conf.d in the Dockerfile. Note that you can find examples of such files in this repositories projects.

Always start the instance by running CMD cd /opt && ./start.sh



