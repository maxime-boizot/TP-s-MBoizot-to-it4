# Sommaire

- [TP4 SECU : Exfiltration](#tp4-secu--exfiltration)
- [Sommaire](#sommaire)
- [0. Setup](#0-setup)
- [I. Getting started Scapy](#i-getting-started-scapy)
- [II. ARP Poisoning](#ii-arp-poisoning)
- [II. Exfiltration ICMP](#ii-exfiltration-icmp)
- [III. Exfiltration DNS](#iii-exfiltration-dns)

# 0. Setup

on possede deja python

```bash
maximeboizot@MacBook-pro-de-Maxime TP-s-reseau % where python3
/Library/Frameworks/Python.framework/Versions/3.12/bin/python3
/opt/homebrew/bin/python3
/usr/local/bin/python3
/usr/bin/python3
/usr/local/bin/python3
```
on install scapy avec pip3 sur mac (j'ai passer 1h a essayer de l'installer et j'ai trouver que c'était pa pip mais pip3)

et wireshark notre fidele requin lui n'as pas bouger et on va le faire chauffer a l'avance 🦈

# I. Getting started Scapy

bien debutont la souffrance de scapy

🌞 **`ping.py`**

voila [le petit programme](/TP-s-reseau/TP-4/ping.py)

et le pong reçu

```
maximeboizot@MacBook-pro-de-Maxime TP-4 % python3 test.py
WARNING: No IPv4 address found on anpi1 !
WARNING: No IPv4 address found on anpi2 !
WARNING: more No IPv4 address found on anpi0 !
Begin emission:
Finished sending 1 packets.
.*
Received 2 packets, got 1 answers, remaining 0 packets
Pong reçu : QueryAnswer(query=<Ether  dst=34:27:92:67:1e:1e src=c8:89:f3:ac:3b:d4 type=IPv4 |<IP  frag=0 proto=icmp src=192.168.0.24 dst=192.168.0.254 |<ICMP  type=echo-request |>>>, answer=<Ether  dst=c8:89:f3:ac:3b:d4 src=34:27:92:67:1e:1e type=IPv4 |<IP  version=4 ihl=5 tos=0x0 len=28 id=24048 flags= frag=0 ttl=64 proto=icmp chksum=0x9a8a src=192.168.0.254 dst=192.168.0.24 |<ICMP  type=echo-reply code=0 chksum=0xffff id=0x0 seq=0x0 |>>>)
<Results: TCP:0 UDP:0 ICMP:1 Other:0>
```

🌞 **`tcp_cap.py`**

pour le tcp cap voila le programme [click here](/TP-s-reseau/TP-4/tcp_cap.py)

avec evidemment

la sortie 

```bash
maximeboizot@MacBook-pro-de-Maxime TP-4 % python3 tcp_cap.py 
WARNING: No IPv4 address found on anpi1 !
WARNING: No IPv4 address found on anpi2 !
WARNING: more No IPv4 address found on anpi0 !
TCP SYN ACK reçu !
- Adresse IP src : 178.32.154.7
- Adresse IP dst : 10.33.75.254
- Port TCP src : 443
- Port TCP src : 53268
```

🌞 **`dns_cap.py`**

on retouve ici le programme du [dns_cap](/TP-s-reseau/TP-4/dns_cap.py)

et la syntaxe elle fait mal vraiment

on oublie pas l'output

```
maximeboizot@MacBook-pro-de-Maxime TP-4 % python3 dns_cap.py
WARNING: No IPv4 address found on anpi1 !
WARNING: No IPv4 address found on anpi2 !
WARNING: more No IPv4 address found on anpi0 !
Adresse IP de la réponse DNS : 172.67.74.226
```

🌞 **`dns_lookup.py`**

le petit dns lookup [just here](/TP-s-reseau/TP-4/dns_lookup.py)

et voici le resultat

```bash
maximeboizot@MacBook-pro-de-Maxime TP-4 % python3 dns_lookup.py ynov.com
WARNING: No IPv4 address found on anpi1 !
WARNING: No IPv4 address found on anpi2 !
WARNING: more No IPv4 address found on anpi0 !
Begin emission:
Finished sending 1 packets.
...*
Received 4 packets, got 1 answers, remaining 0 packets
dns reçu ! adresse ip :  172.67.74.226
```

# II. ARP Poisoning

🌞 **`arp_poisoning.py`**

le petit arp poissoning que je crois ne marche pas ou pas bien [click here](/TP-s-reseau/TP-4/arp_poisoning.py)

# II. Exfiltration ICMP

🌞 **`icmp_exf_send.py`**

pour ce qui est du send le voila [click here](/TP-s-reseau/TP-4/icmp_exf_send.py)

avec la petite preuve

![petite photo preuve](/TP-s-reseau/TP-4/img/Image%2029-11-2023%20à%2011.40.jpg)

🌞 **`icmp_exf_receive.py`**

le receive [just here](/TP-s-reseau/TP-4/icmp_exf_receive.py)