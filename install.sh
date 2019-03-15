#!/bin/bash

echo placing files...
cp -f g_ether.conf /etc/modprobe.d/g_ether.conf
cp -f usb-gadget-init /usr/bin/usb-gadget-init
mkdir -p /usr/lib/systemd/system && cp -f usb-gadget.service /usr/lib/systemd/system/usb-gadget.service
chmod +x /usr/bin/usb-gadget-init

echo updating system configuration...
cat /boot/config.txt | grep -q "dtoverlay=dwc2" || echo "dtoverlay=dwc2" >> /boot/config.txt
cat /etc/modules | grep -q "dwc2" || echo "dwc2" >> /etc/modules
cat /etc/modules | grep -q "g_zero" || echo "g_zero" >> /etc/modules

echo enabling services...
systemctl enable usb-gadget.service
systemctl enable getty@ttyGS0.service

echo starting services...
systemctl enable usb-gadget.service
systemctl enable getty@ttyGS0.service
