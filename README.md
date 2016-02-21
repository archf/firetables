# firetables

# Description

`firetables` is a lightweight deny everything dual stack firewall based on nftables.

# Project Status

This project is still at an early stage! But it works. Currently, all used features
are thoses working with `nftables 0.4` as this is the version currently
packaged on OpenWrt. This will be even if `nftables 0.5` is out on Fedora 24 or Ubuntu 16.04 unless you recompile them for the OpenWrt project.

# Design goals

Some of these are not yet reached but:

* Use as much nftables built-in scripting features as possible to allow for atomic operations
* Be portable, it needs to work on any Debian or RedHat derivatives as well as on Openwrt.
* It should have sensible defaults (i.e work as is on you laptop//destkop to protect you on a hostile network)
* It should handle multiple nic-card machine setups as well as single nic setup
* It should be modular
* Favor simplicity and ease of use and configuration over paranoiac setups
* Dual stack as a default (make use of inet family whenerver possible)

# Architecture

`nftables.conf` is invoked and loads nftables firewall tables
according to include directives. This way you can pick the exact bulding blocks
you need and/or renumber the nftables rules to suit your needs and increase
performance.

Each loaded blocks make use of built-in nftables constructs that can be
enriched with detected OS network configuration and variables declared in
`firetables.conf`

On the long term, I wich we would only need to edit the `nftables.conf`

## Project structure

### System files

nftables.conf`: main configuration file
nftables.service`: systemd unit file to start and enable the firewall as a service
`firetables.sh`: script that aims to be invoked from a network startup hook to edit `nftables.conf` before firewall is started ( todo )

### Startup sequence

1. Service invoked by systemd or init V.
3. `nftables.conf` is edited by a script (invoked by hook) and configured according to network environnement.
4. Load building block in numerical order

    00-nft-default-policy
      * these are non interface specific rules
      * all loopback traffic is allowed
      * allow traffic based on connection tracking
      * egress tracking to basic services is allowed based on dport. This is configured in `firewall.conf`
        * dns
        * ntp
        * smtp
        * http
        * https
        * ...
    01-nft-invalid-rules
    05-create-per-nic-chains
      * create an empty chain for each detected nic

    10-nft-default-policy is loaded
      * log traffic that made it so far
      * apply a deny verdict

# Getting Started

## Requirements

You need a kernel >= 3.18. Why?

* This kernel version is the one available on Openwrt Chaos Calmer 15.04.
* Tables and all its content can be deleted.
* **Masquerading** support
* Log and nflog support for ip, ip6, arp and bridge families

See all nftables changes [here](http://wiki.nftables.org/wiki-nftables/index.php/List_of_updates_since_Linux_kernel_3.13)

## Installation

Run:

```bash
./install
```
from where you cloned this repository

# Other ressources

## nftables

<http://wiki.nftables.org/wiki-nftables/index.php/Main_Page>
<https://home.regit.org/netfilter-en/nftables-quick-howto/>
<https://wiki.archlinux.org/index.php/nftables>
<https://wiki.gentoo.org/wiki/Nftables>

## iptables

# Todo

* make load sequence configurable in firetables.conf
* dnat construct
* snat construct

# Pull Requests

Submit your PR!

# Licence

MIT
