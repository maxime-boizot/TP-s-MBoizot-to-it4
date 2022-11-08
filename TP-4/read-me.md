# TP4 : TCP, UDP et services réseau

## I. First steps

on va determiner le type de paquets en fonction de l'application qui tourne actuellement.

on va pouvoir voir ces paquets on va utiliser la commande 

```
lsof -nP  -i 4
```
qui est une commande spécifique a Mac OS

je suis actuellement entrain de telecharger un jeux sur steam 

```
steam_osx 1867 maximeboizot  109u  IPv4 0x45fa4290191c2df3      0t0  TCP 10.33.16.68:51453->185.25.182.76:27020 (ESTABLISHED)
```

on obtient grâce a cette ligne on obtien 

l'ip: 185.25.182.76

le port: 27020

[capture steam](capture_steam.pcapng)

et le type de paquet utilisé sont des paquets par steam son des paquets TCP

ensuite j'ai lancer deezer qui utilise des paquets de type TCP 
```
Deezer    1761 maximeboizot   23u  IPv4 0x45fa4290191a1573      0t0  TCP 10.33.16.68:51475->185.159.104.92:443 (ESTABLISHED)
```
ip: 185.159.104.92

port: 443

j'ai aussi l'application mail qui tourne en fond avec des paquets tcp aussi

[capture deezer](capture_deezer.pcapng)

```
Mail      1423 maximeboizot   69u  IPv4 0x45fa4290191c6083      0t0  TCP 10.33.16.68:51461->173.194.76.109:993 (ESTABLISHED)
```

ip: 173.194.76.109

port: 993

et en dernier discord

[capture mail](capture_mail.pcapng)
```
Discord   3123 maximeboizot   29u  IPv4 0x45fa4290191a4cc3      0t0  TCP 10.33.16.68:51502->162.159.129.232:443 (ESTABLISHED)
```

ip: 162.159.129.232

port: 443

et le type de paquet est du TCP

[capture discord](capture_discord.pcapng)

## II. Mise en place

### 1. SSH

[capture ssh](capture_ssh.pcapng)

Comme dit dans le tp assez logiquement il s'agit de TCP 

Maintenant chercher le 3-way handshake, ce protocole TCP à 3 étape est un procéssus qui est utilisé dans un réseau TCP/IP pour établir une connexion entre le serveur et le client. On peut trouver la première étape "SYN" sur la première ligne, la deuxième étape "SYN-ACK" ce trouve sur la deuxième ligne et la troisième étape "ACK" on peut en observer à partir de la troisième ligne. on trouve du trafic SSH avec en descrition client et sur la ligne dessous écrit server preuve que les deux echange bien. après cela ligne 100 on trouve le "FIN ACK" qui est le protocole qui indique que la connexion a été interompu et si on regarde les deux paquets au deçu ils s'agit du moment ou j'ai tape le "exit" dans le terminal pour quitter le server.

### 2. Routage

dans cet partie aucun rendu attendu mais on mets bien en place nos vm avec le routeur et les routes par defaut vers le routeur pouyr avoir internet.

## III. DNS

### 2. Setup

Maintenant nous allons configurer notre server DNS 

Dans un premier temps voici notre fichier name.conf auquelle on rajoute quelques lignes, et on modifie la section zone.

```
[max@serverdns ~]$ sudo cat /etc/named.conf
[sudo] password for max: 
//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//

options {
	listen-on port 53 { 127.0.0.1; any; };
	listen-on-v6 port 53 { ::1; };
	directory	"/var/named";
	dump-file	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	secroots-file	"/var/named/data/named.secroots";
	recursing-file	"/var/named/data/named.recursing";
	allow-query     { localhost; any; };
	allow-query-cache { localhost; any; };

	/* 
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to enable 
	   recursion. 
	 - If your recursive DNS server has a public IP address, you MUST enable access 
	   control to limit queries to your legitimate users. Failing to do so will
	   cause your server to become part of large scale DNS amplification 
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface 
	*/
	recursion yes;

	dnssec-validation yes;

	managed-keys-directory "/var/named/dynamic";
	geoip-directory "/usr/share/GeoIP";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";

	/* https://fedoraproject.org/wiki/Changes/CryptoPolicy */
	include "/etc/crypto-policies/back-ends/bind.config";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

zone "tp4.b1" IN {
	type master;
	file "tp4.b1.db";
	allow-update { none; };
	allow-query {any; };};

zone 1.4.10.in-addr.arpa IN{
	type master;
	file "tp4.b1.rev";
	allow-update { none; };
	allow-query { any; };
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";
```

On créé maintenant unfichier qui va permetre d'associer un nom a une ip 

```
[max@serverdns ~]$ sudo cat  /var/named/tp4.b1.db
$TTL 86400
@ IN SOA dns-server.tp4.b1. admin.tp4.b1. (
	2019061800 ;Serial
	3600 ;Refresh
	1800 ;Retry
	604800 ;Expire
	86400 ;Miinimum TTL
)

@ IN NS dns-server.tp4.b1.

dns-server IN A 192.168.80.5
node1	IN A 192.168.80.2
reteur	IN A 192.168.80.3
```
Et dans celui-ci c'est l'inverse on associe une ip a un nom

```
[max@serverdns ~]$ sudo cat  /var/named/tp4.b1.rev
[sudo] password for max: 
$TTL 86400
@ IN SOA dns-server.tp4.b1. admin.tp4.b1. (
    2019061800 ;Serial
    3600 ;Refresh
    1800 ;Retry
    604800 ;Expire
    86400 ;Minimum TTL
)

@ IN NS dns-server.tp4.b1.

201 IN PTR dns-server.tp4.b1.
11 IN PTR node1.tp4.b1.
```

quand un fait un 

```
sudo systemctl start named

```
cela lance le server et on peu verifier qu'il tourne bien avec la commande 

```
sudo systemctl status named
```
et on obtient cela 

```
[max@serverdns ~]$ sudo systemctl status named
[sudo] password for max: 
● named.service - Berkeley Internet Name Domain (DNS)
     Loaded: loaded (/usr/lib/systemd/system/named.service; disabled; vendor preset: disabled)
     Active: active (running) since Wed 2022-11-02 22:47:55 CET; 16min ago
    Process: 1285 ExecStartPre=/bin/bash -c if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then /usr/sbin/named-checkconf -z "$NAMEDCONF";>
    Process: 1287 ExecStart=/usr/sbin/named -u named -c ${NAMEDCONF} $OPTIONS (code=exited, status=0/SUCCESS)
   Main PID: 1288 (named)
      Tasks: 8 (limit: 5876)
     Memory: 25.4M
        CPU: 93ms
     CGroup: /system.slice/named.service
             └─1288 /usr/sbin/named -u named -c /etc/named.conf

Nov 02 22:47:54 serverdns named[1288]: network unreachable resolving './NS/IN': 2001:500:9f::42#53
Nov 02 22:47:54 serverdns named[1288]: zone 1.0.0.127.in-addr.arpa/IN: loaded serial 0
Nov 02 22:47:54 serverdns named[1288]: network unreachable resolving './DNSKEY/IN': 2001:500:200::b#53
Nov 02 22:47:54 serverdns named[1288]: network unreachable resolving './NS/IN': 2001:500:200::b#53
Nov 02 22:47:54 serverdns named[1288]: zone localhost/IN: loaded serial 0
Nov 02 22:47:54 serverdns named[1288]: all zones loaded
Nov 02 22:47:55 serverdns systemd[1]: Started Berkeley Internet Name Domain (DNS).
Nov 02 22:47:54 serverdns named[1288]: running
Nov 02 22:47:55 serverdns named[1288]: managed-keys-zone: Initializing automatic trust anchor management for zone '.'; DNSKEY ID 20326 >
Nov 02 22:47:56 serverdns named[1288]: resolver priming query complete
```
on utilise ensuite la commande 

``` 
netstat -l 
```
pour voir si on peu vour le server
```
[max@serverdns ~]$ netstat -l
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 serverdns:domain        0.0.0.0:*               LISTEN     
tcp        0      0 localhost:domain        0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN     
tcp        0      0 localhost:rndc          0.0.0.0:*               LISTEN     
tcp6       0      0 localhost:domain        [::]:*                  LISTEN     
tcp6       0      0 [::]:ssh                [::]:*                  LISTEN     
tcp6       0      0 localhost:rndc          [::]:*                  LISTEN     
udp        0      0 serverdns:domain        0.0.0.0:*                          
udp        0      0 serverdns:domain        0.0.0.0:*                          
udp        0      0 localhost:domain        0.0.0.0:*                          
udp        0      0 localhost:domain        0.0.0.0:*                          
udp        0      0 localhost:323           0.0.0.0:*                          
udp6       0      0 localhost:domain        [::]:*                             
udp6       0      0 localhost:domain        [::]:*                             
udp6       0      0 localhost:323           [::]:*                             
Active UNIX domain sockets (only servers)
```

et effectivement on peu voir sur les premiere ligne le server dns avec en state listenning

on utilise la commande 

```
sudo firewall-cmd --add-port=53/tcp --permanent
```

pour interagir avec le firewall et ainsi ouvrir le port 53 sur lequel ecoute le server ce qui nous print 

```
succes 
```

pour verifier si tout est bon on uitilise la commande

```
sudo firewald-cmd --reload
```

pour mettre en application toute les modification ensuite on utilise la commande 

```
sudo firewalld-cmd --list-all
```

ce qui print 

```
[max@serverdns ~]$ sudo firewall-cmd --list-all 
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 53/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```
avec cette ligne qui indique bien notre modification 

```
  ports: 53/tcp
```

### 3. Test

on arrive au bout maintenant plus qu'as tester 

youhouuuuuuuuu :))))

on configure node node1 pour utiliser notre server 

```
[max@serverdns ~]$ sudo cat /etc/resolv.conf
[sudo] password for max: 
# Generated by NetworkManager
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 1.1.1.1
```

ensuite on peut tester 

on peu test avec la commande 

```
dig 
```

dans un premier temps avec google.com 

donc on fait 

```
dig google.com
```

et on obtient 

```
[max@serverdns ~]$ dig google.com

; <<>> DiG 9.16.23-RH <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 58411
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		70	IN	A	142.250.201.174

;; Query time: 86 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Thu Nov 03 13:03:34 CET 2022
;; MSG SIZE  rcvd: 55
```

on peut aussi tester avec node1.tp4.b1

et on obtient cela 

```
[max@serverdns ~]$ dig node1

; <<>> DiG 9.16.23-RH <<>> node1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 15672
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;node1.				IN	A

;; AUTHORITY SECTION:
.			86384	IN	SOA	a.root-servers.net. nstld.verisign-grs.com. 2022110501 1800 900 604800 86400

;; Query time: 108 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Thu Nov 03 13:06:18 CET 2022
;; MSG SIZE  rcvd: 109
```


