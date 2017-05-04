#!/bin/bash

#ls /home/pi/.Xauthority > /dev/null

#if [ "$?" == "0" ]; then
#sudo cp -f /home/pi/.Xauthority /root/
#fi

#check for the existence of .Xauthority

ls -ahg /root/.Xauthority &>/dev/null
#echo $?
if [ "$?" == "2" ]; then
sudo cp /home/pi/.Xauthority /root/
fi
