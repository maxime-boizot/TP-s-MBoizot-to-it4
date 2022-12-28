# TP2 : Appréhender l'environnement Linux

## Sommaire

- [TP2 : Appréhender l'environnement Linux](#tp2--appréhender-lenvironnement-linux)
    - [sommaire](#sommaire)
- [I. Service SSH](#i-service-ssh)
- [2. Modification du service](#2-modification-du-service)

## Checklist

ip: OK

hostname: OK

firewall: OK

SSH: OK

accès internet: OK

resolution de nom: OK

selinux en permissive: OK

parrer au décolage mon capitaine 

![decollageee](picture/decollage.gif)

# I. Service SSH

bon pour commencer verifions si le SSH est démarrer avec la commande 

```
systemctl status | grep sshd
```
(le status va nous donner l'état de fonctionnement du systeme et tt les processus en cours avec le status et le grep va nous permettre de filtrer le resultat donc grep sshd car on ne veux que le processus de sshd)

et on obtient ceci 

```
[max@localhost ~]$ systemctl status | grep sshd
           │ ├─sshd.service
           │ │ └─715 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
               │ ├─4351 "sshd: max [priv]"
               │ ├─4355 "sshd: max@pts/0"
               │ └─4388 grep --color=auto sshd
[max@localhost ~]$ 

```
donc notre service est bien en cours d'éxecution donc c'est parfait maintenant essayons de trouver sur quel port il écoute ``

![listen](picture/listen.gif)

pour cela utilison la commande 

```
ss | grep ssh
```

et nous obtenons ceci 

```
[max@localhost ~]$ ss | grep ssh
tcp   ESTAB  0      52                    192.168.64.17:ssh       192.168.64.1:49582        
```

donc Analysons tout cela 

on sait que c'est du tcp gnagnagna et c'est après que ça nous interesse on a notre adresse ip avec le port d'écoute 

```
192.168.64.17:ssh
```

en l'ocurrence la il écoute sur le port ssh qui ont le sait est le 22 mais si on regarde il ya le port sur lequel et apès nous avons l'adresse de mon ordinateur physique vu que je suis en ssh pour le tp avec le port d'ecoute qui est le 49582

![fingerinthenode](picture/fingerinthenose.gif)

maintenant on va check les log duservices ssh 

pour cela on va utiliser la commande

```
journalctl | grep ssh
```

et on obtient cela 

```
[max@localhost /]$ journalctl | grep ssh
Dec 28 00:06:18 localhost systemd[1]: Created slice Slice /system/sshd-keygen.
Dec 28 00:06:19 localhost systemd[1]: Reached target sshd-keygen.target.
Dec 28 00:06:19 localhost sshd[715]: Server listening on 0.0.0.0 port 22.
Dec 28 00:06:19 localhost sshd[715]: Server listening on :: port 22.
Dec 28 00:07:31 localhost.localdomain sshd[4322]: Accepted password for max from 192.168.64.1 port 49575 ssh2
Dec 28 00:07:31 localhost.localdomain sshd[4322]: pam_unix(sshd:session): session opened for user max(uid=1000) by (uid=0)
Dec 28 00:07:47 localhost.localdomain sshd[4326]: Received disconnect from 192.168.64.1 port 49575:11: disconnected by user
Dec 28 00:07:47 localhost.localdomain sshd[4326]: Disconnected from user max 192.168.64.1 port 49575
Dec 28 00:07:47 localhost.localdomain sshd[4322]: pam_unix(sshd:session): session closed for user max
Dec 28 00:08:22 localhost.localdomain sshd[4351]: Accepted password for max from 192.168.64.1 port 49582 ssh2
Dec 28 00:08:22 localhost.localdomain sshd[4351]: pam_unix(sshd:session): session opened for user max(uid=1000) by (uid=0)
```

donc on vois mes connexion et déconnexion de test pour voir si tt est oppé avant le tp 

# 2. Modification du service

