# TP2 : Environnement virtuel

Dans ce TP, on remanipule toujours les mêmes concepts qu'au TP1, mais en environnement virtuel avec une posture un peu plus orientée administrateur qu'au TP1.

- [TP2 : Environnement virtuel](#tp2--environnement-virtuel)
- [0. Prérequis](#0-prérequis)
- [I. Topologie réseau](#i-topologie-réseau)
  - [Topologie](#topologie)
  - [Tableau d'adressage](#tableau-dadressage)
  - [Hints](#hints)
  - [Marche à suivre recommandée](#marche-à-suivre-recommandée)
  - [Compte-rendu](#compte-rendu)
- [II. Interlude accès internet](#ii-interlude-accès-internet)
- [III. Services réseau](#iii-services-réseau)
  - [1. DHCP](#1-dhcp)
  - [2. Web web web](#2-web-web-web)

# 0. Prérequis


La même musique que l'an dernier :

tout est bon on deroule la checklist ça faisait lonnngtemps

# I. Topologie réseau

## Hints

➜ **Sur le `router.tp2`**

on active le routage lets gooo

```bash
$ firewall-cmd --add-masquerade
$ firewall-cmd --add-masquerade --permanent
$ sysctl -w net.ipv4.ip_forward=1
```

toute est bon on ajoute la

```
GATEWAY=10.1.1.254
```

dans le fichier `ifconfig-enp0s1` des node lan 1 et pour celle du lan 2

```
GATEWAY=10.1.2.254
```

## Compte-rendu

pour **`node1.lan1.tp2`** on est partie

- afficher ses cartes réseau

```
[max@node1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether f2:29:81:aa:f9:b2 brd ff:ff:ff:ff:ff:ff
    inet 10.1.1.11/24 brd 10.1.1.255 scope global noprefixroute enp0s1
       valid_lft forever preferred_lft forever
    inet6 fe80::f029:81ff:feaa:f9b2/64 scope link 
       valid_lft forever preferred_lft forever
```

- afficher sa table de routage

```
[max@node1 ~]$ ip route show
default via 10.1.1.254 dev enp0s1 proto static metric 100 
10.1.1.0/24 dev enp0s1 proto kernel scope link src 10.1.1.11 metric 100 
```

- prouvez qu'il peut joindre `node2.lan2.tp2`

```
ping node1.lan2.tp2
PING node1.lan2.tp2 (10.1.2.11) 56(84) bytes of data.
64 bytes from node1.lan2.tp2 (10.1.2.11): icmp_seq=1 ttl=63 time=4.35 ms
64 bytes from node1.lan2.tp2 (10.1.2.11): icmp_seq=2 ttl=63 time=14.8 ms
64 bytes from node1.lan2.tp2 (10.1.2.11): icmp_seq=3 ttl=63 time=11.5 ms
64 bytes from node1.lan2.tp2 (10.1.2.11): icmp_seq=4 ttl=63 time=12.5 ms
^C
--- node1.lan2.tp2 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3011ms
rtt min/avg/max/mdev = 4.345/10.784/14.756/3.897 ms
```

- prouvez avec un `traceroute` que le paquet passe bien par `router.tp2`

```
[max@node1 ~]$ traceroute node1.lan2.tp2
traceroute to node1.lan2.tp2 (10.1.2.11), 30 hops max, 60 byte packets
 1  router.tp2 (10.1.1.254)  3.229 ms  3.033 ms  2.997 ms
 2  node1.lan2.tp2 (10.1.2.11)  7.750 ms !X  7.711 ms !X  7.668 ms !X
```

# II. Interlude accès internet




☀️ **Sur `router.tp2`**

- prouvez que vous avez un accès internet (ping d'une IP publique)
- prouvez que vous pouvez résoudre des noms publics (ping d'un nom de domaine public)

```
[max@router ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=114 time=21.7 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=114 time=27.2 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=114 time=74.1 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=114 time=103 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3011ms
rtt min/avg/max/mdev = 21.709/56.608/103.430/33.844 ms
[max@router ~]$ ping google.com
PING google.com (172.217.18.206) 56(84) bytes of data.
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=1 ttl=116 time=19.4 ms
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=2 ttl=116 time=22.3 ms
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=3 ttl=116 time=61.3 ms
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=4 ttl=116 time=101 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3013ms
rtt min/avg/max/mdev = 19.407/51.101/101.402/33.409 ms
```

☀️ **Accès internet LAN1 et LAN2**

comme vu avant on a ajouter les route par defaut directement dans le fichier de conf de l'interface enp0s1

```
[max@node2 ~]$ cat /etc/sysconfig/network-scripts/ifcfg-enp0s1
DEVICE=enp0s1

BOOTPROTO=static
ONBOOT=yes

IPADDR=10.1.1.12
NETMASK=255.255.255.0
GATEWAY=10.1.1.254
DNS1=8.8.8.8
```

pour `lan1`

```
[max@node1 ~]$ ip route show
default via 10.1.1.254 dev enp0s1 proto static metric 100 
10.1.1.0/24 dev enp0s1 proto kernel scope link src 10.1.1.11 metric 100 
```

pour `lan2`

```
[max@node1 ~]$ ip route show
default via 10.1.2.254 dev enp0s1 proto static metric 100 
10.1.2.0/24 dev enp0s1 proto kernel scope link src 10.1.2.11 metric 100 
```

et voila les ping de 8.8.8.8 dans un premier temps et google.com ensuite

```
[max@node1 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=113 time=24.2 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=113 time=29.2 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=113 time=27.9 ms
^C
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2008ms
rtt min/avg/max/mdev = 24.238/27.128/29.206/2.108 ms
[max@node1 ~]$ ping google.com
PING google.com (172.217.18.206) 56(84) bytes of data.
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=1 ttl=115 time=105 ms
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=2 ttl=115 time=28.6 ms
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=3 ttl=115 time=21.5 ms
64 bytes from ham02s14-in-f206.1e100.net (172.217.18.206): icmp_seq=4 ttl=115 time=33.2 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3008ms
rtt min/avg/max/mdev = 21.544/47.117/105.203/33.790 ms
```


# III. Services réseau

## 1. DHCP

☀️ **Sur `dhcp.lan1.tp2`**

- n'oubliez pas de renommer la machine (`node2.lan1.tp2` devient `dhcp.lan1.tp2`)

```
[max@dhcp ~]$ hostname
dhcp.lan1.tp2
```

- changez son adresse IP en `10.1.1.253`

```
[max@dhcp ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 4e:bc:92:40:11:d8 brd ff:ff:ff:ff:ff:ff
    inet 10.1.1.253/24 brd 10.1.1.255 scope global noprefixroute enp0s1
       valid_lft forever preferred_lft forever
    inet6 fe80::4cbc:92ff:fe40:11d8/64 scope link 
       valid_lft forever preferred_lft forever
```
- setup du serveur DHCP
  - commande d'installation du paquet
  ```
  [max@dhcp ~]$ sudo dnf -y install dhcp-server
  ```
  - fichier de conf
```
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp-server/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#
# this DHCP server to be declared valid
authoritative;

# specify network address and subnetmask
subnet 10.1.1.0 netmask 255.255.255.0 {
    # specify the range of lease IP address
    range dynamic-bootp 10.1.1.100 10.1.1.200;
    # specify broadcast address
    option broadcast-address 10.1.1.255;
    # specify gateway
    option routers 10.1.1.254;
}
```
  - service actif

```
[root@dhcp max]# sudo systemctl status dhcpd
● dhcpd.service - DHCPv4 Server Daemon
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; preset: disabled)
     Active: active (running) since Wed 2023-10-25 16:25:53 CEST; 10min ago
       Docs: man:dhcpd(8)
             man:dhcpd.conf(5)
   Main PID: 777 (dhcpd)
     Status: "Dispatching packets..."
      Tasks: 1 (limit: 7444)
     Memory: 7.1M
        CPU: 11ms
     CGroup: /system.slice/dhcpd.service
             └─777 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid

Oct 25 16:25:53 dhcp.lan1.tp2 dhcpd[777]: Sending on   LPF/enp0s1/4e:bc:92:40:11:d8/10.1.1.0/24
Oct 25 16:25:53 dhcp.lan1.tp2 dhcpd[777]: Sending on   Socket/fallback/fallback-net
Oct 25 16:25:53 dhcp.lan1.tp2 dhcpd[777]: Server starting service.
Oct 25 16:25:53 dhcp.lan1.tp2 systemd[1]: Started DHCPv4 Server Daemon.
Oct 25 16:26:51 dhcp.lan1.tp2 dhcpd[777]: DHCPREQUEST for 192.168.81.4 from f2:29:81:aa:f9:b2 via enp0s1: wrong network.
Oct 25 16:26:51 dhcp.lan1.tp2 dhcpd[777]: DHCPNAK on 192.168.81.4 to f2:29:81:aa:f9:b2 via enp0s1
Oct 25 16:26:51 dhcp.lan1.tp2 dhcpd[777]: DHCPDISCOVER from f2:29:81:aa:f9:b2 via enp0s1
Oct 25 16:26:51 dhcp.lan1.tp2 dhcpd[777]: DHCPREQUEST for 192.168.81.4 (192.168.81.1) from f2:29:81:aa:f9:b2 via enp0s1: wrong network.
Oct 25 16:26:51 dhcp.lan1.tp2 dhcpd[777]: DHCPNAK on 192.168.81.4 to f2:29:81:aa:f9:b2 via enp0s1
Oct 25 16:26:52 dhcp.lan1.tp2 dhcpd[777]: DHCPOFFER on 10.1.1.100 to f2:29:81:aa:f9:b2 (node1) via enp0s1
```

☀️ **Sur `node1.lan1.tp2`**

- demandez une IP au serveur DHCP
- prouvez que vous avez bien récupéré une IP *via* le DHCP
- prouvez que vous avez bien récupéré l'IP de la passerelle
- prouvez que vous pouvez `ping node1.lan2.tp2`

## 2. Web web web

- n'oubliez pas de renommer la machine (`node2.lan2.tp2` devient `web.lan2.tp2`)

```
[max@web var]$ hostname
web.lan2.tp2
```

- setup du service Web
  - installation de NGINX

```

[max@web ~]$ sudo dnf -y install nginx
[sudo] password for max: 
Rocky Linux 9 - BaseOS                                                                                           4.9 kB/s | 4.1 kB     00:00    
Rocky Linux 9 - AppStream                                                                                        3.3 kB/s | 4.5 kB     00:01    
Rocky Linux 9 - Extras                                                                                           2.3 kB/s | 2.9 kB     00:01    
Dependencies resolved.
=================================================================================================================================================
 Package                               Architecture                Version                                   Repository                     Size
=================================================================================================================================================
Installing:
 nginx                                 aarch64                     1:1.20.1-14.el9_2.1                       appstream                      36 k
Installing dependencies:
 nginx-core                            aarch64                     1:1.20.1-14.el9_2.1                       appstream                     566 k
 nginx-filesystem                      noarch                      1:1.20.1-14.el9_2.1                       appstream                     8.5 k
 rocky-logos-httpd                     noarch                      90.14-1.el9                               appstream                      24 k

Transaction Summary
=================================================================================================================================================
Install  4 Packages

Total download size: 634 k
Installed size: 1.7 M
Downloading Packages:
(1/4): rocky-logos-httpd-90.14-1.el9.noarch.rpm                                                                   30 kB/s |  24 kB     00:00    
(2/4): nginx-1.20.1-14.el9_2.1.aarch64.rpm                                                                        30 kB/s |  36 kB     00:01    
(3/4): nginx-filesystem-1.20.1-14.el9_2.1.noarch.rpm                                                             2.8 kB/s | 8.5 kB     00:03    
(4/4): nginx-core-1.20.1-14.el9_2.1.aarch64.rpm                                                                  127 kB/s | 566 kB     00:04    
-------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                            103 kB/s | 634 kB     00:06     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                         1/1 
  Running scriptlet: nginx-filesystem-1:1.20.1-14.el9_2.1.noarch                                                                             1/4 
  Installing       : nginx-filesystem-1:1.20.1-14.el9_2.1.noarch                                                                             1/4 
  Installing       : nginx-core-1:1.20.1-14.el9_2.1.aarch64                                                                                  2/4 
  Installing       : rocky-logos-httpd-90.14-1.el9.noarch                                                                                    3/4 
  Installing       : nginx-1:1.20.1-14.el9_2.1.aarch64                                                                                       4/4 
  Running scriptlet: nginx-1:1.20.1-14.el9_2.1.aarch64                                                                                       4/4 
  Verifying        : rocky-logos-httpd-90.14-1.el9.noarch                                                                                    1/4 
  Verifying        : nginx-1:1.20.1-14.el9_2.1.aarch64                                                                                       2/4 
  Verifying        : nginx-filesystem-1:1.20.1-14.el9_2.1.noarch                                                                             3/4 
  Verifying        : nginx-core-1:1.20.1-14.el9_2.1.aarch64                                                                                  4/4 

Installed:
  nginx-1:1.20.1-14.el9_2.1.aarch64            nginx-core-1:1.20.1-14.el9_2.1.aarch64         nginx-filesystem-1:1.20.1-14.el9_2.1.noarch        
  rocky-logos-httpd-90.14-1.el9.noarch        

Complete!
[max@web ~]$ sudo systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[max@web ~]$ sudo systemctl status nginx
○ nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
     Active: inactive (dead)
[max@web ~]$ sudo systemctl start nginx
[max@web ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
     Active: active (running) since Wed 2023-10-25 19:33:41 CEST; 1s ago
    Process: 1519 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 1520 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 1521 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 1522 (nginx)
      Tasks: 7 (limit: 7444)
     Memory: 6.2M
        CPU: 31ms
     CGroup: /system.slice/nginx.service
             ├─1522 "nginx: master process /usr/sbin/nginx"
             ├─1523 "nginx: worker process"
             ├─1524 "nginx: worker process"
             ├─1525 "nginx: worker process"
             ├─1526 "nginx: worker process"
             ├─1527 "nginx: worker process"
             └─1528 "nginx: worker process"

Oct 25 19:33:41 web.lan2.tp2 systemd[1]: Starting The nginx HTTP and reverse proxy server...
Oct 25 19:33:41 web.lan2.tp2 nginx[1520]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Oct 25 19:33:41 web.lan2.tp2 nginx[1520]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Oct 25 19:33:41 web.lan2.tp2 systemd[1]: Started The nginx HTTP and reverse proxy server.

```

  - gestion de la racine web `/var/www/site_nul/`

```
[max@web ~]$ sudo ls -al /var/www/
drwxr-xr-x.  2 nginx nginx   24 Oct 19 15:48 site_nul
```
  - service actif

```
[max@web var]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
     Active: active (running) since Wed 2023-10-25 19:33:41 CEST; 7min ago
    Process: 1519 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 1520 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 1521 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 1522 (nginx)
      Tasks: 7 (limit: 7444)
     Memory: 6.2M
        CPU: 31ms
     CGroup: /system.slice/nginx.service
             ├─1522 "nginx: master process /usr/sbin/nginx"
             ├─1523 "nginx: worker process"
             ├─1524 "nginx: worker process"
             ├─1525 "nginx: worker process"
             ├─1526 "nginx: worker process"
             ├─1527 "nginx: worker process"
             └─1528 "nginx: worker process"

Oct 25 19:33:41 web.lan2.tp2 systemd[1]: Starting The nginx HTTP and reverse proxy server...
Oct 25 19:33:41 web.lan2.tp2 nginx[1520]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Oct 25 19:33:41 web.lan2.tp2 nginx[1520]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Oct 25 19:33:41 web.lan2.tp2 systemd[1]: Started The nginx HTTP and reverse proxy server.
```

  - ouverture du port firewall

```
[max@web var]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[max@web var]$ sudo firewall-cmd --reload
success
[max@web var]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 22/tcp 22/udp 80/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

- prouvez qu'il y a un programme NGINX qui tourne derrière le port 80 de la machine (commande `ss`)

```
[max@web var]$ ss -alnpt | grep 80
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*          
LISTEN 0      511             [::]:80           [::]:*
```

☀️ **Sur `node1.lan1.tp2`**
```
[max@node1 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.1.1.12	node2.lan1.tp2
10.1.2.11	node1.lan2.tp2
10.1.1.254	router.tp2
10.1.2.12   web.lan2.tp2
[max@web var]$ curl web.lan2.tp2
<H1>j'adore me faire du mal donc je fait du reseau et j'aime çaaaa</H1>
```


voila fin de tp peu de fun dans celui la mais voila 

![](/TP-2/img/yugi.gif)