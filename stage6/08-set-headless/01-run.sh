#!/bin/bash -e

echo "10.10.10.1		${HOSTNAME}.local ${HOSTNAME}" >> "${ROOTFS_DIR}/etc/hosts"

cp -rf files/* "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter"
chown -R 1000:1000 "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter"

install -m 644 files/Network/dhcpcd.conf	"${ROOTFS_DIR}/etc/"
install -m 644 files/Network/nftables/nftables.conf	"${ROOTFS_DIR}/etc/"
install -m 644 files/Network/dnsmasq.conf	"${ROOTFS_DIR}/etc/"
install -m 644 files/Network/hostapd/hostapd.conf	"${ROOTFS_DIR}/etc/hostapd/"
rm -f "${ROOTFS_DIR}/lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant"
install -m 644 files/Network/10-wpa_supplicant_wlan9	"${ROOTFS_DIR}/lib/dhcpcd/dhcpcd-hooks/"
on_chroot << EOF
echo 'KERNEL=="usb0", SUBSYSTEMS=="net", RUN+="/bin/bash /home/${FIRST_USER_NAME}/.openplotter/Network/11-openplotter-usb0.sh"' > '/etc/udev/rules.d/11-openplotter-usb0.rules'
EOF
install -m 644 files/Network/udev/rules.d/72-wireless.rules	"${ROOTFS_DIR}/etc/udev/rules.d/"

on_chroot << EOF
systemctl daemon-reload
systemctl unmask hostapd.service
systemctl disable systemd-networkd
systemctl enable dnsmasq
systemctl enable hostapd
systemctl enable vncserver-x11-serviced.service
systemctl enable ssh
EOF