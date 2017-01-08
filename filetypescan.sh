#!/bin/bash
clear
echo "========================================================================================"
echo "A file scanning utility for BriarIDS to use alongside Suricata"
echo "Goal: Help locate all potentially malicious files captured via the file extract feature"
echo "Note: Displays .exe, .php, and .zip file information that has been discovered by default"
echo "========================================================================================"

#checking for virustotal API key

ls /opt/suricata/etc/suricata/Vtotalapi.key 2> /dev/null
if [ $? != 0 ] ; then
   clear
   zenity --info --text="It doesn't look like you have added your virustotal API key yet.  Let's add that now" &> /dev/null
   YOUR_API_KEY=$(zenity --entry --entry-text="[VTOTAL_API_KEY]" --text="Please enter your VTOTAL API KEY below" 2> /dev/null)
   echo $YOUR_API_KEY > /opt/suricata/etc/suricata/Vtotalapi.key
   else
   clear
   echo "API key found!  Don't forget to check the github wiki on how to configure file extraction suricata feature before using this add-on.  This will be quite lackluster otherwise.  Ok loading program now..."
   sleep 1
   fi


zenity --info --text="Current available options: .exe, .php, and .zip/.rar files. NOTE: .php will scan every php file collected from all websites browsed so use at your own risk" &> /dev/null
selection=$( zenity --forms --title "Select files to scan" --text "Filetype Selection" --add-combo "Choose a filetype to scan below" --combo-values ".exe|.php|.zip|.rar|ALL" 2> /dev/null )
vtotlocation=$( locate Vtotalcheck.py )
if [[ $selection == ".exe" ]] ; then
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy1/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy1" filetypescan_part2.sh
elif [[ $selection == ".php" ]] ; then
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy2/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy2" filetypescan_part2.sh
elif [[ $selection == ".zip" ]] ; then
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy3/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy3" filetypescan_part2.sh
elif [[ $selection == ".rar" ]] ; then
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy4/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy4" filetypescan_part2.sh
elif [[ $selection == "ALL" ]] ; then
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy1/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy1" filetypescan_part2.sh
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy2/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy2" filetypescan_part2.sh
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy3/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy3" filetypescan_part2.sh
sed -i "/\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy4/c\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy4" filetypescan_part2.sh
elif [[ $? == 1 ]] ; then
echo "No filetype selected...defaulting to simply displaying the file information found."
fi

./filetypescan_part2.sh
sed -i "/\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy1/c\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy1" filetypescan_part2.sh
sed -i "/\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy2/c\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy2" filetypescan_part2.sh
sed -i "/\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy3/c\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy3" filetypescan_part2.sh
sed -i "/\python \$vtotlocation \/var\/log\/suricata\/files\/\$listy4/c\#python \$vtotlocation \/var\/log\/suricata\/files\/\$listy4" filetypescan_part2.sh
