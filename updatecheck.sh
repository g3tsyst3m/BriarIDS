#!/bin/bash

###############################
#check for existence of zenity
############################### 
which zenity &> /dev/null
if [ $? != 0 ] ; then
sudo apt-get install zenity 
fi

echo "Checking for updates..."
git remote show origin | grep "out of date"
if [ $? == 0 ] ; then
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   zenity --info --text="An update is available! Updating now!" &> /dev/null
   git pull
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   clear
   exit
   else
   echo "All good here.  No updates available at this time"
   sleep 1
   fi

#echo "[daemon preparation script]"
grep -qF '#pid-file: /var/run/suricata.pid' /opt/suricata/etc/suricata/suricata.yaml
if [ $? == 0 ] ; then
   #clear
   echo "Uncommenting pid file config..."
   sed -i "/#pid-file: \/var\/run\/suricata.pid/c\pid-file: \/var\/run\/suricata.pid" /opt/suricata/etc/suricata/suricata.yaml
   #zenity --info --text="Ok.  TLS_EVENTS rule has been corrected!" &> /dev/null
sudo sed -i '/console:/{n;s/.*/      enabled: no/}' /opt/suricata/etc/suricata/suricata.yaml
sudo sed -i '/- file:/{n;s/.*/      enabled: yes/}' /opt/suricata/etc/suricata/suricata.yaml
sudo sed -i '/- file:/{n;n;n;n;n;s/.*/      enabled: yes/}' /opt/suricata/etc/suricata/suricata.yaml
else
:
#echo "pid file enabled already ;)"
fi

