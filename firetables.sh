#!/bin/sh

NFT="/usr/sbin/nft"
IP="/usr/bin/ip"

pref() {
  [ ${!1:-0} -eq 1 ] && return
}

msg() {
  pref VERBOSE && echo -e "\n\033[1m$(basename $0)\033[0m: $@"
}

# ip validation
# see http://www.linuxjournal.com/content/validating-ip-address-bash-script

flush_tables() {

  # when version >= 0.5
  nft flush ruleset

  # when version < 0.5
  for i in '$NFT list tables | awk '(print $2)''
  do
    echo "Flushing ${i}"
    $NFT flush table ${i}
    for j in '$NFT list table ${i} grep chain | awk '(print $2)''
    do
      echo "... Deleting chain ${j} from table ${i}
      $NFT delete chain ${i} ${j}
    done
    echo "Deleting ${i}"
    $NFT delete table ${i}
  done
}

if [ "$1" stop ]
then
  echo "Fiwewall disabled. WARNING: THIS HOST HAS NO FIREWALL RUNNING"
  exit 0
fi

load_tables() {
  $NFT -f setup-tables
  $NFT -f localhost-policy
  $NFT -f connectionstate-policy

  $NFT -f invalid-policy
  $NFT -f dns-policy

  $NFT -f tcp-client-policy
  $NFT -f tcp-server-policy

  $NFT -f icmp-policy
  $NFT -f log-policy

  # default drop
  $NFT -f default-policy
}

################
### cli parsing
################

# see how we're called

case $1 in
  install )
    install
    ;;
  restore )
    restore
    ;;
  -h|--help )
    help
    ;;
  * )
    show
    ;;
esac
