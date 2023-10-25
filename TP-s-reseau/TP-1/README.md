# TP1 : Maîtrise réseau du poste

le come back du reseau !!!

![youhou](img/youhouuuu.gif)

(je le remet ici je suis sous mac)

- [TP1 : Maîtrise réseau du poste](#tp1--maîtrise-réseau-du-poste)
- [I. Basics](#i-basics)
- [II. Go further](#ii-go-further)
- [III. Le requin](#iii-le-requin)




## I. Basics

bon on reprend trankil

on va Déterminer plein de truc a l'ancienne 

en first l'adresse MAC de la carte WiFi :

simple basique 

```
ifconfig 
```

ça affiche toute les carte reseau avec les adresse ip, mac etc...

on va s'epargner la dixaine de carte reseau on prend direct la carte wifi 

```
maximeboizot@MacBook-pro-de-Maxime TP-1 % ifconfig en0                  
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=6460<TSO4,TSO6,CHANNEL_IO,PARTIAL_CSUM,ZEROINVERT_CSUM>
	ether c8:89:f3:ac:3b:d4
	inet6 fe80::81b:427c:3bd8:ccd1%en0 prefixlen 64 secured scopeid 0xf 
	inet 172.20.10.3 netmask 0xfffffff0 broadcast 172.20.10.15
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active

```
donc la on a l'adresse mac 

```
ether c8:89:f3:ac:3b:d4
```

et la ligner inet on recupere l'adresse ip 

pas mal une pierre deux coup 

```
inet 172.20.10.3
```
et pour ce qui ai du masque de sous reseau nous l'avons juste la 

```
netmask 0xfffffff0
```
ici il est au format CIDR

et en notaition decimal cela donnerai quelque chose comme ça

```
255.255.255.240
```

bien pas si rouillé finalement 

pour le deso pas deso 

merci chatGPT 

et voila les resultat

```
Adresse de réseau : 10.33.64.0
Adresse de broadcast : 10.33.79.255
Nombre d'adresses IP disponibles : 4096
```

aller le hostname de notre machine

c'est compliquer 

il faut faire plain de manip relou et tout 

![jedeconne](/img/jedeconne.gif)

on tape juste 
```
maximeboizot@MacBook-pro-de-Maxime ~ % hostname
MacBook-pro-de-Maxime.local
```

magique non 

et puis vraiment c'est ecris la 

```
maximeboizot@MacBook-pro-de-Maxime ~ %
			|		   ici		  |
```
suiiite 

pour la passerelle reseau 

on fait un petit 

```
route get default | grep gateway
```

grep pour filtrer les info pas besoin de tout recuperer juste ce qui nous interesse 

```
maximeboizot@MacBook-pro-de-Maxime ~ % route get default | grep gateway
    gateway: 10.33.79.254
```

et pour l'adresse mac on fait un petit

```
arp -a 
```

```
maximeboizot@MacBook-pro-de-Maxime Desktop % cat result | grep 10.33.79.254 
? (10.33.79.254) at 7c:5a:1c:d3:d8:76 on en0 ifscope [ethernet]
```

bon alors les server dhcp et dns a nous 

bon alors pour le server dhcp on va utiliser la commande 

```
ipconfig getoption en0 server_identifier
```

et cela nous donne 

```
maximeboizot@MacBook-pro-de-Maxime Desktop % ipconfig getoption en0 server_identifier
192.168.0.254
```

ensuite le dns 

alors la command qui va nous interesser est la suivante 

```
scutil --dns
```

et en executant la command on chercher la section "nameserver"
c'est ici que seront repertorier les ips des server dns utiliser pa la machine

```
resolver #1
  nameserver[0] : 192.168.0.254
  nameserver[1] : fd0f:ee:b0::1
  if_index : 15 (en0)
  flags    : Scoped, Request A records, Request AAAA records
  reach    : 0x00020002 (Reachable,Directly Reachable Address)
```

et voila le travail


bon pour la table de routage un petit netstat 

```
maximeboizot@MacBook-pro-de-Maxime Desktop % netstat -rn | grep default
default            192.168.0.254      UGScg                 en0       
```

trooo facile 

![toeasyboy](/img/toeasy.gif)

## II. Go further

bon ce qu'on veux c'est que `b2.hello.vous` cooresponde a l'ip `1.1.1.1``

a ça on le fait avec le fichier hosts

donc go 

on le modifie 

et on ajoute l'ip et le nom 

et tada

```
maximeboizot@MacBook-pro-de-Maxime bin % cat /etc/hosts | grep 1.1.1.1
1.1.1.1         b2.hello.vous
```

et bha mtn plus qu'as verifier avec le fameux `ping`

![pingpong](/img/pingpong.gif)

```
maximeboizot@MacBook-pro-de-Maxime bin % ping b2.hello.vous
PING b2.hello.vous (1.1.1.1): 56 data bytes
64 bytes from 1.1.1.1: icmp_seq=0 ttl=56 time=40.936 ms
64 bytes from 1.1.1.1: icmp_seq=1 ttl=56 time=42.339 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=56 time=41.181 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=56 time=38.733 ms
^C
--- b2.hello.vous ping statistics ---
4 packets transmitted, 4 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 38.733/40.797/42.339/1.304 ms
```

quand on analyse on a ping `b2.hello.vous`et on recois des paquer de `1.1.1.1`

bon pour la video youtube on doit recuper l'ip du server + le port qu'as ouvert le serv rien que pour nous et celui que ma machine a ouvert bien gentillement

![tropmignonleserver](/img/tropmims.gif)

pour cela on fait une capture wireshark que voila 

[🦈 le requin](/capture_yt.pcap)

```
ip du server: 34.120.195.249
le port du server: 443 (https)
eet le port la machine: 58186
```

pour l'ip de www.inove.com ()
j'ai pas pu ping il y avait pas de reseau en 206

![cheh](/img/cheh.jpeg)

je deconne a l'ancienne on ping (de chez moi tjr pas de co en 206)

```
maximeboizot@MacBook-pro-de-Maxime / % ping www.ynov.com
PING www.ynov.com (104.26.11.233): 56 data bytes
64 bytes from 104.26.11.233: icmp_seq=0 ttl=56 time=35.218 ms
64 bytes from 104.26.11.233: icmp_seq=1 ttl=56 time=197.715 ms
64 bytes from 104.26.11.233: icmp_seq=2 ttl=56 time=153.019 ms
64 bytes from 104.26.11.233: icmp_seq=3 ttl=56 time=183.674 ms
64 bytes from 104.26.11.233: icmp_seq=4 ttl=56 time=189.199 ms
^C
--- www.ynov.com ping statistics ---
5 packets transmitted, 5 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 35.218/151.765/197.715/60.192 ms
```

aller l'ip c'est donc `104.16.11.233`

le reverse lookup mtn 

a qui est l'ip `174.43.238.89`

```
maximeboizot@MacBook-pro-de-Maxime / % nslookup 174.43.238.89
Server:		192.168.0.254
Address:	192.168.0.254#53

Non-authoritative answer:
89.238.43.174.in-addr.arpa	name = 89.sub-174-43-238.myvzw.com.

Authoritative answers can be found from:
```
si c'est exat il s'agris de myvzw.com

![test](/img/fautquejelemettent.jpeg)

ensuite on va determiner par combien de machine passe nos paquets quand on va sur `ynov.com` on va utiliser la command `traceroute`

```
maximeboizot@MacBook-pro-de-Maxime Desktop % traceroute www.ynov.com
traceroute: Warning: www.ynov.com has multiple addresses; using 172.67.74.226
traceroute to www.ynov.com (172.67.74.226), 64 hops max, 52 byte packets
 1  10.33.79.254 (10.33.79.254)  3.488 ms  2.955 ms  3.002 ms
 2  145.117.7.195.rev.sfr.net (195.7.117.145)  7.954 ms  2.629 ms  2.303 ms
 3  * * *
 4  196.224.65.86.rev.sfr.net (86.65.224.196)  9.460 ms  6.290 ms  4.918 ms
 5  12.148.6.194.rev.sfr.net (194.6.148.12)  11.800 ms
    68.150.6.194.rev.sfr.net (194.6.150.68)  16.971 ms
    12.148.6.194.rev.sfr.net (194.6.148.12)  14.055 ms
 6  12.148.6.194.rev.sfr.net (194.6.148.12)  13.856 ms
    68.150.6.194.rev.sfr.net (194.6.150.68)  13.222 ms
    12.148.6.194.rev.sfr.net (194.6.148.12)  12.263 ms
 7  141.101.67.48 (141.101.67.48)  14.216 ms  14.153 ms  11.338 ms
 8  141.101.67.54 (141.101.67.54)  11.749 ms
    172.71.132.4 (172.71.132.4)  101.246 ms  11.525 ms
 9  172.67.74.226 (172.67.74.226)  10.691 ms  13.669 ms  11.787 ms
```

et tous cela nous permet de determiner qu'il y a 9 machine qui sont traverser par nos paquets

suiiiite 

l'ip publique de la passerelle ynov 

un petit `curl` ?

```
maximeboizot@MacBook-pro-de-Maxime Desktop % curl ifconfig.me
195.7.117.146 
```

et voila donc l'ip est `195.7.117.146`

bon pour le scan reseau je essayer d'installer nmap avec brew et arp-scan ça ne veux pas brew est peter et je verrai avec toi plus tard la on passe a la suiite

## III. Le requin

![](/img/sniffing.gif)

bien premiere capture un echange arp entre moi et la passerelle 

[click here 🦈](/arp.pcap)

rien de très compliquer on a juste mis un petit filtre `arp` poue afficher uniquement les paquets arp

aller petite requet dns on lance wireshark et on lookup youtube tien

et tadaaaa

[click here 🦈](dns.pcap)

pour ce qui est du filtre un simple dns et tt est bon

et pour le tcp [c'est ici 🦈](/tcp.pcap)

on lance la capture on ouvre safari et up le handshake du trafic et la fin de connexion 

paaarfait 

aller en route pour le prochain tp 

