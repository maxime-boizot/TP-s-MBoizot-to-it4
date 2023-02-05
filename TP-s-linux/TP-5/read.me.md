# TP5 : Self-hosted cloud

# sommaire: 
- [I. Présentation des composants de NextCloud](#i-présentation-des-composants-de-nextcloud)     
    - [1. Présentation du setup](#1-présentation-du-setup)
- [II. Let's go](#ii-lets-go)

- [Partie 1 : Mise en place et maîtrise du serveur Web](#partie-1--mise-en-place-et-maîtrise-du-serveur-web)

    - [1. Installation](#1-installation)
- [Partie 3 : Configuration et mise en place de NextCloud](#partie-3--configuration-et-mise-en-place-de-nextcloud)
  - [1. Base de données](#1-base-de-données)
  - [2. Serveur Web et NextCloud](#2-serveur-web-et-nextcloud)
  - [3. Finaliser l'installation de NextCloud](#3-finaliser-linstallation-de-nextcloud)

checklist ok on y go 

zéparti

# I. Présentation des composants de NextCloud


# II. Let's go

# Partie 1 : Mise en place et maîtrise du serveur Web

## 1. Installation

bon commençons par installer le server httpd 

```
[max@web ~]$ sudo dnf install httpd
[...]
Complete!
```

tout les packet son installer sur la vm web donc goooo 

on va checker le fichié de conf et on dégage tt les comment parce que y'en a plus que de donnée pour la conf 

donc une fois ça fait on démarre le service

```
[max@web ~]$ systemctl enable httpd

[max@web ~]$ systemctl start httpd

[max@web ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
     Active: active (running) since Tue 2023-01-31 11:15:51 CET; 22min ago
       Docs: man:httpd.service(8)
   Main PID: 35726 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 213 (limit: 7412)
     Memory: 39.0M
        CPU: 6.651s
     CGroup: /system.slice/httpd.service
             ├─35726 /usr/sbin/httpd -DFOREGROUND
             ├─35727 /usr/sbin/httpd -DFOREGROUND
             ├─35728 /usr/sbin/httpd -DFOREGROUND
             ├─35729 /usr/sbin/httpd -DFOREGROUND
             └─35730 /usr/sbin/httpd -DFOREGROUND

Jan 31 11:15:51 web systemd[1]: Starting The Apache HTTP Server...
Jan 31 11:15:51 web httpd[35726]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using fe80::6c2c:86ff:fe8d:e>
Jan 31 11:15:51 web httpd[35726]: Server configured, listening on: port 80
Jan 31 11:15:51 web systemd[1]: Started The Apache HTTP Server.
lines 1-20/20 (END)

```

le enable permet de l'avoir a chaque demarrage le start demarre le proc et le status donne le status 

![elon](picture/elon.gif)

on sait qu'il tourne avec le port 80 vu dans le fichier de conf donc on va ouvrir le port 80


on check qu'il écoute bien 

```
[max@web ~]$ sudo ss -lanpt | grep httpd
LISTEN    0      511                *:80               *:*     users:(("httpd",pid=943,fd=4),("httpd",pid=941,fd=4),("httpd",pid=940,fd=4),("httpd",pid=804,fd=4))
```

ok tt est bon

```
[max@web ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for max: 
success
[max@web ~]$ sudo firewall-cmd --reload
success
[max@web ~]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1 enp0s2
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 8888/tcp 22/tcp 22/udp 80/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:
```

bon il est démmarer mais ça donne quoi le firewall est op ducoup bha on test

deja on kill la vm pour check qu'il redemarre au boot ce qui est le cas le curl ensuite

```
[max@web ~]$ curl localhost
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

ça c'est good la suite 

```
[max@web ~]$ curl http://192.168.64.19:80
<!doctype html>
<html>
  [...]
</html>
```

bon en bref je vais t'éviter une lecture terrible c'est la même chose 

![derien](picture/maisderien.webp)

## 2. Avancer vers la maîtrise du service

bon pour trouver le fichier on fait un petit status et up on recupere le chemin magic non 

le petit cat qui fait plaisir

![cat](picture/cat.gif)

mais no pas celui la 

```
[max@web /]$ cat /usr/lib/systemd/system/httpd.service
# See httpd.service(8) for more information on using the httpd service.

# Modifying this file in-place is not recommended, because changes
# will be overwritten during package upgrades.  To customize the
# behaviour, run "systemctl edit httpd" to create an override unit.

# For example, to pass additional options (such as -D definitions) to
# the httpd binary at startup, create an override unit (as is done by
# systemctl edit) and enter the following:

#	[Service]
#	Environment=OPTIONS=-DMY_DEFINE

[Unit]
Description=The Apache HTTP Server
Wants=httpd-init.service
After=network.target remote-fs.target nss-lookup.target httpd-init.service
Documentation=man:httpd.service(8)

[Service]
Type=notify
Environment=LANG=C

ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
# Send SIGWINCH for graceful stop
KillSignal=SIGWINCH
KillMode=mixed
PrivateTmp=true
OOMPolicy=continue

[Install]
WantedBy=multi-user.target
```

bon quand on regarde qui run le processus 

```
[max@web system]$ ps -ef | grep httpd
root         804       1  0 15:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
```
tien tien tien qui voila 

notre ami root 

hum 

on check que la page de test a les perm pour root question bete root s'en fou de perm

mais bon 
```
[max@web share]$ ls -l | grep testpage
drwxr-xr-x.   2 root root    24 Jan 31 11:15 testpage
```

effectivement root a les perm 

bon on va changer tt ça 

on créé un nouvel user 

```
[max@web conf]$ sudo useradd testeur -d /usr/share/httpd -s /sbin/nologin
```

ensuite on modifie le fichier de conf de httpd pour qque ce soit notre utilisateur qui le lance 

```
[max@web conf]$ cat httpd.conf | grep User
User testeur
```

on restart le service et petit ps pour checker que ça a bien pris le changement 

```
[max@web conf]$ ps -ef | grep httpd
root        4718       1  0 16:10 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
testeur     4719    4718  0 16:10 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
testeur     4720    4718  0 16:10 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
testeur     4721    4718  0 16:10 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
testeur     4722    4718  0 16:10 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
max         4942    4338  0 16:17 pts/0    00:00:00 grep --color=auto httpd
```

donc maintenant on peut essayer de changer le port d'écoute donc on va modifier ouvrir le nouveau port et fermer l'ancien 

on choisi le port au hazard

```
[max@web conf]$ echo $RANDOM
4615
```

ça sera ce port la 


maintenant le firewall on ajoute le nouveau enleve l'ancien reload et c'est good

```
[max@web conf]$ sudo firewall-cmd --add-port=4615/tcp --permanent
success
[max@web conf]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
[max@web conf]$ sudo firewall-cmd --reload
success
[max@web conf]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s1 enp0s2
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 8888/tcp 22/tcp 22/udp 4615/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:
```

on modifie donc le port dans le fichier de conf 

```
[max@web conf]$ cat httpd.conf | grep Listen
Listen 4615
```

on restart le service et normalement toubon 

```
[max@web conf]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
     Active: active (running) since Tue 2023-01-31 16:28:23 CET; 6s ago
       Docs: man:httpd.service(8)
   Main PID: 5049 (httpd)
     Status: "Started, listening on: port 4615"
      Tasks: 213 (limit: 7406)
     Memory: 40.6M
        CPU: 120ms
     CGroup: /system.slice/httpd.service
             ├─5049 /usr/sbin/httpd -DFOREGROUND
             ├─5050 /usr/sbin/httpd -DFOREGROUND
             ├─5051 /usr/sbin/httpd -DFOREGROUND
             ├─5052 /usr/sbin/httpd -DFOREGROUND
             └─5053 /usr/sbin/httpd -DFOREGROUND

Jan 31 16:28:23 web systemd[1]: Starting The Apache HTTP Server...
Jan 31 16:28:23 web httpd[5049]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using fe80::6c2c:86ff:fe8d:e9>
Jan 31 16:28:23 web httpd[5049]: Server configured, listening on: port 4615
Jan 31 16:28:23 web systemd[1]: Started The Apache HTTP Server.
```

ok ça tourne

![nice](picture/nice.webp)

on curl pour verifier 

# Partie 2 : Mise en place et maîtrise du serveur de base de données

bon on install maridb avec la command dnf classic me dirier vous 

```
[max@db ~]$ sudo dnf install maridb-server
```

```
[max@db ~]$ sudo dnf install mariadb-server

[...]                     

Complete!
```

ça c'est fait 

![check](picture/check.gif)

maintenant on demmare le service

```
[max@db ~]$ systemctl enable mariadb
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ====
Authentication is required to manage system service or unit files.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
Created symlink /etc/systemd/system/mysql.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/mysqld.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/multi-user.target.wants/mariadb.service → /usr/lib/systemd/system/mariadb.service.
==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ====
Authentication is required to reload the systemd state.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@db ~]$ systemctl start mariadb
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'mariadb.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
```
maintenant on sécurise tt ça 

```
[max@db ~]$ sudo mysql_secure_installation
[sudo] password for max: 

[...]

Thanks for using MariaDB!
```

en gros on dit yes a tout sauf changer le password root

et c'est bon  

bon mtn on trouve sur quel port ecoute le service comme d'hab un petit ss

```
[sudo] password for max: 
LISTEN 0      80                 *:3306            *:*     users:(("mariadbd",pid=6597,fd=19))
```

et voila ducoup on va open le port sur le firewall pour que le service fonctionne bien 

```
[max@db ~]$ sudo firewall-cmd --add-port=3306/tcp --permanent
success
[max@db ~]$ sudo firewall-cmd --reload
success
[max@db ~]$ sudo firewall-cmd --list-all | grep port
  ports: 8888/tcp 22/tcp 22/udp 3306/tc
```

maintenant le processus avec un petit ps 

```
[max@db ~]$ ps -ef | grep mariadb
mysql       6597       1  0 16:46 ?        00:00:03 /usr/libexec/mariadbd --basedir=/usr
max         6788    4304  0 17:38 pts/0    00:00:00 grep --color=auto mariadb
```

bien maintenant que db est install go la pt 3

![yes](picture/yes.gif)

# Partie 3 : Configuration et mise en place de NextCloud 

on va setup NextCloud 

youhouuuu 

![youhou](picture/youhou.gif)

## 1. Base de données

ooook on va parametre tt ce petit monde on commence par créé un utilisateur sur la bd 

```
[max@db ~]$ sudo mysql -u root -p
[sudo] password for max: 
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 9
Server version: 10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE USER 'nextcloud'@'192.168.64.19' IDENTIFIED BY '******';
Query OK, 0 rows affected (0.011 sec)
```
on créé la bd pour nextcloud 

```
CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

on donne les droit a notre utilisateur 

```
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'192.168.64.19';
```

et on active les privilege parce qu'il faut des privilege dans cette société 
```
FLUSH PRIVILEGES;
```

donc dans un premier temps on install mysql sur la vm web 

```
[max@web ~]$ sudo dnf install mysql
[sudo] password for max: 

[...]                               

Complete!
```

voiiiila mtn on essaye de s'y connecter

```
[max@web ~]$ sudo mysql -u nextcloud -h 192.168.80.11 -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 18
Server version: 5.5.5-10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

et voiiiilaaa on est connecter 

on va test avec les commande fourni dans le tp 

le show 

```
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| nextcloud          |
+--------------------+
2 rows in set (0.00 sec)
```

ok c'est cool 
```
mysql> USE nextcloud;
Database changed
```

ici ça marche 


la petite dernière pour la route 
```
mysql> SHOW TABLES;
Empty set (0.00 sec)
```
oooook c'est tt good

maintenant essayons de vous tt les utilisateur qu'il y a sur le service mais ça on va le faire sur la machine db la web n'as pas les droit pour ça 

```
MariaDB [(none)]> SELECT User, Host, Password FROM mysql.user;
+-------------+---------------+-------------------------------------------+
| User        | Host          | Password                                  |
+-------------+---------------+-------------------------------------------+
| mariadb.sys | localhost     |                                           |
| root        | localhost     | invalid                                   |
| mysql       | localhost     | invalid                                   |
| nextcloud   | 192.168.64.19 | *4490F19AF6EE3F6A666A9EABABF7C7D9E2AB201E |
| nextcloud   | 192.168.80.10 | *4490F19AF6EE3F6A666A9EABABF7C7D9E2AB201E |
+-------------+---------------+-------------------------------------------+
5 rows in set (0.004 sec)
```

ça en fait de utilisateur 


## 2. Serveur Web et NextCloud

bon on remet dans ça config initial le server nextcloud 

et on y va 

```
[max@web conf]$ sudo dnf config-manager --set-enabled crb
[max@web conf]$ sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y

[...]

Complete!
[max@web conf]$ dnf module list php

[...]         

Complete!
```

on recupere un petit zip bien loourrrd (pas du ttjuste ma co est nul)

```
[max@web tp5_nextcloud]$ sudo wget https://download.nextcloud.com/server/prereleases/nextcloud-25.0.0rc3.zip
--2023-02-05 20:43:11--  https://download.nextcloud.com/server/prereleases/nextcloud-25.0.0rc3.zip
Resolving download.nextcloud.com (download.nextcloud.com)... 95.217.64.181, 2a01:4f9:2a:3119::181
Connecting to download.nextcloud.com (download.nextcloud.com)|95.217.64.181|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 176341139 (168M) [application/zip]
Saving to: ‘nextcloud-25.0.0rc3.zip’

 
nextcloud-25.0.0rc3.zip                              100%[====================================================================================================================>] 168.17M   309KB/s    in 55m 40s 

2023-02-05 21:38:53 (51.6 KB/s) - ‘nextcloud-25.0.0rc3.zip’ saved [176341139/176341139]
```
comme écris j'ai mis 55 min pr un pauvre zip 

bon après ça on le des zip 

```
[max@web tp5_nextcloud]$ sudo unzip nextcloud-25.0.0rc3.zip 
[sudo] password for max:
```

j'épargne la lecture des 3 millions de ligne que ça m'as print 

ensuite on move l'index html dans le dossier /var/www/tp5_nextcloud/
```
[max@web nextcloud]$ sudo mv index.html /var/www/tp5_nextcloud/
```

oook maintenant on va donner les droit a tt ce beau monde pour que apache puisse acceder a tt les programme avec lutilisateur avec lequelle il est lancer 

```
[max@web /]$ sudo chown max var
[max@web var]$ sudo chown max www
[max@web www]$ sudo chown max tp5_nextcloud/
[max@web tp5_nextcloud]$ sudo chown max nextcloud
[max@web tp5_nextcloud]$ sudo chown max index.html
```

maintenant on va adapter la conf de apache pr que tt ce beau monde soit link ensemble

on créé un fichier de conf nommé sitetp5.conf

le .conf est important car c'est lui qui permet d'importer la conf et on oublie pas de donner les droit pr pas etre enquiquiner 

```
[max@web conf]$ sudo touch sitewebtp5.conf
[sudo] password for max: 
[max@web conf]$ sudo chown max sitewebtp5.conf 
[max@web httpd]$ sudo chown max conf
[max@web etc]$ sudo chown max httpd
[max@web /]$ sudo chown max etc
```

ok maintenant on modifie notre fichier de conf et restart le service et si tt va bien ça explose pas 

```
[max@web /]$ cd /etc/httpd/conf
[max@web conf]$ sudo nano sitewebtp5.conf 
[max@web conf]$ cat sitewebtp5.conf 
<VirtualHost *:80>

  DocumentRoot /var/www/tp5_nextcloud/

  ServerName  web.tp5.linux

  <Directory /var/www/tp5_nextcloud/> 
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews
    <IfModule mod_dav.c>
      Dav off
    </IfModule>
  </Directory>
</VirtualHost>
```

 attention

```
[max@web conf]$ systemctl restart httpd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to restart 'httpd.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
```

![explosion](picture/explosion.gif)

naaaaan j'rigoooole tt va bien enfaite 

```
[max@web conf]$ systemctl status  httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
    Drop-In: /usr/lib/systemd/system/httpd.service.d
             └─php-fpm.conf
     Active: active (running) since Sun 2023-02-05 22:27:07 CET; 10s ago
       Docs: man:httpd.service(8)
   Main PID: 4369 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 213 (limit: 7406)
     Memory: 45.2M
        CPU: 137ms
     CGroup: /system.slice/httpd.service
             ├─4369 /usr/sbin/httpd -DFOREGROUND
             ├─4370 /usr/sbin/httpd -DFOREGROUND
             ├─4371 /usr/sbin/httpd -DFOREGROUND
             ├─4372 /usr/sbin/httpd -DFOREGROUND
             └─4373 /usr/sbin/httpd -DFOREGROUND

Feb 05 22:27:07 web systemd[1]: Starting The Apache HTTP Server...
Feb 05 22:27:07 web httpd[4369]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using fe80::6c2c:86ff:fe8d:e9a7%enp0s1. Set the 'ServerName' directive globally to suppre>
Feb 05 22:27:07 web httpd[4369]: Server configured, listening on: port 80
Feb 05 22:27:07 web systemd[1]: Started The Apache HTTP Server.

```

![good](picture/good.gif)

## 3. Finaliser l'installation de NextCloud

bien on modifie le fichier host de son pc pr y acceder avec le nom web.tp5.linux

le petit cat 

```
maximeboizot@MacBook-pro-de-Maxime / % sudo cat /etc/hosts
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost

192.168.80.129 mon-super-site.local
192.168.80.1 node1
192.168.80.3 routeur
192.168.80.10 web.tp5.linux
```

et on test 

```
maximeboizot@MacBook-pro-de-Maxime / % curl http://web.tp5.linux
<!doctype html>
<html>
  
  [...]

</html>
```

bon je te passe l'html/css 

mais c'est le bon site mdr

