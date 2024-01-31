#/bin/bash

cd ~/klipper
git pull
cp ~/klipper_flash/sb2209-klipper-firmware-config ~/klipper/.config
make clean
make

python3 ~/klipper/lib/canboot/flash_can.py -u d462d7069bed

sleep 5
sudo systemctl restart klipper.service
sleep 5
curl --fail -s -X POST 'http://localhost/printer/firmware_restart' -H 'content-type: application/json'
