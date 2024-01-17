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
```

et a ceci je rajoute un ```docker ps```
pour lister les process voir que tt est bien la


```bash
max@debian:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                   NAMES
4eb5454e84ad   nginx     "/docker-entrypoint.…"   33 seconds ago   Up 32 seconds   0.0.0.0:9999->80/tcp, :::9999->80/tcp   intelligent_haslett
```

on peut checker les logs avec un simple docker logs *countainer id/containes name*

```bash 
max@debian:/etc$ docker logs 4eb5454e84ad
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/12/22 16:36:23 [notice] 1#1: using the "epoll" event method
2023/12/22 16:36:23 [notice] 1#1: nginx/1.25.3
2023/12/22 16:36:23 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14) 
2023/12/22 16:36:23 [notice] 1#1: OS: Linux 6.1.0-13-amd64
2023/12/22 16:36:23 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2023/12/22 16:36:23 [notice] 1#1: start worker processes
2023/12/22 16:36:23 [notice] 1#1: start worker process 29
2023/12/22 16:36:23 [notice] 1#1: start worker process 30
2023/12/22 16:36:23 [notice] 1#1: start worker process 31
2023/12/22 16:36:23 [notice] 1#1: start worker process 32
2023/12/22 16:36:23 [notice] 1#1: start worker process 33
2023/12/22 16:36:23 [notice] 1#1: start worker process 34
2023/12/22 16:36:23 [notice] 1#1: start worker process 35
2023/12/22 16:36:23 [notice] 1#1: start worker process 36

```

on fait un petit *docker inspect avec l'id du container*

```bash
max@debian:/etc$ docker inspect 4eb5454e84ad
[
    {
        "Id": "4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5",
        "Created": "2023-12-22T16:36:22.704554884Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 11064,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2023-12-22T16:36:23.284602138Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:d453dd892d9357f3559b967478ae9cbc417b52de66b53142f6c16c8a275486b9",
        "ResolvConfPath": "/var/lib/docker/containers/4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5/hostname",
        "HostsPath": "/var/lib/docker/containers/4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5/hosts",
        "LogPath": "/var/lib/docker/containers/4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5/4eb5454e84ad4840507fe91747952f1bb5b637cb2c764ad4c220d43e9398bfd5-json.log",
        "Name": "/intelligent_haslett",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "80/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "9999"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                41,
                188
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "private",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": null,
            "PidsLimit": null,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware",
                "/sys/devices/virtual/powercap"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/b4fdc7672a1785242493878dc7185f30a1ab7888b65abc7f1d212b0203beea79-init/diff:/var/lib/docker/overlay2/a5e707579e1e8b396795f232e5316344b5b537e4d0243f458a242a44f45d74bb/diff:/var/lib/docker/overlay2/0eef57fd9945cfd3f3ac2784cf7b45969ef594c7d296582beec25b64c9046a44/diff:/var/lib/docker/overlay2/7c73728f22884d4af56e50053fa858823a9b8566fee28c056937d25db164ca03/diff:/var/lib/docker/overlay2/db9c162091b0ac0feb528e5313164fb617a622c359857bf6470e1d1958c9bd16/diff:/var/lib/docker/overlay2/1b2ffadffae779d69e32ca18d7a272322c7e4614180fe2d1589cda9bf00809fe/diff:/var/lib/docker/overlay2/078439da5c77d6e477b924a02daa91fcb03544cea5cd5136018bab9d83ef67f5/diff:/var/lib/docker/overlay2/199ca0e4b21e8455e7b03c76d29811cf0e84460a080877a894357b835fb670f6/diff",
                "MergedDir": "/var/lib/docker/overlay2/b4fdc7672a1785242493878dc7185f30a1ab7888b65abc7f1d212b0203beea79/merged",
                "UpperDir": "/var/lib/docker/overlay2/b4fdc7672a1785242493878dc7185f30a1ab7888b65abc7f1d212b0203beea79/diff",
                "WorkDir": "/var/lib/docker/overlay2/b4fdc7672a1785242493878dc7185f30a1ab7888b65abc7f1d212b0203beea79/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "4eb5454e84ad",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "80/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "NGINX_VERSION=1.25.3",
                "NJS_VERSION=0.8.2",
                "PKG_RELEASE=1~bookworm"
            ],
            "Cmd": [
                "nginx",
                "-g",
                "daemon off;"
            ],
            "Image": "nginx",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": [
                "/docker-entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {
                "maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
            },
            "StopSignal": "SIGQUIT"
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "0cd0644437b4a500adeba58fba450cf53019e712c79c5b3ece74348c2beaa0bb",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "80/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "9999"
                    },
                    {
                        "HostIp": "::",
                        "HostPort": "9999"
                    }
                ]
            },
            "SandboxKey": "/var/run/docker/netns/0cd0644437b4",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "f70b5dc1de9e6701ff3879b77626f2e9d130fbbaeac814073ae240b948b1f7ad",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "3ceac01a6390139b1290cec1e0760f2b7c3bd0de71ffaab117a997d288c38592",
                    "EndpointID": "f70b5dc1de9e6701ff3879b77626f2e9d130fbbaeac814073ae240b948b1f7ad",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        }
    }
]
```
pour ce qui est du port d'écoute on fait un petit ```ss -lnpt```

```bash
max@debian:/$ sudo ss -lnpt | grep docker
LISTEN 0      4096         0.0.0.0:9999      0.0.0.0:*    users:(("docker-proxy",pid=11016,fd=4))
LISTEN 0      4096            [::]:9999         [::]:*    users:(("docker-proxy",pid=11023,fd=4))
```

firewall: on ajoute le port, on reload le firewall? et on verifie

```bash
max@debian:/etc$ sudo firewall-cmd --add-port=9999/tcp --permanent
[sudo] Mot de passe de max : 
success
max@debian:/etc$ sudo firewall-cmd --reload
success
max@debian:/etc$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: wlp61s0
  sources: 
  services: dhcpv6-client ssh
  ports: 9999/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

quand on visite le site on tombe sur la page nginx logique 

petit curl a l'appui

```html
max@debian:/etc$ curl http://192.168.0.37:9999
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

bon on a ajouter notre conf et un site_nul et ça fonctionne 

```bash
max@debian:~/nginx$ docker run -d -p 9999:8080 -v /home/max/nginx/index.html:/var/www/html/index.html -v /home/max/nginx/site_nul.conf:/etc/nginx/conf.d/site_nul.conf nginx
df42d6540311502fdec4440342b286bad90d361a16859fe19b1da2916612db79
max@debian:~/nginx$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                               NAMES
df42d6540311   nginx     "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds   80/tcp, 0.0.0.0:9999->8080/tcp, :::9999->8080/tcp   determined_cannon
max@debian:~/nginx$ docker logs df42d6540311
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/12/24 16:37:58 [notice] 1#1: using the "epoll" event method
2023/12/24 16:37:58 [notice] 1#1: nginx/1.25.3
2023/12/24 16:37:58 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14) 
2023/12/24 16:37:58 [notice] 1#1: OS: Linux 6.1.0-13-amd64
2023/12/24 16:37:58 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2023/12/24 16:37:58 [notice] 1#1: start worker processes
2023/12/24 16:37:58 [notice] 1#1: start worker process 29
2023/12/24 16:37:58 [notice] 1#1: start worker process 30
2023/12/24 16:37:58 [notice] 1#1: start worker process 31
2023/12/24 16:37:58 [notice] 1#1: start worker process 32
2023/12/24 16:37:58 [notice] 1#1: start worker process 33
2023/12/24 16:37:58 [notice] 1#1: start worker process 34
2023/12/24 16:37:58 [notice] 1#1: start worker process 35
2023/12/24 16:37:58 [notice] 1#1: start worker process 36
```

et le petit curl qui va bien 

```html
max@debian:~/nginx$ curl http://192.168.0.37:9999
<h1>MEOOOW</h1>
```

pas mal non 

## 5. Un deuxieme conteneur en vif

quand y en a un c'est bien mais quand y en a deux c'est meiuw

et si on demarrai pyhton genre 

bim 


```bash
max@debian:~/nginx$ docker run -it python bash
Unable to find image 'python:latest' locally
latest: Pulling from library/python
bc0734b949dc: Pull complete 
b5de22c0f5cd: Pull complete 
917ee5330e73: Pull complete 
b43bd898d5fb: Pull complete 
7fad4bffde24: Pull complete 
d685eb68699f: Pull complete 
107007f161d0: Pull complete 
02b85463d724: Pull complete 
Digest: sha256:3733015cdd1bd7d9a0b9fe21a925b608de82131aa4f3d397e465a1fcb545d36f
Status: Downloaded newer image for python:latest
root@81e803bad9c2:/# ls 
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@81e803bad9c2:/# ip a
bash: ip: command not found
root@81e803bad9c2:/#
```

on utilise pip pour installer les libs python 

```bash 
root@81e803bad9c2:/# pip install aiohttp
Collecting aiohttp
  Obtaining dependency information for aiohttp from https://files.pythonhosted.org/packages/75/5f/90a2869ad3d1fb9bd984bfc1b02d8b19e381467b238bd3668a09faa69df5/aiohttp-3.9.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading aiohttp-3.9.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (7.4 kB)
Collecting attrs>=17.3.0 (from aiohttp)
  Downloading attrs-23.1.0-py3-none-any.whl (61 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.2/61.2 kB 435.7 kB/s eta 0:00:00
Collecting multidict<7.0,>=4.5 (from aiohttp)
  Downloading multidict-6.0.4.tar.gz (51 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 51.3/51.3 kB 386.1 kB/s eta 0:00:00
  Installing build dependencies ... done
  Getting requirements to build wheel ... done
  Installing backend dependencies ... done
  Preparing metadata (pyproject.toml) ... done
Collecting yarl<2.0,>=1.0 (from aiohttp)
  Obtaining dependency information for yarl<2.0,>=1.0 from https://files.pythonhosted.org/packages/28/1c/bdb3411467b805737dd2720b85fd082e49f59bf0cc12dc1dfcc80ab3d274/yarl-1.9.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading yarl-1.9.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (31 kB)
Collecting frozenlist>=1.1.1 (from aiohttp)
  Obtaining dependency information for frozenlist>=1.1.1 from https://files.pythonhosted.org/packages/0b/f2/b8158a0f06faefec33f4dff6345a575c18095a44e52d4f10c678c137d0e0/frozenlist-1.4.1-cp312-cp312-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading frozenlist-1.4.1-cp312-cp312-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (12 kB)
Collecting aiosignal>=1.1.2 (from aiohttp)
  Downloading aiosignal-1.3.1-py3-none-any.whl (7.6 kB)
Collecting idna>=2.0 (from yarl<2.0,>=1.0->aiohttp)
  Obtaining dependency information for idna>=2.0 from https://files.pythonhosted.org/packages/c2/e7/a82b05cf63a603df6e68d59ae6a68bf5064484a0718ea5033660af4b54a9/idna-3.6-py3-none-any.whl.metadata
  Downloading idna-3.6-py3-none-any.whl.metadata (9.9 kB)
Downloading aiohttp-3.9.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.3 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.3/1.3 MB 376.0 kB/s eta 0:00:00
Downloading frozenlist-1.4.1-cp312-cp312-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (281 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 281.5/281.5 kB 405.0 kB/s eta 0:00:00
Downloading yarl-1.9.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (322 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 322.4/322.4 kB 413.8 kB/s eta 0:00:00
Downloading idna-3.6-py3-none-any.whl (61 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.6/61.6 kB 434.8 kB/s eta 0:00:00
Building wheels for collected packages: multidict
  Building wheel for multidict (pyproject.toml) ... done
  Created wheel for multidict: filename=multidict-6.0.4-cp312-cp312-linux_x86_64.whl size=114916 sha256=2c67c438f55e6f2cc07a770b5ac8f947e6be615cff8a8825723d456f1bfb6978
  Stored in directory: /root/.cache/pip/wheels/f6/d8/ff/3c14a64b8f2ab1aa94ba2888f5a988be6ab446ec5c8d1a82da
Successfully built multidict
Installing collected packages: multidict, idna, frozenlist, attrs, yarl, aiosignal, aiohttp
Successfully installed aiohttp-3.9.1 aiosignal-1.3.1 attrs-23.1.0 frozenlist-1.4.1 idna-3.6 multidict-6.0.4 yarl-1.9.4
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

[notice] A new release of pip is available: 23.2.1 -> 23.3.2
[notice] To update, run: pip install --upgrade pip
root@81e803bad9c2:/# pip install aioconsole
Collecting aioconsole
  Obtaining dependency information for aioconsole from https://files.pythonhosted.org/packages/f7/39/b392dc1a8bb58342deacc1ed2b00edf88fd357e6fdf76cc6c8046825f84f/aioconsole-0.7.0-py3-none-any.whl.metadata
  Downloading aioconsole-0.7.0-py3-none-any.whl.metadata (5.3 kB)
Downloading aioconsole-0.7.0-py3-none-any.whl (30 kB)
Installing collected packages: aioconsole
Successfully installed aioconsole-0.7.0
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

[notice] A new release of pip is available: 23.2.1 -> 23.3.2
[notice] To update, run: pip install --upgrade pip
root@81e803bad9c2:/# sudo pip install aioconsole
bash: sudo: command not found
root@81e803bad9c2:/# python
Python 3.12.1 (main, Dec 19 2023, 20:14:15) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
```

le petit interpreteur

```bash
root@81e803bad9c2:/# python
Python 3.12.1 (main, Dec 19 2023, 20:14:15) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

et l'import des lib 

```bash
>>> import aiohttp
>>> import aioconsole
```

# II. Images

- [II. Images](#ii-images)
  - [1. Images publiques](#1-images-publiques)
  - [2. Construire une image](#2-construire-une-image)

## 1. Images publiques

bon on recupere les images demander on peut les recuperr avec un docker pull

```bash
max@debian:~/nginx$ docker pull python:3.11
3.11: Pulling from library/python
bc0734b949dc: Already exists 
b5de22c0f5cd: Already exists 
917ee5330e73: Already exists 
b43bd898d5fb: Already exists 
7fad4bffde24: Already exists 
1f68ce6a3e62: Pull complete 
e27d998f416b: Pull complete 
fefdcd9854bf: Pull complete 
Digest: sha256:4e5e9b05dda9cf699084f20bb1d3463234446387fa0f7a45d90689c48e204c83
Status: Downloaded newer image for python:3.11
docker.io/library/python:3.11
```
ici python avec la version specifier en 3.11

et on recupere pareil pour my sql 

pour ce qui est de wordpress on recupere la derniere version donc on mets le tag *:latest*


```bash
max@debian:~/nginx$ docker pull wordpress:latest
latest: Pulling from library/wordpress
af107e978371: Already exists 
6480d4ad61d2: Pull complete 
95f5176ece8b: Pull complete 
0ebe7ec824ca: Pull complete 
673e01769ec9: Pull complete 
74f0c50b3097: Pull complete 
1a19a72eb529: Pull complete 
50436df89cfb: Pull complete 
8b616b90f7e6: Pull complete 
df9d2e4043f8: Pull complete 
d6236f3e94a1: Pull complete 
59fa8b76a6b3: Pull complete 
99eb3419cf60: Pull complete 
22f5c20b545d: Pull complete 
1f0d2c1603d0: Pull complete 
4624824acfea: Pull complete 
79c3af11cab5: Pull complete 
e8d8239610fb: Pull complete 
a1ff013e1d94: Pull complete 
31076364071c: Pull complete 
87728bbad961: Pull complete 
Digest: sha256:ffabdfe91eefc08f9675fe0e0073b2ebffa8a62264358820bcf7319b6dc09611
Status: Downloaded newer image for wordpress:latest
docker.io/library/wordpress:latest
```

et on list toute les image avec un *docker images*

```bash
max@debian:~/nginx$ docker images
REPOSITORY           TAG       IMAGE ID       CREATED        SIZE
linuxserver/wikijs   latest    869729f6d3c5   10 days ago    441MB
mysql                5.7       5107333e08a8   12 days ago    501MB
python               latest    fc7a60e86bae   2 weeks ago    1.02GB
wordpress            latest    fd2f5a0c6fba   2 weeks ago    739MB
python               3.11      22140cbb3b0c   2 weeks ago    1.01GB
nginx                latest    d453dd892d93   2 months ago   187MB
hello-world          latest    d2c94e258dcb   7 months ago   13.3kB
```

on peut voir toute les images telecharger sur ma machine leur version leur tailles etc...

on lance un petit container avec python 3.11

```bash
max@debian:~/nginx$ docker run -it python:3.11 bash
root@0e7a7bac67b2:/# python -V
Python 3.11.7
```


## 2. Construire une image

bon construire une image c'est chaint j'en ai chier avec une grippe c'est du fun bref 

on a ici le petit docker files et le contener qui run bien comme il faut (es autres y sont plus mon pc s'est eteit oups)


```bash
max@debian:~/python_app_build$ sudo docker build . -t python_app:version_de_ouf
[+] Building 584.8s (12/12) FINISHED                                                                                                                                         docker:default
 => [internal] load .dockerignore                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                        0.0s
 => [internal] load build definition from Dockerfile                                                                                                                                   0.0s
 => => transferring dockerfile: 652B                                                                                                                                                   0.0s
 => [internal] load metadata for docker.io/library/debian:bullseye-slim                                                                                                                0.5s
 => [1/7] FROM docker.io/library/debian:bullseye-slim@sha256:d3d0d14f49b49a4dd98a436711f5646dc39e1c99203ef223d1b6620061e2c0e5                                                        116.9s
 => => resolve docker.io/library/debian:bullseye-slim@sha256:d3d0d14f49b49a4dd98a436711f5646dc39e1c99203ef223d1b6620061e2c0e5                                                          0.0s
 => => sha256:634e16cb03ae927ff6e94ef9db8adae6749a3c9d9cc2e8c6e880ba83a291a85d 1.46kB / 1.46kB                                                                                         0.0s
 => => sha256:b5a0d5c14ba9ece1eecd5137c468d9a123372b0af2ed2c8c4446137730c90e5b 31.42MB / 31.42MB                                                                                     115.7s
 => => sha256:d3d0d14f49b49a4dd98a436711f5646dc39e1c99203ef223d1b6620061e2c0e5 1.85kB / 1.85kB                                                                                         0.0s
 => => sha256:4b48997afc712259da850373fdbc60315316ee72213a4e77fc5a66032d790b2a 529B / 529B                                                                                             0.0s
 => => extracting sha256:b5a0d5c14ba9ece1eecd5137c468d9a123372b0af2ed2c8c4446137730c90e5b                                                                                              1.0s
 => [internal] load build context                                                                                                                                                      0.0s
 => => transferring context: 27B                                                                                                                                                       0.0s
 => [2/7] RUN apt-get update                                                                                                                                                          33.0s
 => [3/7] RUN apt-get install -y python3 python3-pip python3-venv                                                                                                                    426.6s
 => [4/7] WORKDIR /app                                                                                                                                                                 0.1s 
 => [5/7] COPY app.py /app/                                                                                                                                                            0.1s 
 => [6/7] RUN python3 -m venv venv                                                                                                                                                     2.1s 
 => [7/7] RUN /app/venv/bin/python3 -m pip install emoji                                                                                                                               3.5s 
 => exporting to image                                                                                                                                                                 1.9s 
 => => exporting layers                                                                                                                                                                1.9s 
 => => writing image sha256:550be2cb44e8af1b8c29e073f1d7207b131e6df8abbc46ed7d97ddf6cbfc9e69                                                                                           0.0s 
 => => naming to docker.io/library/python_app:version_de_ouf                                                                                                                           0.0s
max@debian:~/python_app_build$ docker run python_app:version_de_ouf
Cet exemple d'application est vraiment naze 👎

```

# III. Docker compose


bon docker composer maintenant 

pouf 


```bash 
max@debian:~$ touch docker-compose.yml
max@debian:~$ mkdir ^C
max@debian:~$ mkdir compose_test
max@debian:~$ mv docker-compose.yml compose_test/
max@debian:~$ ls -l
total 52
drwxr-xr-x 5 max max 4096 Jan  5 12:14  Bureau
drwxr-xr-x 3 max max 4096 Dec  8 09:56  Documents
drwxr-xr-x 7 max max 4096 Dec  7 11:32  GNS3
drwxr-xr-x 2 max max 4096 Dec  5 11:39  Images
drwxr-xr-x 2 max max 4096 Dec  5 11:39 'Mod'$'\303\250''les'
drwxr-xr-x 2 max max 4096 Dec  5 11:39  Musique
drwxr-xr-x 2 max max 4096 Dec  5 11:39  Public
drwxr-xr-x 2 max max 4096 Jan  5 12:25 'T'$'\303\251''l'$'\303\251''chargements'
drwxr-xr-x 2 max max 4096 Dec  5 11:39 'Vid'$'\303\251''os'
drwx------ 4 max max 4096 Dec 15 12:15 'VirtualBox VMs'
drwxr-xr-x 2 max max 4096 Jan 10 05:32  compose_test
drwxr-xr-x 2 max max 4096 Dec 24 17:11  nginx
drwxr-xr-x 2 max max 4096 Jan 10 05:14  python_app_build
max@debian:~$ cd compose_test/
max@debian:~/compose_test$ ls -l
total 0
-rw-r--r-- 1 max max 0 Jan 10 05:31 docker-compose.yml
max@debian:~/compose_test$ nano docker-compose.yml 
max@debian:~/compose_test$ docker compose up -d
[+] Running 3/3
 ✔ conteneur_nul 1 layers [⣿]      0B/0B      Pulled                                                                                                                                   4.4s 
   ✔ bc0734b949dc Already exists                                                                                                                                                       0.0s 
 ✔ conteneur_flopesque Pulled                                                                                                                                                          4.8s 
[+] Running 3/3
 ✔ Network compose_test_default                  Created                                                                                                                               0.2s 
 ✔ Container compose_test-conteneur_nul-1        Started                                                                                                                               0.1s 
 ✔ Container compose_test-conteneur_flopesque-1  Started                                                                                                                               0.1s 
max@debian:~/compose_test$ docker ps
CONTAINER ID   IMAGE     COMMAND        CREATED          STATUS          PORTS     NAMES
20536ed4faeb   debian    "sleep 9999"   24 seconds ago   Up 23 seconds             compose_test-conteneur_flopesque-1
c1c763ec29eb   debian    "sleep 9999"   24 seconds ago   Up 23 seconds             compose_test-conteneur_nul-1
```

donc la en gros je crée le docker compose avec la conf que le grand meo nous donne et je le up sans soucis.
