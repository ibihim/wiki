# IPTABLES

"filter" is the default table. It contains the built-in chains INPUT (for packets destined to local sockets), FORWARD (for packets being routed through the box) and OUTPUT (for locally-generated packkets).

"nat" is consulted when a packet that creates a new connection is encountered. It has PREROUTING (for altering packets as soon as they come in) and POSTROUTING (for altering packets as they are about to go out) and INPUT / OUTPUT.

Chain - Rule -> Filter -> What-to-do-on-Match.

## Params:
 - -L: List the rules in a chain for all chains.
 - -P: Change policy on chain to target. Policy is default behavior after all rules applied in chain.
 - -A: Append to chain
 - -D: Delete matching rule from chain
 - -j: This specifies the target of the rule; i.e. what to do if the packet matches it (ACCEPT, DROP and REJECT).
 - -i: Name of an interface via which a packet was received (INPUT, FORWARD and PREROUTING).
 - -o: Name of an interface via which a packet is going to be sent (OUTPUT, FORWARD and POSTROUTING). 
 - -dport: Destination port
 - -p: protocol
 - -m: Loads kernel module.
    - -m state --state: tracks state {ESTABLISHED, RELATED}
 - -I: Insert one or more rules in the selected chain as the given rule number.
 - -t: Change table, e.g. `nat`.

## Default Steps

Hardcore start (everything closed):
- Default policy on `INPUT` should be `DROP`: `iptables -P INPUT DROP`.
- Default policy on `FORWARD` set to `DROP`: `iptables -P FORWARD DROP`.
- Default policy on `OUTPUT` set to `DROP`: `iptables -P OUTPUT DROP`.
- Verify: `ping exmaple.com`, `ping localhost`.

Allow loopback :
 - input: `iptables -A INPUT -i lo -j ACCEPT`
 - output: `iptables -A OUTPUT -o lo -j ACCEPT`
 - Verify: `ping localhost`.

Allow traffic from 80 (HTTP), 443 (HTTPS), 22 (SSH):
 - `iptables -A INPUT -p tcp --dport 80 -j ACCEPT`
 - `iptables -A INPUT -p tcp --dport 443 -j ACCEPT`
 - `iptables -A INPUT -p tcp --dport 22 -j ACCEPT`

Allow response traffic:
 - `iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT`

Allow outgoing traffic:
 - `iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT`
 - `iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT`
 - `iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT`

Allow DNS traffic, move it up in the chain:
 - `iptables -I OUTPUT 2 -p tcp --dport 53 -j ACCEPT`
 - `iptables -I OUTPUT 2 -p udp --dport 53 -j ACCEPT`

Save iptables (otherwise they'll be reseted): `iptables-save > /etc/sysconfig/iptables`.

Optional: 
 - Allow being pinged `iptables -A INPUT -p icmp -j ACCEPT`.

## NAT steps

In order to forward IPv4 traffic `cat /proc/sys/net/ipv4/ip_forward` needs to be set to `1`. 

Otherwise adjust related config:
 - go to directory: `cd /etc/sysctl.d`
 - search for existing forwarding: `grep -r forward .`
 - mostly found in `99-sysctl.conf`. Could be a symbolic link on `../sysctl.conf`
 - add: `net.ipv4.ip_forward = 1`
 - search for options (like ipv6) in `sysctl -a | grep forward`.

Set table:
 - `iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE`
 - Incoming traffic, if related or established: `iptables -A FORWARD -i ens33 -o ens37 -m state --state RELATED,ESTABLISHED -j ACCEPT`
 - Outoing traffic (everything): `iptables -A FORWARD -i ens37 -o ens33  -j ACCEPT`

## Port forwarding

- `iptables -t nat -A PREROUTING -i ens33 -p tcp --dport 2222 -j DNAT --to 10.10.0.20:22`

## Debugigng / Logging

Enable logging by adding log as last rule in the chain:
 - `iptables -A INPUT -j LOG`
 - `iptables -A OUTPUT -j LOG`
 - `cd /var/log/messages`

While trying to fix, during debugging... don't APPEND rules to the chain. Log rule will not let it through.
Restart without saving to reset logging.

Check services using PORTs in `less /etc/services`.
