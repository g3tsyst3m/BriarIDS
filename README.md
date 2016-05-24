# BriarIDS
A simple yet effective IDS for the Raspberry PI.  
Why the name Briar IDS?
=======================
The name comes from the protection Briars and Brambles (Raspberry bushes) give to rabbits when under attack.  
So how's it different from other IDS solutions?
===============================================
It's not really.  The key difference is how it's setup.  This is a home IDS solution using Suricata.  I looked all over the web for a simple home-based IDS using the PI and didn't have much luck.  I decided to start my own research and work towards a solution...
I wanted to provide the most cost effective and feasible solution for homeowners to protect their network.  A PI will run you roughly $40-$60 with a decent SDcard purchased along with it. Next, as we all know, you need a tap interface or some way to get packets into your monitoring interface.  Well, I couldn't afford the switch I truly wanted to achieve this.  While there are other somewhat reasonably priced solutions out there, I decided to take advantage of what I already had to work with at the house.  That's where Tomato Router firmware comes in.  The rest is history.  After a weekend of researching IPTable entries and Raspberry PI customizations, the solution was ready to test in Beta form.  
What OS does it run on?
=======================
Raspbian - Jessie
Can this be ported to other OSes?
=================================
Yup.  Try it out in A VM running the latest Debian or Ubuntu.  It should cooperate.  If not give me some issue requests to mess around with.
What Router(s) have you tested this with?
=========================================
Just the Linksys E1200v2 thus far
What firmware of Tomato are you using?
======================================
tomato-E1200v2-NVRAM64K-1.28.RT-N5x-MIPSR2-132-Max.bin
