#!/bin/bash
touch /usr/local/src/install_log.log
rm /usr/local/src/install_log.log

ls /opt/suricata/etc/suricata/BriarIDS_installed 2>/dev/null
#echo $?
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
   echo "[Doesn't look like you have installed BriarIDS.  Continuing with the installation...]"
   fi


echo "#######################################################"
echo "# BriarIDS Suricata install script for the raspberry pi"
echo "#------------------------------------------------------"
echo "#######################################################"
sleep 3
echo "--------------------------------"
echo "make sure you are ROOT for this!"
echo "--------------------------------"
sleep 3
echo "Phase-1: Gettin' the dependencies..."
apt-get update 


apt-get -y install libpcre3 libpcre3-dbg libpcre3-dev \
build-essential autoconf automake libtool libpcap-dev libnet1-dev \
libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
make libmagic-dev libjansson-dev libjansson4 pkg-config libnetfilter-queue-dev \
libnetfilter-queue1 libnfnetlink-dev libnss3-dev libnspr4-dev libnfnetlink0 

if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "review the log file:: '/usr/local/src/install_log.log' for more info"
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   echo "so far so good ;)"
   fi

echo "Now it's time to install SURICATA!"
echo "This can take up to 30-45 minutes total to complete configure -> make install or longer depending on PI unit used"

sleep 3
cd /usr/local/src
VER=4.0.4
wget "http://www.openinfosecfoundation.org/download/suricata-$VER.tar.gz"
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   echo "so far so good ;)"
   fi
tar xvf suricata* 
rm *.gz
cd suricata*
echo "Phase-2: Issuing the configure command.  Please be patient while this completes..."
./configure --enable-nfqueue --with-libnss-libraries=/usr/lib --with-libnss-includes=/usr/include/nss/ --with-libnspr-libraries=/usr/lib --with-libnspr-includes=/usr/include/nspr --prefix=/opt/suricata --sysconfdir=/opt/suricata/etc --localstatedir=/var
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   echo "configure command finished without errors ;)"
   fi
echo "Phase-3: Issuing the MAKE command...this could take a bit to complete so please be patient..."
make
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   echo "MAKE command finished without errors ;)"
   fi
echo "Phase-4: Issuing the 'make install' command..."
make install-full
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   echo "Phase-5: finalizing installation!"
   fi
ldconfig
echo "installing ethtool..."
apt-get install -y ethtool 
if [ $? != 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "There was an error..."
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   echo "almost done!"
   fi

echo "enabling http-log for capturing http log traffic"
sed -i '/http-log:/!b;n;s/enabled: no/enabled: yes/' /opt/suricata/etc/suricata/suricata.yaml
echo "touching the BriarIDS_installed file to show suricata is installed for the Raspberry PI unit"
touch /opt/suricata/etc/suricata/BriarIDS_installed
echo "You made it!  Installation was a success.  You can give it a test run now by following the commands below or just close this terminal.  Your installation of suricata is complete"
echo "To continue the test run, please select the interface you would like to monitor: examples: eth0/eth1/wlan0,etc"
read yourinterface
ethtool -K $yourinterface tx off rx off sg off gso off gro off
echo "Starting your PI IDS!  Give it a sec to load the rules..."
echo "Once this is loaded and running, you can test your IDS by issuing the following command in a separate shell on your PI IDS box:"
echo "curl http://testmyids.com"
echo "review the output of your detected alerts by issuing this command in a separate shell on your PI IDS box: tail -f /var/log/suricata/fast.log /var/log/suricata/http.log"
/opt/suricata/bin/suricata -c /opt/suricata/etc/suricata/suricata.yaml  --af-packet=$yourinterface

