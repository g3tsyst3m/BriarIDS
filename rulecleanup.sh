#!/bin/bash

grep -qF '# - emerging-chat.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out AIM_SERVERS rule..."
   sed -i "/ - emerging-chat.rules/c\# - emerging-chat.rules" /opt/suricata/etc/suricata/suricata.yaml
   zenity --info --text="Ok.  AIM_SERVERS rule has been corrected!" &> /dev/null
   fi

grep -qF '# - tls-events.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out TLS_EVENTS rule..."
   sed -i "/ - tls-events.rules/c\# - tls-events.rules" /opt/suricata/etc/suricata/suricata.yaml
   zenity --info --text="Ok.  TLS_EVENTS rule has been corrected!" &> /dev/null
   fi
   exit

