#!/bin/bash

###########################
# .Xauthority craziness
#
#
#rollback the last change as it did not function as expected
########################################
ls /etc/profile.d/xauth.sh &>/dev/null

if [ "$?" == "0" ]; then
sudo rm /etc/profile.d/xauth.sh
fi

##########################################################################
#try this for a while until someone forks and replaces w/ more optimal code
#I opted not to use the $HOME variable as it always assumed it 
#was /root since ran as sudo
##########################################################################


ls -ahg /home/pi/.Xauthority &>/dev/null

if [ "$?" == "0" ]; then
sudo cp /home/pi/.Xauthority /root/
fi


