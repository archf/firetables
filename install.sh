#!/bin/sh

INSTALL_PATH=/etc

# install firewall
cp -r nftables.d ${INSTALL_PATH}/
cp nftables.conf ${INSTALL_PATH}/nftables.conf

# edit permissions
chown -R root:root ${INSTALL_PATH}/nftables*

# install unit file
# cp nftables.service /lib/systemd/system/nftables.service
# chown root:root /lib/systemd/system/nftables.service
# chmod 644 /lib/systemd/system/nftables.service

# restart service
systemctl restart nftables.service || systemctl start nftables.service
