#!/bin/bash

vtotlocation=$( locate Vtotalcheck.py )
echo -e "\033[0;33m"
echo "Scanning for .exe files..."
scanner=$( grep -He 'FILENAME:.*\.exe' /var/log/suricata/files/*.meta )
if [[ $scanner == *".exe"* ]]; then
echo -e "\033[32m discovered .exe file(s)! "
exe_catcher=$( echo $scanner | egrep -o 'file.[[:digit:]]{1,3}' )
echo -e "\033[1;33m"
for listy1 in $exe_catcher; do
echo "File location and name:" /var/log/suricata/files/$listy1
echo file details below:
echo "=================="
echo ""
cat /var/log/suricata/files/$listy1.meta;
echo ""
#echo $vtotlocation
#python $vtotlocation /var/log/suricata/files/$listy1
done
else
echo -e "\033[0;34m no .exe files discovered..."
fi

echo -e "\033[0;33m"
echo "Scanning for .php files..."
scanner=$( file --mime /var/log/suricata/files/* | grep text/x-php )
if [[ $scanner == *"x-php"* ]]; then
echo -e "\033[32m discovered .php file(s)! "
php_catcher=$( echo $scanner | egrep -o 'file.[[:digit:]]{1,3}' )
echo -e "\033[1;33m"
for listy2 in $php_catcher; do
echo "File location and name:" /var/log/suricata/files/$listy2
echo file details below:
echo "=================="
echo ""
cat /var/log/suricata/files/$listy2.meta;
echo ""
#python $vtotlocation /var/log/suricata/files/$listy2
done
else
echo -e "\033[0;34m no .php files discovered..."
fi

echo -e "\033[0;33m"
echo "Scanning for .zip files..."
scanner=$( grep -He 'FILENAME:.*\.zip' /var/log/suricata/files/*.meta )
if [[ $scanner == *".zip"* ]]; then
echo -e "\033[32m discovered .zip file(s)! "
zip_catcher=$( echo $scanner | egrep -o 'file.[[:digit:]]{1,3}' )
echo -e "\033[1;33m"
for listy3 in $zip_catcher; do
echo "File location and name:" /var/log/suricata/files/$listy3
echo file details below:
echo "=================="
echo ""
cat /var/log/suricata/files/$listy3.meta;
echo ""
#python $vtotlocation /var/log/suricata/files/$listy3
done
else
echo -e "\033[0;34m no .zip files discovered..."
fi

echo -e "\033[0;33m"
echo "Scanning for .rar files..."
scanner=$( file --mime /var/log/suricata/files/* | grep application/x-rar )
if [[ $scanner == *"x-rar"* ]]; then
echo -e "\033[32m discovered .rar file(s)! "
rar_catcher=$( echo $scanner | egrep -o 'file.[[:digit:]]{1,3}' )
echo -e "\033[1;33m"
for listy4 in $rar_catcher; do
echo "File location and name:" /var/log/suricata/files/$listy4
echo file details below:
echo "=================="
echo ""
cat /var/log/suricata/files/$listy4.meta;
echo ""
#python $vtotlocation /var/log/suricata/files/$listy4
done
else
echo -e "\033[0;34m no .rar files discovered..."
fi

