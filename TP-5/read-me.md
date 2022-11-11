# Serveur VPN



## I. Setup machine distante

pour ce TP je vais utilisé une machine sous rocky linux qui est relier a ma box par cable ethernet

sur cette machine une fois configurer on peu éxécuter un 

```
ip a
```

pour obtenir son ip 

```
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 0c:9d:92:45:1a:3d brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.26/24 brd 192.168.0.255 scope global dynamic noprefixroute enp2s0
       valid_lft 41591sec preferred_lft 41591sec
    inet6 fde1:5f82:ece7:4077:e9d:92ff:fe45:1a3d/64 scope global deprecated dynamic noprefixroute 
       valid_lft 1367sec preferred_lft 0sec
    inet6 2a01:e0a:e6:1660:e9d:92ff:fe45:1a3d/64 scope global dynamic noprefixroute 
       valid_lft 86252sec preferred_lft 86252sec
    inet6 fe80::e9d:92ff:fe45:1a3d/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
``` 

on trouve donc l'ip de la machine a la ligne inet 

```
inet 192.168.0.26
```

### 1. Utilisateurs

durant la configuration de notre rocky on a donner les droit administrateur a notre utilisateur afin qu'il ai les droits root

### 2. Serveur SSH

#### A. Connexion par clé

sur le client donc mon MAC je genere ma clef de connection ssh avec la commande 

```
ssh-keygen -t rsa -b 4096
```

une fois notre clé généré on utilise la commande 
```
ssh-copy-id -i ~/.ssh/id_rsa.pub max@192.168.0.26
```

on obtient en retour la confirmation que la clef ssh a été reçu et je peut desormais me connecter en sseh a ma machine distance sans taper de mots de passe.

#### B. SSH Server Hardening



## II. Serveur VPN

