```
R1#sh running-config
Building configuration...

interface FastEthernet0/0
 ip address dhcp
 ip nat outside
 ip virtual-reassembly
 duplex auto
 speed auto
!
interface FastEthernet0/1
 ip address 10.8.1.1 255.255.255.252
 duplex auto
 speed auto
!
interface FastEthernet1/0
 no ip address
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
 duplex auto
 speed auto
!
interface FastEthernet1/0.10
 encapsulation dot1Q 10
 ip address 10.1.10.1 255.255.254.0
 ip helper-address 10.1.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.20
 encapsulation dot1Q 20
 ip address 10.1.20.1 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.30
 encapsulation dot1Q 30
 ip address 10.1.30.1 255.255.255.192
 ip helper-address 10.90.0.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.40
 encapsulation dot1Q 40
 ip address 10.1.40.1 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.50
 encapsulation dot1Q 50
 ip address 10.1.50.1 255.255.255.0
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.60
 encapsulation dot1Q 60
 ip address 10.1.60.1 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.70
 encapsulation dot1Q 70
 ip address 10.1.70.1 255.255.254.0
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.80
 encapsulation dot1Q 80
 ip address 10.1.80.1 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet1/0.90
 encapsulation dot1Q 90
 ip address 10.1.90.1 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0
 no ip address
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
 duplex auto
 speed auto
!
interface FastEthernet2/0.10
 encapsulation dot1Q 10
 ip address 10.8.10.1 255.255.254.0
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.20
 encapsulation dot1Q 20
 ip address 10.8.20.14 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.30
 encapsulation dot1Q 30
 ip address 10.8.30.62 255.255.255.192
 ip helper-address 10.90.0.2
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.40
 encapsulation dot1Q 40
 ip address 10.8.40.14 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.50
 encapsulation dot1Q 50
 ip address 10.8.50.254 255.255.255.0
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.60
 encapsulation dot1Q 60
 ip address 10.8.60.14 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.70
 encapsulation dot1Q 70
 ip address 10.8.70.1 255.255.254.0
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.80
 encapsulation dot1Q 80
 ip address 10.8.80.14 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
interface FastEthernet2/0.90
 encapsulation dot1Q 90
 ip address 10.8.90.14 255.255.255.240
 ip helper-address 10.8.40.5
 ip nat inside
 ip virtual-reassembly
!
ip forward-protocol nd
ip route 10.11.0.0 255.255.254.0 10.8.40.5
ip route 10.21.0.0 255.255.255.240 10.8.40.5
ip route 10.31.0.0 255.255.255.192 10.8.40.5
ip route 10.41.0.0 255.255.255.240 10.8.40.5
ip route 10.51.0.0 255.255.255.0 10.8.40.5
ip route 10.61.0.0 255.255.255.240 10.8.40.5
ip route 10.71.0.0 255.255.254.0 10.8.40.5
ip route 10.81.0.0 255.255.255.240 10.8.40.5
ip route 10.91.0.0 255.255.255.240 10.8.40.5
!
!
no ip http server
no ip http secure-server
ip nat inside source list 1 interface FastEthernet0/0 overload
!
access-list 1 permit any
```

## server DCHP

```
[max@localhost ~]$ sudo cat /etc/dhcp/dhcpd.conf
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp-server/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#
option domain-name      "tp8-domain";

option domain-name-servers      1.1.1.1;

default-lease-time      600;

max-lease-time  7200;

authoritative;


subnet 10.1.10.0 netmask 255.255.254.0 {
        range dynamic-bootp 10.8.10.5 10.8.10.253;
        option routers 10.8.10.1;
}

subnet 10.1.20.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.20.1 10.8.20.13;
        option routers 10.8.20.14;
}

subnet 10.1.30.0 netmask 255.255.255.192 {
        range dynamic-bootp 10.8.30.1 10.8.30.60;
        option routers 10.8.30.62;
}

subnet 10.1.40.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.40.1 10.8.40.13;
        option routers 10.8.40.14;
}

subnet 10.1.50.0 netmask 255.255.255.0 {
        range dynamic-bootp 10.8.50.100 10.8.50.200;
        option routers 10.8.50.254;
}

subnet 10.1.60.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.60.1 10.8.60.13;
        option routers 10.8.60.14;
}

subnet 10.1.70.0 netmask 255.255.254.0 {
        range dynamic-bootp 10.8.70.5 10.8.70.253;
        option routers 10.8.70.1;
}

subnet 10.1.80.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.80.1 10.8.80.13;
        option routers 10.8.80.14;
}

subnet 10.1.90.0 netmask 255.255.255.240 {
        range dynamic-bootp 10.8.90.1 10.8.90.13;
        option routers 10.8.90.14;
}
```

avec le petit service DHCPD qui run bieng 

```
[max@dhcp ~]$ systemctl status dhcpd
● dhcpd.service - DHCPv4 Server Daemon
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; preset: disabled)
     Active: active (running) since Tue 2024-05-19 18:47:56 CET; 2h 55min ago
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

