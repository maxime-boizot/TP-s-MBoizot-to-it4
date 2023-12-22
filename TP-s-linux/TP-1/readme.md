# TP1 : Premiers pas Docker

## Sommaire

- [TP1 : Premiers pas Docker](#tp1--premiers-pas-docker)
  - [Sommaire](#sommaire)
- [0. Setup](#0-setup)
- [I. Init](#i-init)
- [II. Images](#ii-images)
- [III. Docker compose](#iii-docker-compose)

# 0. Setup

On va faire ça sur ma machine donc la checklist est ok

# I. Init

- [I. Init](#i-init)
  - [1. Installation de Docker](#1-installation-de-docker)
  - [2. Vérifier que Docker est bien là](#2-vérifier-que-docker-est-bien-là)
  - [3. sudo c pa bo](#3-sudo-c-pa-bo)
  - [4. Un premier conteneur en vif](#4-un-premier-conteneur-en-vif)
  - [5. Un deuxième conteneur en vif](#5-un-deuxième-conteneur-en-vif)

## 1. Installation de Docker
```bash
max@debian:~$ sudo apt-get update
[sudo] password for max: 
Get:1 http://security.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Hit:2 http://deb.debian.org/debian bookworm InRelease                                      
Get:3 http://deb.debian.org/debian bookworm-updates InRelease [52.1 kB]                    
Hit:4 http://ppa.launchpad.net/gns3/ppa/ubuntu trusty InRelease                            
Hit:5 http://download.virtualbox.org/virtualbox/debian bookworm InRelease                  
Hit:6 http://packages.microsoft.com/repos/code stable InRelease                            
Hit:7 https://brave-browser-apt-release.s3.brave.com stable InRelease                      
Get:8 http://security.debian.org/debian-security bookworm-security/main Sources [67.0 kB]
Get:9 http://security.debian.org/debian-security bookworm-security/main amd64 Packages [130 kB]
Get:10 http://security.debian.org/debian-security bookworm-security/main Translation-en [76.5 kB]
Fetched 373 kB in 1s (384 kB/s)                                
Reading package lists... Done
W: http://ppa.launchpad.net/gns3/ppa/ubuntu/dists/trusty/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
max@debian:~$ sudo apt-get update             
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg                                                                            sudo chmod a+r /etc/apt/keyrings/docker.gpg
                                           
echo \                              
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \                                                              $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \                                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
Hit:1 http://deb.debian.org/debian bookworm InRelease
Hit:2 http://download.virtualbox.org/virtualbox/debian bookworm InRelease
Hit:3 http://deb.debian.org/debian bookworm-updates InRelease                              
Hit:4 http://security.debian.org/debian-security bookworm-security InRelease               
Hit:5 http://ppa.launchpad.net/gns3/ppa/ubuntu trusty InRelease                            
Hit:6 https://brave-browser-apt-release.s3.brave.com stable InRelease                      
Hit:7 http://packages.microsoft.com/repos/code stable InRelease                            
Reading package lists... Done            
W: http://ppa.launchpad.net/gns3/ppa/ubuntu/dists/trusty/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ca-certificates is already the newest version (20230311).
curl is already the newest version (7.88.1-10+deb12u4).
gnupg is already the newest version (2.2.40-1.1).
gnupg set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 88 not upgraded.
Hit:1 http://deb.debian.org/debian bookworm InRelease
Hit:2 http://security.debian.org/debian-security bookworm-security InRelease
Hit:3 http://deb.debian.org/debian bookworm-updates InRelease                              
Hit:4 http://download.virtualbox.org/virtualbox/debian bookworm InRelease                  
Hit:5 http://packages.microsoft.com/repos/code stable InRelease                            
Get:6 https://download.docker.com/linux/debian bookworm InRelease [43.3 kB]                
Hit:7 https://brave-browser-apt-release.s3.brave.com stable InRelease          
Hit:8 http://ppa.launchpad.net/gns3/ppa/ubuntu trusty InRelease                
Get:9 https://download.docker.com/linux/debian bookworm/stable amd64 Packages [13.5 kB]
Fetched 56.8 kB in 1s (54.5 kB/s)   
Reading package lists... Done
W: http://ppa.launchpad.net/gns3/ppa/ubuntu/dists/trusty/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
max@debian:~$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  docker-ce-rootless-extras iptables libip6tc2 libslirp0 pigz slirp4netns
Suggested packages:
  aufs-tools cgroupfs-mount | cgroup-lite firewalld
The following NEW packages will be installed:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-ce-rootless-extras
  docker-compose-plugin iptables libip6tc2 libslirp0 pigz slirp4netns
0 upgraded, 11 newly installed, 0 to remove and 88 not upgraded.
Need to get 115 MB of archives.
After this operation, 413 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://deb.debian.org/debian bookworm/main amd64 pigz amd64 2.6-1 [64.0 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 libip6tc2 amd64 1.8.9-2 [19.4 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 iptables amd64 1.8.9-2 [360 kB] 
Get:4 http://deb.debian.org/debian bookworm/main amd64 libslirp0 amd64 4.7.0-1 [63.0 kB]
Get:5 http://deb.debian.org/debian bookworm/main amd64 slirp4netns amd64 1.2.0-1 [37.5 kB]
Get:6 https://download.docker.com/linux/debian bookworm/stable amd64 containerd.io amd64 1.6.26-1 [29.5 MB]
Get:7 https://download.docker.com/linux/debian bookworm/stable amd64 docker-buildx-plugin amd64 0.11.2-1~debian.12~bookworm [28.2 MB]
Get:8 https://download.docker.com/linux/debian bookworm/stable amd64 docker-ce-cli amd64 5:24.0.7-1~debian.12~bookworm [13.3 MB]
Get:9 https://download.docker.com/linux/debian bookworm/stable amd64 docker-ce amd64 5:24.0.7-1~debian.12~bookworm [22.5 MB]
Get:10 https://download.docker.com/linux/debian bookworm/stable amd64 docker-ce-rootless-extras amd64 5:24.0.7-1~debian.12~bookworm [9030 kB]
Get:11 https://download.docker.com/linux/debian bookworm/stable amd64 docker-compose-plugin amd64 2.21.0-1~debian.12~bookworm [11.9 MB]
Fetched 115 MB in 2s (47.7 MB/s)             
apt-listchanges: Can't set locale; make sure $LC_* and $LANG are correct!
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US",
        LC_ALL = (unset),
        LC_TIME = "fr_FR.UTF-8",
        LC_MONETARY = "en_150.UTF-8",
        LC_MEASUREMENT = "fr_FR.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
locale: Cannot set LC_ALL to default locale: No such file or directory
Selecting previously unselected package pigz.
(Reading database ... 199077 files and directories currently installed.)
Preparing to unpack .../00-pigz_2.6-1_amd64.deb ...
Unpacking pigz (2.6-1) ...
Selecting previously unselected package containerd.io.
Preparing to unpack .../01-containerd.io_1.6.26-1_amd64.deb ...
Unpacking containerd.io (1.6.26-1) ...
Selecting previously unselected package docker-buildx-plugin.
Preparing to unpack .../02-docker-buildx-plugin_0.11.2-1~debian.12~bookworm_amd64.deb ...
Unpacking docker-buildx-plugin (0.11.2-1~debian.12~bookworm) ...
Selecting previously unselected package docker-ce-cli.
Preparing to unpack .../03-docker-ce-cli_5%3a24.0.7-1~debian.12~bookworm_amd64.deb ...
Unpacking docker-ce-cli (5:24.0.7-1~debian.12~bookworm) ...
Selecting previously unselected package libip6tc2:amd64.
Preparing to unpack .../04-libip6tc2_1.8.9-2_amd64.deb ...
Unpacking libip6tc2:amd64 (1.8.9-2) ...
Selecting previously unselected package iptables.
Preparing to unpack .../05-iptables_1.8.9-2_amd64.deb ...
Unpacking iptables (1.8.9-2) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../06-docker-ce_5%3a24.0.7-1~debian.12~bookworm_amd64.deb ...
Unpacking docker-ce (5:24.0.7-1~debian.12~bookworm) ...
Selecting previously unselected package docker-ce-rootless-extras.
Preparing to unpack .../07-docker-ce-rootless-extras_5%3a24.0.7-1~debian.12~bookworm_amd64.deb ...
Unpacking docker-ce-rootless-extras (5:24.0.7-1~debian.12~bookworm) ...
Selecting previously unselected package docker-compose-plugin.
Preparing to unpack .../08-docker-compose-plugin_2.21.0-1~debian.12~bookworm_amd64.deb ...
Unpacking docker-compose-plugin (2.21.0-1~debian.12~bookworm) ...
Selecting previously unselected package libslirp0:amd64.
Preparing to unpack .../09-libslirp0_4.7.0-1_amd64.deb ...
Unpacking libslirp0:amd64 (4.7.0-1) ...
Selecting previously unselected package slirp4netns.
Preparing to unpack .../10-slirp4netns_1.2.0-1_amd64.deb ...
Unpacking slirp4netns (1.2.0-1) ...
Setting up libip6tc2:amd64 (1.8.9-2) ...
Setting up docker-buildx-plugin (0.11.2-1~debian.12~bookworm) ...
Setting up containerd.io (1.6.26-1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
Setting up docker-compose-plugin (2.21.0-1~debian.12~bookworm) ...
Setting up docker-ce-cli (5:24.0.7-1~debian.12~bookworm) ...
Setting up libslirp0:amd64 (4.7.0-1) ...
Setting up pigz (2.6-1) ...
Setting up docker-ce-rootless-extras (5:24.0.7-1~debian.12~bookworm) ...
Setting up slirp4netns (1.2.0-1) ...
Setting up iptables (1.8.9-2) ...
update-alternatives: using /usr/sbin/iptables-legacy to provide /usr/sbin/iptables (iptables) in auto mode
update-alternatives: using /usr/sbin/ip6tables-legacy to provide /usr/sbin/ip6tables (ip6tables) in auto mode
update-alternatives: using /usr/sbin/iptables-nft to provide /usr/sbin/iptables (iptables) in auto mode
update-alternatives: using /usr/sbin/ip6tables-nft to provide /usr/sbin/ip6tables (ip6tables) in auto mode
update-alternatives: using /usr/sbin/arptables-nft to provide /usr/sbin/arptables (arptables) in auto mode
update-alternatives: using /usr/sbin/ebtables-nft to provide /usr/sbin/ebtables (ebtables) in auto mode
```

## 2. Vérifier que Docker est bien là

```bash
max@debian:~$ systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; preset: enabled)
     Active: active (running) since Fri 2023-12-22 10:39:51 CET; 20min ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 6958 (dockerd)
      Tasks: 13
     Memory: 46.5M
        CPU: 1.140s
     CGroup: /system.slice/docker.service
             └─6958 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
max@debian:~$ 
max@debian:~$ 
max@debian:~$ 
max@debian:~$ 
max@debian:~$ sudo docker ps
[sudo] password for max: 
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

bon docker est la il est demarrer et il repond quand on l'appel mais comme dit dans la partie d'après 

sudo c pa bo


## 3. sudo c pa bo

on va s'incruster dans le groupe docker pour avoir le droit sans sudo de causer avec lui

aller c'est tarpi 

on s'ajoute au groupe docker

```bash
sudo usermod -aG docker max
```

ensuite pour appliquer on deco reco mais aussi ce que j'ai fait moi 

```bash
su - max
```

et on test 

```bash
max@debian:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

## 4. Un premier conteneur en vif

allez première image un petit nginx on le connais lui on a l'habitude de bosser avec lui 

on éxécute la commande qui va bien pour deployer l'image 

```bash
max@debian:~$ docker run -d -p 9999:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
af107e978371: Pull complete 
336ba1f05c3e: Pull complete 
8c37d2ff6efa: Pull complete 
51d6357098de: Pull complete 
782f1ecce57d: Pull complete 
5e99d351b073: Pull complete 
7b73345df136: Pull complete 
Digest: sha256:2bdc49f2f8ae8d8dc50ed00f2ee56d00385c6f8bc8a8b320d0a294d9e3b49026
Status: Downloaded newer image for nginx:latest
4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5
max@debian:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                   NAMES
4eb5454e84ad   nginx     "/docker-entrypoint.…"   33 seconds ago   Up 32 seconds   0.0.0.0:9999->80/tcp, :::9999->80/tcp   intelligent_haslett
```

et a ceci je rajoute un ```docker ps```
pour lister les process voir que tt est bien la



# II. Images



# III. Docker compose

[Document dédié à l'utilisation de `docker-compose`.](./compose.md)
