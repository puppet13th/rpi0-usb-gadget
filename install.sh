#!/bin/bash

echo placing files...
cmp -s g_ether.conf /etc/modprobe.d/g_ether.conf
if [ $? -eq 1 ]
  then
  echo updating /etc/modprobe.d/g_ether.conf
  cp -f g_ether.conf /etc/modprobe.d/g_ether.conf
fi
cmp -s usb-gadget-init /usr/bin/usb-gadget-init
if [ $? -eq 1 ]
  then
  echo updating /usr/bin/usb-gadget-init
  cp -f usb-gadget-init /usr/bin/usb-gadget-init
fi
cmp -s usb-gadget.service /usr/lib/systemd/system/usb-gadget.service
if [ $? -eq 1 ]
  then
  echo updating /usr/lib/systemd/system/usb-gadget.service
  mkdir -p /usr/lib/systemd/system && cp -f usb-gadget.service /usr/lib/systemd/system/usb-gadget.service
  chmod +x /usr/bin/usb-gadget-init
fi

echo updating system configuration...
grep -q "dtoverlay=dwc2" /boot/config.txt|| {
echo "dtoverlay=dwc2" >> /boot/config.txt
rebootneed=1
}
grep -q "dwc2" /etc/modules|| echo "dwc2" >> /etc/modules

echo enabling services...
systemctl enable usb-gadget.service
if [ ! $rebootneed -eq 1 ]
  then
  echo type "systemctl enable usb-gadget.service" to enable service
  else
  echo "system reboot required!"
fi
