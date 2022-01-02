#!/usr/bin/env bash

set -euxo pipefail

DEVICE="mmcblk0"

wget -c https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-11-08/2021-10-30-raspios-bullseye-armhf-lite.zip

cat > owner.txt << EOF
Petr Ruzicka

petr.ruzicka@gmail.com

Czech Republic
EOF

lsblk --output NAME,MODEL,MODEL | grep ${DEVICE}

umount /run/media/liveuser/boot /run/media/liveuser/rootfs || true

# read -r -p "Press enter to remove everything from ${DEVICE} !!!"

zcat ./*raspios*.zip | sudo dd of=/dev/${DEVICE} bs=4M conv=fsync status=progress
sudo partprobe /dev/${DEVICE}

MYTMP=$(mktemp --directory)
sudo mount /dev/${DEVICE}p1 "${MYTMP}"
sudo touch "${MYTMP}/ssh"
sudo cp owner.txt "${MYTMP}/"
sudo umount "${MYTMP}"

sudo mount "/dev/${DEVICE}p2" "${MYTMP}"
sudo bash -c "cat >> ${MYTMP}/etc/dhcpcd.conf" << EOF
interface eth0
static ip_address=192.168.1.2/24
static routers=192.168.1.1
static domain_name_servers=1.1.1.1
EOF
sudo cp owner.txt "${MYTMP}/"
sudo umount "${MYTMP}"
sudo sync
