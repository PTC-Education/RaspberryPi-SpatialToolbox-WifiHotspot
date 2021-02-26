# SpatialToolbox on RaspberryPi, No Coding Required

This repo contains notes and instructions for configuring a WIFI-enabled Raspberry Pi (RPi) to act as a standalone WIFI hotspot and a [node.js](https://nodejs.org/) server running [Vuforia Spatial Toolbox](https://spatialtoolbox.vuforia.com/) (VST)) Edge server. 

The purpose of this is to enable use of Vuforia Spatial Toolbox without the need for coding or connection to an existing WIFI network for less-technical audiences.

Summary:
- Setting up the RPi
- Using the VST on the RPi Hotspot 

## Setting up the RPi

### Create an RPI image:
Download and install from: https://www.raspberrypi.org/software/
- successfully tested using Debian with Desktop, release 2021-01-11

### Use [these instructions](https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/168-raspberry-pi-hotspot-access-point-dhcpcd-method) to set up a RPi hotspot (with Internet Routing)
- [This tutorial](https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/168-raspberry-pi-hotspot-access-point-dhcpcd-method) explains this process well. Follow the steps to include internet Routing. 

#### Methods used in this tutorial:
- [Hostapd](https://en.wikipedia.org/wiki/Hostapd) enables the wifi card on the RPI to act as a hotspot (access point and WIFI authentication server), allowing users to connect to the RPi
- [DNSmasq](https://en.wikipedia.org/wiki/Dnsmasq) provides DNS services, handling the internet traffic on the hotspot network, serving domain names on the local network 
- [dhcpcd](https://wiki.archlinux.org/index.php/Dhcpcd) is a DHCP client. It assigns IP/Gateway/DNS addresses to network clients and store assigned addressesto avoid conflicts
- [ip forwarding](https://openvpn.net/faq/what-is-and-how-do-i-enable-ip-forwarding-on-linux/) enables the Pi to also connect to the internet, and allows some traffic to bypass the hotspot and go out. this may be turned on or off as explained below

Installing Spatial Toolbox for PI
https://spatialtoolbox.vuforia.com/docs/vuforia-spatial-edge-server/raspberry-pi
(used directions for Raspbian)

This worked!

**Added Emun’s traffic light and connected to Kepware on 5480…
But, this requires internet, so can’t do Matt’s test, installing Spike interface. After, had to run:
npm install serialport
and
npm install readline-sync
then in robotic add on, re-ran
npm rebuild
Needed, on Mac, to run system_profiler SPBluetoothDataType  to find bluetooth MAC address of spike
LEGO Spike: 40-BD-32-48-23-61

Connect spike, use  /dev/ttyACM0 as port in /vuforia…server/addons/vuf..robotic/interfaces/Spike…/serial.js for port

added
address=/#/192.168.50.10
to the end of /etc/dnsmasq.conf to redirect all traffic

Enable auto start of node server with Pm2:
https://pm2.keymetrics.io/docs/usage/startup/

Added Apache server for web interface, still not working:
https://www.raspberrypi.org/documentation/remote-access/web-server/apache.md

to enable php running in browser, used this (https://serverfault.com/questions/215455/what-causes-php-pages-to-consistently-download-instead-of-running-normally) and in /etc/apache2/mods-available/php7.3.conf I commented out last lines 

Also used this (https://unix.stackexchange.com/questions/155150/where-in-apache-2-do-you-set-the-servername-directive-globally)
in sudo nano /etc/apache2/apache2.conf to set global servername 

followed third update here:
https://stackoverflow.com/questions/14667916/php-not-executing-from-webpage-but-is-fine-from-php-cli-on-a-raspberry-pi

Used this page to create HTML: https://www.layoutit.com/build - https://bit.ly/2NqpeKU

Trying to use Php to start node server via:
https://stackoverflow.com/questions/1697484/a-button-to-start-php-script-how

