#!/bin/bash

#Installing prereqs
cd ~
echo "Installing prereqs"
sudo apt-get update
sudo apt-get install cmake make gcc g++ flex bison libpcap-dev libgeoip-dev libssl-dev python-dev zlib1g-dev libmagic-dev swig2.0 -y
sudo apt-get install python-pip -y
sudo pip install setuptools
git clone git://git.bro-ids.org/pysubnettree.git
cd pysubnettree
sudo python setup.py install
cd ~
#Install Bro
clear
echo "Installing Bro...go do something entertaining for about 2 hours and when you get back this should be about done ;)"
sudo wget https://www.bro.org/downloads/release/bro-2.4.1.tar.gz
sudo tar -xzf bro-2.4.1.tar.gz
sudo mkdir /opt/nsm
sudo mkdir /opt/nsm/bro
cd bro-2.4.1
sudo ./configure --prefix=/opt/nsm/bro
sudo make
sudo make install
cd ..
sudo rm bro-2.4.1.tar.gz
sudo rm -rf bro-2.4.1/
clear
echo "Bro Install complete.  Now let's setup the Intel feed from CriticalStack."
echo "Browse to this URL and sign up for a free account so you can use their security intel feeds with Bro: https://intel.criticalstack.com/user/sign_up"

echo "Next, Login to your account at intel.criticalstack.com and copy your API key.  Input that below:"
read apikey
cd ~
#Install Critical Stack
clear
echo "Installing Critical Stack Agent"
sudo wget https://intel.criticalstack.com/client/critical-stack-intel-arm.deb
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

