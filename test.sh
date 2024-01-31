ec=1
while [ $ec -ge 1 ]
do
lsusb|grep "STMicroelectronics STM Device in DFU Mode"; ec=$?  # grab the exit code into a variable so that it can
                         # be reused later, without the fear of being overwritten
echo $ec
done

