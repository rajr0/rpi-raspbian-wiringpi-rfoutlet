FROM resin/rpi-raspbian:jessie
MAINTAINER RajR

# Install dependencies
RUN apt-get update && apt-get install -y \
    git-core \
    build-essential \
    gcc \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    apache2 \
    php5 libapache2-mod-php5 \
    vim \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pyserial
RUN git clone git://git.drogon.net/wiringPi
RUN cd wiringPi && ./build
RUN pip install wiringpi2

# Install rfoutlet
RUN git clone https://github.com/timleland/rfoutlet.git /var/www/html/rfoutlet
RUN chown root.root /var/www/html/rfoutlet/codesend
RUN chmod 4755 /var/www/html/rfoutlet/codesend

COPY toggle.php /var/www/html/rfoutlet/toggle.php

# Define working directory
WORKDIR /var/www/html/rfoutlet/

# Expose apache.
EXPOSE 80

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

###############################################################################
###-- HOW TO BUILD THE HARDWARE
## https://timleland.com/wireless-power-outlets/
## Wiring for 433MHz Wireless Transmitter Module
## #GND #5v #GPIO-17

### HOW TO RUN
## ===AS DAEMON 
# docker run -d --name rfoutlet --device /dev/ttyAMA0:/dev/ttyAMA0 --device /dev/mem:/dev/mem --privileged  -p 8888:80  -name rfoutlet rajr/rpi-raspbian-wiringpi-rfoutlet

## ===INTERACTIVE
# docker run -it --rm --name rfoutlet --device /dev/ttyAMA0:/dev/ttyAMA0 --device /dev/mem:/dev/mem --privileged  -p 8888:80  rajr/rpi-raspbian-wiringpi-rfoutlet /bin/bash -c '/usr/sbin/apache2ctl -D FOREGROUND'
## ===TEST COMMAND
# gpio readall
# /usr/sbin/apache2ctl -D FOREGROUND
## ===TO STOP
# docker stop rfoutlet && docker rm rfoutlet

### CONNECT THRU BROWSER
# OPEN IN A BROWSER http://<RPI's-ip-address>:8888/rfoutlet
