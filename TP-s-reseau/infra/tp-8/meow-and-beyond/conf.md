# Conf Meow-and-Beyond

le fichier chiant et pas drôle a lire 

bon courage soit fort


## le routeur

```
R2#sh running-config
Building configuration...

interface FastEthernet0/0
 ip address dhcp
 ip nat outside
 ip virtual-reassembly
 duplex auto
 speed auto
!
interface FastEthernet0/1
 ip address 10.8.1.2 255.255.255.252
 duplex auto
 speed auto
!
interface FastEthernet1/0
 no ip address
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
 duplex auto
 speed auto
!
interface FastEthernet1/0.11
 encapsulation dot1Q 11
 ip address 10.8.11.1 255.255.254.0
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.21
 encapsulation dot1Q 21
 ip address 10.8.21.14 255.255.255.240
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.31
 encapsulation dot1Q 31
 ip address 10.8.31.62 255.255.255.192
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.41
 encapsulation dot1Q 41
 ip address 10.8.41.14 255.255.255.240
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.51
 encapsulation dot1Q 51
 ip address 10.8.51.254 255.255.255.0
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.61
 encapsulation dot1Q 61
 ip address 10.8.61.14 255.255.255.240
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.71
 encapsulation dot1Q 71
 ip address 10.8.71.1 255.255.254.0
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.81
 encapsulation dot1Q 81
 ip address 10.8.81.14 255.255.255.240
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.91
 encapsulation dot1Q 91
 ip address 10.8.91.14 255.255.255.240
 ip helper-address 10.8.41.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0
 no ip address
 shutdown
 duplex auto
 speed auto
!
ip forward-protocol nd
ip route 0.0.0.0 0.0.0.0 FastEthernet0/1
ip route 10.8.10.0 255.255.254.0 10.8.40.5
ip route 10.8.20.0 255.255.255.240 10.8.40.5
ip route 10.8.30.0 255.255.255.192 10.8.40.5
ip route 10.8.40.0 255.255.255.240 10.8.40.5
ip route 10.8.50.0 255.255.255.0 10.8.40.5
ip route 10.8.60.0 255.255.255.240 10.8.40.5
ip route 10.8.70.0 255.255.254.0 10.8.40.5
ip route 10.8.80.0 255.255.255.240 10.8.40.5
ip route 10.8.90.0 255.255.255.240 10.8.40.5
!
!
no ip http server
no ip http secure-server
ip nat inside source list 1 interface FastEthernet0/0 overload
!
access-list 1 permit any
```

## les switch

sw1 : 
````
sw1#sh running-config
Building configuration...

Current configuration : 2258 bytes
!
! Last configuration change at 18:16:41 UTC tue May 14 2024
!
version 15.2
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
service compress-config
!
hostname sw1MB
!
boot-start-marker
boot-end-marker
!
!
logging discriminator EXCESS severity drops 6 msg-body drops EXCESSCOLL
logging buffered 50000
logging console discriminator EXCESS
!
no aaa new-model
!
```

sw2 Bat1: 
```
sw2Bat1MB#sh running-config
Building configuration...

Current configuration : 2258 bytes
!
! Last configuration change at 18:36:32 UTC tue May 14 2024
!
version 15.2
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
service compress-config
!
hostname sw2Bat1MB
!
boot-start-marker
boot-end-marker
!
!
logging discriminator EXCESS severity drops 6 msg-body drops EXCESSCOLL
logging buffered 50000
logging console discriminator EXCESS
!
no aaa new-model
!
```

sw1 Bat2:
```
sw1Bat2MB#sh running-config
Building configuration...

Current configuration : 2258 bytes
!
! Last configuration change at 18:48:27 UTC tue May 14 2024
!
version 15.2
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
service compress-config
!
hostname sw2Bat2MB
!
boot-start-marker
boot-end-marker
!
!
logging discriminator EXCESS severity drops 6 msg-body drops EXCESSCOLL
logging buffered 50000
logging console discriminator EXCESS
!
no aaa new-model
!
```



## server DCHP

```
[max@dhcpmb ~]$ sudo cat /etc/dhcp/dhcpd.conf

option domain-name      "tp8-domain";

option domain-name-servers      1.1.1.1;

default-lease-time      600;

max-lease-time  7200;

authoritative;


subnet 10.1.11.0 netmask 255.255.254.0 {
        range dynamic-bootp 10.8.11.5 10.8.11.253;
        option routers 10.8.11.1;
}

subnet 10.1.21.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.21.1 10.8.21.13;
        option routers 10.8.21.14;
}

subnet 10.1.31.0 netmask 255.255.255.192 {
        range dynamic-bootp 10.8.31.1 10.8.31.60;
        option routers 10.8.31.62;
}

subnet 10.1.41.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.41.1 10.8.41.13;
        option routers 10.8.41.14;
}

subnet 10.1.51.0 netmask 255.255.255.0 {
        range dynamic-bootp 10.8.51.100 10.8.51.200;
        option routers 10.8.51.254;
}

subnet 10.1.61.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.61.1 10.8.61.13;
        option routers 10.8.61.14;
}

subnet 10.1.71.0 netmask 255.255.254.0 {
        range dynamic-bootp 10.8.71.5 10.8.71.253;
        option routers 10.8.71.1;
}

subnet 10.1.81.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.81.1 10.8.81.13;
        option routers 10.8.81.14;
}

subnet 10.1.91.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.91.1 10.8.91.13;
        option routers 10.8.91.14;
}
```

qui marche evidemment 

```
[max@dhcpmb ~]$ systemctl status dhcpd
● dhcpd.service - DHCPv4 Server Daemon
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; preset: disabled)
     Active: active (running) since Sun 2024-05-19 13:27:06 CET; 3h 35min ago
       Docs: man:dhcpd(8)
             man:dhcpd.conf(5)
   Main PID: 803 (dhcpd)
     Status: "Dispatching packets..."
      Tasks: 1 (limit: 11038)
     Memory: 7.6M
        CPU: 10ms
     CGroup: /system.slice/dhcpd.service
             └─803 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid
```
