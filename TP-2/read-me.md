# TP2 : Ethernet, IP, et ARP

## I. Setup IP

1. pour ma part j'ai mis en place un VM qui cummunique avec mon PC physique 
2. pour prouver que c'est fonctionnel on peut executer la commande ping des deux coté on tape donc dans le terminal de le machine physique la commande: ```ifconfig```ce qui nous permet de récuper l'adresse IP de notre VM qui est ```192.168.128.1``` et celle de mon PC est ```192.168.128.2```maintenant pour prouvé que cela marche il suffit de taper la commande ```ping "adresse ip"``` dans le terminal de chque machine.
dans le terminal du la machine physique cela donne:
```
maximeboizot@MacBook-pro-de-Maxime ~ % ping 192.168.128.1
PING 192.168.128.1 (192.168.128.1): 56 data bytes
64 bytes from 192.168.128.1: icmp_seq=0 ttl=64 time=0.238 ms
64 bytes from 192.168.128.1: icmp_seq=1 ttl=64 time=0.312 ms
64 bytes from 192.168.128.1: icmp_seq=2 ttl=64 time=0.285 ms
64 bytes from 192.168.128.1: icmp_seq=3 ttl=64 time=0.299 ms
64 bytes from 192.168.128.1: icmp_seq=4 ttl=64 time=0.361 ms
64 bytes from 192.168.128.1: icmp_seq=5 ttl=64 time=0.327 ms
64 bytes from 192.168.128.1: icmp_seq=6 ttl=64 time=0.262 ms
64 bytes from 192.168.128.1: icmp_seq=7 ttl=64 time=0.269 ms
64 bytes from 192.168.128.1: icmp_seq=8 ttl=64 time=0.297 ms
64 bytes from 192.168.128.1: icmp_seq=9 ttl=64 time=0.253 ms
64 bytes from 192.168.128.1: icmp_seq=10 ttl=64 time=0.298 ms
^C
--- 192.168.128.1 ping statistics ---
11 packets transmitted, 11 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 0.238/0.291/0.361/0.034 ms
```
et du coter de la VM on tape la même commande mais avec l'adresse IP de mon pc physique on obtient: 
```
maximousse@linux:~$ ping 192.168.128.1
PING 192.168.128.1 (192.168.128.1) 56(84) bytes of data.
64 bytes from 192.168.128.1: icmp_seq=1 ttl=64 time=0.647 ms
64 bytes from 192.168.128.1: icmp_seq=2 ttl=64 time=0.805 ms
64 bytes from 192.168.128.1: icmp_seq=3 ttl=64 time=1.50 ms
64 bytes from 192.168.128.1: icmp_seq=4 ttl=64 time=1.02 ms
64 bytes from 192.168.128.1: icmp_seq=5 ttl=64 time=1.65 ms
^C
--- 192.168.128.1 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4037ms
rtt min/avg/max/mdev = 0.647/1.123/1.647/0.389 ms
```

maintenant on determine le type de paquet ICMP envoyer par wireshark lors du ping de ma VM dans mon terminal.

[la capture wireshark](capture%20ping%20icmp.pcapng)

les types de mes paquets icmp son des request et des reply.

## II. ARP my bro

pour checker la table arp sur mac il s'agit de la mêmecommande que sur windows il faut taper 
```
arp -a
````
et on obtient ceci 

```
maximeboizot@MacBook-pro-de-Maxime ~ % arp -a
? (10.33.16.1) at 74:f2:fa:11:6c:dc on en0 ifscope [ethernet]
? (10.33.16.4) at ac:5f:3e:79:e6:34 on en0 ifscope [ethernet]
? (10.33.16.10) at 8a:55:aa:70:16:19 on en0 ifscope [ethernet]
? (10.33.16.15) at 3e:da:c8:2a:ea:5e on en0 ifscope [ethernet]
? (10.33.16.21) at 7e:17:d1:8a:53:e6 on en0 ifscope [ethernet]
? (10.33.16.44) at 30:3:c8:c3:6:59 on en0 ifscope [ethernet]
? (10.33.16.51) at 82:98:9e:de:b5:41 on en0 ifscope [ethernet]
? (10.33.16.66) at 98:f6:21:8d:1a:33 on en0 ifscope [ethernet]
? (10.33.16.68) at c8:89:f3:ac:3b:d4 on en0 ifscope permanent [ethernet]
? (10.33.16.68) at (incomplete) on bridge100 ifscope [bridge]
? (10.33.16.73) at a2:12:60:6b:b7:9d on en0 ifscope [ethernet]
? (10.33.16.97) at 32:cc:f7:50:67:53 on en0 ifscope [ethernet]
? (10.33.16.112) at 9e:f9:61:57:1:7a on en0 ifscope [ethernet]
? (10.33.16.159) at 84:14:4d:e:5e:b1 on en0 ifscope [ethernet]
? (10.33.16.199) at 4c:3:4f:e7:6a:fd on en0 ifscope [ethernet]
? (10.33.17.16) at (incomplete) on en0 ifscope [ethernet]
? (10.33.17.57) at 4e:35:d9:af:82:97 on en0 ifscope [ethernet]
? (10.33.17.62) at e2:af:c6:c4:ac:22 on en0 ifscope [ethernet]
? (10.33.17.168) at 42:70:74:58:43:37 on en0 ifscope [ethernet]
? (10.33.17.246) at 5a:91:bb:34:e8:e3 on en0 ifscope [ethernet]
? (10.33.17.249) at 8a:bf:9a:ad:8e:39 on en0 ifscope [ethernet]
? (10.33.17.252) at 8:6d:41:c8:96:cc on en0 ifscope [ethernet]
? (10.33.17.255) at 72:5a:f0:e8:6b:42 on en0 ifscope [ethernet]
? (10.33.18.1) at 52:81:b6:2d:ef:b9 on en0 ifscope [ethernet]
? (10.33.18.4) at 3c:a6:f6:20:18:e1 on en0 ifscope [ethernet]
? (10.33.18.7) at 76:b:ad:5f:bd:0 on en0 ifscope [ethernet]
? (10.33.18.9) at da:a0:b6:31:bb:e on en0 ifscope [ethernet]
? (10.33.18.12) at b0:fc:36:e9:27:2b on en0 ifscope [ethernet]
? (10.33.18.14) at 7a:b9:27:7b:98:4e on en0 ifscope [ethernet]
? (10.33.18.15) at 60:6e:e8:b7:8b:66 on en0 ifscope [ethernet]
? (10.33.18.17) at 3c:a6:f6:d:f4:5c on en0 ifscope [ethernet]
? (10.33.18.22) at a4:45:19:19:63:9 on en0 ifscope [ethernet]
? (10.33.18.23) at be:f7:a:a2:55:d7 on en0 ifscope [ethernet]
? (10.33.18.25) at a4:83:e7:7e:1b:b5 on en0 ifscope [ethernet]
? (10.33.18.28) at 9a:7d:f:57:55:77 on en0 ifscope [ethernet]
? (10.33.18.30) at 12:ba:dd:27:6a:d5 on en0 ifscope [ethernet]
? (10.33.18.31) at 8a:9:93:a:16:69 on en0 ifscope [ethernet]
? (10.33.18.34) at f2:1f:de:42:65:57 on en0 ifscope [ethernet]
? (10.33.18.35) at 9a:47:14:7c:8d:cf on en0 ifscope [ethernet]
? (10.33.18.36) at ac:bc:32:bc:43:2f on en0 ifscope [ethernet]
? (10.33.18.37) at a:7:1e:9c:c0:83 on en0 ifscope [ethernet]
? (10.33.18.39) at e:32:ec:7b:8b:87 on en0 ifscope [ethernet]
? (10.33.18.40) at 6:40:3:c2:3b:52 on en0 ifscope [ethernet]
? (10.33.18.44) at 3c:6:30:2b:2e:f on en0 ifscope [ethernet]
? (10.33.18.45) at f2:6b:2:7b:87:c3 on en0 ifscope [ethernet]
? (10.33.18.51) at 4e:98:7e:3a:6b:b4 on en0 ifscope [ethernet]
? (10.33.18.54) at 22:b4:ef:79:5b:51 on en0 ifscope [ethernet]
? (10.33.18.56) at 1e:0:7c:39:a6:3d on en0 ifscope [ethernet]
? (10.33.18.58) at 8c:85:90:b4:ce:2c on en0 ifscope [ethernet]
? (10.33.18.64) at 3c:6:30:0:20:2e on en0 ifscope [ethernet]
? (10.33.18.65) at aa:21:c9:17:ec:72 on en0 ifscope [ethernet]
? (10.33.18.66) at 3a:d2:4d:6a:dc:e6 on en0 ifscope [ethernet]
? (10.33.18.68) at ee:6b:a1:17:e3:b6 on en0 ifscope [ethernet]
? (10.33.18.72) at 18:3e:ef:b9:bb:86 on en0 ifscope [ethernet]
? (10.33.18.74) at a4:83:e7:77:1a:ee on en0 ifscope [ethernet]
? (10.33.18.75) at 30:35:ad:d1:3c:30 on en0 ifscope [ethernet]
? (10.33.18.85) at 30:35:ad:af:17:42 on en0 ifscope [ethernet]
? (10.33.18.92) at 8c:85:90:9f:60:9f on en0 ifscope [ethernet]
? (10.33.18.94) at 22:82:c3:b0:1a:6 on en0 ifscope [ethernet]
? (10.33.18.96) at aa:c0:b0:25:4d:4f on en0 ifscope [ethernet]
? (10.33.18.128) at f6:0:78:55:7b:c7 on en0 ifscope [ethernet]
? (10.33.18.141) at 96:b1:88:1d:79:e5 on en0 ifscope [ethernet]
? (10.33.18.161) at (incomplete) on en0 ifscope [ethernet]
? (10.33.18.168) at ca:c0:74:b5:c1:99 on en0 ifscope [ethernet]
? (10.33.18.174) at 3c:6:30:1f:60:83 on en0 ifscope [ethernet]
? (10.33.18.187) at 2:61:67:dc:76:81 on en0 ifscope [ethernet]
? (10.33.18.188) at 6a:cd:ad:23:d1:3c on en0 ifscope [ethernet]
? (10.33.18.197) at a8:7d:12:54:cf:e6 on en0 ifscope [ethernet]
? (10.33.18.200) at d0:ab:d5:6a:2c:2d on en0 ifscope [ethernet]
? (10.33.18.204) at f8:4d:89:8c:0:24 on en0 ifscope [ethernet]
? (10.33.18.207) at f8:4d:89:7e:8b:4e on en0 ifscope [ethernet]
? (10.33.18.209) at f6:dd:5:5:a5:8c on en0 ifscope [ethernet]
? (10.33.18.211) at 9e:d9:4:a0:c8:5c on en0 ifscope [ethernet]
? (10.33.18.212) at ca:34:13:30:4d:6e on en0 ifscope [ethernet]
? (10.33.18.213) at e:68:24:2e:15:db on en0 ifscope [ethernet]
? (10.33.18.215) at e2:5b:53:6e:95:48 on en0 ifscope [ethernet]
? (10.33.18.216) at 1a:4e:fe:c1:3c:53 on en0 ifscope [ethernet]
? (10.33.18.225) at da:f1:8f:74:1e:8e on en0 ifscope [ethernet]
? (10.33.18.227) at fe:9e:e0:5e:6b:2f on en0 ifscope [ethernet]
? (10.33.18.228) at 16:6e:71:31:ef:cc on en0 ifscope [ethernet]
? (10.33.18.229) at 70:5f:a3:d6:80:95 on en0 ifscope [ethernet]
? (10.33.18.238) at 6:a9:5a:6e:c7:eb on en0 ifscope [ethernet]
? (10.33.19.7) at 3c:22:fb:6b:3e:bc on en0 ifscope [ethernet]
? (10.33.19.10) at 9a:ed:45:7d:f5:55 on en0 ifscope [ethernet]
? (10.33.19.191) at 5e:e1:1f:e2:66:cd on en0 ifscope [ethernet]
? (10.33.19.254) at 0:c0:e7:e0:4:4e on en0 ifscope [ethernet]
? (10.33.19.255) at ff:ff:ff:ff:ff:ff on en0 ifscope [ethernet]
macbook-pro-de-maxime.local (169.254.3.244) at c2:a6:0:3a:30:66 on en7 permanent [ethernet]
macbook-pro-de-maxime.local (169.254.110.74) at 22:d4:24:66:52:64 on en8 permanent [ethernet]
iphone-de-maxime.local (169.254.178.48) at c2:a6:0:40:6e:af on en7 [ethernet]
? (169.254.255.255) at (incomplete) on en0 [ethernet]
? (192.168.80.1) at ca:89:f3:ca:67:64 on bridge100 ifscope permanent [bridge]
mon-super-site.local (192.168.80.129) at (incomplete) on bridge100 ifscope [bridge]
? (192.168.80.255) at ff:ff:ff:ff:ff:ff on bridge100 ifscope [bridge]
? (224.0.0.251) at 1:0:5e:0:0:fb on en0 ifscope permanent [ethernet]
```

on retrouve notre VM a la ligne ou il y a ecrit

```
[bridge]
```

on essaye de manipuler la table arp on utilise donc on va chercher la mac de ma VM dans la table arp on cherche donc l'adresse ip de la VM:

```
(192.168.80.2) at 6a:63:bb:61:90:d2 on bridge100 ifscope [bridge]
```
 mon adresse mac coorespond 


```
sudo arp -a -d
```

ce qui surpime la table arp et donne ceci

```
10.33.16.15 (10.33.16.15) deleted
delete: cannot locate 10.33.16.68
10.33.16.68 (10.33.16.68) deleted
10.33.16.112 (10.33.16.112) deleted
10.33.17.52 (10.33.17.52) deleted
10.33.17.177 (10.33.17.177) deleted
10.33.17.249 (10.33.17.249) deleted
10.33.17.250 (10.33.17.250) deleted
10.33.17.252 (10.33.17.252) deleted
10.33.17.253 (10.33.17.253) deleted
10.33.18.7 (10.33.18.7) deleted
10.33.18.25 (10.33.18.25) deleted
10.33.18.28 (10.33.18.28) deleted
10.33.18.30 (10.33.18.30) deleted
10.33.18.33 (10.33.18.33) deleted
10.33.18.34 (10.33.18.34) deleted
10.33.18.36 (10.33.18.36) deleted
10.33.18.40 (10.33.18.40) deleted
10.33.18.44 (10.33.18.44) deleted
10.33.18.56 (10.33.18.56) deleted
10.33.18.57 (10.33.18.57) deleted
10.33.18.58 (10.33.18.58) deleted
10.33.18.61 (10.33.18.61) deleted
10.33.18.65 (10.33.18.65) deleted
10.33.18.68 (10.33.18.68) deleted
10.33.18.74 (10.33.18.74) deleted
10.33.18.95 (10.33.18.95) deleted
10.33.18.102 (10.33.18.102) deleted
10.33.18.112 (10.33.18.112) deleted
10.33.18.117 (10.33.18.117) deleted
10.33.18.128 (10.33.18.128) deleted
10.33.18.129 (10.33.18.129) deleted
10.33.18.132 (10.33.18.132) deleted
10.33.18.141 (10.33.18.141) deleted
10.33.19.254 (10.33.19.254) deleted
10.33.19.255 (10.33.19.255) deleted
169.254.30.177 (169.254.30.177) deleted
169.254.134.215 (169.254.134.215) deleted
169.254.167.213 (169.254.167.213) deleted
169.254.230.8 (169.254.230.8) deleted
169.254.255.255 (169.254.255.255) deleted
delete: cannot locate 192.168.80.1
192.168.80.255 (192.168.80.255) deleted
224.0.0.251 (224.0.0.251) deleted
maximeboizot@MacBook-pro-de-Maxime ~ % arp -a
? (10.33.16.68) at c8:89:f3:ac:3b:d4 on en0 ifscope permanent [ethernet]
? (10.33.16.112) at 9e:f9:61:57:1:7a on en0 ifscope [ethernet]
? (10.33.19.254) at 0:c0:e7:e0:4:4e on en0 ifscope [ethernet]
? (192.168.80.1) at ca:89:f3:ca:67:64 on bridge100 ifscope permanent [bridge]
```

pour trouver la mac du réseau ynov on cherche l'adresse ip du reseau ynov l'adresse etant 