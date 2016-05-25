# BriarIDS
A simple yet effective IDS for the Raspberry PI.  Right now it's simply a shell script but there will be enhancements added very soon to make this more automated and expanded in its capabilities.
Why the name BriarIDS?
=======================
It's kinda cheesy.  The name comes from the protection Briars and Brambles (Raspberry bushes) give to rabbits when under attack.  
So how's it different from other IDS solutions?
===============================================
It's not really.  The key difference is how it's setup.  This is a home network based IDS solution using Suricata that primarily monitors WAN traffic (LAN too if you wanted).  I looked all over the web for a SIMPLE home-based IDS using the PI and getting a network TAP working; I didn't have much luck.  I'll reemphasize that there were Raspberry PI solutions out there, some that were quite amazing.  They just weren't very agreeable with home network-based configurations.  I just wanted a simple command-line solution that's cooperative in a few minutes upon installation.  Snorby and SGUIL and all the other GUI frontends are always awesome secondary add-ons and those will be integrated into BriarIDS shortly.  For now, I just want to provide a simple working IDS that is fairly straight forward and user friendly.
How'd you do it?
================
I decided to start my own research and work towards a solution...
Since I wanted to provide the most cost effective and feasible solution for homeowners to protect their network, I knew a Raspberry PI would fit the bill assuming it cooperated.  A PI will run you roughly $40-$60 with a decent SDcard purchased along with it. Next, as we all know, you need a tap interface or some way to get packets into your monitoring interface.  Well, I couldn't afford the switch I truly wanted to achieve this.  While there are other somewhat reasonably priced solutions out there, I decided to take advantage of what I already had to work with at the house.  That's where Tomato Router firmware comes in.  The rest is history.  After a weekend of researching IPTable entries and Raspberry PI customizations, the solution was ready to test in Beta form.  
What OS does it run on?
=======================
Raspbian - Jessie
Can this be ported to other OSes?
=================================
Yup.  Try it out in a VM running the latest Debian or Ubuntu.  It should cooperate.  If not give me some issue requests to mess around with.
What Router(s) have you tested this with?
=========================================
Just the Linksys E1200v2 thus far
What Tomato firmware version are you using?
======================================
tomato-E1200v2-NVRAM64K-1.28.RT-N5x-MIPSR2-132-Max.bin
I have more questions...
========================
I hoped you would.  Check out the wiki and let me know what needs to be added.
