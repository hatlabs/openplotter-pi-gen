#!/bin/bash -e

on_chroot << EOF
sudo -u ${FIRST_USER_NAME} sudo opencpnPostInstall
apt install -y opencpn -t bookworm-backports
EOF

install -m 644 files/opencpn.desktop	"${ROOTFS_DIR}/usr/share/applications/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn"
install -m 644 files/opencpn.conf	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn/"