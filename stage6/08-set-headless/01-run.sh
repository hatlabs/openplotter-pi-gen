#!/bin/bash -e

on_chroot << EOF
	raspi-config nonint do_vnc 0
	raspi-config nonint do_ssh 0
	sudo -u ${FIRST_USER_NAME} nmcli d wifi hotspot ifname wlan0 ssid OpenPlotter password 12345678
EOF