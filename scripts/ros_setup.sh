#!/bin/bash

set -e
set -x

# Uncomment to enable ROS configuration
#RUN printf "source /opt/ros/${ROS_DISTRO}/setup.bash \n\
#FILE=/app/$workspacename/devel/setup.bash && test -f \$FILE && source \$FILE || true\n\
#export ROS_MASTER_URI=http://\$(hostname):11311 \n\
#export ROS_HOSTNAME=\$(hostname) \n\
#export ROS_IP=\$(hostname -i) \n\
#export PATH=/sbin/:\$PATH \n\
#cd /app/$workspacename \
#" >> /app/.bash_profile
