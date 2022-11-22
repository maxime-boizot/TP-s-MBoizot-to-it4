# TP3 : On va router des trucs

## I. ARP

### 1. Echange ARP

pour effectuer les ping on utilise la commande ip a pour trouver les deux ip 

on obtient 

```
192.168.80.1
```
pour la machine de maxime et 

```
192.168.80.3
```

pour la machine de max.


on check ensuite la table arp de chaques machines avec la commande 

```
arp -a
```
sur la machine de maxime on utilise la commande et on trouve l'ip de la machine max avec ça mac. 

```
? (192.168.80.3) at 2e:42:1d:cd:e9:e0 on bridge100 ifscope [bridge]
```

et si on tape la même commande sur la machine de max on obtient l'ip de la machine de maxime avec ça mac.

```
? (192.168.80.3) at ca:89:f3:ca:67:64 [ether] on enp0s6
```

### 2. Analyse de trames



poour capture l'interfa e ouce trouve notre vm on tape la commande 

```
tcpdump -i <interface> -W <fichier>
```

ce qui donne pour moi 

```
tcpdump -i bridge100 -w tp3_arp.pcapng arp 
```

on rajoute arp pour filtrer les paquet et ne garder que les paquets souhaiter dans notre cas c'est l'arp 

[et la petit capture arp qui fait plaisir](tp3_arp.pcappng)

## II. Routage

### 1. Mise en place du routage

on mets en place notre router donc on ce sert d'une VM pour le faire et on tape ces 4 commande pour le configurer 

```
$ sudo firewall-cmd --list-all
$ sudo firewall-cmd --get-active-zone
$ sudo firewall-cmd --add-masquerade --zone=public
$ sudo firewall-cmd --add-masquerade --zone=public --permanent
```

une fois cela fait 

(on passe a la partie 3 du au fait que je suis sous mac)

### 3. Accès internet

après avoir ajouté une carte réseau à notre routeur 

nous allons effectuer unue analyse des trames 