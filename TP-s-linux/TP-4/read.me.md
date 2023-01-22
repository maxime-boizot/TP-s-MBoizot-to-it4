# TP4 : Real services

## sommaire: 

- [0-checklist](#checklist)
- [Partie 1 : Partitionnement du serveur de stockage](#partie-1--partitionnement-du-serveur-de-stockage)
- [Partie 2 : Serveur de partage de fichiers](#partie-2--serveur-de-partage-de-fichiers)
    - [coter server](#coter-server)
    - [coter client](#coter-client)
- [Partie 3 : Serveur web](#partie-3--serveur-web)
    - [2. Install](#2-install)
    - [3. analyse](#3-analyse)
    - [4. Visite du service web](#4-visite-du-service-web)
    - [5. Modif de la conf du serveur web](#5-modif-de-la-conf-du-serveur-web)
    - [6. Deux sites web sur un seul serveur](#6-deux-sites-web-sur-un-seul-serveur)
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

le petit cat qui fait plaisir 

```
[max@storage /]$ cat /etc/exports
/storage/site_web_1/    192.168.64.20(rw,sync,no_subtree_check)
/storage/site_web_2     192.168.64.20(rw,sync,no_root_squash,no_subtree_check)
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
```

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

ensuite 

on va préparer notre client au partage avec le server 

on créé deux directories pour le mounting

```
sudo mkdir -p /var/www/site_web_1
sudo mkdir -p /var/www/site_web_2
```

on ce donne les droit pour tt ces petits fichier

```
sudo chown max site_web_2
sudo chown max site_web_1
sudo chown max www
sudo chown max var
```

et voila on a les droits

maintenant on va monter le partage de fichier vu que l'ont a créé nos fichié ouvert le parfeu etc.. tt est bon 

```
[[max@web www]$ sudo mount 192.168.64.21:/storage/site_web_2 /var/www/site_web_1 
[max@web /]$ sudo mount 192.168.64.21:/storage/site_web_1 /var/www/site_web_2
```

je vais tépargner les 20min que j'ai passer ou j'ai chercher pourquoi host_ip il arrivais pas a le resoudre 

![jesuiscon](picture/jesuiscon.gif)

maintenant on va checker que notre partage marche bien 

```
[max@web www]$ df -h | grep 192
192.168.64.21:/storage/site_web_1   12G  1.6G   11G  13% /var/www/site_web_1
192.168.64.21:/storage/site_web_2   12G  1.6G   11G  13% /var/www/site_web_2
```

on va tester que ça fonctionne 


et bha maintenant on pete touuuuus (juste le montage flm de reparer l'os et tt (en vrai je sais pas faire(une parenthèse dans une paranthèse dans une paranthèse whaaat!!!))) naaaan je rigole on va garder tt ça ça servira par la suite 

![wtf](picture/wtf.gif)

aller en route pour la partie 3

# Partie 3 : Serveur web

## 2. Install

bon on va mettre en place une fois de plus un server web donc installons NGINX sur le client

```
sudo dnf install nginx
```

et voila c'est fait 

```
[max@web ~]$ sudo dnf install nginx
[sudo] password for max: 

[...]

Installed:
  nginx-1:1.20.1-13.el9.aarch64           nginx-core-1:1.20.1-13.el9.aarch64    nginx-filesystem-1:1.20.1-13.el9.noarch   
  rocky-logos-httpd-90.13-1.el9.noarch   

Complete!
```

## 3. Analyse

bon on va checker que tt va bien que ça marche bien 

```
sudo systemctl start nginx

[max@web ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
     Active: active (running) since Sun 2023-01-22 03:35:32 CET; 7s ago
    Process: 1660 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 1661 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 1662 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 1663 (nginx)
      Tasks: 7 (limit: 7412)
     Memory: 6.3M
        CPU: 31ms
     CGroup: /system.slice/nginx.service
             ├─1663 "nginx: master process /usr/sbin/nginx"
             ├─1664 "nginx: worker process"
             ├─1665 "nginx: worker process"
             ├─1666 "nginx: worker process"
             ├─1667 "nginx: worker process"
             ├─1668 "nginx: worker process"
             └─1669 "nginx: worker process"

Jan 22 03:35:32 web systemd[1]: Starting The nginx HTTP and reverse proxy server...
Jan 22 03:35:32 web nginx[1661]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Jan 22 03:35:32 web nginx[1661]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Jan 22 03:35:32 web systemd[1]: Started The nginx HTTP and reverse proxy server.
```

en bref ça marche sans configue particulière mais ça fonctionne 

on va analyser d'autre chose pr voir si tt va bien

on check qui run le processe avec la commande ps 

```
[max@web ~]$ sudo ps -ef | grep nginx
root        1663       1  0 03:35 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       1664    1663  0 03:35 ?        00:00:00 nginx: worker process
nginx       1665    1663  0 03:35 ?        00:00:00 nginx: worker process
nginx       1666    1663  0 03:35 ?        00:00:00 nginx: worker process
nginx       1667    1663  0 03:35 ?        00:00:00 nginx: worker process
nginx       1668    1663  0 03:35 ?        00:00:00 nginx: worker process
nginx       1669    1663  0 03:35 ?        00:00:00 nginx: worker process
max         1755    1236  0 03:50 pts/0    00:00:00 grep --color=auto nginx
`````

on a la première ligne avec le master process qui est run par le root 

ensuite on va checker sur quel port ecoute le service avec la commande ss 

```
[max@web ~]$ sudo ss -lnpaute4 | grep nginx
tcp   LISTEN 0      511                 0.0.0.0:80        0.0.0.0:*     users:(("nginx",pid=1669,fd=6),("nginx",pid=1668,fd=6),("nginx",pid=1667,fd=6),("nginx",pid=1666,fd=6),("nginx",pid=1665,fd=6),("nginx",pid=1664,fd=6),("nginx",pid=1663,fd=6)) ino:25935 sk:3d cgroup:/system.slice/nginx.service <->
```

et voila en bref ça écoute sur le port 80

maintenant on va chercher la racine web de notre service en gros l'endroit ou sont stocker nos fichier html etc...

on va aller checker dans le fichier de conf si il ya le chemin 

on y trouve ce chemin /usr/share/nginx/html petit ls por checker 

```
[max@web nginx]$ ls -l /usr/share/nginx/html | grep .html
-rw-r--r--. 1 root root 3332 Oct 31 16:35 404.html
-rw-r--r--. 1 root root 3404 Oct 31 16:35 50x.html
lrwxrwxrwx. 1 root root   25 Oct 31 16:37 index.html -> ../../testpage/index.html
```

on y trouve pleiiin de chose dont l'index html (la page de base) une page 404.html donc on est au bon endroit


avec ce même ls on peut voir les utilisateur qui on les droit et il ya écrit root donc vu que c'est root qui lance le service il a les droit mais pas le user de la machine donc pour le modifier soit on ce donne les droit soit on utilise ce bon vieux sudo 

## 4. Visite du service web

on va setup le firewall avec le service je mets tt les commande mais on ajoute le port 80 qui va avec le service (vu plus haut) on reload et on list-all pr checker 

```
[max@web nginx]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[max@web nginx]$ sudo firewall-cmd --reload
success
[max@web nginx]$ sudo firewall-cmd --list-all 
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1 enp0s2
  sources: 
  services: cockpit dhcpv6-client mountd nfs rpc-bind ssh
  ports: 8888/tcp 22/tcp 22/udp 80/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:
```

on va acceder au site web avec la commande curl directement 

```
[max@web ~]$ curl 19992.168.64.20
curl: (6) Could not resolve host: 19992.168.64.20
[max@web ~]$ curl 192.168.64.20:80
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/
      
      html {
        height: 100%;
        width: 100%;
      }  
        body {
  background: rgb(20,72,50);
  background: -moz-linear-gradient(180deg, rgba(23,43,70,1) 30%, rgba(0,0,0,1) 90%)  ;
  background: -webkit-linear-gradient(180deg, rgba(23,43,70,1) 30%, rgba(0,0,0,1) 90%) ;
  background: linear-gradient(180deg, rgba(23,43,70,1) 30%, rgba(0,0,0,1) 90%);
  background-repeat: no-repeat;
  background-attachment: fixed;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#3c6eb4",endColorstr="#3c95b4",GradientType=1); 
        color: white;
        font-size: 0.9em;
        font-weight: 400;
        font-family: 'Montserrat', sans-serif;
        margin: 0;
        padding: 10em 6em 10em 6em;
        box-sizing: border-box;      
        
      }

   
  h1 {
    text-align: center;
    margin: 0;
    padding: 0.6em 2em 0.4em;
    color: #fff;
    font-weight: bold;
    font-family: 'Montserrat', sans-serif;
    font-size: 2em;
  }
  h1 strong {
    font-weight: bolder;
    font-family: 'Montserrat', sans-serif;
  }
  h2 {
    font-size: 1.5em;
    font-weight:bold;
  }
  
  .title {
    border: 1px solid black;
    font-weight: bold;
    position: relative;
    float: right;
    width: 150px;
    text-align: center;
    padding: 10px 0 10px 0;
    margin-top: 0;
  }
  
  .description {
    padding: 45px 10px 5px 10px;
    clear: right;
    padding: 15px;
  }
  
  .section {
    padding-left: 3%;
   margin-bottom: 10px;
  }
  
  img {
  
    padding: 2px;
    margin: 2px;
  }
  a:hover img {
    padding: 2px;
    margin: 2px;
  }

  :link {
    color: rgb(199, 252, 77);
    text-shadow:
  }
  :visited {
    color: rgb(122, 206, 255);
  }
  a:hover {
    color: rgb(16, 44, 122);
  }
  .row {
    width: 100%;
    padding: 0 10px 0 10px;
  }
  
  footer {
    padding-top: 6em;
    margin-bottom: 6em;
    text-align: center;
    font-size: xx-small;
    overflow:hidden;
    clear: both;
  }
 
  .summary {
    font-size: 140%;
    text-align: center;
  }

  #rocky-poweredby img {
    margin-left: -10px;
  }

  #logos img {
    vertical-align: top;
  }
  
  /* Desktop  View Options */
 
  @media (min-width: 768px)  {
  
    body {
      padding: 10em 20% !important;
    }
    
    .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6,
    .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
      float: left;
    }
  
    .col-md-1 {
      width: 8.33%;
    }
    .col-md-2 {
      width: 16.66%;
    }
    .col-md-3 {
      width: 25%;
    }
    .col-md-4 {
      width: 33%;
    }
    .col-md-5 {
      width: 41.66%;
    }
    .col-md-6 {
      border-left:3px ;
      width: 50%;
      

    }
    .col-md-7 {
      width: 58.33%;
    }
    .col-md-8 {
      width: 66.66%;
    }
    .col-md-9 {
      width: 74.99%;
    }
    .col-md-10 {
      width: 83.33%;
    }
    .col-md-11 {
      width: 91.66%;
    }
    .col-md-12 {
      width: 100%;
    }
  }
  
  /* Mobile View Options */
  @media (max-width: 767px) {
    .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6,
    .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12 {
      float: left;
    }
  
    .col-sm-1 {
      width: 8.33%;
    }
    .col-sm-2 {
      width: 16.66%;
    }
    .col-sm-3 {
      width: 25%;
    }
    .col-sm-4 {
      width: 33%;
    }
    .col-sm-5 {
      width: 41.66%;
    }
    .col-sm-6 {
      width: 50%;
    }
    .col-sm-7 {
      width: 58.33%;
    }
    .col-sm-8 {
      width: 66.66%;
    }
    .col-sm-9 {
      width: 74.99%;
    }
    .col-sm-10 {
      width: 83.33%;
    }
    .col-sm-11 {
      width: 91.66%;
    }
    .col-sm-12 {
      width: 100%;
    }
    h1 {
      padding: 0 !important;
    }
  }
        
  
  </style>
  </head>
  <body>
    <h1>HTTP Server <strong>Test Page</strong></h1>

    <div class='row'>
    
      <div class='col-sm-12 col-md-6 col-md-6 '></div>
          <p class="summary">This page is used to test the proper operation of
            an HTTP server after it has been installed on a Rocky Linux system.
            If you can read this page, it means that the software is working
            correctly.</p>
      </div>
      
      <div class='col-sm-12 col-md-6 col-md-6 col-md-offset-12'>
     
       
        <div class='section'>
          <h2>Just visiting?</h2>

          <p>This website you are visiting is either experiencing problems or
          could be going through maintenance.</p>

          <p>If you would like the let the administrators of this website know
          that you've seen this page instead of the page you've expected, you
          should send them an email. In general, mail sent to the name
          "webmaster" and directed to the website's domain should reach the
          appropriate person.</p>

          <p>The most common email address to send to is:
          <strong>"webmaster@example.com"</strong></p>
    
          <h2>Note:</h2>
          <p>The Rocky Linux distribution is a stable and reproduceable platform
          based on the sources of Red Hat Enterprise Linux (RHEL). With this in
          mind, please understand that:

        <ul>
          <li>Neither the <strong>Rocky Linux Project</strong> nor the
          <strong>Rocky Enterprise Software Foundation</strong> have anything to
          do with this website or its content.</li>
          <li>The Rocky Linux Project nor the <strong>RESF</strong> have
          "hacked" this webserver: This test page is included with the
          distribution.</li>
        </ul>
        <p>For more information about Rocky Linux, please visit the
          <a href="https://rockylinux.org/"><strong>Rocky Linux
          website</strong></a>.
        </p>
        </div>
      </div>
      <div class='col-sm-12 col-md-6 col-md-6 col-md-offset-12'>
        <div class='section'>
         
          <h2>I am the admin, what do I do?</h2>

        <p>You may now add content to the webroot directory for your
        software.</p>

        <p><strong>For systems using the
        <a href="https://httpd.apache.org/">Apache Webserver</strong></a>:
        You can add content to the directory <code>/var/www/html/</code>.
        Until you do so, people visiting your website will see this page. If
        you would like this page to not be shown, follow the instructions in:
        <code>/etc/httpd/conf.d/welcome.conf</code>.</p>

        <p><strong>For systems using
        <a href="https://nginx.org">Nginx</strong></a>:
        You can add your content in a location of your
        choice and edit the <code>root</code> configuration directive
        in <code>/etc/nginx/nginx.conf</code>.</p>
        
        <div id="logos">
          <a href="https://rockylinux.org/" id="rocky-poweredby"><img src="icons/poweredby.png" alt="[ Powered by Rocky Linux ]" /></a> <!-- Rocky -->
          <img src="poweredby.png" /> <!-- webserver -->
        </div>       
      </div>
      </div>
      
      <footer class="col-sm-12">
      <a href="https://apache.org">Apache&trade;</a> is a registered trademark of <a href="https://apache.org">the Apache Software Foundation</a> in the United States and/or other countries.<br />
      <a href="https://nginx.org">NGINX&trade;</a> is a registered trademark of <a href="https://">F5 Networks, Inc.</a>.
      </footer>
      
  </body>
</html>
```

![eyesonfire](picture/eyesonfire.gif)

c'est bcp moins esthétique que par le navigateur mais c'est un curl

maintenant on va check le dossier de log de nginx qui ce trouve a ce chemin /var/log/nginx

et on trouve dedans tt ça 

```
[max@web nginx]$ ls -l
total 4
-rw-r--r--. 1 root root 190 Jan 22 15:39 access.log
-rw-r--r--. 1 root root   0 Jan 22 03:35 error.log
[max@web nginx]$ cat access.log 
192.168.64.20 - - [22/Jan/2023:15:38:15 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
192.168.64.20 - - [22/Jan/2023:15:39:41 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
[max@web nginx]$ cat error.log 
[max@web nginx]
```

deux fichier acces (celui qui nous interesse) et error on cat les deux pour voir
dans le acces les requette que j'ai fait via curl et dans error rien du tt parce que j'en ai juste pas eu 


## 5. Modif de la conf du serveur web

ensuite on va changer le port d'écoute du server on passe du 80 au 8080 

etape 1: le firewall 

on ouvre le port 8080 et on fermer le 80

```
[max@web nginx]$ sudo firewall-cmd --remove-port=80/tcp --permanent
[sudo] password for max: 
success
[max@web nginx]$ sudo firewall-cmd --add-port=8080/tcp --permanent
success
[max@web nginx]$ sudo firewall-cmd --add-port=8080/tcp --permanent
Warning: ALREADY_ENABLED: 8080:tcp
success
[max@web nginx]$ sudo firewall-cmd --reload
success
[max@web nginx]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1 enp0s2
  sources: 
  services: cockpit dhcpv6-client mountd nfs rpc-bind ssh
  ports: 8888/tcp 22/tcp 22/udp 8080/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:
```

toute les commande firewall son la 

ensuite 

étape 2: changer la conf du service

on va aller dans la conf de nginx et changer le port d'écoute 

```
[max@web nginx]$ cat nginx.conf | grep listen
        listen       8080;
        listen       [::]:8080;
```

et voila 

on restart le service pour faire prendre effet au changement 

```
[max@web /]$ systemctl restart nginx
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to restart 'nginx.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@web /]$ systemctl status  nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
     Active: active (running) since Sun 2023-01-22 17:28:17 CET; 5s ago
    Process: 4842 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 4843 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 4844 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 4845 (nginx)
      Tasks: 7 (limit: 7412)
     Memory: 6.2M
        CPU: 54ms
     CGroup: /system.slice/nginx.service
             ├─4845 "nginx: master process /usr/sbin/nginx"
             ├─4846 "nginx: worker process"
             ├─4847 "nginx: worker process"
             ├─4848 "nginx: worker process"
             ├─4849 "nginx: worker process"
             ├─4850 "nginx: worker process"
             └─4851 "nginx: worker process"

Jan 22 17:28:17 web systemd[1]: Starting The nginx HTTP and reverse proxy server...
Jan 22 17:28:17 web nginx[4843]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Jan 22 17:28:17 web nginx[4843]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Jan 22 17:28:17 web systemd[1]: Started The nginx HTTP and reverse proxy server. 
```

je t'évite la lecture relou encore une fois ça tourne plus qu'as verifier que c'est sur le bon port 

```
[max@web /]$ sudo ss -lnpaute4 | grep nginx
tcp   LISTEN 0      511                 0.0.0.0:8080       0.0.0.0:*     users:(("nginx",pid=4851,fd=6),("nginx",pid=4850,fd=6),("nginx",pid=4849,fd=6),("nginx",pid=4848,fd=6),("nginx",pid=4847,fd=6),("nginx",pid=4846,fd=6),("nginx",pid=4845,fd=6)) ino:27464 sk:6 cgroup:/system.slice/nginx.service <->
```

et voila encore une fois 

toubon 

![yeahboy](picture/yes.gif)

OK, donc on crée les dossiers www et site_web_1 Et dedans on met un fichier index.html 

le petit cat qui fait plaisir 

```
[max@web nginx]$ cat /var/www/site_web_1/index.html 
<h1>j'adore les chat tt fou </h1>
```

ensuite on va changer la racine web de nginx et toubon normalement 

op la ligne modifier si dessous 

```
[max@web nginx]$ cat nginx.conf | grep root
        root         /var/www/site_web_1/index.html;
```

on restart 

```
[max@web nginx]$ systemctl restart nginx.service 
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to restart 'nginx.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@web nginx]$ curl 192.168.64.20:8080
<h1>j'adore les chat tt fou </h1>
```

ça maaaaarche 

## 6. Deux sites web sur un seul serveur

bon et si on ebergais deux site sur un même server 

pour eviter que ce soit le BORDEL 

on va checker le fichier de conf 

on va reperer la petit ligne qui inclus les fichier additionnel 

```
[max@web nginx]$ cat nginx.conf | grep include
include /usr/share/nginx/modules/*.conf;
    include             /etc/nginx/mime.types;
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/default.d/*.conf;
#        include /etc/nginx/default.d/*.conf;
```

on créé le fichier de conf pour le site 1 et le site 2 

le cat du conf du site 1

```
[max@web conf.d]$ cat site_web_1.conf 
server {
        listen       8080;
        listen       [::]:8080;
        server_name  _;
        root         /var/www/site_web_1/;

        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
```

le cat du fichié de conf du site 2

```
[max@web conf.d]$ cat site_web_2.conf 
server {
        listen       8888;
        listen       [::]:8888;
        server_name  _;
        root         /var/www/site_web_2/;

        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
```

le port 8888 etant deja ouvert sur ma vm 

petit list-all pour le prouver 

```
[sudo] password for max: 
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1 enp0s2
  sources: 
  services: cockpit dhcpv6-client mountd nfs rpc-bind ssh
  ports: 8888/tcp 22/tcp 22/udp 8080/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:
```

et puis il faut faire une petite page web pour le site 2

```
[max@web site_web_2]$ curl 192.168.64.20:8080
<h1>j'adore les chat tt fou </h1>
[max@web site_web_2]$ curl 192.168.64.20:8888
<h1>et voila le site 2 et j'adore toujours les chat fouuuuuuu </h1>
```

et voilaaaaaa toubon 

pfiou fiiiiniiiiii

![fini](picture/fiini.gif)