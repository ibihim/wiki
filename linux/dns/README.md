# DNS

`/etc/resolv.conf` - DNS resolver: identifies DNS name server
`/etc/nsswitch.conf` - Sets priority where to look first
`/etc/hosts` - hostname ip mapping from file
`/etc/resolv.conf` - temporary changes. Will be overwritten
`/etc/sysconfig/network-scripts/ifcfg-eth0` - long term solutions

## unbound - caching
`/etc/unbound`:
 - interface: set to `0.0.0.0`, otherwise only localhost
 - access-control: `192.168.178.0/24 allow`, otherwise no one has access
 - forward-zone: `name: "."`, `forward-addr: 192.168.4.250`, forwards everything to 192.168.4.250

## firewall
Open port 53:

    - `iptables -A INPUT -p udp --dport 53 -j ACCEPT`
    - `iptables -A INPUT -p tcp --dport 53 -j ACCEPT`
    - `iptables -A OUTPUT -p udp --sport 53 -j ACCEPT`
    - `iptables -A OUTPUT -p tcp --sport 53 -j ACCEPT`

    - `iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT`

