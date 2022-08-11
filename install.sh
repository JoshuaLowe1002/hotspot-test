sudo apt install hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo apt install dnsmasq
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo cp -f /etc/dhcpcd.conf files/dhcpcd.conf
sudo cp -f /etc/sysctl.d/routed-ap.conf files/routed-ap.conf
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo cp -f /etc/dnsmasq.conf files/dnsmasq.conf
sudo rfkill unblock wlan
SERIALSSID=$(cat /sys/firmware/devicetree/base/serial-number | tail -c -8)
echo "ssid=FC-$SERIALSSID" >> files/hostapd.conf
sudo cp -f /etc/hostapd/hostapd.conf files/hostapd.conf
sudo systemctl reboot
