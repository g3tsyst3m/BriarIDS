#!/bin/bash

#wipe log to have a fresh version
> /usr/local/src/broinstall.log
echo "Installation log file located here: /usr/local/src/broinstall.log"
#Installing prereqs
cd ~
echo "Installing prereqs"
echo "Installing prereqs" >> /usr/local/src/broinstall.log
sudo apt-get update
sudo apt-get install cmake make gcc g++ flex bison libcanberra-gtk* libpcap-dev locate libgeoip-dev python-dev zlib1g-dev libmagic-dev swig -y

#determine libssl version to install
ourversion="$(cat /etc/*release)"

shopt -s nocasematch
if [[ $ourversion = *"Debian"* ]] ; then
echo "running debian"
sudo apt-get install libssl1.0-dev -y
else
echo "not running debian"
sudo apt-get install libssl-dev -y
fi
shopt -u nocasematch

sudo apt-get install python-pip -y
echo "Installing setuptools via pip..." >> /usr/local/src/broinstall.log
sudo pip install setuptools
git clone git://git.bro-ids.org/pysubnettree.git
cd pysubnettree
sudo python setup.py install
cd ~
#Install Bro
clear
echo "Installing Bro...depending on your PI (zero, pi2, pi 3) this could take anywhere from 2 - 5 hours to complete, so go grab a coffee and when you get back this should be about done ;)"
#sudo wget https://www.bro.org/downloads/release/bro-2.4.1.tar.gz
echo "using wget to download the most recent bro version..." >> /usr/local/src/broinstall.log
sudo wget https://www.bro.org/downloads/bro-2.5.4.tar.gz
echo "issuing the tar command on the file..." >> /usr/local/src/broinstall.log
sudo tar -xzf bro-2.5.4.tar.gz
echo "creating necessary directories..." >> /usr/local/src/broinstall.log
sudo mkdir /opt/nsm
sudo mkdir /opt/nsm/bro
echo "navigating into the directory" >> /usr/local/src/broinstall.log
cd bro-2.5.4
echo "issuing 'configure' command."
echo "issuing 'configure' command." >> /usr/local/src/broinstall.log
sudo make distclean
sudo ./configure --prefix=/opt/nsm/bro
echo "issuing 'make' command."
echo "issuing 'make' command" >> /usr/local/src/broinstall.log
sudo make
echo "issuing 'make install' command" >> /usr/local/src/broinstall.log
echo "issuing 'make install' command"
sudo make install
cd ..
touch /opt/nsm/bro/bro_install_complete
echo "Bro Install complete! Hit enter to continue or review your console output for any errors above this text."
echo "hit enter to continue...please review console output above to check for any errors during make and make install"
read

