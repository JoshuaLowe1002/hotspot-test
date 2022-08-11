sudo apt update
sudo apt install -y libcups2-dev
curl -sL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt install -y nodejs
npm install
(crontab -l 2>/dev/null; echo "@reboot node /home/fulfilmentcrowd/hotspot-test/app.js") | crontab -
sudo apt install -y hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo apt install -y dnsmasq
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo cp -f files/dhcpcd.conf /etc/dhcpcd.conf
sudo touch /etc/sysctl.d/routed-ap.conf
sudo cp -f files/routed-ap.conf /etc/sysctl.d/routed-ap.conf
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
sudo touch /etc/dnsmasq.conf
sudo cp -f files/dnsmasq.conf /etc/dnsmasq.conf
sudo bash -c 'echo "country=GB" >> /etc/wpa_supplicant/wpa_supplicant.conf'
sudo rfkill unblock all

SERIALSSID=$(cat /sys/firmware/devicetree/base/serial-number | tail -c -8)
echo "ssid=FC-$SERIALSSID" >> files/hostapd.conf
sudo touch /etc/hostapd/hostapd.conf
sudo cp -f files/hostapd.conf /etc/hostapd/hostapd.conf
sudo systemctl reboot