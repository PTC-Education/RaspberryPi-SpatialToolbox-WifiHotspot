# SpatialToolbox on RaspberryPi, No Coding Required

This repo contains notes and instructions for configuring a WIFI-enabled Raspberry Pi (RPi) to act as a standalone WIFI hotspot and a [node.js](https://nodejs.org/) server running [Vuforia Spatial Toolbox](https://spatialtoolbox.vuforia.com/) (VST)) Edge server. 

The purpose of this is to enable use of Vuforia Spatial Toolbox without the need for coding or connection to an existing WIFI network for less-technical audiences.

Summary:
- Setting up the RPi
- Using the VST on the RPi Hotspot 

## Setting up the RPi

During the setup, it will be helpful to have a keyboard, mouse and monitor connected to the RPi, and have it connected via the ethernet port to an internet-connected router assigning addresses to the RPi via DHCP.

### Create an RPI image:
Download and install from: https://www.raspberrypi.org/software/
- Successfully tested using Debian with Desktop, release 2021-01-11

### Use [these instructions](https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/168-raspberry-pi-hotspot-access-point-dhcpcd-method) to set up a RPi hotspot (with Internet Routing)
- [This tutorial](https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/168-raspberry-pi-hotspot-access-point-dhcpcd-method) explains this process well. Follow the steps to include internet Routing. 

#### Methods used in this tutorial:
- [Hostapd](https://en.wikipedia.org/wiki/Hostapd) enables the wifi card on the RPI to act as a hotspot (access point and WIFI authentication server), allowing users to connect to the RPi
- [DNSmasq](https://en.wikipedia.org/wiki/Dnsmasq) provides DNS services, handling the internet traffic on the hotspot network, serving domain names on the local network 
- [dhcpcd](https://wiki.archlinux.org/index.php/Dhcpcd) is a DHCP client. It assigns IP/Gateway/DNS addresses to network clients and store assigned addressesto avoid conflicts
- [ip forwarding](https://openvpn.net/faq/what-is-and-how-do-i-enable-ip-forwarding-on-linux/) enables the Pi to also connect to the internet, and allows some traffic to bypass the hotspot and go out. this may be turned on or off as explained below
- [ip tables](http://www.intellamech.com/RaspberryPi-projects/rpi_iptables.html) are used with ip forwarding to allow devices connected to the hotspot to access the internet

## Spatial Toolbox for RPi
Download and install from: https://spatialtoolbox.vuforia.com/docs/vuforia-spatial-edge-server/raspberry-pi
- Successfully tested using directions for Raspbian

### Spatial Toolbox Interface
- In order for Spatial Toolbox to work, a hardare interface needs to be added. 
'*** PTC Education team -- can we update the SpatialToolbox-Mac/Windows-Interns folders to just hold the intialize.py and functions.py and addons folders needed to make this work? ***'

#### Spike Prime interface example:
Connect spike, use  /dev/ttyACM0 as port in /vuforia…server/addons/vuf..robotic/interfaces/Spike…/serial.js 

### Changes for Internet-free enviroments
- If the Ethernet calbe is unplugged or internet access is unavailable, the Spatial Toolbox Edge Server will fail
- To resolve this, a change is made in the  *dnsmasq* seeting to route all traffic to the local DNS server, ignoring ip forwarding
- to enable this
-- edit /etc/dnsmasq.conf 
-- at the end, add address=/#/192.168.50.10
- [More information and discussion of alternative methods](https://raspberrypi.stackexchange.com/questions/93883/client-connects-to-node-web-server-once-connected-to-raspberry-pi-access-point) 

### Enable auto start of node server with Pm2:
- [Download, install and configure pm2](https://pm2.keymetrics.io/docs/usage/startup/) to automatically start the node server for the spatial toolbox when the Rpi is turned on. This allows this to run in a headless mode with nothing but the pi turned on

### [Add an Apache server for web interface](https://www.raspberrypi.org/documentation/remote-access/web-server/apache.md), (still not working):
- This might allow us to [use php to start and stop the node server through a browser]((https://serverfault.com/questions/215455/what-causes-php-pages-to-consistently-download-instead-of-running-normally)
- More ideas: (https://unix.stackexchange.com/questions/155150/where-in-apache-2-do-you-set-the-servername-directive-globally) in sudo nano /etc/apache2/apache2.conf to set global servername 
- More: https://stackoverflow.com/questions/14667916/php-not-executing-from-webpage-but-is-fine-from-php-cli-on-a-raspberry-pi
- Use this page to create HTML: https://www.layoutit.com/build - https://bit.ly/2NqpeKU
- Trying to use Php to start node server via: https://stackoverflow.com/questions/1697484/a-button-to-start-php-script-how

