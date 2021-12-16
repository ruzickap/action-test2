#!/bin/bash -eux

DEVICE="sda"

lsblk --output NAME,MODEL,MODEL | grep ${DEVICE}

read -r -p "Press enter to remove everything from ${DEVICE} !!!"

zcat ./*raspios*.zip | sudo dd of=/dev/${DEVICE} bs=4M
sudo partprobe /dev/${DEVICE}

MYTMP=$(mktemp --directory)
sudo mount /dev/${DEVICE}1 "${MYTMP}"
sudo touch "${MYTMP}/ssh"
sudo cp ~/Documents/owner.txt "${MYTMP}/"
sudo umount "${MYTMP}"

sudo mount "/dev/${DEVICE}2" "${MYTMP}"
sudo bash -c "cat >> ${MYTMP}/etc/dhcpcd.conf" << EOF
interface eth0
static ip_address=192.168.1.2/24
static routers=192.168.1.1
static domain_name_servers=1.1.1.1
EOF
sudo cp ~/Documents/owner.txt "${MYTMP}/"
sudo umount "${MYTMP}"
