#!/bin/bash

#wipe log to have a fresh version
> /usr/local/src/broinstall.log
echo "Installation log file located here: /usr/local/src/broinstall.log"
#Installing prereqs
cd ~
echo "Installing prereqs"
echo "Installing prereqs" >> /usr/local/src/broinstall.log
sudo apt-get update
sudo apt-get install cmake make gcc g++ flex bison libpcap-dev locate libgeoip-dev libssl-dev python-dev zlib1g-dev libmagic-dev swig -y
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
sudo wget https://www.bro.org/downloads/bro-2.5.tar.gz
echo "issuing the tar command on the file..." >> /usr/local/src/broinstall.log
sudo tar -xzf bro-2.5.tar.gz
echo "creating necessary directories..." >> /usr/local/src/broinstall.log
sudo mkdir /opt/nsm
sudo mkdir /opt/nsm/bro
echo "navigating into the directory" >> /usr/local/src/broinstall.log
cd bro-2.5
echo "issuing 'configure' command."
echo "issuing 'configure' command." >> /usr/local/src/broinstall.log
sudo ./configure --prefix=/opt/nsm/bro
echo "issuing 'make' command."
echo "issuing 'make' command" >> /usr/local/src/broinstall.log
sudo make
echo "issuing 'make install' command" >> /usr/local/src/broinstall.log
echo "issuing 'make install' command"
sudo make install
cd ..
sudo rm bro-2.5.tar.gz
sudo rm -rf bro-2.5/
echo "Bro Install complete. Hit enter to continue or review your console output for any errors above this text."
echo "hit enter to continue...please review console output above to check for any errors during make and make install"
read
clear
echo "let's setup the Intel feed from CriticalStack."
echo "Browse to this URL and sign up for a free account so you can use their security intel feeds with Bro: https://intel.criticalstack.com/user/sign_up"

echo "Next, Login to your account at intel.criticalstack.com and copy your API key.  Input that below:"
read apikey
cd ~
#Install Critical Stack
clear
echo "Installing Critical Stack Agent for Raspberry pi .arm client"
sudo wget https://intel.criticalstack.com/client/critical-stack-intel-arm.deb --no-check-certificate
sudo dpkg -i critical-stack-intel-arm.deb
sudo -u critical-stack critical-stack-intel api $apikey
sudo rm critical-stack-intel-arm.deb
clear
echo "Almost done.  What you will want to do now is to add some feeds.  Since the raspberry pi is limited in its processing power, signing up for too many feeds will overload the unit."
echo "I would suggest signing up for just a few feeds initially, such as 'Phish Tank Intel Feed' and 'Known Tor exit nodes'."

echo "Once you have added your feeds to your sensor, go ahead and pull that info into Bro by issuing the following command:"
echo "sudo -u critical-stack critical-stack-intel pull"

echo "Now, you will want to perform three final changes.  Go to /opt/nsm/bro/etc"
echo "edit Networks.cfg and be sure to add something similar to the following:"
echo "10.0.0.0/8          Private IP space"
echo "192.168.0.0/16      Private IP space"
echo "pubicipgoeshere/32      Public WAN IP space"
echo "Now, edit nodes.cfg and add in your interface, either eth0 or eth1, etc"
echo "finally, start bro.  go to /nsm/opt/bro/bin/ as ROOT and do: ./broctl"
echo "type in 'deploy' which should auto start the application.  Log files will be in /nsm/opt/bro/logs/current for active scans and folder archives for completed scans."
echo "That's it. Congrats!"

