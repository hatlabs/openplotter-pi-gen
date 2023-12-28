#!/bin/bash -e

#touchscreen
sed -i "s/maximize = 0/maximize = 1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/openplotter.conf"
sed -i "s/maximize=0/maximize=1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/openplotter.conf"
sed -i "s/touchscreen = 0/touchscreen = 1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/openplotter.conf"
sed -i "s/touchscreen=0/touchscreen=1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/openplotter.conf"

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config/gtk-3.0"
install -m 644 -o 1000 -g 1000 files/settings.ini "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config/gtk-3.0/"
install -m 644 -o 1000 -g 1000 files/gtk.css "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config/gtk-3.0/"

#backlight
install -m 644 files/backlight-permissions.rules "${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/openplotter-brightness.desktop "${ROOTFS_DIR}/usr/share/applications/"

#opencpn
sed -i "s/MobileTouch = 0/MobileTouch = 1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn/opencpn.conf"
sed -i "s/MobileTouch=0/MobileTouch=1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn/opencpn.conf"
sed -i "s/mobiletouch = 0/mobiletouch = 1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn/opencpn.conf"
sed -i "s/mobiletouch=0/mobiletouch=1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn/opencpn.conf"

on_chroot << EOF
pip3 install rpi_backlight -U
EOF

