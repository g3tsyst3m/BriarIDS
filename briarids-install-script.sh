#!/bin/bash
touch install_log.log
rm install_log.log

ls /opt/suricata/etc/suricata/BriarIDS_installed
if [ $? == 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "It looks like you've already installed BriarIDS."
   echo "Delete this file if you'd like to re-install: '/opt/suricata/etc/suricata/BriarIDS_installed' "
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 10
   exit
   else
   clear
   echo "Doesn't look like you have installed BriarIDS.  Continuing with installation..."
   zenity --info --text="There is an install log file that gets created and added to that can be viewed by issuing the following command: tail -f /usr/local/src/install_log.log.  If you wish to follow the installation progress or be aware of installation issues, refer to this log at any point during installation."
   fi


echo "#######################################################"
echo "# BriarIDS install script for Raspian OS (raspberry pi)"
echo "# This is revision 0.1 and a VERY early Beta solution"
echo "#------------------------------------------------------"
echo "#######################################################"
sleep 3
echo "--------------------------------"
echo "make sure you are ROOT for this!"
echo "--------------------------------"
sleep 3
echo "Gettin the dependencies.  Takes about 10 minutes roughly..."
apt-get update
apt-get -y install build-essential lxterminal cmake autoconf automake libtool libpcap-dev libnet1-dev \
libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
make flex bison git git-core subversion libmagic-dev \
libgeoip1 libgeoip-dev libjansson4 libjansson-dev python-simplejson libnss3-dev libnspr4-dev \
libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev libnfnetlink0 >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
echo "######################################################################################"
echo "Downloading and compiling pcre from source "
echo "since apt version is blacklisted/vulnerable"
echo "######################################################################################"
sleep 3
echo "Also moving us into /usr/local/src as our homebase for install/downloaded files"
sleep 2

cd /usr/local/src
wget https://sourceforge.net/projects/pcre/files/pcre/8.38/pcre-8.38.tar.gz/download
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
tar xvf download
rm download
cd pcre*
./configure >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
make >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
make install >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi

echo "Now it's time to install SURICATA!"
echo "This takes about 30 - 45 minutes total to complete configure -> make install"

sleep 3

wget http://www.openinfosecfoundation.org/download/suricata-3.0.1.tar.gz
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
tar xvf suricata*
cd suricata*
./configure --enable-nfqueue --prefix=/opt/suricata --sysconfdir=/opt/suricata/etc --localstatedir=/var >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
make >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
make install-full >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi
ldconfig

apt-get install -y ethtool >> /usr/local/src/install_log.log
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   exit
   else
   clear
   echo "so far so good ;)"
   fi

touch /opt/suricata/etc/suricata/BriarIDS_installed
echo "You made it!  Installation was a success.  Now it's time to give it a test run."
echo "what interface do you want to monitor? examples: eth0/eth1/wlan0,etc"
read yourinterface
ethtool -K $yourinterface tx off rx off sg off gso off gro off
echo "Starting your PI IDS!  Give it a sec to load the rules..."
echo "Once this is loaded and running, you can test your IDS by issuing the following command in a separate shell on your PI IDS box:"
echo "curl http://testmyids.com"
echo "review the output of your detected alerts by issuing this command in a separate shell on your PI IDS box: tail -f /var/log/suricata/fast.log /var/log/suricata/http.log"
/opt/suricata/bin/suricata -c /opt/suricata/etc/suricata/suricata.yaml  --af-packet=$yourinterface

