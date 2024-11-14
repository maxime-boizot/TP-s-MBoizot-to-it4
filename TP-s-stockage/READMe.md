# TP1 Stockage: 


list de tout les peripheriques de stockage brancher à la machine

```
[max@localhost ~]$ lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                8:0    0   10G  0 disk 
├─sda1             8:1    0    1G  0 part /boot
└─sda2             8:2    0    9G  0 part 
  ├─rl_vbox-root 253:0    0    8G  0 lvm  /
  └─rl_vbox-swap 253:1    0    1G  0 lvm  [SWAP]
sdb                8:16   0   10G  0 disk 
sdc                8:32   0   10G  0 disk 
sdd                8:48   0   10G  0 disk 
sde                8:64   0   10G  0 disk 
sdf                8:80   0   10G  0 disk 
sr0               11:0    1 1024M  0 rom
```

ici on liste les partition des disques 

[max@localhost ~]$ sudo fdisk -l
Disque /dev/sda : 10 GiB, 10737418240 octets, 20971520 secteurs
Modèle de disque : VBOX HARDDISK   
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0xde052a5a

Périphérique Amorçage   Début      Fin Secteurs Taille Id Type
/dev/sda1    *           2048  2099199  2097152     1G 83 Linux
/dev/sda2             2099200 20971519 18872320     9G 8e LVM Linux


Disque /dev/sdb : 10 GiB, 10737418240 octets, 20971520 secteurs
Modèle de disque : VBOX HARDDISK   
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets


Disque /dev/sdc : 10 GiB, 10737418240 octets, 20971520 secteurs
Modèle de disque : VBOX HARDDISK   
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets


Disque /dev/sdd : 10 GiB, 10737418240 octets, 20971520 secteurs
Modèle de disque : VBOX HARDDISK   
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets


Disque /dev/sde : 10 GiB, 10737418240 octets, 20971520 secteurs
Modèle de disque : VBOX HARDDISK   
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets


Disque /dev/sdf : 10 GiB, 10737418240 octets, 20971520 secteurs
Modèle de disque : VBOX HARDDISK   
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets


Disque /dev/mapper/rl_vbox-root : 8 GiB, 8585740288 octets, 16769024 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets


Disque /dev/mapper/rl_vbox-swap : 1 GiB, 1073741824 octets, 2097152 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets

on test `smartctl`

```bash
[max@localhost ~]$ sudo smartctl --all /dev/sda
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.14.0-427.13.1.el9_4.x86_64] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     VBOX HARDDISK
Serial Number:    VBf0eaed32-94b298b0
Firmware Version: 1.0
User Capacity:    10 737 418 240 bytes [10,7 GB]
Sector Size:      512 bytes logical/physical
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ATA/ATAPI-6 published, ANSI INCITS 361-2002
Local Time is:    Thu Nov 14 15:26:59 2024 CET
SMART support is: Unavailable - device lacks SMART capability.

A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options
```

l'espace disque disponible: 

```
[max@localhost ~]$ df -H /
Sys. de fichiers         Taille Utilisé Dispo Uti% Monté sur
/dev/mapper/rl_vbox-root   8,6G    1,9G  6,7G  22% /
```

