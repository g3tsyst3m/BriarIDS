#!/bin/bash

ls /home/pi/.Xauthority > /dev/null

if [ "$?" == "0" ]; then
sudo cp /home/pi/.Xauthority /root/
fi
