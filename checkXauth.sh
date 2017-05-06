#!/bin/bash

###########################
# .Xauthority preparations
###########################

ls /etc/profile.d/xauth.sh &>/dev/null

if [ "$?" == "2" ]; then
cat <<EOF > /etc/profile.d/xauth.sh
#!/sbin/bash
export XAUTHORITY=~/.Xauthority
EOF
fi

