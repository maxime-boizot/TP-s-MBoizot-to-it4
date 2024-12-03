# TP1 Stockage: 


list de tout les peripheriques de stockage brancher à la machine

```bash
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

ici on liste les partitions des disques 

```bash
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
```

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

```bash
[max@localhost ~]$ df -H /
Sys. de fichiers         Taille Utilisé Dispo Uti% Monté sur
/dev/mapper/rl_vbox-root   8,6G    1,9G  6,7G  22% /
```

on instal ioping

on utilie `-c` pour obtenir la latence disque `3` c'est le nombre de requetes et `/`

```bash
[max@localhost ~]$ sudo ioping -c 3 /
[sudo] Mot de passe de max : 
4 KiB <<< / (xfs /dev/dm-0 7.93 GiB): request=1 time=490.5 us (warmup)
4 KiB <<< / (xfs /dev/dm-0 7.93 GiB): request=2 time=707.7 us
4 KiB <<< / (xfs /dev/dm-0 7.93 GiB): request=3 time=685.7 us

--- / (xfs /dev/dm-0 7.93 GiB) ioping statistics ---
2 requests completed in 1.39 ms, 8 KiB read, 1.44 k iops, 5.61 MiB/s
generated 3 requests in 2.00 s, 12 KiB, 1 iops, 5.99 KiB/s
min/avg/max/mdev = 685.7 us / 696.7 us / 707.7 us / 11.0 us
```

le temps en ms coorespond à la latence

le cache du filesystem

```bash
[max@localhost ~]$ vmstat
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 0  0      0 354452   2708 231056    0    0   135    74   83  171  1  2 98  0  0
```

## II. partitioning 

aller on créée le physical volume 

```
sudo pvcreate /dev/sdb
```

on ajoute notre physical volume à notre volume groupe

```
sudo vgcreate storage /dev/sdb
```

ensuite on crée notre volume logique

```
sudo lvcreate -L 2G -n smol_data storage
sudo lvcreate -l 100%FREE -n smol_data storage
```

la première commande créé le volume logique smol_data avec 2G
et la deuxième créé le LV big_data avec l'agument `100%FREE` qui permet d'aloué 100% de l'éspace restant disponible.

maintenant on va y ajouter un système de fichier `ext4` à nos deux LV avec la command `mkfs`

```bash
sudo mkfs.ext4 /dev/storage/big_data
sudo mkfs.ext4 /dev/storage/smol_data
```

on créé le point de montage

```bash
sudo mkdir /mnt/lvm_storage/smol
sudo mkdir /mnt/lvm_storage/big
```

maintenant on va monté les LV

```bash
[max@localhost ~]$ sudo mount /dev/storage/smol_data /mnt/lvm_storage/smol
[max@localhost ~]$ sudo mount /dev/storage/big_data /mnt/lvm_storage/big
```

le potit check

```bash
[max@localhost ~]$ df -h
Sys. de fichiers              Taille Utilisé Dispo Uti% Monté sur
devtmpfs                        4,0M       0  4,0M   0% /dev
tmpfs                           385M       0  385M   0% /dev/shm
tmpfs                           154M    3,1M  151M   2% /run
/dev/mapper/rl_vbox-root        8,0G    2,0G  6,0G  26% /
/dev/sda1                       960M    349M  612M  37% /boot
tmpfs                            77M       0   77M   0% /run/user/1000
/dev/mapper/storage-smol_data   2,0G     24K  1,8G   1% /mnt/lvm_storage/smol
/dev/mapper/storage-big_data    7,8G     24K  7,4G   1% /mnt/lvm_storage/big
```

