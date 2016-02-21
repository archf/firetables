#!/bin/sh

INSTALL_PATH=/etc

# install firewall
cp -r nftables.d ${INSTALL_PATH}/
cp nftables.conf ${INSTALL_PATH}/nftables.conf

# edit permissions
chown -R root:root ${INSTALL_PATH}/nftables*

# install unit file

if [ ! -f '/lib/systemd/system/nftables.service' ]; then
  /usr/bin/cp nftables.service /lib/systemd/system/nftables.service
  /usr/bin/chown root:root /lib/systemd/system/nftables.service
  /usr/bin/chmod 644 /lib/systemd/system/nftables.service
fi

# restart service
systemctl restart nftables.service || systemctl start nftables.service
