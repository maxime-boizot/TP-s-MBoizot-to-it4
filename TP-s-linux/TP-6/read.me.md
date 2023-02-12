# TP6 : Travail autour de la solution NextCloud

# sommaire: 

- [0. Setup](#0-setup)
- [Module 1 : Reverse Proxy](#module-1--reverse-proxy)
- [Module 2 : Sauvegarde du système de fichiers](#module-2--sauvegarde-du-système-de-fichiers)


# 0. Setup 

ooook bon comme d'hab on déroule la check liste on rajoute dans celle-ci un petite mise a jour de l'os a faire pr eviter tt probleme relou 

nous allons reutiliser nos machine web et db du tp 5

leeets go c'est partie c'est partie 

![go](picture/go.gif)

# Module 1 : Reverse Proxy

notre bon veille amie nginx 

bon nouvelle vm proxy.tp6.linux

comme d'hab checklist ok l'update qui va bien et c'est ok 

ok on y va 

on install nginx, ça fait on demmare le service et on check le port sur lequel écoute le service et on ouvre le port sur le firewall

```
[max@proxy ~]$ sudo dnf install nginx
[sudo] password for max: 
Dependencies resolved.
====================================================================================================================================================
 Package                                 Architecture                  Version                                Repository                       Size
====================================================================================================================================================
Installing:
 nginx                                   aarch64                       1:1.20.1-13.el9                        appstream                        38 k
Installing dependencies:
 nginx-core                              aarch64                       1:1.20.1-13.el9                        appstream                       568 k
 nginx-filesystem                        noarch                        1:1.20.1-13.el9                        appstream                        11 k
 rocky-logos-httpd                       noarch                        90.14-1.el9                            appstream                        24 k

Transaction Summary
====================================================================================================================================================
Install  4 Packages

Total download size: 641 k
Installed size: 1.7 M
Is this ok [y/N]: y
Downloading Packages:
(1/4): rocky-logos-httpd-90.14-1.el9.noarch.rpm                                                                      80 kB/s |  24 kB     00:00    
(2/4): nginx-filesystem-1.20.1-13.el9.noarch.rpm                                                                     33 kB/s |  11 kB     00:00    
(3/4): nginx-1.20.1-13.el9.aarch64.rpm                                                                               73 kB/s |  38 kB     00:00    
(4/4): nginx-core-1.20.1-13.el9.aarch64.rpm                                                                         382 kB/s | 568 kB     00:01    
----------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                               279 kB/s | 641 kB     00:02     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                            1/1 
  Running scriptlet: nginx-filesystem-1:1.20.1-13.el9.noarch                                                                                    1/4 
  Installing       : nginx-filesystem-1:1.20.1-13.el9.noarch                                                                                    1/4 
  Installing       : nginx-core-1:1.20.1-13.el9.aarch64                                                                                         2/4 
  Installing       : rocky-logos-httpd-90.14-1.el9.noarch                                                                                       3/4 
  Installing       : nginx-1:1.20.1-13.el9.aarch64                                                                                              4/4 
  Running scriptlet: nginx-1:1.20.1-13.el9.aarch64                                                                                              4/4 
  Verifying        : rocky-logos-httpd-90.14-1.el9.noarch                                                                                       1/4 
  Verifying        : nginx-1:1.20.1-13.el9.aarch64                                                                                              2/4 
  Verifying        : nginx-filesystem-1:1.20.1-13.el9.noarch                                                                                    3/4 
  Verifying        : nginx-core-1:1.20.1-13.el9.aarch64                                                                                         4/4 

Installed:
  nginx-1:1.20.1-13.el9.aarch64  nginx-core-1:1.20.1-13.el9.aarch64  nginx-filesystem-1:1.20.1-13.el9.noarch  rocky-logos-httpd-90.14-1.el9.noarch 

Complete!
```

```
[max@proxy ~]$ systemctl enable nginx
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ====
Authentication is required to manage system service or unit files.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ====
Authentication is required to reload the systemd state.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@proxy ~]$ systemctl start  nginx
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'nginx.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@proxy ~]$ systemctl status  nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
     Active: active (running) since Sun 2023-02-12 16:21:52 CET; 10s ago
    Process: 35923 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 35924 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 35925 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 35926 (nginx)
      Tasks: 7 (limit: 7412)
     Memory: 6.2M
        CPU: 27ms
     CGroup: /system.slice/nginx.service
             ├─35926 "nginx: master process /usr/sbin/nginx"
             ├─35927 "nginx: worker process"
             ├─35928 "nginx: worker process"
             ├─35929 "nginx: worker process"
             ├─35930 "nginx: worker process"
             ├─35931 "nginx: worker process"
             └─35932 "nginx: worker process"

Feb 12 16:21:52 proxy systemd[1]: Starting The nginx HTTP and reverse proxy server...
Feb 12 16:21:52 proxy nginx[35924]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Feb 12 16:21:52 proxy nginx[35924]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Feb 12 16:21:52 proxy systemd[1]: Started The nginx HTTP and reverse proxy server.
```

bon maintenant on va checker le port d'écoute

```
[max@proxy ~]$ sudo ss -lanput4 | grep nginx
tcp   LISTEN 0      511                 0.0.0.0:80        0.0.0.0:*     users:(("nginx",pid=35932,fd=6),("nginx",pid=35931,fd=6),("nginx",pid=35930,fd=6),("nginx",pid=35929,fd=6),("nginx",pid=35928,fd=6),("nginx",pid=35927,fd=6),("nginx",pid=35926,fd=6))
```

port d'écoute port 80

maintenant on ouvre le port 80 dans le firewall 

```
[max@proxy ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[max@proxy ~]$ sudo firewall-cmd --reload
success
[max@proxy ~]$ sudo firewall-cmd --list-all | grep port
  ports: 8888/tcp 22/tcp 22/udp 80/tcp
  forward-ports: 
  source-ports:
```

on check quel user run le process de nginx 

```
[max@proxy ~]$ sudo ps -ef | grep ngninx
max        35980    1210  0 16:26 pts/0    00:00:00 grep --color=auto ngninx
```

on fait un petit curl sur localhost

```
[max@proxy ~]$ curl localhost
<!doctype html>
<html>

[...]

</html>
```

et pr le fun voila ce que ça donne sur mon navigateur sur mon mac

![petitscreen](picture/Capture%20d%E2%80%99%C3%A9cran%202023-02-12%20%C3%A0%2016.29.20.png)

![c'estbeau](picture/c'estbeau.webp)

maintenant go conf nginx

bon on créé un fichier de conf en .conf pour que le service l'importe bien et on y mets ceci dedans 

```
[max@proxy ~]$ cat /etc/nginx/proxy.conf 
server {

    server_name www.nextcloud.tp6;

    listen 80;

    location / {

        proxy_set_header  Host $host;
        proxy_set_header  X-Real-IP $remote_addr;
        proxy_set_header  X-Forwarded-Proto https;
        proxy_set_header  X-Forwarded-Host $remote_addr;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;

        # On définit la cible du proxying 
        proxy_pass http://<IP_DE_NEXTCLOUD>:80;
    }

    location /.well-known/carddav {
      return 301 $scheme://$host/remote.php/dav;
    }

    location /.well-known/caldav {
      return 301 $scheme://$host/remote.php/dav;
    }
}
```

now on modifie le fichier host de notre machine physique pr qu'elle passe par le proxy pr acceder au server 

```
maximeboizot@MacBook-pro-de-Maxime ~ % cat /etc/hosts
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
192.168.64.24 www.nextcloud.tp6
```

ok ça c'est cool now on va faire en sorte de rendre la connexion au server sur la machine web impossible une des solution c'est de la rendre impossible via le firewall en gros on va fermer le port 

le service continuera d'écouter mais personne ne pourra s'y connecter 

```
[max@web /]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
[max@web /]$ sudo firewall-cmd --reload
success
```

donc si on test de ce connecter en fesant un curl localhost sur la machine web ça marche

```
[max@web ~]$ curl localhost
<!doctype html>
<html>
  
[...]

</html>
```

mais si par exemple avec la machine db on test avec l'ip de la machine web 

```
[max@db ~]$ curl http://192.168.64.19:80
curl: (7) Failed to connect to 192.168.64.19 port 80: No route to host
```

connection refused 

bon pour la suite le port ne suffit pas mais on peut manager les zones pour gerer tous cela 

dans notre cas on va utiliser la zone block 

et comme son nom l'indique elle bloque tous pas de connection entrante donc pas de ssh #relou mais bon tampi 

```
[max@web ~]$ sudo firewall-cmd --set-default-zone block
success
```

ducoup maintenant plus de ssh et plus de ping 

```
maximeboizot@MacBook-pro-de-Maxime ~ % ssh max@192.168.80.10
ssh: connect to host 192.168.80.10 port 22: Connection refused

[max@db ~]$ ping 192.168.64.19
PING 192.168.64.19 (192.168.64.19) 56(84) bytes of data.
From 192.168.64.19 icmp_seq=1 Packet filtered
From 192.168.64.19 icmp_seq=2 Packet filtered
From 192.168.64.19 icmp_seq=3 Packet filtered
From 192.168.64.19 icmp_seq=4 Packet filtered
^C
--- 192.168.64.19 ping statistics ---
4 packets transmitted, 0 received, +4 errors, 100% packet loss, time 3012ms
```

par contre on peut ping le proxy 

```
[max@db ~]$ ping 192.168.64.24
PING 192.168.64.24 (192.168.64.24) 56(84) bytes of data.
64 bytes from 192.168.64.24: icmp_seq=1 ttl=64 time=10.3 ms
64 bytes from 192.168.64.24: icmp_seq=2 ttl=64 time=1.96 ms
64 bytes from 192.168.64.24: icmp_seq=3 ttl=64 time=5.81 ms
64 bytes from 192.168.64.24: icmp_seq=4 ttl=64 time=2.74 ms
^C
--- 192.168.64.24 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3008ms
rtt min/avg/max/mdev = 1.961/5.199/10.293/3.274 ms
```

ooook 



# Module 2 : Sauvegarde du système de fichiers


pour cette partie on va utilisé la vm web allez zepartie 

![zebardi](picture/zebardi.gif)

# Module 3 : Fail2Ban

bon la c'est pas complique on va ban les gens qui brut force 

![degage](picture/degage.gif)

bon on instal fail2ban avec une commande dnf classic 

```
[max@web ~]$ sudo dnf install fail2ban fail2ban-firewalld
[sudo] password for max: 

[...]

Complete!
```

on enable, start, et status 

```
[max@web ~]$ systemctl enable fail2ban.service 
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ====
Authentication is required to manage system service or unit files.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
Created symlink /etc/systemd/system/multi-user.target.wants/fail2ban.service → /usr/lib/systemd/system/fail2ban.service.
==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ====
Authentication is required to reload the systemd state.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@web ~]$ systemctl status fail2ban.service 
○ fail2ban.service - Fail2Ban Service
     Loaded: loaded (/usr/lib/systemd/system/fail2ban.service; enabled; vendor preset: disabled)
     Active: inactive (dead)
       Docs: man:fail2ban(1)
[max@web ~]$ systemctl start fail2ban.service 
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'fail2ban.service'.
Authenticating as: boizot maxime (max)
Password: 
==== AUTHENTICATION COMPLETE ====
[max@web ~]$ systemctl status fail2ban.service 
● fail2ban.service - Fail2Ban Service
     Loaded: loaded (/usr/lib/systemd/system/fail2ban.service; enabled; vendor preset: disabled)
     Active: active (running) since Sun 2023-02-12 22:24:12 CET; 2s ago
       Docs: man:fail2ban(1)
    Process: 27072 ExecStartPre=/bin/mkdir -p /run/fail2ban (code=exited, status=0/SUCCESS)
   Main PID: 27073 (fail2ban-server)
      Tasks: 3 (limit: 7406)
     Memory: 10.3M
        CPU: 54ms
     CGroup: /system.slice/fail2ban.service
             └─27073 /usr/bin/python3 -s /usr/bin/fail2ban-server -xf start

Feb 12 22:24:12 web systemd[1]: Starting Fail2Ban Service...
Feb 12 22:24:12 web systemd[1]: Started Fail2Ban Service.
Feb 12 22:24:12 web fail2ban-server[27073]: 2023-02-12 22:24:12,589 fail2ban.configreader   [27073]: WARNING 'allowipv6' not defined in 'Definition'.>
Feb 12 22:24:12 web fail2ban-server[27073]: Server ready
```

ça c'est ok maintenant la conf 

ok on ce rend dans le fichié de conf nommé 
jail.conf porte bien son nom celui la 

et on entre ce block la 

```
[sshd]
enabled = true
maxretry = 3
findtime = 60
bantime = 120
```

j'ai mis 2min de ban time pr test que je me fasse déban 

on test

```
[max@db ~]$ ssh max@192.168.80.10
max@192.168.80.10's password: 
fPermission denied, please try again.
max@192.168.80.10's password: 
Permission denied, please try again.
max@192.168.80.10's password: 
max@192.168.80.10: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).
[max@db ~]$ ssh max@192.168.80.10
ssh: connect to host 192.168.80.10 port 22: Connection refused
```

![ban](picture/ban.gif)

ok je me suis fait ban on attend 2 min et on reessaye 

```
[max@db ~]$ ssh max@192.168.80.10
max@192.168.80.10's password: 
Activate the web console with: systemctl enable --now cockpit.socket

Last failed login: Sun Feb 12 22:39:14 CET 2023 from 192.168.80.11 on ssh:notty
There were 20 failed login attempts since the last successful login.
Last login: Sun Feb 12 22:01:13 2023 from 192.168.80.1
```

ooook ça marche maintenant petite option en plus 

ok voila un petite command sympa permetant de voir les banni en temps reel 

```
[max@web fail2ban]$ sudo fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed:	0
|  |- Total failed:	3
|  `- Journal matches:	_SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned:	0
   |- Total banned:	1
   `- Banned IP list:
```

je vais me refaire ban pour l'avoir rempli 

```
[max@web fail2ban]$ sudo fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed:	0
|  |- Total failed:	6
|  `- Journal matches:	_SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned:	1
   |- Total banned:	2
   `- Banned IP list:	192.168.80.11
```

et voila l'ip de db 

et si on checkai pendant un ban ce qu'il y a dans le firewall 

```
[max@web fail2ban]$ sudo firewall-cmd --list-all
[sudo] password for max: 
block
  target: BLOCK
  icmp-block-inversion: no
  interfaces: enp0s1 enp0s2
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 22/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	rule family="ipv4" source address="192.168.80.11" port port="ssh" protocol="tcp" reject type="icmp-port-unreachable"
```

on peut voir le ban sur la ligne rich rules

```
set sshd unbanip <ip_debanie>
```

voila une commande a utiliser lorsque l'ont souhaite deban une ip 

pas mal pour un premier dispositif de securiter 

