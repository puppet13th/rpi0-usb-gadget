#!/bin/bash

echo placing files...
cp g_ether.conf /etc/modprobe.d/g_ether.conf
cp usb-gadget-init /sbin/usb-gadget-init
cp usb-gadget.service /etc/systemd/system/usb-gadget.service
chmod +x /sbin/usb-gadget-init

echo updating system configuration...
cat /boot/config.txt | grep -q "dtoverlay=dwc2" || echo "dtoverlay=dwc2" >> /boot/config.txt
cat /etc/modules | grep -q "g_zero" || echo "g_zero" >> /etc/modules

echo enabling services...
systemctl enable usb-gadget.service
systemctl enable getty@ttyGS0.service

echo starting services...
systemctl enable usb-gadget.service
systemctl enable getty@ttyGS0.service
