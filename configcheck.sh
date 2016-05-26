#!/bin/bash

grep -F '[192.168.0.0/16,10.0.0.0/8,172.16.0.0/12]' /opt/suricata/etc/suricata/suricata.yaml
if [ $? == 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "It looks like you've still got the default config set"
   echo "Optimizing config now... "
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "Please enter your WAN ip address below:"
   read YOUR_WAN_IP
   sed -i "/172.16.0.0\/12/c\    HOME_NET: \"[$YOUR_WAN_IP\/32,10.0.0.0\/8,192.168.0.0\/16,172.16.0.0\/12]\"" /opt/suricata/etc/suricata/suricata.yaml
   sed -i "/EXTERNAL_NET/c\    EXTERNAL_NET: \"any\"" /opt/suricata/etc/suricata/suricata.yaml
   echo "ok configuration should be optimized now"
   sleep 10
   exit
   else
   clear
   echo "Your config looks good ;)"
   sleep 10
   fi
