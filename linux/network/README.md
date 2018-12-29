# Network

## ip

Don't user `ifconfig` anymore!

- Show ip addresses: `ip address show`.
- Config ip address: `ip address add dev eth0 192.168.4.100/24`, runtime only.
- Link statistics: `ip -s link`

## Troubleshooting

Tools:
 - `ping`: `-f` flood, `-s 4096` stress test.
 - `traceroute`: not that useful anymore.
 - `nmap`: Overview of open ports: `nmap 192.168.4.100`.
 - `arp`: Address resolution protocols; IP <-> MAC.
 - `telnet`: `telnet google.de 80`, enter HTTP protocol GET.
 - `openssl`: connect to https `openssl s_client -connect example.com:443`
 - `tcpdump` / `wireshark`
    - `tcpdump -i eth0 -w catpre.pcap port 22`
 - `ss`

## ss - sockets statistics

Use instead of netstat!
 - `ss -tua`: tcp, udp, all (`-n` numeric, instead of resolve)
 - `ss -ltn`: tcp, no resolve, listening
 - `ss -at dst :443 or dst :80`: web traffic

## nmap

 - `nmap -sn 192.168.4.0/24` scan, network
 - `nmap 192.168.4.207` tries default ports against hosts
 - `nmap -0 192.168.4.100` tries to identify OS
 - `nmap -sL 192.168.178.0/24`, list hosts

## Monitoring

Tools:
 - `iptraf-ng`: 'GUI' Network Traffic Monitor
 - `ntop`: is a service. Runs on :3000. Website hosted on localhost.