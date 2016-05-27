echo "Enter your desired monitor interface (eth0, eth1, etc)"
read -p ":" monint
ethtool -K $monint tx off rx off sg off gso off gro off
echo "Making Suricata a background process.  Don't forget to kill it when you are done using it."
echo "You can kill it by doing the following: ps aux | grep suricata"
echo "Next, get the PID (process ID) and do this: kill -9 (thePID)"
sleep 10
/opt/suricata/bin/suricata -c /opt/suricata/etc/suricata/suricata.yaml --af-packet=$monint &
x-terminal-emulator -e "tail -f /var/log/suricata/http.log /var/log/suricata/fast.log"

