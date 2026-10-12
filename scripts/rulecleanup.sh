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

########################################
#Removing unnecessary rules
#
#Feel free to add your own to this list
#######################################

grep -qF '# - emerging-chat.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out AIM_SERVERS rule..."
   sed -i "/ - emerging-chat.rules/c\# - emerging-chat.rules" /opt/suricata/etc/suricata/suricata.yaml
  #zenity --info --text="Ok.  AIM_SERVERS rule has been corrected!" &> /dev/null
   fi

grep -qF '# - tls-events.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out TLS_EVENTS rule..."
   sed -i "/ - tls-events.rules/c\# - tls-events.rules" /opt/suricata/etc/suricata/suricata.yaml
   #zenity --info --text="Ok.  TLS_EVENTS rule has been corrected!" &> /dev/null
   fi

grep -qF '# - stream-events.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out STREAM_EVENTS rule..."
   sed -i "/ - stream-events.rules/c\# - stream-events.rules" /opt/suricata/etc/suricata/suricata.yaml
   #zenity --info --text="Ok.  STREAM_EVENTS rule has been corrected!" &> /dev/null
   fi

grep -qF '# - app-layer-events.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out APP_LAYER_EVENTS rule..."
   sed -i "/ - app-layer-events.rules/c\# - app-layer-events.rules" /opt/suricata/etc/suricata/suricata.yaml
   #zenity --info --text="Ok.  APP_LAYER_EVENTS rule has been corrected!" &> /dev/null
   fi

grep -qF '# - decoder-events.rules' /opt/suricata/etc/suricata/suricata.yaml
if [ $? != 0 ] ; then
   clear
   echo "Commenting out DECODER_EVENTS rule..."
   sed -i "/ - decoder-events.rules/c\# - decoder-events.rules" /opt/suricata/etc/suricata/suricata.yaml
   #zenity --info --text="Ok.  DECODER_EVENTS rule has been corrected!" &> /dev/null
   fi

   exit

