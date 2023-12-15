# TP3 INFRA : Premiers pas GNS, Cisco et VLAN

# Sommaire

- [TP3 INFRA : Premiers pas GNS, Cisco et VLAN](#tp3-infra--premiers-pas-gns-cisco-et-vlan)
- [Sommaire](#sommaire)
- [0. Prérequis](#0-prérequis)
- [I. Dumb switch](#i-dumb-switch)
  - [1. Topologie 1](#1-topologie-1)
  - [2. Adressage topologie 1](#2-adressage-topologie-1)
  - [3. Setup topologie 1](#3-setup-topologie-1)
- [II. VLAN](#ii-vlan)
  - [1. Topologie 2](#1-topologie-2)
  - [2. Adressage topologie 2](#2-adressage-topologie-2)
    - [3. Setup topologie 2](#3-setup-topologie-2)
- [III. Ptite VM DHCP](#iii-ptite-vm-dhcp)

# 0. Prérequis

bon on commence les tps réseau retour a ce qu'on aime 

après les quelque galère de gns3 on a gns qui fonctionne parfaitement

# I. Dumb switch

| Node  | IP            |
| ----- | ------------- |
| `pc1` | `10.3.1.1/24` |
| `pc2` | `10.3.1.2/24` |

## 1. Setup topologie 1

bon on a fait un bon debut on a defini des ips static 

pour cela on ce connect via tel net sur les vpcs 

la c'est pour le vpcs1

```bash
telnet 192.168.56.101 5002
```

et pour definir les ips

```
PC1> ip 10.3.1.1             
Checking for duplicate address...
PC1 : 10.3.1.1 255.255.255.0

PC1> save
Saving startup configuration to startup.vpc
.  done
```
et on save pour garder la conf

on a une connection qui est faite via le switch qui sans conf est une multi-prise

ce qui nous permet de...

```bash
PC1> ping 10.3.1.2

84 bytes from 10.3.1.2 icmp_seq=1 ttl=64 time=1.244 ms
84 bytes from 10.3.1.2 icmp_seq=2 ttl=64 time=1.280 ms
84 bytes from 10.3.1.2 icmp_seq=3 ttl=64 time=1.371 ms
84 bytes from 10.3.1.2 icmp_seq=4 ttl=64 time=1.156 ms
84 bytes from 10.3.1.2 icmp_seq=5 ttl=64 time=0.472 ms


PC2> ping 10.3.1.1

84 bytes from 10.3.1.1 icmp_seq=1 ttl=64 time=2.373 ms
84 bytes from 10.3.1.1 icmp_seq=2 ttl=64 time=1.091 ms
84 bytes from 10.3.1.1 icmp_seq=3 ttl=64 time=1.128 ms
84 bytes from 10.3.1.1 icmp_seq=4 ttl=64 time=1.134 ms
84 bytes from 10.3.1.1 icmp_seq=5 ttl=64 time=1.066 ms
```

oh ça alors on peut ce ping 

![maisnaaan](/TP-s-reseau/infra/tp-3/img/maiisss-non.gif)

et pour ce qui est de la cam table 

```bash
IOU1#show mac address-table
          Mac Address Table
-------------------------------------------

Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
   1    0050.7966.6800    DYNAMIC     Et1/0
   1    0050.7966.6801    DYNAMIC     Et1/1
Total Mac Addresses for this criterion: 2
```

# II. VLAN

## 1. Topologie 2

## 2. Adressage topologie 2

| Node  | IP            | VLAN |
| ----- | ------------- | ---- |
| `pc1` | `10.3.1.1/24` | 10   |
| `pc2` | `10.3.1.2/24` | 10   |
| `pc3` | `10.3.1.3/24` | 20   |

### 3. Setup topologie 2

🌞 **Adressage**

comme tout a l'heure on defini l'ip et on save

```bash
PC3> ip 10.3.1.3
Checking for duplicate address...
PC3 : 10.3.1.3 255.255.255.0

PC3> save
Saving startup configuration to startup.vpc
.  done
```
on check le ping 

```bash
PC2> ping 10.3.1.3

84 bytes from 10.3.1.3 icmp_seq=1 ttl=64 time=0.942 ms
84 bytes from 10.3.1.3 icmp_seq=2 ttl=64 time=1.112 ms
84 bytes from 10.3.1.3 icmp_seq=3 ttl=64 time=1.172 ms
^C
```
on check la cam tab 

```bash
IOU1#show mac address-table
          Mac Address Table
-------------------------------------------

Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
   1    0050.7966.6800    DYNAMIC     Et1/0
   1    0050.7966.6801    DYNAMIC     Et1/1
   1    0050.7966.6802    DYNAMIC     Et2/0
Total Mac Addresses for this criterion: 3
```
aller la tipo est la letsgo to the vlan

![vlan ma boy](/TP-s-reseau/infra/tp-3/img/vlan.png)

🌞 **Configuration des VLANs**

bon debut de conf on ajoute nos vlan on leur donne un petit nom et tada

```bash
IOU1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
IOU1(config)#vlan 10
IOU1(config-vlan)#name admins
IOU1(config-vlan)#exit
IOU1(config)#vlan 20
IOU1(config-vlan)#name client
IOU1(config-vlan)#exit
IOU1(config)#exit
IOU1#sh
*Dec  7 15:01:02.303: %SYS-5-CONFIG_I: Configured from console by console
```
on check avec ```show vlan```
```bash
IOU1#show vlan

VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Et0/0, Et0/1, Et0/2, Et0/3
                                                Et1/0, Et1/1, Et1/2, Et1/3
                                                Et2/0, Et2/1, Et2/2, Et2/3
                                                Et3/0, Et3/1, Et3/2, Et3/3
10   admins                           active    
20   client                           active    
1002 fddi-default                     act/unsup 
1003 token-ring-default               act/unsup 
1004 fddinet-default                  act/unsup 
1005 trnet-default                    act/unsup 

VLAN Type  SAID       MTU   Parent RingNo BridgeNo Stp  BrdgMode Trans1 Trans2
---- ----- ---------- ----- ------ ------ -------- ---- -------- ------ ------
1    enet  100001     1500  -      -      -        -    -        0      0   
10   enet  100010     1500  -      -      -        -    -        0      0   
20   enet  100020     1500  -      -      -        -    -        0      0   
1002 fddi  101002     1500  -      -      -        -    -        0      0   
1003 tr    101003     1500  -      -      -        -    -        0      0   
1004 fdnet 101004     1500  -      -      -        ieee -        0      0   
1005 trnet 101005     1500  -      -      -        ibm  -        0      0   
          
Remote SPAN VLANs
          

Primary Secondary Type              Ports
------- --------- ----------------- ------------------------------------------
```

et mtn on ajoute nos machine au vlan 

```bash
IOU1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
IOU1(config)#interface Ethernet1/0    
IOU1(config-if)#switchport mode access
IOU1(config-if)#switchport access vlan 10
IOU1(config-if)#exit
IOU1(config)#interface Ethernet2/0              
IOU1(config-if)#switchport mode access   
IOU1(config-if)#switchport access vlan 20
IOU1(config-if)#exit
IOU1(config)#exit
IOU1#
*Dec  7 15:07:10.839: %SYS-5-CONFIG_I: Configured from console by console
```

```bash
IOU1#show vlan br

VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Et0/0, Et0/1, Et0/2, Et0/3
                                                Et1/1, Et1/2, Et1/3, Et2/1
                                                Et2/2, Et2/3, Et3/0, Et3/1
                                                Et3/2, Et3/3
10   admins                           active    Et1/0 Et1/1
20   client                           active    Et2/0
```
et normalement tout est bonon a bien le port de specifier a coter de notre vlan donc plus qu'as tester 

🌞 **Vérif**

on a tester et effectivement 

pc1 et pc2 peuvent ce ping 

```bash
PC1> ping 10.3.1.2

84 bytes from 10.3.1.2 icmp_seq=1 ttl=64 time=0.881 ms
84 bytes from 10.3.1.2 icmp_seq=2 ttl=64 time=1.122 ms
84 bytes from 10.3.1.2 icmp_seq=3 ttl=64 time=1.082 ms
^C

PC2> ping 10.3.1.1

84 bytes from 10.3.1.1 icmp_seq=1 ttl=64 time=1.102 ms
84 bytes from 10.3.1.1 icmp_seq=2 ttl=64 time=1.127 ms
84 bytes from 10.3.1.1 icmp_seq=3 ttl=64 time=1.172 ms
^C
```

mais pc3 n'est pas ne peut pas joindre pc1 et 2 et il ne peuvent pas la joindre non plus

```bash
PC2> ping 10.3.1.3

host (10.3.1.3) not reachable


PC3> ping 10.3.1.2

host (10.3.1.2) not reachable
```
![vlan](/TP-s-reseau/infra/tp-3/img/and_vlan.gif)

# III. Ptite VM DHCP

| Node          | IP              | VLAN |
| ------------- | --------------- | ---- |
| `pc1`         | `10.3.1.1/24`   | 10   |
| `pc2`         | `10.3.1.2/24`   | 10   |
| `pc3`         | `10.3.1.3/24`   | 20   |
| `pc4`         | X               | 20   |
| `pc5`         | X               | 10   |
| `dhcp.tp3.b2` | `10.3.1.253/24` | 20   |

🌞 **VM `dhcp.tp3.b2`**

bien on configure notre server dhcp la routine etc et on install dhcpd 

que l'ont conf comme si dessous 

```bash
[root@dhcp dhcp]# cat dhcpd.conf 
default-lease-time 600;
max-lease-time 7200;
authoritative;
subnet 10.3.1.0 netmask 255.255.255.0 {
    range dynamic-bootp 10.3.1.100 10.3.1.200;
}

```

ensuite on l'ajoute a gns3 etc

on le mets bien dans le même lan que pc4, et pc5 lui sera dans le lan 20

une fois ajouter dans gns3 on a juste a faire une command nul dans pc' et pouf 

![dora](/TP-s-reseau/infra/tp-3/img/dora.gif)

```bash
PC4> ip dhcp
DORA
PC4> ip show IP 10.3.1.100/24
Invalid address

PC4> show ip

NAME        : PC4[1]
IP/MASK     : 10.3.1.100/24
GATEWAY     : 0.0.0.0
DNS         : 
DHCP SERVER : 10.3.1.253
DHCP LEASE  : 556, 573/286/501
MAC         : 00:50:79:66:68:03
LPORT       : 20017
RHOST:PORT  : 127.0.0.1:20018
MTU         : 1500
```

on va montrer ici que ça ne marche pas sur pc5

```bash
PC5> ip dhcp
DDD
Can't find dhcp server

PC5> show ip 

NAME        : PC5[1]
IP/MASK     : 0.0.0.0/0
GATEWAY     : 0.0.0.0
DNS         : 
MAC         : 00:50:79:66:68:04
LPORT       : 20019
RHOST:PORT  : 127.0.0.1:20020
MTU         : 1500
```

et voilaaaa fiiiiniiiii

vive le reseau 

go to tp4