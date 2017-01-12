#!/bin/bash

function selecter
{
clear
echo "Choose an option from the list below"
echo "===================================="
echo "1. Install Bro"
echo "2. Configure Bro"
echo "3. Configure Intel-Critical-Stack Agent"
echo "4. Start Bro"
echo "5. Stop Bro"
echo "6. Check Bro Status"
echo "7. Show captured files"
echo "8. Exit"
echo -n ":"
read choice

if [ -z "$choice" ]; then
echo "Uh oh...Looks like you forgot to make a choice"
sleep 3
fi

if [[ $choice == "1" ]]; then
sudo ./bro-installer.sh
fi


if [[ $choice == "2" ]]; then
echo "Please enter your desired monitoring interface below (eth0, wlan0, etc):"
echo -n ":"
read monint
echo "Adding monitor interface to node.cfg"
sudo sed -i '/interface=/,+1 d' /opt/nsm/bro/etc/node.cfg
sudo sed -i '/type=standalone/a interface='$monint /opt/nsm/bro/etc/node.cfg
echo "Ok monitor interface is set."
echo "Checking WAN IP information..."
grep Public /opt/nsm/bro/etc/networks.cfg
if [ $? != 0 ] ; then
echo "Please enter your WAN ip below (hint: you can go to ipchicken.com to grab it):"
echo -n ":"
read wanip
echo "Adding in WAN ip to networks.cfg"
sed -i "\$a$wanip/32      Public WAN IP" "/opt/nsm/bro/etc/networks.cfg"
echo "Done."
else
echo "You've already added in your WAN IP.  Would you like to add in a new WAN IP?"
echo "y or n?"
echo -n ":"
read choice2
if [[ $choice2 == "y" ]]; then
echo "updating WAN IP info..."
sudo sed -i '/Public/,+1 d' /opt/nsm/bro/etc/networks.cfg
sed -i "\$a$wanip/32      Public WAN IP" "/opt/nsm/bro/etc/networks.cfg"
else
echo "ok leaving as is."
fi
fi

sudo /opt/nsm/bro/bin/broctl install
echo "ok done updating bro configuration items.  You should be all set to go."
sleep 3
fi

if [[ $choice == "3" ]]; then
sudo -u critical-stack critical-stack-intel config --set bro.include.path=/opt/nsm/bro/share/bro/site/local.bro
sudo -u critical-stack critical-stack-intel config --set bro.broctl.path=/opt/nsm/bro/bin/broctl
sudo -u critical-stack critical-stack-intel config --set bro.path=/opt/nsm/bro/bin/bro
sudo chmod -R 777 /opt/nsm/bro/share/bro/site/local.bro
sudo chown critical-stack:critical-stack /etc/sudoers.d/99-critical-stack
sudo -u critical-stack critical-stack-intel pull
sudo chown root:root /etc/sudoers.d/99-critical-stack
echo "Done!  Your intel critical stack configuration should be good to go now."
sleep 3
fi

if [[ $choice == "4" ]]; then
sudo /opt/nsm/bro/bin/broctl start
fi

if [[ $choice == "5" ]]; then
sudo /opt/nsm/bro/bin/broctl stop
fi

if [[ $choice == "6" ]]; then
sudo /opt/nsm/bro/bin/broctl status
sleep 5
fi

if [[ $choice == "7" ]]; then
ls /opt/nsm/bro/logs/current
sleep 5
fi

if [[ $choice == "8" ]]; then
exit
fi
selecter
}
selecter

