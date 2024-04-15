#!/bin/bash -e

# Install device tree compiler on the build container
apt-get update
apt-get install -y device-tree-compiler

# compile the device tree overlay file
dtc -@ -I dts -O dtb -o files/sc16is752-spi1-cs26.dtbo files/sc16is752-spi1-cs26-overlay.dts

# Copy the compiled device tree overlay file to the boot partition
install -m 644 files/sc16is752-spi1-cs26.dtbo "${ROOTFS_DIR}/boot/firmware/overlays/"

if ! grep -q "dtoverlay=mcp2515-can0" "${ROOTFS_DIR}/boot/firmware/config.txt"; then
    # Append the config.txt file snippet to the original file
    cat files/config.txt.part >> "${ROOTFS_DIR}/boot/firmware/config.txt"
fi

# Install the can0 network interface file
install -m 644 files/can0 "${ROOTFS_DIR}/etc/network/interfaces.d/can0"

# Install the gpsd configuration file
install -m 644 files/gpsd "${ROOTFS_DIR}/etc/default/gpsd"

# Install Signal K config file
install -m 644 -o 1000 -g 1000 files/settings.json "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.signalk/settings.json"
