# udpxy-debian

Debian packager for [udpxy](http://gigapxy.com/udpxy-en.html)

`udpxy` is a UDP-to-HTTP multicast traffic relay daemon:
it forwards UDP traffic from a given multicast subscription
to the requesting HTTP client.

## Requirements

    sudo apt install build-essential devscripts fakeroot debhelper
    
On some system the package `dh-systemd` is required too.

## Building the Debian package

    make deb

## Installing the package

    sudo dpkg -i udpxy_1.0.23-12-3_*.deb
    
## Service setup

The package will install `udpxy`, and start it as a service on port `5000`

Systemd is used to control the service:

    systemctl status udpxy

You can edit the default parameters of the service in `/etc/default/udpxy`

The log file of the service is `/var/log/udpxy.log`, and logrotate take care of it.
