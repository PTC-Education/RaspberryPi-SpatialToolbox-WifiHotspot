echo "RPiToolbox - making sure wlan is enabled";
sudo rfkill unblock wlan;
echo "RPiToolbox - installing hostapd";
sudo apt-get install hostapd;
yes | sudo apt-get install hostapd;
echo "RPiToolbox - installing dnsmasq";
sudo apt-get install -y dnsmasq;
echo;
echo;
echo;
echo;
sleep 10;
yes | sudo apt-get install dnsmasq;
echo "RPiToolbox - stopping";
sudo systemctl stop hostapd;
sudo systemctl stop dnsmasq;
echo "RPiToolbox - setting up hotspot";
cd /etc/hostapd;
echo "interface=wlan0
driver=nl80211
ssid=RPiSpatialToolbox
hw_mode=g
channel=6
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=Vuforia123
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP" > hostapd.conf;
cd /etc/default;
echo "RPiToolbox - setting up hostapd";
echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' >> hostapd;
cd;
echo "RPiToolbox - enable hostapd";
sudo systemctl unmask hostapd;
sudo systemctl enable hostapd;
echo "RPiToolbox - set up internet routing through ethernet";
cd /etc;
echo '#RPiHotspot config - Internet
interface=wlan0
bind-dynamic 
domain-needed
bogus-priv
dhcp-range=192.168.50.150,192.168.50.200,255.255.255.0,12h' >> dnsmasq.conf;
cd;
cd /etc;
echo "RPiToolbox - wpa supplicant";
echo 'nohook wpa_supplicant
interface wlan0
static ip_address=192.168.50.10/24
static routers=192.168.50.1' >> dhcpcd.conf;
