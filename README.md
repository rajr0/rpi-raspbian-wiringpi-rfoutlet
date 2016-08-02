# rpi-raspbian-wiringpi-rfoutlet
================================
-- HOW TO BUILD THE HARDWARE
--
- https://timleland.com/wireless-power-outlets/
- Wiring for 433MHz Wireless Transmitter Module
- #GND #5v #GPIO-17
- Build  433MHz Wireless Receiver and sniff the codes and edit toggle.php

-- HOW TO RUN
--
- AS DAEMON:
++
 docker run -d --name rfoutlet --device /dev/ttyAMA0:/dev/ttyAMA0 --device /dev/mem:/dev/mem --privileged  -p 8888:80  -name rfoutlet rajr/rpi-raspbian-wiringpi-rfoutlet

- INTERACTIVE:
++
 docker run -it --rm --name rfoutlet --device /dev/ttyAMA0:/dev/ttyAMA0 --device /dev/mem:/dev/mem --privileged  -p 8888:80  rajr/rpi-raspbian-wiringpi-rfoutlet /bin/bash -c '/usr/sbin/apache2ctl -D FOREGROUND'

-- TEST COMMAND
--
- gpio readall
- /usr/sbin/apache2ctl -D FOREGROUND

-- TO STOP
--
- docker stop rfoutlet && docker rm rfoutlet

-- CONNECT THRU BROWSER
--
- OPEN IN A BROWSER http://RPIs-ip-address:8888/rfoutlet
