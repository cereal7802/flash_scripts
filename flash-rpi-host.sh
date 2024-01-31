#/bin/bash

cd ~/klipper
git pull
cp ~/klipper_flash/rpi-klipper-process-config ~/klipper/.config
sudo cp ./scripts/klipper-mcu.service /etc/systemd/system/
sudo systemctl enable klipper-mcu.service
make clean
sudo systemctl stop klipper
make flash
sudo systemctl start klipper


sleep 5
sudo systemctl restart klipper.service
sleep 5
curl --fail -s -X POST 'http://localhost/printer/firmware_restart' -H 'content-type: application/json'
