# TP4 : Vers une maîtrise des OS Linux

bonn visiblement on va repartir sur les baase

## Sommaire

- [TP4 : Vers une maîtrise des OS Linux](#tp4--vers-une-maîtrise-des-os-linux)
  - [Sommaire](#sommaire)
- [I. Partitionnement](#i-partitionnement)
  - [1. LVM dès l'installation](#1-lvm-dès-linstallation)
  - [2. Scénario remplissage de partition](#2-scénario-remplissage-de-partition)
- [II. Gestion de users](#ii-gestion-de-users)
- [III. Gestion du temps](#iii-gestion-du-temps)

# I. Partitionnement


## 1. LVM dès l'installation

on fait l'install d'une rocky sur vbox en utilisait l'interface graphique d'installation pour les partition

## 2. Scénario remplissage de partition

```bash
[max@localhost ~]$ dd if=/dev/zero of=/home/max/bigfile bs=4M count=5000
```

on remplie la partition avec un truc fatasse


on va regarder la gueule de la partition maintenant

```bash
[max@localhost ~]$ df -h | grep /home
/dev/mapper/rl-hom   4.9G  4.6G     0 100% /home
```

hum hum effectivement 5000 x 4M ça fait bcp

![beaucoup](/TP-s-linux/TP-admin/TP-4/img/cfaitbcplanon)


boooon on va agrandir la partition /home pour mettre encore plus de monde dedans

```bash
[max@localhost ~]$ sudo lvresize -L +5G /dev/mapper/rl-hom
[max@localhost ~]$ resize2fs /dev/sda3/rl-hom
[max@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                379M     0  379M   0% /dev/shm
tmpfs                152M  3.0M  149M   2% /run
/dev/mapper/rl-root  9.8G  962M  8.3G  11% /
/dev/sda2            974M  183M  724M  21% /boot
/dev/mapper/rl-hom   9.8G  4.6G  4.8G  50% /home
/dev/mapper/rl-var   5.0G  170M  4.8G   4% /var
tmpfs                 76M     0   76M   0% /run/user/1000
```

on ajoute ici 5G a la partition on informe le systeme de fichier quil y a de l'espace en + avec le petit ```df -h```qui montr ele changement de 5 on passe a 10G


et encore une fois on fait les bourrin 

```bash
[max@localhost ~]$ dd if=/dev/zero of=/home/max/bigfile bs=4M count=5000
[max@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                379M     0  379M   0% /dev/shm
tmpfs                152M  3.0M  149M   2% /run
/dev/mapper/rl-root  9.8G  962M  8.3G  11% /
/dev/sda2            974M  183M  724M  21% /boot
/dev/mapper/rl-hom   9.8G  9.3G     0 100% /home
/dev/mapper/rl-var   5.0G  170M  4.8G   4% /var
tmpfs                 76M     0   76M   0% /run/user/1000
```

evidemment c'est plein

🌞 **Utiliser ce nouveau disque pour étendre la partition `/home` de 40G**

```bash
[max@localhost ~]$ lsblk
NAME        MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
sda           8:0    0  40G  0 disk 
├─sda1        8:1    0  21G  0 part 
│ ├─rl-root 253:0    0  10G  0 lvm  /
│ ├─rl-swap 253:1    0   1G  0 lvm  [SWAP]
│ ├─rl-var  253:2    0   5G  0 lvm  /var
│ └─rl-hom  253:3    0  63G  0 lvm  /home
├─sda2        8:2    0   1G  0 part /boot
└─sda3        8:3    0  18G  0 part 
  └─rl-hom  253:3    0  10G  0 lvm  /home
sdb           8:16   0  40G  0 disk 
└─rl-hom    253:3    0  63G  0 lvm  /home
```
on liste et on trouve effectivement le nouveaux disque

```bash
[max@localhost ~]$ sudo pvcreate /dev/sdb
[sudo] password for max: 
  Physical volume "/dev/sdb" successfully created.
[max@localhost ~]$ sudo pvs
  PV         VG Fmt  Attr PSize  PFree 
  /dev/sda1  rl lvm2 a--  21.00g     0 
  /dev/sda3  rl lvm2 a--  17.99g 12.99g
  /dev/sdb      lvm2 ---  40.00g 40.00g
```
ici on créé un physical volume avec notre disque

```bash
[max@localhost ~]$ sudo vgextend rl /dev/sdb
  Volume group "rl" successfully extended
[max@localhost ~]$ sudo vgs
  VG #PV #LV #SN Attr   VSize   VFree  
  rl   3   4   0 wz--n- <78.99g <52.99g
```
la on etent notre groupe de volume

```bash                                           
[max@localhost ~]$ sudo lvextend -l +100%FREE /dev/mapper/rl-hom
  Size of logical volume rl/hom changed from 10.00 GiB (2560 extents) to <62.99 GiB (16125 extents).
  Logical volume rl/hom successfully resized.
[max@localhost ~]$ sudo lvs
  LV   VG Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  hom  rl -wi-ao---- <62.99g                                                    
  root rl -wi-ao----  10.00g                                                    
  swap rl -wi-ao----   1.00g                                                    
  var  rl -wi-ao----   5.00g
```
ici c'est les volume logique qu'on etend avec 100% de l'espace dispo

```bash 
[max@localhost ~]$ sudo resize2fs /dev/rl/hom
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/rl/hom is mounted on /home; on-line resizing required
old_desc_blocks = 2, new_desc_blocks = 8
The filesystem on /dev/rl/hom is now 16512000 (4k) blocks long.
```
ici on dit au systeme de fichier ext4 que la partoche a été agrandi et on list pour check que tout est bon

```bash
[max@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                379M     0  379M   0% /dev/shm
tmpfs                152M  3.1M  149M   2% /run
/dev/mapper/rl-root  9.8G  962M  8.3G  11% /
/dev/sda2            974M  183M  724M  21% /boot
/dev/mapper/rl-hom    62G  9.3G   51G  16% /home
/dev/mapper/rl-var   5.0G  170M  4.8G   4% /var
tmpfs                 76M     0   76M   0% /run/user/1000
```
that's goooood

# II. Gestion de users

allé on va gerer des users

bon fastoche

```bash
sudo useradd <username>
```

la on crée juste un user de base sans mdp rien

avec l'option -d on crée le home dir de base c'est /home/user

avec un -s on defini un shell specific

donc pour alice bob charlie eet eve la première command suffit pour le moment mais pour le back up faut custom

elle ressemble plus a ça 

```bash
[max@localhost ~]$ sudo useradd backup -d /var/backup -s /usr/bin/nologin
```

mais la pas de mdp tjr

donc petite command passwd

```bash
sudo passwd <username>
```
et on entre deux fois le mdp et tout est bon

et les groupes ne les oublions pas

```bash
sudo groupadd admins
```
le group est créé maintenant on a juste a l'ajouter au user conserner

```bash
[max@localhost ~]$ sudo usermod -aG admins alice
```

et enfin quand on cat le fichier passwd

```bash
[max@localhost ~]$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:65534:65534:Kernel Overflow User:/:/sbin/nologin
systemd-coredump:x:999:997:systemd Core Dumper:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
tss:x:59:59:Account used for TPM access:/:/usr/sbin/nologin
sssd:x:998:995:User for sssd:/:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/usr/share/empty.sshd:/sbin/nologin
chrony:x:997:994:chrony system user:/var/lib/chrony:/sbin/nologin
systemd-oom:x:992:992:systemd Userspace OOM Killer:/:/usr/sbin/nologin
max:x:1000:1000:max:/home/max:/bin/bash
alice:x:1001:1001::/home/alice:/bin/bash
bob:x:1002:1002::/home/bob:/bin/bash
charlie:x:1003:1003::/home/charlie:/bin/bash
eve:x:1004:1004::/home/eve:/bin/bash
backup:x:1005:1005::/var/backup:/usr/bin/nologin
```
on y vois tout les user créé sur notre machine

avec le nom le homedir et le shell a la fin

et ici le group file

```bash
[max@localhost ~]$ cat /etc/group
root:x:0:
[...]
max:x:1000:
alice:x:1001:
bob:x:1002:
charlie:x:1003:
eve:x:1004:
backup:x:1005:
admins:x:1006:alice,bob,charlie
```
on y vois tout les group et les gens qui en font partie top non

### conf sudo

bon on va conf sudo un peu 

ce qui nous ai demander c'est que les user faisant parti du groupe `admins` ai tous les droit sudo sans avoir a taper leurs mots de passe

et deuxiemement que le user eve puise executer la commande ls en tant que backup

bien direction le fichier sudoer

```bash
max@localhost ~]$ sudo cat /etc/sudoers
[sudo] password for max: 
root    ALL=(ALL)       ALL
eve     ALL=(backup)    /bin/ls
%wheel  ALL=(ALL)       ALL
%admins ALL=(ALL)       NOPASSWD: ALL
```
bon j'ai cut les 3/4 du fichier le fichier lui même est un doc donc ce qui va nous interessert c'est les quelque ligne qui sont présente

```bash
%admins ALL=(ALL)       NOPASSWD: ALL
```

ici on ajoute le groupe admins au fichier on dit ils ont absolument tous les droit sudo et n'ont même pas besoin de taper leurs mots de passe


```bash
eve     ALL=(backup)    /bin/ls
```

ici on lui dit bha eve elle peut executer que la command ls mais en tant que back up sinon elle peut pas executer sudo point barre

preuve

```bash
[eve@localhost ~]$ sudo cat /etc/sudoers
[sudo] password for eve: 
Sorry, user eve is not allowed to execute '/bin/cat /etc/sudoers' as root on localhost.localdomain.
[eve@localhost ~]$ sudo -u backup ls -la /
total 68
dr-xr-xr-x.  19 root root  4096 Jan 19 13:10 .
dr-xr-xr-x.  19 root root  4096 Jan 19 13:10 ..
dr-xr-xr-x.   2 root root  4096 May 16  2022 afs
lrwxrwxrwx.   1 root root     7 May 16  2022 bin -> usr/bin
dr-xr-xr-x.   6 root root  4096 Jan 19 15:30 boot
drwxr-xr-x.  20 root root  3260 Jan 25 10:48 dev
drwxr-xr-x.  77 root root  4096 Jan 25 13:31 etc
drwxr-xr-x.   8 root root  4096 Jan 25 11:53 home
lrwxrwxrwx.   1 root root     7 May 16  2022 lib -> usr/lib
lrwxrwxrwx.   1 root root     9 May 16  2022 lib64 -> usr/lib64
drwx------.   2 root root 16384 Jan 19 13:09 lost+found
drwxr-xr-x.   2 root root  4096 May 16  2022 media
drwxr-xr-x.   2 root root  4096 May 16  2022 mnt
drwxr-xr-x.   2 root root  4096 May 16  2022 opt
dr-xr-xr-x. 182 root root     0 Jan 25 10:48 proc
dr-xr-x---.   3 root root  4096 Jan 25 14:10 root
drwxr-xr-x.  26 root root   760 Jan 25 10:48 run
lrwxrwxrwx.   1 root root     8 May 16  2022 sbin -> usr/sbin
drwxr-xr-x.   2 root root  4096 May 16  2022 srv
dr-xr-xr-x.  13 root root     0 Jan 25 10:48 sys
drwxrwxrwt.  10 root root  4096 Jan 25 14:54 tmp
drwxr-xr-x.  12 root root  4096 Jan 19 13:10 usr
drwxr-xr-x.  20 root root   278 Jan 25 11:57 var
```

eve viens de ce voir refuser un cat necessitant les droit sudo mais par contre un ls en tant que backup c'est ok 


### les perm et zéé pardi

le dossier var backup eexistant deja on va lui crée du contenu 

```bash 
touch precious_backup
```
bien ensuite enfaite c'est le homedirde du user backup donc les perm baaaah c'est deja que pour lui 

```bash
[max@localhost /]$ ls -la var | grep backup
drwx------.  2 backup backup   85 Jan 25 15:25 backup
```

les perm actuelle elles sont que ya personne a part le user backup peut ecrire dedans ni même lire et encore moins exec

### les mots de passe en sha512

alors la on va aller check direct dans le fichier shadow

```bash
[max@localhost /]$ sudo cat /etc/shadow
[sudo] password for max: 
root:$6$yrMH5NRFy9WJ1adW$TMNYA80BFmT/C6elSwF8DcbWwovZuIbur3EL4KIaI.fXEh7EpjyZ4KfOgmiEF43J7Ba2PhFmeIbeCrXRZc.0u1::0:99999:7:::
bin:*:19469:0:99999:7:::
daemon:*:19469:0:99999:7:::
adm:*:19469:0:99999:7:::
lp:*:19469:0:99999:7:::
sync:*:19469:0:99999:7:::
shutdown:*:19469:0:99999:7:::
halt:*:19469:0:99999:7:::
mail:*:19469:0:99999:7:::
operator:*:19469:0:99999:7:::
games:*:19469:0:99999:7:::
ftp:*:19469:0:99999:7:::
nobody:*:19469:0:99999:7:::
systemd-coredump:!!:19741::::::
dbus:!!:19741::::::
tss:!!:19741::::::
sssd:!!:19741::::::
sshd:!!:19741::::::
chrony:!!:19741::::::
systemd-oom:!*:19741::::::
max:$6$MV4QH.EYfH5SYuxU$tLK4c0e9Ay8YXYIaSRqmT0w1nmoobiXNSBHEXUbq9J9mcKsR2PG13FPtADE3kZxXuFOR6QBXu7q8QN/UAc58O/::0:99999:7:::
alice:$6$VGNI2OMZslkct5us$EzX3x3Y9lUorbK.W5MGEIHj6I9yYFLFzigsfHTPnxIR1vU8qnWKWrynTLTmekg.9D7lSPDv1g7hZry7MQWe190:19747:0:99999:7:::
bob:$6$aYMb1DEOH5ZWi6dh$SPzwBGRBVkkSJNrsBRlj379LsupFiqX5DD8yF46dmtfWqaK7.Tl/nJEEh9ssry1ipDdOlauPGXf44RAhPRsLs/:19747:0:99999:7:::
charlie:$6$2qsdZeqle8IZFEl8$xaE/WuWb5j/kU0RklgWW/4si9LshaPu3VMveD4kjey1e7ONKdNFOLweQnNZeRhrGBFoaUProY3j17NCGwf4Eb0:19747:0:99999:7:::
eve:$6$tula87CGdlLQup2U$js3lK1ccLkRhkIjBmJxiQPqMqOUxWUWdZ03i3.QkbzQeKrsVIQBM51vHty7Vz9FUIUEU5l2/4wLGzyG1Hi0fx0:19747:0:99999:7:::
backup:$6$s9tX/mYTU45LbQuT$Jpf6aphMaEEgy.m9.IrI8nUXgvCpVfvUQxe./BYya3E95IwQAhmAMM1wPYioT.DSKrtbDYQzm3.xlWKa71skT0:19747:0:99999:7:::
```

biiiiim va decripter le mots de passe comme ça

un mots de passe cripter en SHA512 commence par un `$6$` ce qui est le cas pour nos mots de passe

### Eve et les droits

et notre trés chère eve qu'as-t-elle reelement le droit de faire on a vu que un sudo ls c'était le max de ça command sudo mais verifions

```bash
[sudo] password for eve: 
Matching Defaults entries for eve on localhost:
    !visiblepw, always_set_home, match_group_by_gid, always_query_group_plugin, env_reset, env_keep="COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS", env_keep+="MAIL PS1 PS2 QTDIR
    USERNAME LANG LC_ADDRESS LC_CTYPE", env_keep+="LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES", env_keep+="LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE",
    env_keep+="LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY", secure_path=/sbin\:/bin\:/usr/sbin\:/usr/bin

User eve may run the following commands on localhost:
    (backup) /bin/ls
```

voila tous pour eve ls et c'est tout

# III. Gestion du temps



🌞 **Je vous laisse gérer le bail vous-mêmes**

mon petit doigt me dit que le petit service ntp sur rocky 
s'appel chrony

regardoonnnns 

```bash
[max@localhost ~]$ systemctl status chronyd
● chronyd.service - NTP client/server
     Loaded: loaded (/usr/lib/systemd/system/chronyd.service; enabled; preset: enabled)
     Active: active (running) since Thu 2024-01-25 10:48:21 CET; 4h 55min ago
       Docs: man:chronyd(8)
             man:chrony.conf(5)
    Process: 715 ExecStart=/usr/sbin/chronyd $OPTIONS (code=exited, status=0/SUCCESS)
   Main PID: 721 (chronyd)
      Tasks: 1 (limit: 4588)
     Memory: 4.4M
        CPU: 66ms
     CGroup: /system.slice/chronyd.service
             └─721 /usr/sbin/chronyd -F 2

Jan 25 10:48:21 localhost systemd[1]: Starting NTP client/server...
Jan 25 10:48:21 localhost chronyd[721]: chronyd version 4.3 starting (+CMDMON +NTP +REFCLOCK +RTC +PRIVDROP +SCFILTER +SIGND +ASYNCDNS +NTS +SECHASH +IPV6 +DEBUG)
Jan 25 10:48:21 localhost chronyd[721]: Frequency 0.000 +/- 1000000.000 ppm read from /var/lib/chrony/drift
Jan 25 10:48:21 localhost chronyd[721]: Using right/UTC timezone to obtain leap second data
Jan 25 10:48:21 localhost chronyd[721]: Loaded seccomp filter (level 2)
Jan 25 10:48:21 localhost systemd[1]: Started NTP client/server.
```

wow c'est ecrit en haut 

`● chronyd.service - NTP client/server`

bim trouver et bha mtn maintenant on va ce connecter au server fr du ntp pool project
