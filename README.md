# udpxy-debian

Debian packager for [udpxy](http://www.udpxy.com/)

## Requirements

    sudo apt install build-essential

## Building the Debian package

    make deb

## Installing the package

    sudo dpkg -i udpxy_1.0.23-12-1_*.deb
    
## Setup

The package will install the `udpxy` program and start it on port `5000`

Systemd is used to control the service:

    systemctl status udpxy

You can edit the default parameters of the service in `/etc/default/udpxy`

The log file of the service is `/var/log/udpxy.log`, and logrotate take care of it.
