SERIALSSID=$(cat /sys/firmware/devicetree/base/serial-number | tail -c -8)
echo "ssid=FC-$SERIALSSID" >> files/hostapd.conf
sudo touch /etc/hostapd/hostapd.conf
sudo cp -f files/hostapd.conf /etc/hostapd/hostapd.conf
sudo systemctl restart hostapd 
sudo systemctl restart dnsmasq