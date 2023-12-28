#!/bin/bash -e

on_chroot << EOF
apt update
apt dist-upgrade -y
apt autoremove -y rp-bookshelf
EOF
