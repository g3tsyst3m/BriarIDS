#!/bin/bash
echo "Checking for updates..."
git remote show origin | grep "out of date"
if [ $? == 0 ] ; then
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   zenity --info --text="An update is available! Updating now!" &> /dev/null
   git pull
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 5
   clear
   exit
   else
   echo "All good here.  No updates available at this time"
   sleep 1
   fi
