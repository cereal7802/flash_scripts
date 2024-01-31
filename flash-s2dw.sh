#/bin/bash

cd ~/klipper
git pull
cp ~/klipper_flash/lis2dw-klipper-firmware-config ~/klipper/.config
make clean
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_rp2040_45503571288BFBA8-if00

sleep 5
sudo systemctl restart klipper.service
sleep 5
curl --fail -s -X POST 'http://localhost/printer/firmware_restart' -H 'content-type: application/json'
