# TP3 Admin : Vagrant


## Sommaire

- [TP3 Admin : Vagrant](#tp3-admin--vagrant)
  - [0. Intro blabla](#0-intro-blabla)
  - [1. Une première VM](#1-une-première-vm)
  - [2. Repackaging](#2-repackaging)
  - [3. Moult VMs](#3-moult-vms)

## 1. Une première VM

🌞 **Générer un `Vagrantfile`**

aller c'est parti on génère un Vagrantfile ou on va mettre notre petite conf 

```bash
max@debian:~$ mkdir firstbox
max@debian:~$ cd firstbox/
max@debian:~/firstbox$ vagrant init myfirstbox
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
max@debian:~/firstbox$ ls
Vagrantfile
max@debian:~/firstbox$ cat Vagrantfile
[...]
```

et voila rien de compliquer on a juste a suivre ce que dit la doc/le grand méo

🌞 **Modifier le `Vagrantfile`**

bon mtn on va custommm l'Vagrantfile et crée notre premiere box

```bash
max@debian:~/firstbox$ nano Vagrantfile 
max@debian:~/firstbox$ cat Vagrantfile 
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.box_check_update = false 
  config.vm.synced_folder ".", "/vagrant", disabled: true
end
```

tada un Vagrantfile custom avec un box trouver sur le vagrant cloud on par sur un ubuntu

🌞 **Faire joujou avec une VM**

mtn on up la machine et on joue

```bash
max@debian:~/firstbox$ vagrant up
```
on attend et c'est up

```bash
max@debian:~/firstbox$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'generic/ubuntu2204' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
==> default: Loading metadata for box 'generic/ubuntu2204'
    default: URL: https://vagrantcloud.com/api/v2/vagrant/generic/ubuntu2204
==> default: Adding box 'generic/ubuntu2204' (v4.3.10) for provider: virtualbox (amd64)
    default: Downloading: https://vagrantcloud.com/generic/boxes/ubuntu2204/versions/4.3.10/providers/virtualbox/amd64/vagrant.box
    default: Calculating and comparing box checksum...
==> default: Successfully added box 'generic/ubuntu2204' (v4.3.10) for 'virtualbox (amd64)'!
==> default: Importing base box 'generic/ubuntu2204'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: firstbox_default_1705053655775_50086
==> default: Fixed port collision for 22 => 2222. Now on port 2200.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2200 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2200
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default: 
    default: Guest Additions Version: 6.1.38
    default: VirtualBox Version: 7.0
max@debian:~/firstbox$ vagrant status
Current machine states:

default                   running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.
max@debian:~/firstbox$ vagrant ssh
vagrant@ubuntu2204:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=63 time=14.3 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=63 time=14.2 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=63 time=14.6 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=63 time=13.9 ms
64 bytes from 8.8.8.8: icmp_seq=5 ttl=63 time=14.2 ms
^C
--- 8.8.8.8 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4036ms
rtt min/avg/max/mdev = 13.890/14.217/14.582/0.222 ms
vagrant@ubuntu2204:~$ ls -l
total 0
vagrant@ubuntu2204:~$ cd /
vagrant@ubuntu2204:/$ ls -l
total 2097220
lrwxrwxrwx   1 root root          7 Aug 10 00:17 bin -> usr/bin
drwxr-xr-x   4 root root       4096 Dec 25 21:35 boot
drwxr-xr-x  19 root root       3980 Jan 12 10:01 dev
drwxr-xr-x 102 root root       4096 Jan 12 10:01 etc
drwxr-xr-x   3 root root       4096 Dec 25 21:26 home
lrwxrwxrwx   1 root root          7 Aug 10 00:17 lib -> usr/lib
lrwxrwxrwx   1 root root          9 Aug 10 00:17 lib32 -> usr/lib32
lrwxrwxrwx   1 root root          9 Aug 10 00:17 lib64 -> usr/lib64
lrwxrwxrwx   1 root root         10 Aug 10 00:17 libx32 -> usr/libx32
drwx------   2 root root      16384 Dec 25 21:14 lost+found
drwxr-xr-x   2 root root       4096 Aug 10 00:17 media
drwxr-xr-x   2 root root       4096 Aug 10 00:17 mnt
drwxr-xr-x   2 root root       4096 Aug 10 00:17 opt
dr-xr-xr-x 162 root root          0 Jan 12 10:01 proc
drwx------   5 root root       4096 Dec 25 21:34 root
drwxr-xr-x  28 root root        860 Jan 12 10:03 run
lrwxrwxrwx   1 root root          8 Aug 10 00:17 sbin -> usr/sbin
drwxr-xr-x   6 root root       4096 Aug 10 00:22 snap
drwxr-xr-x   2 root root       4096 Aug 10 00:17 srv
-rw-------   1 root root 2147483648 Dec 25 21:17 swap.img
dr-xr-xr-x  13 root root          0 Jan 12 10:01 sys
drwxrwxrwt  12 root root       4096 Jan 12 10:06 tmp
drwxr-xr-x  14 root root       4096 Aug 10 00:17 usr
drwxr-xr-x  13 root root       4096 Aug 10 00:20 var
vagrant@ubuntu2204:/$ logout
max@debian:~/firstbox$ vagrant halt
==> default: Attempting graceful shutdown of VM...
max@debian:~/firstbox$ vagrant destroy -f
==> default: Destroying VM and associated drives...
```

bon en gros c'est up on ce connect en ssh on test un petit ping un vm quoi on deco on eteint et on destroy easy !

🌞 **Repackager la box que vous avez choisie**

bon on verifie que toutest bien install vim dig etc... puis on crée la box

```bash
max@debian:~/firstbox$ vagrant package --output super_box.box
max@debian:~/firstbox$ ls -l
total 2933836
-rw-r--r-- 1 max max        174 Jan 12 10:57 Vagrantfile
-rw-r--r-- 1 max max 3004238027 Jan 14 16:07 super_box.box

max@debian:~/firstbox$ vagrant box list
generic/ubuntu2204 (virtualbox, 4.3.10, (amd64))
hashicorp/bionic64 (virtualbox, 1.0.282)
super_box          (virtualbox, 0)
```

une fois la box créé on a fait le petit ls et un list pour check que le fichier et la box sont bien la and **they are here**

![](/TP-s-linux/TP-admin/TP-3/img/ok.gif)

yup yup

du coup on modifie le Vagrantfile et on vagrant destroy tout pour etre sur que ça lance bieng a partir de la box

et tada

```bash
max@debian:~/firstbox$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'super_box'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: firstbox_default_1705253762358_57236
==> default: Fixed port collision for 22 => 2222. Now on port 2200.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2200 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2200
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default: 
    default: Guest Additions Version: 6.1.38
    default: VirtualBox Version: 7.0
==> default: Mounting shared folders...
    default: /vagrant => /home/max/firstbox
max@debian:~/firstbox$ vagrant status
Current machine states:

default                   running (virtualbox)
```

c'est beau et on oublie pas le Vagrantfile

```bash
max@debian:~/firstbox$ cat Vagrantfile 
Vagrant.configure("2") do |config|
  config.vm.box = "super_box"
end
```

il est super simple le petit Vagrantfile 

now on va adapter le Vagrantfile pour qu'il lance 3 vms avec un boucle for 

[click here to see the Vagrantfile](https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUJcmljayByb2xs)



[or click here to see the Vagrantfile](/TP-s-linux/TP-admin/TP-3/Vagrantfile-3A)


![eheh](/TP-s-linux/TP-admin/TP-3/img/ehe.gif)

now on va l'adapter pour utilise une liste en début de fichier avec les données des vms avec le for sur cette liste

bon et bien tout fonctionne on a bien bob alice et eve qui celance exactement avec ce qu'on leur demande

[tu peuc clicker ici pour voir le Vagrantfile](/TP-s-linux/TP-admin/TP-3/Vagrantfile-3B)

et voila c'est tout pour ce tp ma foi 

