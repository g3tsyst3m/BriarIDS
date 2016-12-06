#!/bin/bash
echo "Checking for updates..."
git remote show origin | grep "out of date"
if [ $? == 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   zenity --info --text="An update is available! Updating now!" &> /dev/null
   git pull
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   exit
   else
   clear
   zenity --info --text="All good here.  No updates available at this time" &> /dev/null
   sleep 1
   fi
