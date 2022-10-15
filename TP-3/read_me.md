# TP3 : On va router des trucs

## I. ARP

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

