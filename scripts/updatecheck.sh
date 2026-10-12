#!/bin/bash

###############################
#check for existence of zenity
############################### 
which zenity &> /dev/null
if [ $? != 0 ] ; then
sudo apt-get install zenity 
fi
