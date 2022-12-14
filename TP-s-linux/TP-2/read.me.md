# TP2 : Appréhender l'environnement Linux

## Sommaire

- [TP2 : Appréhender l'environnement Linux](#tp2--appréhender-lenvironnement-linux)
    - [sommaire](#sommaire)
- [I. Service SSH](#i-service-ssh)
  - [1. Analyse du service](#1-analyse-du-service)
  - [2. Modification du service](#2-modification-du-service)
- [II. Service HTTP](#ii-service-http)
  - [1. Mise en place](#1-mise-en-place)
  - [2. Analyser la conf de NGINX](#2-analyser-la-conf-de-nginx)
  - [3. Déployer un nouveau site web](#3-déployer-un-nouveau-site-web)
- [III. Your own services](#iii-your-own-services)
  - [2. Analyse des services existants](#2-analyse-des-services-existants)
  - [3. Création de service](#3-création-de-service)
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

## 1. Analyse du service

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

## 2. Modification du service

nous allons tout d'abors aller trouver le fichier de conf du ssh qui ce trouve dans le dossier etc puis ssh donc bete commande 

```
cd /etc/ssh
```
et on arrive dans le dossier petit 

```
ls -l
```

pour check ce qu'il y'a la dedans 

![folders](picture/folders.webp)

```
[max@localhost ssh]$ ls -l
total 600
-rw-r--r--. 1 root root     578094 Nov 15 11:07 moduli
-rw-r--r--. 1 root root       1921 Nov 15 11:07 ssh_config
drwxr-xr-x. 2 root root         28 Dec 27 23:58 ssh_config.d
-rw-r-----. 1 root ssh_keys    492 Dec 26 22:13 ssh_host_ecdsa_key
-rw-r--r--. 1 root root        162 Dec 26 22:13 ssh_host_ecdsa_key.pub
-rw-r-----. 1 root ssh_keys    387 Dec 26 22:13 ssh_host_ed25519_key
-rw-r--r--. 1 root root         82 Dec 26 22:13 ssh_host_ed25519_key.pub
-rw-r-----. 1 root ssh_keys   2578 Dec 26 22:13 ssh_host_rsa_key
-rw-r--r--. 1 root root        554 Dec 26 22:13 ssh_host_rsa_key.pub
-rw-------. 1 root root       3667 Nov 15 11:07 sshd_config
drwx------. 2 root root         59 Dec 27 23:58 sshd_config.d
```

du a son nom on devine que le fichier nommé ssh_config est le fichié rechercher 

![elementary](picture/elementary.webp)

et si on essayais de le bidouiller un peu ce petit fichier qui nous a strictement rien demander (sans rien casser évidement)

on execute la commande 

```
echo $RABDOM
```

pour obtenir un nombre au hazard et on obtien 

![roulement de tambour](picture/relementdetambou.gif)

19618

bon bha on va changer le port d'écoute qui de base est le 22 dans le fichier de conf par le port 19618

let's go 

```
nano ssh_config
```

pour modifier le fichier on cherche la ligne port et on mets notre nombre on save et tada

```
[max@localhost ssh]$ cat ssh_config | grep Port
#   Port 19618
```

maintenant on doit gerer le firewall fermer services ssh et ouvrir le port 19618

on reload le firewall 

```
sudo firewall-cmd --reload
```

petit list-all qui montre les modif 

```
[max@localhost ssh]$ sudo firewall-cmd --list-all | grep port
  ports: 19618/tcp
  forward-ports: 
  source-ports:
```

on redemare le services 

```
systemctl restart sshd
```

vu que je l'ai éxécuté directement en ssh il m'as redemander monmots de passe mais ça donne ça 

```
[max@localhost ssh]$ systemctl restart sshd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to restart 'sshd.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
```

# II. Service HTTP

allez mettons en place un server HTTP sur notre machine 

## 1. Mise en place

pour tous cela nous allons utiliser NGINX 

donc on cherche sur internet comment l'installer sur notre machine:

![tapingonkeyboard](picture/tapingonkeyboard.gif)

plus serieusement pour installer NGINX nous allons utilisé la commande 

```
sudo dnf install nginx
```

entrer ça telecharge...

![download](picture/download.gif)

```
Installed:
  nginx-1:1.20.1-13.el9.aarch64  nginx-core-1:1.20.1-13.el9.aarch64  nginx-filesystem-1:1.20.1-13.el9.noarch  rocky-logos-httpd-90.13-1.el9.noarch 

Complete!
```
et voila toc !

<br>

Ensuite pour demarrer le service 

on éxécute la commande suivante

```
[max@localhost ~]$ sudo systemctl enable nginx
```

et on a ceci en sortie 

```
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
```

ensuite on tape celle-ci 

```
[max@localhost ~]$ sudo systemctl start nginx
```

petit status pour verifier 

```
[max@localhost ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
     Active: active (running) since Thu 2022-12-29 22:58:39 CET; 8s ago
    Process: 1547 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 1548 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 1549 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 1550 (nginx)
      Tasks: 7 (limit: 7412)
     Memory: 6.2M
        CPU: 37ms
     CGroup: /system.slice/nginx.service
             ├─1550 "nginx: master process /usr/sbin/nginx"
             ├─1551 "nginx: worker process"
             ├─1552 "nginx: worker process"
             ├─1553 "nginx: worker process"
             ├─1554 "nginx: worker process"
             ├─1555 "nginx: worker process"
             └─1556 "nginx: worker process"

Dec 29 22:58:39 localhost.localdomain systemd[1]: Starting The nginx HTTP and reverse proxy server...
Dec 29 22:58:39 localhost.localdomain nginx[1548]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Dec 29 22:58:39 localhost.localdomain nginx[1548]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Dec 29 22:58:39 localhost.localdomain systemd[1]: Started The nginx HTTP and reverse proxy server.
```

et ça tourne 

on va tt de même faire quelque petit ajustement au niveau du firewall 

```
sudo firewall-cmd --add-services=http --permanent
```

on ajoute le service http que l'ont va utiliser 

et grace a la doc on sait qu'il faut ajouté le port 80 au firewall

```
sudo firewall-cmd --add-port=80/tcp --permanent
```

et on reload 

```
sudo firewall-cmd --reload
```

petit list all avec la ligne conserner

```
  services: cockpit dhcpv6-client http
  ports: 19618/tcp 80/tcp
```


ensuite sur quel port ecoute tu mon grand 

hum...

```
[max@localhost system]$ ss -l | grep 80
tcp   LISTEN 0      511                                       0.0.0.0:80                   0.0.0.0:*
```
il écoute bien sur le 80


pour ce qui est du processus 

on utilise ceci 

```
systemctl status | grep nginx
```

et tadaaaa

```
[max@localhost ~]$ systemctl status | grep nginx
           │ ├─nginx.service
           │ │ ├─1336 "nginx: master process /usr/sbin/nginx"
           │ │ ├─1337 "nginx: worker process"
           │ │ ├─1338 "nginx: worker process"
           │ │ ├─1339 "nginx: worker process"
           │ │ ├─1340 "nginx: worker process"
           │ │ ├─1341 "nginx: worker process"
           │ │ └─1342 "nginx: worker process"
               │ └─1352 grep --color=auto nginx
```

![hagriiiid](picture/wizard.gif)

maiiis naaaan 

ya un server web qui tourne la ??? 

si si jte jure regarde 

on tape http://192.168.64.17:80

et j'atterie sur une page web 

regarde j'utilise la commande curl pour t'afficher le code de la page 

```
curl http://192.168.64.17:80 | head
```

et ça affiche ça

```
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/
      
      html {

```

## 2. Analyser la conf de NGINX

bon c'est bien beau mais baladon nous un peu dans la conf de ce service et customison le 

bon deja il est ou ??? 

![ilestou](picture/whereisit.gif)

après moulte recherche (10 seconde en vrai)

```
[max@localhost nginx]$ ls -al /etc/nginx | grep nginx.conf
```

allons checker a cet endroit la 

bingo 

```
[max@localhost nginx]$ ls -al /etc/nginx | grep nginx.conf
-rw-r--r--.  1 root root 2334 Oct 31 16:37 nginx.conf
-rw-r--r--.  1 root root 2656 Oct 31 16:37 nginx.conf.default
```

bon maintenant es que dedans il y a ce qui affiche cette veille page web qu'on a vu tt a l'heure

```
cat nginx.conf | grep server -A 16
```

```
server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
```

on y trouve même des lignes qui incluse d'autre fichié 

```
include /usr/share/nginx/modules/*.conf;
    include             /etc/nginx/mime.types;
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/default.d/*.conf;
#        include /etc/nginx/default.d/*.conf;
```

## 3. Déployer un nouveau site web

bon on va créé un piti site tt mims 

donc on créée des dossier dans le var 

ici 

![var](picture/var.jpeg)

je rigole 

dans le dossier var comme ça 

```
sudo mkdir www
```

ainsi que 

```
sudo mkdir tp2_linux
```

on créé ensuite un fichié html

```
sudo touch index.html
```

et on mets ça dedans 

```
[max@localhost tp2_linux]$ cat index.html 
<h1>MEOW mon premier serveur web</h1>
```

maintenant on va adpeter la conf de nginx 

on supprime la partie server vu avant et on créé un fichié de conf avec la commande 

```
touch siteweb.conf
```

on crée notre ficher de conf dans le dossier default.d

et on inclu notre fichié de conf sur le fichié de conf principal 

```
include /etc/nginx/conf.d/siteweb.conf;
```

```
[max@localhost default.d]$ ls -l
total 0
-rw-r--r--. 1 root root 0 Dec 30 19:35 siteweb.conf
```

et maintenant on tire un port au hasard avec 

```
echo $RANDOM
```

et ce sera le

```
[max@localhost conf.d]$ echo $RANDOM
10971
```

10971

ok maintenant on remplie le fichier de conf avec nos info a nous 

```
server {
  listen 10971;

  root /var/www/tp2_linux;
}

```

le petit cat du fichier de conf 

```
[max@localhost conf.d]$ cat siteweb.conf 
server {
  listen 10971;

  root /var/www/tp2_linux;
}
```

on restart 

```
systemctl restart nginx
```

et on check

avec un petit curl 

```
[max@localhost default.d]$ curl http://192.168.64.17:10971
<h1>MEOW mon premier serveur web</h1>
```

et voilaaaaaa


# III. Your own services

créons notre propre service

![ohyeah](picture/ohyeah.gif)

## 2. Analyse des services existants

on recupere le chemin pour le fichier sshd.service

```
[max@localhost /]$ systemctl status sshd
Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
```

j'ai pas tt mis mais c'est cette partie la qui m'interesse 

on mets en evidence la ligne qui nous interesse avec un grep et ça donne ça 

```
[max@localhost system]$ cat sshd.service | grep ExecStart=
ExecStart=/usr/sbin/sshd -D $OPTIONS
```

on fait la même chose avec nginx

status on trouve le chemin et on cat 

```
[max@localhost system]$ cat nginx.service | grep ExecStart=
ExecStart=/usr/sbin/nginx
```

## 3. Création de service

bon on créé le fichier de notre service 

petit cat une fois rempli

```
[max@localhost system]$ cat tp2_nc.service 
[Unit]
Description=Super netcat tout fou

[Service]
ExecStart=/usr/bin/nc -l 16415
```

on explique gentillement en toute gentillesse au system qu'on le custom avec cette commande 

```
sudo systemctl daemon-reload
```

et on demmarre le service

petit status 

```
[max@localhost system]$ systemctl status tp2_nc
● tp2_nc.service - Super netcat tout fou
     Loaded: loaded (/etc/systemd/system/tp2_nc.service; static)
     Active: active (running) since Sat 2022-12-31 00:35:48 CET; 4min 18s ago
   Main PID: 1945 (nc)
      Tasks: 1 (limit: 7412)
     Memory: 740.0K
        CPU: 4ms
     CGroup: /system.slice/tp2_nc.service
             └─1945 /usr/bin/nc -l 16415

Dec 31 00:35:48 localhost.localdomain systemd[1]: Started Super netcat tout fou.
```

ça tourne bien il est tt mims tt va bien 

petit ss

```
[max@localhost system]$ ss -l | grep 16415
tcp   LISTEN 0      10                                        0.0.0.0:16415                   0.0.0.0:*          
tcp   LISTEN 0      10                                           [::]:16415                      [::]:*
```

il écoute bien sur le port 16415 donc tt roule 

bon checkon les logs de notre service un peu 

ça c'est le log de start

```
Dec 31 01:06:32 localhost.localdomain systemd[1]: Started Super netcat tout fou.
```
ici le log de message (c'est fou)

```
Dec 31 01:02:22 localhost.localdomain nc[1409]: coucou
```

et ici le log de stop du service

```
Dec 31 01:06:24 localhost.localdomain systemd[1]: Stopped Super netcat tout fou.
```

ok bon c'est cool mais c'est relou que ça s'eteigne a chaque fois donc rejoutont une petite ligne qui empeche ça 

donc on modifie le fichié de conf et tt va bien 

```
[max@localhost system]$ cat tp2_nc.service 
[Unit]
Description=Super netcat tout fou

[Service]
ExecStart=/usr/bin/nc -l 16415
Restart=always
```

c'est la ligne Restart qui va s'en occuper 

et bien sur on oublie pas de dire a notre system qu'on a modifier un truc 

```
[max@localhost system]$ sudo systemctl daemon-reload
```

et voila c'est tout pour moi 

merci pour la lecture

sur ce je vais dormir 

![goodbye](picture/goodbye.gif)