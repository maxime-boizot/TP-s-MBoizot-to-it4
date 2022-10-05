# TP 1 réseau: BOIZOT Maxime

## première partie: Exploration locale en solo

## 1. Affichage d'informations sur la pile TCP/IP locale:

### Avec la terminal

A - pour trouver l'adresse IP de mon ordinateur j'ai taper la commande 

`ifconfig`

on cherche notre carte reseau wifi parmi toute les cartes reseau.

ma carte reseau donc coorespond a cela : 

```
en0:flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500	                        
options=6463<RXCSUM,TXCSUM,TSO4,TSO6,CHANNEL_IO,PARTIAL_CSU M,ZEROINVERT_CSUM>
    ether c8:89:f3:ac:3b:dether c8:89:f3:ac:3b:d`4
    inet6 fe80::1c78:630b:902d:f156%en0 prefixlen 64 secured scopeid 0xe 
	inet 10.33.16.43 netmask 0xfffffc00 broadcast 10.33.19.255
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
```
    

mon adresse IP coorespond a la ligne inet donc mon adresse ip est 10.33.16.43 et mon adresse mac est c8:89:f3:ac:3b:d4
on l'obtien toujours avec la même commande dans la même carte a la ligne ether.

pour ce qui est de la carte ethernet je n'en possede pas car ne possedant pas sur mon ordinateur je n'ai donc pas de carte reseau pour les ports ethernet.

2) pour ce qui du gateway de mon reseau personnel j'ai taper la commande suivante dans mon terminal: 

```
netstat -nr
```

ce qui permet d'obtenir un suite une suite de ligne mais nous allons nous pencher sur la partie nommé internet 

```
Internet:
Destination        Gateway            Flags           Netif Expire
default            192.168.0.254      UGScg             en0       
127                127.0.0.1          UCS               lo0       
127.0.0.1          127.0.0.1          UH                lo0       
169.254            link#14            UCS               en0      !
192.168.0          link#14            UCS               en0      !
192.168.0.11       58:d3:49:15:f6:d8  UHLWIi            en0    402
192.168.0.12       42:2d:15:e6:f5:ae  UHLWI             en0    158
192.168.0.19       42:bc:e7:d1:c3:8   UHLWIi            en0     71
192.168.0.22/32    link#14            UCS               en0      !
192.168.0.23       82:46:eb:4e:8:ac   UHLWI             en0     71
192.168.0.35       c2:d2:50:7e:32:26  UHLWIi            en0   1148
192.168.0.254/32   link#14            UCS               en0      !
192.168.0.254      34:27:92:67:1e:1e  UHLWIir           en0   1168
192.168.0.255      ff:ff:ff:ff:ff:ff  UHLWbI            en0      !
224.0.0/4          link#14            UmCS              en0      !
224.0.0.251        1:0:5e:0:0:fb      UHmLWI            en0       
255.255.255.255/32 link#14            UCS               en0      !
```

Nous pouvons donc trouver l'adresser ip de notre routeur a la ligne default dans la colone gateway donc l'adresse IP de mon routeur est 192.168.0.254.

### Avec l'interface graphique de notre OS (pour ma part ce sera mac OS Monterey): 

Sur mac os pour trouver toute ces info ils faut ce rendre dans les preferences systeme puis dans réseau aller dans avancer puis cliquer sur l'onglet TCP/IP et voila le resultat:

(voir srceen config de l'ip d'origine)

pour l'adresse mac il faut allerchercher sur la même pages de parametre avancer mais dans l'onglet WI-FI:

(voir screen mac du wifi)

### 2. Modifications des informations:

pour modifier mon adresse IP nous nous rendons dans le même onglet que pour trouver notre adresse IP et au lieux de le mettre ne automatique nous le mettons en manuel et pouvons changer l'adresse pour paseer de 192.168.0.22 a 192.168.0.23:

Avant:

(voir screen config de l'IP basique)

Après:

(voir screen config de l'IP manuel)

pour ma part je n'est perdu internet que quelque seconde pour ne pas dire 2 seconde mais cela ce produit car notre box internet reconnais notre ordinateur lorsqu'il ce connecte quand on arrive chez soit par exemple sur son réseau et il l'identifie avec l'adresse qu'il a a ce moment T. Si en cours d'utilisation la box detecte un changement d'adresse inatendu il est logique qu'elle ne reconnaisse plus l'ordinateur, donc nous perdron internet le temps que la box internet recupere la nouvelle adresse IP de l'ordinateur ce qui peut prendre jusqu'a quelque secondes.


## II. Exploration locale en duo:



## III. Manipulations d'autres outils/protocoles côté client:

1. Le DHCP

Pour trouver le bail DHCP il faut ce rendre dans les préferences systeme, réseau puis dans avancer et dans l'onglet TCP/IP on y trouve toute les informatin sur le baille DHCP avec un bouton. 

(voir screen nommer bail DHCP)

pour ce qui est du delait d'expiration un bail DHCP a une durée determiner a 24h donc il change toute les 24h.

2. DNS

Pour trouver l'adresse IP du server que connais mon ordinateur j'ai taper dans mon terminal la commande 

```
dig
```

ce qui m'as return 

```
; <<>> DiG 9.10.6 <<>>
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 15789
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;.				IN	NS

;; ANSWER SECTION:
.			85834	IN	NS	l.root-servers.net.
.			85834	IN	NS	b.root-servers.net.
.			85834	IN	NS	a.root-servers.net.
.			85834	IN	NS	j.root-servers.net.
.			85834	IN	NS	h.root-servers.net.
.			85834	IN	NS	d.root-servers.net.
.			85834	IN	NS	f.root-servers.net.
.			85834	IN	NS	e.root-servers.net.
.			85834	IN	NS	g.root-servers.net.
.			85834	IN	NS	i.root-servers.net.
.			85834	IN	NS	k.root-servers.net.
.			85834	IN	NS	c.root-servers.net.
.			85834	IN	NS	m.root-servers.net.

;; Query time: 22 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Wed Oct 05 10:49:10 CEST 2022
;; MSG SIZE  rcvd: 239
```

on trouve l'adresse dans les derniere ligne, a la ligne server qui nous donne l'ip suivante 

```
8.8.8.8
```
il s'agit de l'IP du server DNS de google.

maintenant si on execute la commande avec l'adresse des site de ynov et google 

```
nslookup google.com // nslookup ynov.com
```

on obtient 

les IP's suivante: 

pour google
```
216.58.214.78
```

et pour ynov on obtirnt 3 IP differentes: 

```
104.26.11.233
172.67.74.226
104.26.10.233
```

ensuite si on utilise la même commande mais dans le sens inverse avec un adresse ip donc cela donne:

```
nslookup 231.34.113.12
```

et
```
nslookup 78.34.2.17
```

on obtient 

pour la premiere il nous sort ceci

```
server can't find 12.113.34.231.in-addr.arpa: NXDOMAIN
```

cela voudrai dire qu'il ne trouve rien associer a l'adresse donnée

et pour la deuxieme 

```
17.2.34.78.in-addr.arpa	name = cable-78-34-2-17.nc.de.
```

il trouve une adresse ainsi qu'un nom cable-78-34-2-17.nc.de.