# BriarIDS

Check out the new Donors page!  I huge thanks to all those who support BriarIDS: [**Donors**](https://github.com/g3tsyst3m/BriarIDS/wiki/Donors)<br>
* Also be sure to check out the [**WIKI**](https://github.com/g3tsyst3m/BriarIDS/wiki) for detailed instructions, demo videos, etc.  I've updated it with plenty of useful information. *

Thank you all for the donations received in the last year.  I do truly appreciate your support!

If BriarIDS is used for educational purposes in the classroom setting (ie. Network Security courses, etc) please send me some feedback if you don't mind, letting me know how it cooperated.  Thanks!
Here's my email: g3tsyst3m@gmail.com

## Introduction

A simple yet effective IDS for the Raspberry PI.  BriarIDS is configured to work with Raspbian and takes advantage of the PyQT GUI frontend for an all-in-one solution that monitors your home network.  Bro is now integrated into the BriarIDS GUI for additional logging options.  Snorby is still a work in progress concerning an automated installation.  Will post progress notes on Wordpress site periodically.  

<img src="https://github.com/g3tsyst3m/BriarIDS/blob/master/images/Briar.PNG?raw=true" style="float:right">

## Why the name BriarIDS?

It's kinda cheesy.  The name comes from the protection Briars and Brambles (Raspberry bushes) give to rabbits when under attack.  
## So how's it different from other IDS solutions?

It's not really.  The key difference is how it's setup.  This is a home network based IDS solution using Suricata that primarily monitors WAN traffic (LAN too if you wanted).  I looked all over the web for a SIMPLE home-based IDS using the PI and getting a network TAP working; I didn't have much luck.  I'll reemphasize that there were Raspberry PI solutions out there, some that were quite amazing.  They just weren't very agreeable with home network-based configurations.  I just wanted a simple command-line solution that's cooperative in a few minutes upon installation.  Snorby and SGUIL and all the other GUI frontends are always awesome secondary add-ons and those will be integrated into BriarIDS shortly.  For now, I just want to provide a simple working IDS that is fairly straight forward and user friendly.

## Why the Raspberry Pi?

Since I wanted to provide the most cost effective and feasible solution for homeowners to protect their network, I knew a Raspberry PI would fit the bill assuming it cooperated.  A PI will run you roughly $40-$60 with a decent SDcard purchased along with it. Next, as we all know, you need a tap interface or some way to get packets into your monitoring interface.  While there are other somewhat reasonably priced solutions out there, I decided to take advantage of what I already had to work with at the house.  That's where Tomato Router firmware comes in.  The IPTables --tee functionality did the job and copied all my WAN packets over to the Raspberry Device with ease.  Once things began cooperating I wanted to share this solution with everyone.  I know I can't be the only one out there who desires to have an easy and affordable solution for their home network security perimeter.

## What PI OS(es) does it run on (that you have personally tested)?

Raspbian, DietPI

## Can this be ported to other OSes?

Yes.  You may need to adjust some of the apt packages depending on the Linux flavor you are using.  I've installed it successfully on Kali Linux (Debian 4.8.15-1kali1 (2016-12-23) x86_64 GNU/Linux). Try it out in a VM running the latest Debian or Ubuntu.  It should cooperate with the exception of the critical-stack agent and libssl.  You will want to download the Intel x86/x64 .deb file versus the .arm deb file currently set to download in the script.  As for ssl, bro-2.5 only currently supports libssl1.0-dev so make sure you have that installed if installing on Kali Linux or other new repos.

## What Router(s) have you tested this with?

Just the Linksys E1200v2 thus far

## What Tomato firmware version are you using?

tomato-E1200v2-NVRAM64K-1.28.RT-N5x-MIPSR2-132-Max.bin

## I have more questions...

I hoped you would.  Check out the wiki and let me know what needs to be added.
