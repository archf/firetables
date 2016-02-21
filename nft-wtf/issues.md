# NFT Behavior

## this doesn't works

```
define udp_dhcp_ports = {bootpc, bootps, dhcpv6-client, dhcpv6-server}
```

```
table inet filter {
  chain input {
    type filter hook input priority 0;
    udp dport {$udp_dhcp_ports, $udp_dhcv6_ports} accept
  }
}
```

## neighter this

define udp_dhcp_ports = {bootpc, bootps, dhcpv6-client, dhcpv6-server}

table inet filter {
  chain input {
    type filter hook input priority 0;
    udp dport {$udp_dhcp_ports, $udp_dhcv6_ports} accept
  }
}

## this does

# allow dhcp renews
#udp dport $udp_dhcp_ports accept

  define udp_dhcv6_ports = {dhcpv6-client, dhcpv6-server}
