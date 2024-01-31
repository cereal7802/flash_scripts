#/bin/bash

cd ~/klipper
git pull
cp ~/klipper_flash/manta-klipper-firmware-config ~/klipper/.config
make clean
sudo make -j4 flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32g0b1xx_3F00280011504B4633373520-if00
sudo systemctl restart udev
sleep 5
ec=1
ec2=1
while [ $ec -ge 1 ]
do
lsusb|grep "STMicroelectronics STM Device in DFU Mode"; ec=$?  # grab the exit code into a variable so that it can
                         # be reused later, without the fear of being overwritten
if [ $ec -eq 0 ]
then
sudo dfu-util -p 1-1.4 -R -a 0 -s 0x8002000:leave -D /home/cereal/klipper/out/klipper.bin
fi

lsusb|grep "OpenMoko, Inc. stm32g0b1xx";ec2=$?
if [ $ec2 -eq 0 ]
then
break
fi
done


sudo systemctl restart klipper.service
sleep 10
curl --fail -s -X POST 'http://localhost/printer/firmware_restart' -H 'content-type: application/json'
