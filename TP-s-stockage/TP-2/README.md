# TP - 2 - Modest Storage SAN 

## I le setup de tout ce machin chelou

j'en parlerai pas

mais ça marche on a la topo et on en parle plus 

![toto](/TP-s-stockage/TP-2/picture/fdb-farine-de-blé.gif)

## II. San Network

### 1. Storage machines

#### A. Disks and RAID.


bon créé du RAID easy on a déja fait

```bash
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdX /dev/sdY
```

````bash
[max@sto1 ~]$ lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda                8:0    0   10G  0 disk  
├─sda1             8:1    0    1G  0 part  /boot
└─sda2             8:2    0    9G  0 part
  ├─rl_vbox-root 253:0    0    8G  0 lvm   /
  └─rl_vbox-swap 253:1    0    1G  0 lvm   [SWAP]
sdb                8:16   0    1G  0 disk
└─md0              9:0    0 1022M  0 raid1
sdc                8:32   0    1G  0 disk
└─md0              9:0    0 1022M  0 raid1
sdd                8:48   0    1G  0 disk
└─md1              9:1    0 1022M  0 raid1
sde                8:64   0    1G  0 disk
└─md2              9:2    0 1022M  0 raid1
sdf                8:80   0    1G  0 disk
└─md1              9:1    0 1022M  


[max@sto2 ~]$ lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda                8:0    0   10G  0 disk  
├─sda1             8:1    0    1G  0 part  /boot
└─sda2             8:2    0    9G  0 part
  ├─rl_vbox-root 253:0    0    8G  0 lvm   /
  └─rl_vbox-swap 253:1    0    1G  0 lvm   [SWAP]
sdb                8:16   0    1G  0 disk
└─md0              9:0    0 1022M  0 raid1
sdc                8:32   0    1G  0 disk
└─md0              9:0    0 1022M  0 raid1
sdd                8:48   0    1G  0 disk
└─md1              9:1    0 1022M  0 raid1
sde                8:64   0    1G  0 disk
└─md1              9:1    0 1022M  0 raid1
sdf                8:80   0    1G  0 disk
└─md2              9:2    0 1022M  0 raid1
sdg                8:96   0    1G  0 disk
└─md2              9:2    0 1022M  0 raid1
sr0               11:0    1 1024M  0 rom 
````

#### B. iSCSi target 

On a installé targetcli

````
[max@sto2 ~]$ sudo systemctl status target
● target.service - Restore LIO kernel target configuration
     Loaded: loaded (/usr/lib/systemd/system/target.service; enabled; preset: disabled)
     Active: active (exited) since Sun 2024-12-08 17:48:53 CET; 5min ago
    Process: 787 ExecStart=/usr/bin/targetctl restore (code=exited, status=0/SUCCESS)
   Main PID: 787 (code=exited, status=0/SUCCESS)
        CPU: 184ms

Dec 08 17:48:52 sto2 systemd[1]: Starting Restore LIO kernel target configuration...
Dec 08 17:48:53 sto2 systemd[1]: Finished Restore LIO kernel target configuration.
````

on conf la target iscsi sur sto1 et 2
```bash
/> ls
o- / ......................................................................................................................... [...]
  o- backstores .............................................................................................................. [...]
  | o- block .................................................................................................. [Storage Objects: 0]
  | o- fileio ................................................................................................. [Storage Objects: 0]
  | o- pscsi .................................................................................................. [Storage Objects: 0]
  | o- ramdisk ................................................................................................ [Storage Objects: 0]
  o- iscsi ............................................................................................................ [Targets: 0]
  o- loopback ......................................................................................................... [Targets: 0]
/> /backstores/fileio create name=data-chunk1 file_or_dev=/dev/md0 
Note: block backstore preferred for best results
Created fileio data-chunk1 with size 1071644672
/> /iscsi create iqn.2024-12.tp2.b3:data-chunk1
Created target iqn.2024-12.tp2.b3:data-chunk1.
Created TPG 1.
Global pref auto_add_default_portal=true
Created default portal listening on all IPs (0.0.0.0), port 3260.
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk1/tpg1/acls create iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
Created Node ACL for iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk1/tpg1/luns/ create /backstores/fileio/data-chunk1
Created LUN 0.
Created LUN 0->0 mapping in node ACL iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
/> /backstores/fileio create name=data-chunk2 file_or_dev=/dev/md1
Note: block backstore preferred for best results
Created fileio data-chunk2 with size 1071644672
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk2/tpg1/acls create iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
No such path /iscsi/iqn.2024-12.tp2.b3:data-chunk2
/> /iscsi create iqn.2024-12.tp2.b3:data-chunk2
Created target iqn.2024-12.tp2.b3:data-chunk2.
Created TPG 1.
Global pref auto_add_default_portal=true
Created default portal listening on all IPs (0.0.0.0), port 3260.
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk2/tpg1/acls create iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
Created Node ACL for iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk2/tpg1/luns/ create /backstores/fileio/data-chunk2
Created LUN 0.
Created LUN 0->0 mapping in node ACL iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
/> ls
o- / ......................................................................................................................... [...]
  o- backstores .............................................................................................................. [...]
  | o- block .................................................................................................. [Storage Objects: 0]
  | o- fileio ................................................................................................. [Storage Objects: 2]
  | | o- data-chunk1 ................................................................... [/dev/md0 (1022.0MiB) write-back activated]
  | | | o- alua ................................................................................................... [ALUA Groups: 1]
  | | |   o- default_tg_pt_gp ....................................................................... [ALUA state: Active/optimized]
  | | o- data-chunk2 ................................................................... [/dev/md1 (1022.0MiB) write-back activated]
  | |   o- alua ................................................................................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ....................................................................... [ALUA state: Active/optimized]
  | o- pscsi .................................................................................................. [Storage Objects: 0]
  | o- ramdisk ................................................................................................ [Storage Objects: 0]
  o- iscsi ............................................................................................................ [Targets: 2]
  | o- iqn.2024-12.tp2.b3:data-chunk1 .................................................................................... [TPGs: 1]
  | | o- tpg1 ............................................................................................... [no-gen-acls, no-auth]
  | |   o- acls .......................................................................................................... [ACLs: 1]
  | |   | o- iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator ...................................................... [Mapped LUNs: 1]
  | |   |   o- mapped_lun0 .......................................................................... [lun0 fileio/data-chunk1 (rw)]
  | |   o- luns .......................................................................................................... [LUNs: 1]
  | |   | o- lun0 ............................................................... [fileio/data-chunk1 (/dev/md0) (default_tg_pt_gp)]
  | |   o- portals .................................................................................................... [Portals: 1]
  | |     o- 0.0.0.0:3260 ..................................................................................................... [OK]
  | o- iqn.2024-12.tp2.b3:data-chunk2 .................................................................................... [TPGs: 1]
  |   o- tpg1 ............................................................................................... [no-gen-acls, no-auth]
  |     o- acls .......................................................................................................... [ACLs: 1]
  |     | o- iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator ...................................................... [Mapped LUNs: 1]
  |     |   o- mapped_lun0 .......................................................................... [lun0 fileio/data-chunk2 (rw)]
  |     o- luns .......................................................................................................... [LUNs: 1]
  |     | o- lun0 ............................................................... [fileio/data-chunk2 (/dev/md1) (default_tg_pt_gp)]
  |     o- portals .................................................................................................... [Portals: 1]
  |       o- 0.0.0.0:3260 ..................................................................................................... [OK]
  o- loopback ......................................................................................................... [Targets: 0]
/> /backstores/fileio create name=data-chunk3 file_or_dev=/dev/md2
Note: block backstore preferred for best results
Created fileio data-chunk3 with size 1071644672
/> /iscsi create iqn.2024-12.tp2.b3:data-chunk3
Created target iqn.2024-12.tp2.b3:data-chunk3.
Created TPG 1.
Global pref auto_add_default_portal=true
Created default portal listening on all IPs (0.0.0.0), port 3260.
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk3/tpg1/acls create iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
Created Node ACL for iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
/> /iscsi/iqn.2024-12.tp2.b3:data-chunk3/tpg1/luns/ create /backstores/fileio/data-chunk3
Created LUN 0.
Created LUN 0->0 mapping in node ACL iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
/> saveconfig 
Configuration saved to /etc/target/saveconfig.json
/> ls
o- / ......................................................................................................................... [...]
  o- backstores .............................................................................................................. [...]
  | o- block .................................................................................................. [Storage Objects: 0]
  | o- fileio ................................................................................................. [Storage Objects: 3]
  | | o- data-chunk1 ................................................................... [/dev/md0 (1022.0MiB) write-back activated]
  | | | o- alua ................................................................................................... [ALUA Groups: 1]
  | | |   o- default_tg_pt_gp ....................................................................... [ALUA state: Active/optimized]
  | | o- data-chunk2 ................................................................... [/dev/md1 (1022.0MiB) write-back activated]
  | | | o- alua ................................................................................................... [ALUA Groups: 1]
  | | |   o- default_tg_pt_gp ....................................................................... [ALUA state: Active/optimized]
  | | o- data-chunk3 ................................................................... [/dev/md2 (1022.0MiB) write-back activated]
  | |   o- alua ................................................................................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ....................................................................... [ALUA state: Active/optimized]
  | o- pscsi .................................................................................................. [Storage Objects: 0]
  | o- ramdisk ................................................................................................ [Storage Objects: 0]
  o- iscsi ............................................................................................................ [Targets: 3]
  | o- iqn.2024-12.tp2.b3:data-chunk1 .................................................................................... [TPGs: 1]
  | | o- tpg1 ............................................................................................... [no-gen-acls, no-auth]
  | |   o- acls .......................................................................................................... [ACLs: 1]
  | |   | o- iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator ...................................................... [Mapped LUNs: 1]
  | |   |   o- mapped_lun0 .......................................................................... [lun0 fileio/data-chunk1 (rw)]
  | |   o- luns .......................................................................................................... [LUNs: 1]
  | |   | o- lun0 ............................................................... [fileio/data-chunk1 (/dev/md0) (default_tg_pt_gp)]
  | |   o- portals .................................................................................................... [Portals: 1]
  | |     o- 0.0.0.0:3260 ..................................................................................................... [OK]
  | o- iqn.2024-12.tp2.b3:data-chunk2 .................................................................................... [TPGs: 1]
  | | o- tpg1 ............................................................................................... [no-gen-acls, no-auth]
  | |   o- acls .......................................................................................................... [ACLs: 1]
  | |   | o- iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator ...................................................... [Mapped LUNs: 1]
  | |   |   o- mapped_lun0 .......................................................................... [lun0 fileio/data-chunk2 (rw)]
  | |   o- luns .......................................................................................................... [LUNs: 1]
  | |   | o- lun0 ............................................................... [fileio/data-chunk2 (/dev/md1) (default_tg_pt_gp)]
  | |   o- portals .................................................................................................... [Portals: 1]
  | |     o- 0.0.0.0:3260 ..................................................................................................... [OK]
  | o- iqn.2024-12.tp2.b3:data-chunk3 .................................................................................... [TPGs: 1]
  |   o- tpg1 ............................................................................................... [no-gen-acls, no-auth]
  |     o- acls .......................................................................................................... [ACLs: 1]
  |     | o- iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator ...................................................... [Mapped LUNs: 1]
  |     |   o- mapped_lun0 .......................................................................... [lun0 fileio/data-chunk3 (rw)]
  |     o- luns .......................................................................................................... [LUNs: 1]
  |     | o- lun0 ............................................................... [fileio/data-chunk3 (/dev/md2) (default_tg_pt_gp)]
  |     o- portals .................................................................................................... [Portals: 1]
  |       o- 0.0.0.0:3260 ..................................................................................................... [OK]
  o- loopback ......................................................................................................... [Targets: 0]
```

### 2. Chunks machine

#### A. Simple iSCSi 

on install iscsid

```bash
[max@chunk1 ~]$ systemctl status iscsid
● iscsid.service - Login and scanning of iSCSI devices
     Loaded: loaded (/usr/lib/systemd/system/iscsi.service; indirect; preset: enabled)
     Active: active (exited) since Sun 2024-12-08 17:47:57 CET; 9min ago
       Docs: man:iscsiadm(8)
             man:iscsid(8)
    Process: 841 ExecStart=/usr/sbin/iscsiadm -m node --loginall=automatic -W (code=exited, status=0/SUCCESS)
    Process: 850 ExecReload=/usr/sbin/iscsiadm -m node --loginall=automatic -W (code=exited, status=0/SUCCESS)
   Main PID: 841 (code=exited, status=0/SUCCESS)
        CPU: 7ms
```

la list maudite

![tott](/TP-s-stockage/TP-2/picture/laliste.gif)

```bash
[max@chunk1 ~]$ sudo iscsiadm -m node
[sudo] password for max: 
10.3.1.1:3260,1 iqn.2024-12.tp2.b3:data-chunk1
10.3.1.2:3260,1 iqn.2024-12.tp2.b3:data-chunk1
10.3.2.1:3260,1 iqn.2024-12.tp2.b3:data-chunk1
10.3.2.2:3260,1 iqn.2024-12.tp2.b3:data-chunk1
10.3.1.1:3260,1 iqn.2024-12.tp2.b3:data-chunk2
10.3.1.2:3260,1 iqn.2024-12.tp2.b3:data-chunk2
10.3.2.1:3260,1 iqn.2024-12.tp2.b3:data-chunk2
10.3.2.2:3260,1 iqn.2024-12.tp2.b3:data-chunk2
10.3.1.1:3260,1 iqn.2024-12.tp2.b3:data-chunk3
10.3.1.2:3260,1 iqn.2024-12.tp2.b3:data-chunk3
10.3.2.1:3260,1 iqn.2024-12.tp2.b3:data-chunk3
10.3.2.2:3260,1 iqn.2024-12.tp2.b3:data-chunk3
```

```bash
[max@chunk1 ~]$ sudo cat /etc/iscsi/iscsid.conf | grep node.session.timeo.replacement_timeout
node.session.timeo.replacement_timeout = 0
```

on est d'accord


````bash
[max@chunk1 ~]$ sudo lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0   20G  0 disk  
├─sda1        8:1    0    1G  0 part  /boot
└─sda2        8:2    0   19G  0 part  
  ├─rl-root 253:0    0   17G  0 lvm   /
  └─rl-swap 253:1    0    2G  0 lvm   [SWAP]
sdb           8:16   0    5G  0 disk  
sdc           8:32   0    5G  0 disk  
sdd           8:48   0    5G  0 disk  
sde           8:64   0    5G  0 disk  
sr0          11:0    1 1024M  0 rom   
````

la aussi

![tata](/TP-s-stockage/TP-2/picture/artus-victor-artus-solaro.gif)

```bash
[root@chunk1 ~]$ sudo iscsiadm -m session -P 3 
iSCSI Transport Class version 2.0-870
version 6.2.1.9
Target: iqn.2024-12.tp2.b3:data-chunk1 (non-flash)
        Current Portal: 10.3.2.2:3260,1
        Persistent Portal: 10.3.2.2:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
                Iface IPaddress: 10.3.2.101
                Iface HWaddress: default
                Iface Netdev: default
                SID: 1
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 3  State: running
                scsi3 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdb          State: running
        Current Portal: 10.3.1.2:3260,1
        Persistent Portal: 10.3.1.2:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
                Iface IPaddress: 10.3.1.101
                Iface HWaddress: default
                Iface Netdev: default
                SID: 10
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 10 State: running
                scsi10 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdd          State: running
        Current Portal: 10.3.1.1:3260,1
        Persistent Portal: 10.3.1.1:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
                Iface IPaddress: 10.3.1.101
                Iface HWaddress: default
                Iface Netdev: default
                SID: 4
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 4  State: running
                scsi4 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdc          State: running
        Current Portal: 10.3.2.1:3260,1
        Persistent Portal: 10.3.2.1:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk1:chunk1-initiator
                Iface IPaddress: 10.3.2.101
                Iface HWaddress: default
                Iface Netdev: default
                SID: 5
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 5  State: running
                scsi5 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sde          State: running
```

#### B. Multipathing 

bien multipath à nous deux 

![toto](/TP-s-stockage/TP-2/picture/rdr2.gif)

```bash
[max@chunk1 ~]$ systemctl status multipathd
● multipathd.service - Device-Mapper Multipath Device Controller
     Loaded: loaded (/usr/lib/systemd/system/multipathd.service; enabled; preset: enabled)
     Active: active (running) since Sun 2024-12-08 17:47:54 CET; 22min ago
TriggeredBy: ● multipathd.socket
    Process: 640 ExecStartPre=/sbin/modprobe -a scsi_dh_alua scsi_dh_emc scsi_dh_rdac dm-multipath (code=exited, status=0/SUCCESS)
    Process: 643 ExecStartPre=/sbin/multipath -A (code=exited, status=0/SUCCESS)
   Main PID: 644 (multipathd)
     Status: "up"
      Tasks: 7
     Memory: 21.0M
        CPU: 433ms
     CGroup: /system.slice/multipathd.service
             └─644 /sbin/multipathd -d -s
```

multipath.conf


```bash
[max@chunk1 ~]$ cat /etc/multipath.conf 
defaults {
  user_friendly_names yes
  find_multipaths yes
  path_grouping_policy failover
  features "1 queue_if_no_path"
  no_path_retry 100
}
```

lsblk multipath :


```bash
[max@chunk1 ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0   20G  0 disk  
├─sda1        8:1    0    1G  0 part  /boot
└─sda2        8:2    0   19G  0 part  
  ├─rl-root 253:0    0   17G  0 lvm   /
  └─rl-swap 253:1    0    2G  0 lvm   [SWAP]
sdb           8:16   0    5G  0 disk  
└─mpatha    253:2    0    5G  0 mpath 
sdc           8:32   0    5G  0 disk  
└─mpathb    253:4    0    5G  0 mpath 
sdd           8:48   0    5G  0 disk  
└─mpatha    253:2    0    5G  0 mpath 
sde           8:64   0    5G  0 disk  
└─mpathb    253:4    0    5G  0 mpath 
sr0          11:0    1 1024M  0 rom  
```

```bash
[max@chunk1 ~]$ sudo multipath -ll
mpatha (36001405e5bf5c158c4e4a5398ccba2cc) dm-2 LIO-ORG,data-chunk1
size=5.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=enabled
| `- 3:0:0:0  sdb 8:16 active ready running
`-+- policy='service-time 0' prio=50 status=active
  `- 10:0:0:0 sdd 8:48 active ready running
mpathb (3600140566ee7fadd60740a0afd27f8d5) dm-4 LIO-ORG,data-chunk1
size=5.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=active
| `- 4:0:0:0  sdc 8:32 active ready running
`-+- policy='service-time 0' prio=50 status=enabled
  `- 5:0:0:0  sde 8:64 active ready running
```

### 3. Formatage et montage : 

up up up on monte tt ça

![](/TP-s-stockage/TP-2/picture/15b857d3947b0752e3f4366049a5d6c1.gif)


```bash 
[max@chunk1 ~]$sudo fdisk -l
Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x431a3bfd

Device     Boot   Start      End  Sectors Size Id Type
/dev/sda1  *       2048  2099199  2097152   1G 83 Linux
/dev/sda2       2099200 41943039 39843840  19G 8e Linux LVM


Disk /dev/mapper/rl-root: 17 GiB, 18249416704 bytes, 35643392 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/rl-swap: 2 GiB, 2147483648 bytes, 4194304 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdb: 5 GiB, 5363466240 bytes, 10475520 sectors
Disk model: data-chunk1     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 8388608 bytes
Disklabel type: dos
Disk identifier: 0x9dadc42a

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1       16384 10475519 10459136   5G 83 Linux


Disk /dev/mapper/mpatha: 5 GiB, 5363466240 bytes, 10475520 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 8388608 bytes
Disklabel type: dos
Disk identifier: 0x9dadc42a

Device              Boot Start      End  Sectors Size Id Type
/dev/mapper/mpatha1      16384 10475519 10459136   5G 83 Linux


Disk /dev/sdc: 5 GiB, 5363466240 bytes, 10475520 sectors
Disk model: data-chunk1     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 8388608 bytes
Disklabel type: dos
Disk identifier: 0x9593d560

Device     Boot Start      End  Sectors Size Id Type
/dev/sdc1       16384 10475519 10459136   5G 83 Linux


Disk /dev/sdd: 5 GiB, 5363466240 bytes, 10475520 sectors
Disk model: data-chunk1     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 8388608 bytes
Disklabel type: dos
Disk identifier: 0x9dadc42a

Device     Boot Start      End  Sectors Size Id Type
/dev/sdd1       16384 10475519 10459136   5G 83 Linux


Disk /dev/sde: 5 GiB, 5363466240 bytes, 10475520 sectors
Disk model: data-chunk1     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 8388608 bytes
Disklabel type: dos
Disk identifier: 0x9593d560

Device     Boot Start      End  Sectors Size Id Type
/dev/sde1       16384 10475519 10459136   5G 83 Linux


Disk /dev/mapper/mpathb: 5 GiB, 5363466240 bytes, 10475520 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 8388608 bytes
Disklabel type: dos
Disk identifier: 0x9593d560

Device              Boot Start      End  Sectors Size Id Type
/dev/mapper/mpathb1      16384 10475519 10459136   5G 83 Linux
```

une fois tout ça fait ça donne ça

```bash
[max@chunk1 ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0   20G  0 disk  
├─sda1        8:1    0    1G  0 part  /boot
└─sda2        8:2    0   19G  0 part  
  ├─rl-root 253:0    0   17G  0 lvm   /
  └─rl-swap 253:1    0    2G  0 lvm   [SWAP]
sdb           8:16   0    5G  0 disk  
└─mpatha    253:2    0    5G  0 mpath 
  └─mpatha1 253:3    0    5G  0 part  /mnt/data_chunk1
sdc           8:32   0    5G  0 disk  
└─mpathb    253:4    0    5G  0 mpath 
  └─mpathb1 253:5    0    5G  0 part  /mnt/data_chunk2
sdd           8:48   0    5G  0 disk  
└─mpatha    253:2    0    5G  0 mpath 
  └─mpatha1 253:3    0    5G  0 part  /mnt/data_chunk1
sde           8:64   0    5G  0 disk  
└─mpathb    253:4    0    5G  0 mpath 
  └─mpathb1 253:5    0    5G  0 part  /mnt/data_chunk2
sr0          11:0    1 1024M  0 rom   
[max@chunk1 ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                229M     0  229M   0% /dev/shm
tmpfs                 92M  2.5M   89M   3% /run
/dev/mapper/rl-root   17G  1.7G   16G  11% /
/dev/sda1            960M  431M  530M  45% /boot
/dev/mapper/mpatha1  5.0G   68M  4.9G   2% /mnt/data_chunk1
/dev/mapper/mpathb1  5.0G   68M  4.9G   2% /mnt/data_chunk2
tmpfs                 46M     0   46M   0% /run/user/1000
```

## 4. test

bien je crois que ça devais plus marcher bah ça a plus marcher du tout du tout. gns3 je te haie

![](/TP-s-stockage/TP-2/picture/Bk7D4Q.gif)

## 5. Replicate. 

bon pour les deux zosio on fait pareil

![](/TP-s-stockage/TP-2/picture/oopsies-ohno.gif)

chunk2
```bash


[max@chunk2 ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0   20G  0 disk  
├─sda1        8:1    0    1G  0 part  /boot
└─sda2        8:2    0   19G  0 part  
  ├─rl-root 253:0    0   17G  0 lvm   /
  └─rl-swap 253:1    0    2G  0 lvm   [SWAP]
sdb           8:16   0    5G  0 disk  
├─sdb1        8:17   0    5G  0 part  
└─mpatha    253:2    0    5G  0 mpath 
  └─mpatha1 253:4    0    5G  0 part  /mnt/data_chunk1
sdc           8:32   0    5G  0 disk  
├─sdc1        8:33   0    5G  0 part  
└─mpathb    253:3    0    5G  0 mpath 
  └─mpathb1 253:5    0    5G  0 part  /mnt/data_chunk2
sdd           8:48   0    5G  0 disk  
├─sdd1        8:49   0    5G  0 part  
└─mpatha    253:2    0    5G  0 mpath 
  └─mpatha1 253:4    0    5G  0 part  /mnt/data_chunk1
sde           8:64   0    5G  0 disk  
├─sde1        8:65   0    5G  0 part  
└─mpathb    253:3    0    5G  0 mpath 
  └─mpathb1 253:5    0    5G  0 part  /mnt/data_chunk2
sr0          11:0    1 1024M  0 rom   


[max@chunk2 ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                229M     0  229M   0% /dev/shm
tmpfs                 92M  3.4M   88M   4% /run
/dev/mapper/rl-root   17G  1.7G   16G  10% /
/dev/sda1            960M  431M  530M  45% /boot
tmpfs                 46M     0   46M   0% /run/user/1000
/dev/mapper/mpatha1  5.0G   68M  4.9G   2% /mnt/data_chunk1
/dev/mapper/mpathb1  5.0G   68M  4.9G   2% /mnt/data_chunk2



[max@chunk2 ~]$ sudo iscsiadm -m session -P 3
iSCSI Transport Class version 2.0-870
version 6.2.1.9
Target: iqn.2024-12.tp2.b3:data-chunk2 (non-flash)
        Current Portal: 10.3.1.2:3260,1
        Persistent Portal: 10.3.1.2:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
                Iface IPaddress: 10.3.1.102
                Iface HWaddress: default
                Iface Netdev: default
                SID: 48
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 3  State: running
                scsi3 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdb          State: running
        Current Portal: 10.3.2.1:3260,1
        Persistent Portal: 10.3.2.1:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
                Iface IPaddress: 10.3.2.102
                Iface HWaddress: default
                Iface Netdev: default
                SID: 49
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 4  State: running
                scsi4 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sde          State: running
        Current Portal: 10.3.1.1:3260,1
        Persistent Portal: 10.3.1.1:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
                Iface IPaddress: 10.3.1.102
                Iface HWaddress: default
                Iface Netdev: default
                SID: 53
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 8  State: running
                scsi8 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdc          State: running
        Current Portal: 10.3.2.2:3260,1
        Persistent Portal: 10.3.2.2:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk2:chunk2-initiator
                Iface IPaddress: 10.3.2.102
                Iface HWaddress: default
                Iface Netdev: default
                SID: 54
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 9  State: running
                scsi9 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdd          State: running


[max@chunk2 ~]$ sudo multipath -ll
mpatha (36001405db562ce454f54628969266d41) dm-2 LIO-ORG,data-chunk2
size=5.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=active
| `- 3:0:0:0 sdb 8:16 active ready running
`-+- policy='service-time 0' prio=50 status=enabled
  `- 9:0:0:0 sdd 8:48 active ready running
mpathb (360014053f73c389d13d4a11972fc461e) dm-3 LIO-ORG,data-chunk2
size=5.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=active
| `- 4:0:0:0 sde 8:64 active ready running
`-+- policy='service-time 0' prio=50 status=enabled
  `- 8:0:0:0 sdc 8:32 active ready running

```

et chunk3


```bash
[max@chunk3 ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0   20G  0 disk  
├─sda1        8:1    0    1G  0 part  /boot
└─sda2        8:2    0   19G  0 part  
  ├─rl-root 253:0    0   17G  0 lvm   /
  └─rl-swap 253:1    0    2G  0 lvm   [SWAP]
sdb           8:16   0    5G  0 disk  
└─mpatha    253:2    0    5G  0 mpath 
  └─mpatha1 253:4    0    5G  0 part  /mnt/data_chunk1
sdc           8:32   0    5G  0 disk  
└─mpathb    253:3    0    5G  0 mpath 
  └─mpathb1 253:5    0    5G  0 part  /mnt/data_chunk2
sdd           8:48   0    5G  0 disk  
└─mpathb    253:3    0    5G  0 mpath 
  └─mpathb1 253:5    0    5G  0 part  /mnt/data_chunk2
sde           8:64   0    5G  0 disk  
└─mpatha    253:2    0    5G  0 mpath 
  └─mpatha1 253:4    0    5G  0 part  /mnt/data_chunk1
sr0          11:0    1 1024M  0 rom   



[max@chunk3 ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                229M     0  229M   0% /dev/shm
tmpfs                 92M  2.5M   89M   3% /run
/dev/mapper/rl-root   17G  1.7G   16G  10% /
/dev/sda1            960M  431M  530M  45% /boot
tmpfs                 46M     0   46M   0% /run/user/1000
/dev/mapper/mpatha1  5.0G   68M  4.9G   2% /mnt/data_chunk1
/dev/mapper/mpathb1  5.0G   68M  4.9G   2% /mnt/data_chunk2


[max@chunk3 ~]$ sudo iscsiadm -m session -P 3
iSCSI Transport Class version 2.0-870
version 6.2.1.9
Target: iqn.2024-12.tp2.b3:data-chunk3 (non-flash)
        Current Portal: 10.3.1.1:3260,1
        Persistent Portal: 10.3.1.1:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
                Iface IPaddress: 10.3.1.103
                Iface HWaddress: default
                Iface Netdev: default
                SID: 10
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 11 State: running
                scsi11 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdb          State: running
        Current Portal: 10.3.1.2:3260,1
        Persistent Portal: 10.3.1.2:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
                Iface IPaddress: 10.3.1.103
                Iface HWaddress: default
                Iface Netdev: default
                SID: 11
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 12 State: running
                scsi12 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdc          State: running
        Current Portal: 10.3.2.1:3260,1
        Persistent Portal: 10.3.2.1:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
                Iface IPaddress: 10.3.2.103
                Iface HWaddress: default
                Iface Netdev: default
                SID: 12
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 13 State: running
                scsi13 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sde          State: running
        Current Portal: 10.3.2.2:3260,1
        Persistent Portal: 10.3.2.2:3260,1
                **********
                Interface:
                **********
                Iface Name: default
                Iface Transport: tcp
                Iface Initiatorname: iqn.2024-12.tp2.b3:data-chunk3:chunk3-initiator
                Iface IPaddress: 10.3.2.103
                Iface HWaddress: default
                Iface Netdev: default
                SID: 3
                iSCSI Connection State: LOGGED IN
                iSCSI Session State: LOGGED_IN
                Internal iscsid Session State: NO CHANGE
                *********
                Timeouts:
                *********
                Recovery Timeout: 5
                Target Reset Timeout: 30
                LUN Reset Timeout: 30
                Abort Timeout: 15
                *****
                CHAP:
                *****
                username: <empty>
                password: ********
                username_in: <empty>
                password_in: ********
                ************************
                Negotiated iSCSI params:
                ************************
                HeaderDigest: None
                DataDigest: None
                MaxRecvDataSegmentLength: 262144
                MaxXmitDataSegmentLength: 262144
                FirstBurstLength: 65536
                MaxBurstLength: 262144
                ImmediateData: Yes
                InitialR2T: Yes
                MaxOutstandingR2T: 1
                ************************
                Attached SCSI devices:
                ************************
                Host Number: 3  State: running
                scsi3 Channel 00 Id 0 Lun: 0
                        Attached scsi disk sdd          State: running


[max@chunk3 ~]$ sudo multipath -ll
mpatha (360014057fd41286d7d046b4a5b43e855) dm-2 LIO-ORG,data-chunk3
size=5.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=active
| `- 11:0:0:0 sdb 8:16 active ready running
`-+- policy='service-time 0' prio=50 status=enabled
  `- 13:0:0:0 sde 8:64 active ready running
mpathb (3600140557bb1dc1ce1442fb807ead65d) dm-3 LIO-ORG,data-chunk3
size=5.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=active
| `- 12:0:0:0 sdc 8:32 active ready running
`-+- policy='service-time 0' prio=50 status=enabled
  `- 3:0:0:0  sdd 8:48 active ready running
```

## III. Distributed Filesystem.

on prend ce bon vieux man pour l'install

![](/TP-s-stockage/TP-2/picture/200w%20(1).gif)

```bash
[root@master ~]$ dnf install moosefs-master 
MooseFS 9 - x86_64                                                                                                                                            17 kB/s | 6.1 kB     00:00    
Dependencies resolved.
=============================================================================================================================================================================================
 Package                                         Architecture                            Version                                              Repository                                Size
=============================================================================================================================================================================================
Installing:
 moosefs-master                                  x86_64                                  3.0.118-1.rhsystemd                                  MooseFS                                  379 k

Transaction Summary
=============================================================================================================================================================================================
Install  1 Package

Total download size: 379 k
Installed size: 873 k
Is this ok [y/N]: y
Downloading Packages:
moosefs-master-3.0.118-1.rhsystemd.x86_64.rpm                                                                                                                427 kB/s | 379 kB     00:00    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                        424 kB/s | 379 kB     00:00     
MooseFS 9 - x86_64                                                                                                                                           1.7 MB/s | 1.8 kB     00:00    
Importing GPG key 0xCF82ADBA:
 Userid     : "MooseFS Development Team (Official MooseFS Repositories) <support@moosefs.com>"
 Fingerprint: 0F42 5A56 8FAF F43D EA2F 6843 0427 65FC CF82 ADBA
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-MooseFS
Is this ok [y/N]: y
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                     1/1 
  Running scriptlet: moosefs-master-3.0.118-1.rhsystemd.x86_64                                                                                                                           1/1 
  Installing       : moosefs-master-3.0.118-1.rhsystemd.x86_64                                                                                                                           1/1 
  Running scriptlet: moosefs-master-3.0.118-1.rhsystemd.x86_64                                                                                                                           1/1 
  Verifying        : moosefs-master-3.0.118-1.rhsystemd.x86_64                                                                                                                           1/1 

Installed:
  moosefs-master-3.0.118-1.rhsystemd.x86_64                                                                                                                                                  

Complete!
[root@master mfs]$ cp mfsmaster.cfg.sample mfsmaster.cfg
[root@master mfs]$ ll
total 48
-rw-r--r--. 1 root root  6441 Dec  8 20:05 mfsexports.cfg
-rw-r--r--. 1 root root  6441 Aug  2 16:18 mfsexports.cfg.sample
-rw-r--r--. 1 root root 11618 Dec  8 20:05 mfsmaster.cfg
-rw-r--r--. 1 root root 11618 Aug  2 16:18 mfsmaster.cfg.sample
-rw-r--r--. 1 root root  2588 Dec  8 20:05 mfstopology.cfg
-rw-r--r--. 1 root root  2588 Aug  2 16:18 mfstopology.cfg.sample
[root@master mfs]$ sudo cp mfsexports.cfg.sample mfsexports.cfg
```

on continue mon ami

```bash
[root@chunk1 ~]# curl "https://repository.moosefs.com/RPM-GPG-KEY-Moosefs" > /etc/pki/rpm-gpg/RPM-GPG-KEY-Moosefs
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   196  100   196    0     0    715      0 --:--:-- --:--:-- --:--:--   715
[root@master ~]# curl "https://repository.moosefs.com/MooseFS-3-el9.repo" > /etc/yum.repos.d/MooseFS.repo
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   175  100   175    0     0    660      0 --:--:-- --:--:-- --:--:--   660
```

vous vous vous ouvrer sinon je... 

![](/TP-s-stockage/TP-2/picture/thanos-infinity.gif)

```bash
[mmederic@master ~]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3 enp0s8 enp0s9
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 80/tcp 9425/tcp 9419/tcp 9420/tcp 9421/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

merci


redemarito el servicito 

![](/TP-s-stockage/TP-2/picture/magie.gif)

```bash
[root@master ~]$ systemctl status moosefs-master
● moosefs-master.service - MooseFS Master server
     Loaded: loaded (/usr/lib/systemd/system/moosefs-master.service; enabled; preset: disabled)
     Active: active (running) since Sun 2024-12-08 20:11:11 CET; 3min 23s ago
    Process: 1487 ExecStart=/usr/sbin/mfsmaster start (code=exited, status=0/SUCCESS)
   Main PID: 1489 (mfsmaster)
      Tasks: 2 (limit: 2658)
     Memory: 125.3M
        CPU: 1.320s
     CGroup: /system.slice/moosefs-master.service
             ├─1489 /usr/sbin/mfsmaster start
             └─1490 "mfsmaster (data writer)"
```

and it's goodito