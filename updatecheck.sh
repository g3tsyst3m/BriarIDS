#!/bin/bash
echo "Checking for updates..."
git remote show origin | grep "out of date"
if [ $? == 0 ] ; then
   clear
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   zenity --info --text="An update is available! Updating now!"
   git pull
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   sleep 10
   exit
   else
   clear
   zenity --info --text="All good here.  No updates available at this time"
   sleep 10
   fi

