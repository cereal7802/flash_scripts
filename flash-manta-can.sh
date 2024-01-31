#/bin/bash

cd ~/klipper
git pull
cp ~/klipper_flash/manta-klipper-firmware-config-2.0 ~/klipper/.config
make clean
make -j4
sudo python3 ~/klipper/lib/canboot/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u b2546f01f6a4
sudo dfu-util -a 0 -D ~/klipper/out/klipper.bin --dfuse-address 0x08000000:force:mass-erase -d 0483:df11
sudo make flash FLASH_DEVICE=0483:df11

sleep 5
sudo systemctl restart klipper.service
sleep 5
curl --fail -s -X POST 'http://localhost/printer/firmware_restart' -H 'content-type: application/json'
