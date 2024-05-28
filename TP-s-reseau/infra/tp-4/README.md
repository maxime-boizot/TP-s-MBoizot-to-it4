# TP4 INFRA : Router-on-a-stick

im back maaaan 

de retour avec du gns3 qui veux me jouer uniquement des mauvais tour

# Sommaire

- [TP4 INFRA : Router-on-a-stick](#tp4-infra--router-on-a-stick)
- [Sommaire](#sommaire)
- [0. Prérequis](#0-prérequis)
  - [Checklist VM Linux](#checklist-vm-linux)
- [I. VLAN et Routing](#i-vlan-et-routing)
- [II. NAT](#ii-nat)
- [III. Add a building](#iii-add-a-building)

# 0. Prérequis

## Checklist VM Linux

comme d'habitude la petite checkmist ddes VMs ip local hostname defini fw actif qui laisse passer que ce qu'on a besoin ssh resolution de nom et on y bien



c'est l'heure du TP !!!

![c'est lheure](/TP-s-reseau/infra/tp-4/img/clheure.gif)

# [I. VLAN et Routing](./1_routing_vlan/README.md)

bon on defini les ip pour tout les vpcs ainsi que notre que pour `web1.server.tp4`

pour les vpcs on tape la commande suivante et ce sera la même pour tout les autre 

`PC1> ip 10.1.10.1 255.255.255.0`

et après un `show ip`

```
VPCS> show ip

NAME        : VPCS[1]
IP/MASK     : 10.1.10.1/24
GATEWAY     : 0.0.0.0
DNS         : 
MAC         : 00:50:79:66:68:00
LPORT       : 20011
RHOST:PORT  : 127.0.0.1:20012
MTU         : 1500

VPCS> show ip

NAME        : VPCS[1]
IP/MASK     : 10.1.10.2/24
GATEWAY     : 0.0.0.0
DNS         : 
MAC         : 00:50:79:66:68:01
LPORT       : 20013
RHOST:PORT  : 127.0.0.1:20014
MTU         : 1500

PC3> show ip

NAME        : PC3[1]
IP/MASK     : 10.1.20.1/24
GATEWAY     : 0.0.0.0
DNS         : 
MAC         : 00:50:79:66:68:02
LPORT       : 20015
RHOST:PORT  : 127.0.0.1:20016
MTU         : 1500
```


ici web1
```
[max@web1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:ad:15:9e brd ff:ff:ff:ff:ff:ff
    inet 10.1.30.1/24 brd 10.1.30.255 scope global noprefixroute enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fead:159e/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:3c:c3:3c brd ff:ff:ff:ff:ff:ff
    inet 192.168.56.105/24 brd 192.168.56.255 scope global dynamic noprefixroute enp0s8
       valid_lft 461sec preferred_lft 461sec
    inet6 fe80::92be:d992:1739:b71f/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever 
```

maintenant sur IOU on va mettre en place nos petit vlan avec la topo donnée 

![iou](/TP-s-reseau/infra/tp-4/img/iou.gif)

ici on a jouter nos vlan et on attribu a chaque port son vlan

```
IOU1#show vlan br

VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Et0/0, Et0/1, Et0/2, Et0/3
                                                Et1/0, Et1/3, Et2/0, Et2/2
                                                Et2/3, Et3/0, Et3/2, Et3/3
10   clients                          active    Et1/1, Et1/2
20   admins                           active    Et2/1
30   servers                          active    Et3/1
1002 fddi-default                     act/unsup 
1003 token-ring-default               act/unsup 
1004 fddinet-default                  act/unsup 
1005 trnet-default                    act/unsup
```

On mets le port du routeur en trunk 

```
IOU1#show interface trunk

Port        Mode             Encapsulation  Status        Native vlan
Et0/0       on               802.1q         trunking      1

Port        Vlans allowed on trunk
Et0/0       1-4094

Port        Vlans allowed and active in management domain
Et0/0       1,10,20,30

Port        Vlans in spanning tree forwarding state and not pruned
Et0/0       1,10,20,30
```

puis on configure les sous interface avec leurs ips respectif sur le routeur

```
R1#show ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            unassigned      YES unset  up                    up      
FastEthernet0/0.10         10.1.10.254     YES manual up                    up      
FastEthernet0/0.20         10.1.20.254     YES manual up                    up      
FastEthernet0/0.30         10.1.30.254     YES manual up                    up      
FastEthernet0/1            unassigned      YES unset  administratively down down    
FastEthernet1/0            unassigned      YES unset  administratively down down    
FastEthernet2/0            unassigned      YES unset  administratively down down 
```

avec tous ça maintenant tout le monde peut ping le routeur

![](/TP-s-reseau/infra/tp-4/img/test.gif)

chaque vpcs peut ping la sous interface du routeur qui est attricuer a son vlan

- pc1 :
```
PC1> ping 10.1.10.254

10.1.10.254 icmp_seq=1 timeout
84 bytes from 10.1.10.254 icmp_seq=2 ttl=255 time=10.543 ms
84 bytes from 10.1.10.254 icmp_seq=3 ttl=255 time=8.813 ms
84 bytes from 10.1.10.254 icmp_seq=4 ttl=255 time=3.644 ms
84 bytes from 10.1.10.254 icmp_seq=5 ttl=255 time=1.190 ms
```

- pc2 :
```
PC2> ping 10.1.10.254

84 bytes from 10.1.10.254 icmp_seq=1 ttl=255 time=3.283 ms
84 bytes from 10.1.10.254 icmp_seq=2 ttl=255 time=9.464 ms
84 bytes from 10.1.10.254 icmp_seq=3 ttl=255 time=9.710 ms
84 bytes from 10.1.10.254 icmp_seq=4 ttl=255 time=11.880 ms
```

- adm1 :
```
adm1> ping 10.1.20.254

84 bytes from 10.1.20.254 icmp_seq=1 ttl=255 time=7.249 ms
84 bytes from 10.1.20.254 icmp_seq=2 ttl=255 time=3.261 ms
84 bytes from 10.1.20.254 icmp_seq=3 ttl=255 time=1.299 ms
84 bytes from 10.1.20.254 icmp_seq=4 ttl=255 time=9.283 ms
```

- web1:
```
[mmederic@web1 ~]$ ping 10.1.30.254
PING 10.1.30.254 (10.1.30.254) 56(84) bytes of data.
64 bytes from 10.1.30.254: icmp_seq=1 ttl=255 time=27.8 ms
64 bytes from 10.1.30.254: icmp_seq=2 ttl=255 time=5.54 ms
64 bytes from 10.1.30.254: icmp_seq=3 ttl=255 time=8.51 ms
64 bytes from 10.1.30.254: icmp_seq=4 ttl=255 time=2.07 ms
```

et maintenant on test le ping entre les reseau 

- vlan 10 :
```
pc1> ping 10.1.30.1

84 bytes from 10.1.30.1 icmp_seq=1 ttl=63 time=19.722 ms
84 bytes from 10.1.30.1 icmp_seq=2 ttl=63 time=20.929 ms
84 bytes from 10.1.30.1 icmp_seq=3 ttl=63 time=16.752 ms
```

- vlan 20 :
```
adm1> ping 10.1.30.1

84 bytes from 10.1.30.1 icmp_seq=1 ttl=63 time=12.882 ms
84 bytes from 10.1.30.1 icmp_seq=2 ttl=63 time=16.578 ms
84 bytes from 10.1.30.1 icmp_seq=3 ttl=63 time=11.573 ms
84 bytes from 10.1.30.1 icmp_seq=4 ttl=63 time=18.740 ms
```

- vlan 30 :
```
[mmederic@web1 ~]$ ping 10.1.10.2
PING 10.1.10.2 (10.1.10.2) 56(84) bytes of data.
64 bytes from 10.1.10.2: icmp_seq=1 ttl=63 time=17.4 ms
64 bytes from 10.1.10.2: icmp_seq=2 ttl=63 time=14.2 ms
64 bytes from 10.1.10.2: icmp_seq=3 ttl=63 time=14.8 ms
64 bytes from 10.1.10.2: icmp_seq=4 ttl=63 time=17.4 ms
```

![](/TP-s-reseau/infra/tp-4/img/ping.gif)

bingo tout le monte fait du ping pong donc

neeeext part


# [II. NAT](./2_nat/README.md)


ok on va rajouter un petit cloud a tout ça on le co a `eth1` sur le routeur 

et puis taddaaaaa

```
R1#show ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            unassigned      YES NVRAM  up                    up
FastEthernet0/0.10         10.1.10.254     YES NVRAM  up                    up
FastEthernet0/0.20         10.1.20.254     YES NVRAM  up                    up
FastEthernet0/0.30         10.1.30.254     YES NVRAM  up                    up
FastEthernet0/1            192.168.122.63  YES DHCP   up                    up
```
la suite logique a tout ça c'est de test avec des ping

```
R1#ping 1.1.1.1

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 1.1.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 20/22/28 ms
```

# [III. Add a building](./3_second_building/README.md)

je viens d'acheter mon nouveau bat il est tout neuuuuf 
![deja vu celui la non](/TP-s-reseau/infra/tp-4/img/conde.png)

il est pas beauuuu 

bref j'ai mis en place un petit server dhcp pour les gens qui y bosse

voila les petite running config de tous ce petit monde

**le routeur**

```bash
R1#show running-config

hostname R1

interface FastEthernet0/0
 no ip address
 ip nat inside
 ip virtual-reassembly
 speed 100
 full-duplex
!
interface FastEthernet0/0.10
 encapsulation dot1Q 10
 ip address 10.1.10.254 255.255.255.0
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet0/0.20
 encapsulation dot1Q 20
 ip address 10.1.20.254 255.255.255.0
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet0/0.30
 encapsulation dot1Q 30
 ip address 10.1.30.254 255.255.255.0
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet0/1
 ip address dhcp
 ip nat outside
 ip virtual-reassembly
 duplex auto
 speed auto
!
ip nat inside source list 1 interface FastEthernet0/1 overload
!
access-list 1 permit any
no cdp log mismatch duplex
!
```
**sw1**

```
sw1#sh running-config
Building configuration...

Current configuration : 1604 bytes
!
! Last configuration change at 13:34:25 UTC Sun Mar 10 2024
!
version 15.2
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
service compress-config
!
hostname sw1
!
boot-start-marker
boot-end-marker
!
!
logging discriminator EXCESS severity drops 6 msg-body drops EXCESSCOLL
logging buffered 50000
logging console discriminator EXCESS
!

```

**sw2:**

```
sw2#sh running-config
Building configuration...

Current configuration : 1635 bytes
!
! Last configuration change at 15:15:34 UTC Tue Mar 12 2024
!
version 15.2
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
service compress-config
!
hostname sw2
!
boot-start-marker
boot-end-marker
!
!
logging discriminator EXCESS severity drops 6 msg-body drops EXCESSCOLL
logging buffered 50000
logging console discriminator EXCESS
```

**sw3**

```
sw3#sh running-config
Building configuration...

Current configuration : 1635 bytes
!
! Last configuration change at 16:02:51 UTC Tue Mar 12 2024
!
version 15.2
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
service compress-config
!
hostname sw3
!
boot-start-marker
boot-end-marker
!
!
logging discriminator EXCESS severity drops 6 msg-body drops EXCESSCOLL
logging buffered 50000
logging console discriminator EXCESS
```

on config les **vlan's** sur les switch 

now on va monter le serv **DHCP**

avec une petite vm avec le jolie petit nom de **dhcp1.client1.tp4** (c'est con on avais vrm celle du tp1 dommage de l'avoir rm gros debile que je suis)

on déroule la **checklist** comme d'hab

```
sudo cat /etc/dhcp/dhcpd.conf
[sudo] password for max:
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp-server/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#
option domain-name "GNS-server-is-back";

option domain-name-servers 1.1.1.1;

default-lease-time 600;

max-lease-time 7200;

authoritative;

subnet 10.1.10.0 netmask 255.255.255.0 {
        range dynamic-bootp 10.1.10.3 10.1.10.10;
        option routers 10.1.10.254;

}
```



```bash
[max@dhcp1 ~]$ sudo cat /etc/dhcp/dhcpd.conf
[sudo] password for max:
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp-server/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#

option domain-name-servers 1.1.1.1;

default-lease-time 600;

max-lease-time 7200;

authoritative;

subnet 10.1.10.0 netmask 255.255.255.0 {
        range dynamic-bootp 10.1.10.3 10.1.10.10;
        option routers 10.1.10.254;

}
```

une fois ça fait baaaah on va essayer de recuperer une ip

```bash
PC5> ip dhcp -r
DDORA IP 10.1.10.5/24 GW 10.1.10.254
```

bon bha le dhcp marche et ça c'est cool

on va test de ping `web1.servers.tp4`

```bash
PC3> ping 10.1.30.1

84 bytes from 10.1.30.1 icmp_seq=1 ttl=63 time=23.030 ms
84 bytes from 10.1.30.1 icmp_seq=2 ttl=63 time=13.298 ms
84 bytes from 10.1.30.1 icmp_seq=3 ttl=63 time=19.880 ms
^C
```

on resoud `ynov.com`

```bash
PC4> ping ynov.com
ynov.com resolved to 172.67.74.226
```

bon bah that's good pour ce tp ma fois

la suite dans le prochain épisode