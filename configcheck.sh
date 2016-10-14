#!/bin/bash

ls /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   zenity --info --text="You need to install BriarIDS first before you check its config..."
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 4
   exit
   else
   clear
   echo "Loading..."
   sleep 5
   fi

grep -F '[192.168.0.0/16,10.0.0.0/8,172.16.0.0/12]' /opt/suricata/etc/suricata/suricata.yaml
if [ $? == 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   zenity --info --text="It looks like you've still got the default config set"
   echo "Optimizing config now... "
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   YOUR_WAN_IP=$(zenity --entry --entry-text="[WAN_IP]" --text="Please enter your WAN ip address below:")
   sed -i "/172.16.0.0\/12/c\    HOME_NET: \"[$YOUR_WAN_IP\/32,10.0.0.0\/8,192.168.0.0\/16,172.16.0.0\/12]\"" /opt/suricata/etc/suricata/suricata.yaml
   sed -i "/EXTERNAL_NET/c\    EXTERNAL_NET: \"any\"" /opt/suricata/etc/suricata/suricata.yaml
   zenity --info --text="ok configuration should be optimized now"
   sleep 4
   exit
   else
   clear
   zenity --info --text="Main config looks good ;)"
   sleep 3
   fi

grep -F '# - emerging-chat.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out AIM_SERVERS rule..."
   sed -i "/ - emerging-chat.rules/c\# - emerging-chat.rules" /opt/suricata/etc/suricata/suricata.yaml
   zenity --info --text="Ok.  AIM_SERVERS rule has been corrected!"
   fi
   exit
