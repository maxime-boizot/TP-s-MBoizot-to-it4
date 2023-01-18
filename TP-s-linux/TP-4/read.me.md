# TP4 : Real services

## sommaire: 

- [0-checklist](#checklist)
- [Partie 1 : Partitionnement du serveur de stockage](#partie-1--partitionnement-du-serveur-de-stockage)
- [Partie 2 : Serveur de partage de fichiers](#partie-2--serveur-de-partage-de-fichiers)
    - [coter server](#coter-server)
    - [coter client]()
## checklist 

comme d'hab on déroule la checklist et on y va 

![letsgo](picture/letsgo.gif)

# Partie 1 : Partitionnement du serveur de stockage

bon on attaque dans le dur on mets un petit disque de 2G via l'interface de notre virtualiseur et quand on check si il est bien apparue une fois la vm redemarrer 

```
[max@storage ~]$ lsblk | grep vdb
vdb         252:16   0    2G  0 disk
```

il est bien la et il fait bien 2G

Maintenant on créé le pv 

```
[max@storage ~]$ sudo pvcreate /dev/vdb
  Physical volume "/dev/vdb" successfully created.
```

ça fait on check 

```
[max@storage ~]$ sudo pvs | grep /dev/vdb
  /dev/vdb      lvm2 ---   2.00g 2.00g
```

il est la tt va bien parfait on enchaine 

le volume groupe 

```
sudo lvcreate -l 100%FREE  storage -n storage
```

on check pr verifier que tt est bon 

```
[max@storage ~]$ sudo lvs | grep storage
  storage storage -wi-a----- <2.00g 
```

maintenant on va formater et monter la partition pour que tt soit bon carré 

```
mkfs -t ext4 /dev/storage/storage
```
maintenant on la monte

```
sudo mount /dev/storage/storage /mnt/storage
```

on check tout ça 

```
[max@storage ~]$ df -h | grep /dev/mapper/storage
/dev/mapper/storage-storage  2.0G   24K  1.9G   1% /mnt/storage
```

toubon on a notre partition formater comme il faut c'est nickel

![toubon](picture/toubon.gif)

LA SUIIIITE 

# Partie 2 : Serveur de partage de fichiers

bon maintenant on va set une notre server tranquillement

## coter server:


on install le server

```
sudo dnf install nfs-utils
```

ensuite on créé le dossier partager avec le client 

```
sudo mkdir /var/nfs/general -p
```

on check qu'il c'est bien créé 

```
[max@storage /]$ ls -dl /var/nfs/general
drwxr-xr-x. 2 root root 6 Jan 17 12:17 /var/nfs/general
```

vu qu'il a été créé avec sudo on va ce donner les droit d'acces 

```
sudo chown max /var/nfs/general
```

et voila comme par magie

```
[max@storage /]$ ls -dl /var/nfs/general
drwxr-xr-x. 2 max root 6 Jan 17 12:17 /var/nfs/general
```

![onalesdroit](picture/onalesdroit.webp)

après ça on va plonger direct dans le fichier de conf du service 


```
sudo nano /etc/exports
```

on va le remplir de manière a donner l'ip du client les dfroit que l'ont va lui attribuer et evidemment le dossier auquel il aura accès

```


le petit cat qui fait plaisir 


```
[max@storage nfs]$ cat /etc/exports
/var/nfs/general    192.168.64.20(rw,sync,no_subtree_check)
```

après et bha toc on demarre le service 

```
sudo systemctl enable nfs-server
sudo systemctl start nfs-server
```

on check que le service tourne bien comme il faut 

pour t'epargner une lecture chiante ça fonctionne nickel

```
[max@storage /]$ sudo systemctl status nfs-server
● nfs-server.service - NFS server and services
     Loaded: loaded (/usr/lib/systemd/system/nfs-server.service; enabled; vendor preset: disabled)
    Drop-In: /run/systemd/generator/nfs-server.service.d
             └─order-with-mounts.conf
     Active: active (exited) since Tue 2023-01-17 12:25:46 CET; 9s ago
    Process: 27085 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)
    Process: 27086 ExecStart=/usr/sbin/rpc.nfsd (code=exited, status=0/SUCCESS)
    Process: 27105 ExecStart=/bin/sh -c if systemctl -q is-active gssproxy; then systemctl reload gssproxy ; fi (code=exited, status=0/SUCCESS)
   Main PID: 27105 (code=exited, status=0/SUCCESS)
        CPU: 21ms

Jan 17 12:25:46 storage systemd[1]: Starting NFS server and services...
Jan 17 12:25:46 storage systemd[1]: Finished NFS server and services.
``

maintenant le firewall

```
[max@storage nfs]$ sudo firewall-cmd --permanent --list-all | grep services
[sudo] password for max: 
  services: cockpit dhcpv6-client ssh
```

quand on check le firewall il va nous manquer des service donc il va falloir qu'on ajoute les chose qui manque 

donc on va ajouter les service manquant 

```
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload
```
petit list-all qui prouve que tt est passer 

```
[max@storage ~]$ sudo firewall-cmd --list-all | grep service
[sudo] password for max: 
  services: cockpit dhcpv6-client mountd nfs rpc-bind ssh
```



## coter client:

coté client maintenant on install les outils nfs  

```
sudo dnf install nfs-utils
```

etape 5