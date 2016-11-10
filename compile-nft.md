# Install requirements

## On fedora

s dnf install bison-devel flex-devel libmnl-devel libnftnl-devel readline-devel gmp-devel bison flex docbook2X docbook-utils

## On ubuntu

## Alternatively you can build required librairies

see https://wiki.nftables.org/wiki-nftables/index.php/Building_and_installing_nftables_from_sources

# Prepare

./autogen.sh
./configure --prefix=/ --datarootdir=/usr/share

# Compile and install

make
make install


