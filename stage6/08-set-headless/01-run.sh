#!/bin/bash -e

#forceHotspot
sed -i "s/forceHotspot = 0/forceHotspot = 1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/openplotter.conf"
sed -i "s/forceHotspot=0/forceHotspot=1/g" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/openplotter.conf"

on_chroot << EOF
	raspi-config nonint do_vnc 0
	raspi-config nonint do_ssh 0
EOF