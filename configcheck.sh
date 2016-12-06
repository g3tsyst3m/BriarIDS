#!/bin/bash

ls /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   zenity --info --text="You need to install BriarIDS first before you check its config..." &> /dev/null
   sleep 4
   exit
   else
   clear
   echo "Loading..."
   sleep 1
   fi

grep -F '[192.168.0.0/16,10.0.0.0/8,172.16.0.0/12]' /opt/suricata/etc/suricata/suricata.yaml
if [ $? == 0 ] ; then
   clear
   zenity --text="It doesn't look like you have a WAN IP entry in your config.  Would you like to add it in so you can monitor traffic against your WAN interface?" --question &> /dev/null
   if [ $? == 0 ] ; then
   YOUR_WAN_IP=$(zenity --entry --entry-text="[WAN_IP]" --text="Please enter your WAN IP below" 2> /dev/null)
   if [ $? == 0 ] ; then
   sed -i "/172.16.0.0\/12/c\    HOME_NET: \"[$YOUR_WAN_IP\/32,10.0.0.0\/8,192.168.0.0\/16,172.16.0.0\/12]\"" /opt/suricata/etc/suricata/suricata.yaml
   sed -i "/EXTERNAL_NET/c\    EXTERNAL_NET: \"any\"" /opt/suricata/etc/suricata/suricata.yaml
   zenity --info --text="done!" &> /dev/null
   sleep 4
   exit
   else
   echo ""
   fi
   else
   zenity --info --text="ok skipping for now" &> /dev/null
   fi
   else
   clear
   zenity --info --text="Main config looks good ;)" &> /dev/null
   sleep 3
   fi
   exit
