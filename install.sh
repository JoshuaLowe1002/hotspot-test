sudo apt update
sudo apt install hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo apt install dnsmasq
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo cp -f files/dhcpcd.conf /etc/dhcpcd.conf
sudo touch /etc/sysctl.d/routed-ap.conf
sudo cp -f files/routed-ap.conf /etc/sysctl.d/routed-ap.conf
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
sudo touch /etc/dnsmasq.conf
sudo cp -f files/dnsmasq.conf /etc/dnsmasq.conf
sudo rfkill unblock wlan
SERIALSSID=$(cat /sys/firmware/devicetree/base/serial-number | tail -c -8)
echo "ssid=FC-$SERIALSSID" >> files/hostapd.conf
sudo touch /etc/hostapd/hostapd.conf
sudo cp -f files/hostapd.conf /etc/hostapd/hostapd.conf
sudo systemctl reboot
