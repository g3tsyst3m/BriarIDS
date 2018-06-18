#!/bin/bash
echo "installing python requests module"
pip install requests
echo "creating nsm log directory in /var/log"
mkdir /var/log/nsm
 
OTX_PATH="/opt/nsm/bro/share/bro/policy/bro-otx"

# Download connector
echo
echo "Downloading Bro/OTX Connector ..."
echo
cd /opt/nsm/bro/share/bro/policy
if [ ! -d bro-otx ]; then
	git clone https://github.com/hosom/bro-otx
else
	echo "Bro-OTX directory already exists!"
fi
cd bro-otx
if [ -d scripts ]; then
	cp -av scripts/* .
	rm -rf scripts
fi 

# Get APIKEY
echo
echo "Please provide an Alienvault OTX API key! [ENTER]:"
echo "(Input field is hidden)"
echo
read -s APIKEY

# Configure connector
echo "Configuring Bro OTX Connector..."
echo
if [ -f $OTX_PATH/bro-otx.conf ]; then
	sed -i "s|api_key.*|api_key = $APIKEY|" $OTX_PATH/bro-otx.conf
	sed -i "s|outfile.*|outfile = $OTX_PATH/otx.dat|" $OTX_PATH/bro-otx.conf
fi 
if [ -f $OTX_PATH/bro-otx.py ];then
	sed -i "s|default='bro-otx.conf'|default='$OTX_PATH/bro-otx.conf'|" $OTX_PATH/bro-otx.py
fi
 
# Add to local.bro
cp /opt/nsm/bro/share/bro/site/local.bro /opt/nsm/bro/share/bro/site/local.bro.bak 
cat << EOF >> /opt/nsm/bro/share/bro/site/local.bro
 
# Load Bro OTX Pulses
@load bro-otx
EOF
 
# Run Pulse retrieval script for first time
echo "Pulling OTX Pulses..."
echo
if [ -f $OTX_PATH/bro-otx.py ];then
	/usr/bin/python $OTX_PATH/bro-otx.py
fi

# Add cron job
echo "Adding cron job...will run hourly to pull new pulses"
echo
cat << EOF > /etc/cron.d/bro-otx
# /etc/cron.d/bro-otx
#
# crontab entry to manage Bro OTX pulse updates
 
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
 
0 * * * * root python $OTX_PATH/bro-otx.py >> /var/log/nsm/bro-otx.log 2>&1
EOF

sudo sed -i "\$agoogle.com	Intel::DOMAIN	Test-Google-Intel	https://google.com	T" /opt/nsm/bro/share/bro/policy/bro-otx/otx.dat

echo "done!  now starting bro with new intel feeds"
echo "i've added a line to your otx.dat file so you can test to make sure your intel feeds were loaded successfully"
echo "simply issue a curl google.com request and check your /opt/nsm/bro/logs/current directory for an intel.log file"
echo "if you see that log file, then that confirms everything is working as expected!"
/opt/nsm/bro/bin/broctl deploy
