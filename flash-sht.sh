#/bin/bash

cd ~/klipper
git pull
cp ~/klipper_flash/sht36-klipper-firmware-config ~/klipper/.config
make clean
make

python3 ~/klipper/lib/canboot/flash_can.py -u 09b0ebc269fc

sleep 5
sudo systemctl restart klipper.service
sleep 5
curl --fail -s -X POST 'http://localhost/printer/firmware_restart' -H 'content-type: application/json'
