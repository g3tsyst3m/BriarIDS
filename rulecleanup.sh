#!/bin/bash

#cleaning up previous files
echo "cleaning up previously captured files.  If you'd rather keep these and remove them manually just comment out the code below"
rm /var/log/suricata/files/* 2>/dev/null

#checking to see if the updatedb command is listed in rc.local and if the user would like to add it to the file
grep updatedb /etc/rc.local &>/dev/null

if [ $? != 0 ] ; then
   echo "It doesn't look like you have an 'updatedb' entry in your rc.local (startup) script.  This helps keep track of recently installed and added files on your Pi.  Adding now."
   sed -i '\/bin\/sh/a updatedb' /etc/rc.local
   fi

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

