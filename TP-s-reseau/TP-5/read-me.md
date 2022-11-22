# Serveur VPN



## I. Setup machine distante

pour ce TP je vais utilisé une machine sous rocky linux qui est relier a ma box par cable ethernet

sur cette machine une fois configurer on peu éxécuter un 

```
ip a
```

pour obtenir son ip 

```
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 0c:9d:92:45:1a:3d brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.26/24 brd 192.168.0.255 scope global dynamic noprefixroute enp2s0
       valid_lft 41591sec preferred_lft 41591sec
    inet6 fde1:5f82:ece7:4077:e9d:92ff:fe45:1a3d/64 scope global deprecated dynamic noprefixroute 
       valid_lft 1367sec preferred_lft 0sec
    inet6 2a01:e0a:e6:1660:e9d:92ff:fe45:1a3d/64 scope global dynamic noprefixroute 
       valid_lft 86252sec preferred_lft 86252sec
    inet6 fe80::e9d:92ff:fe45:1a3d/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
``` 

on trouve donc l'ip de la machine a la ligne inet 

```
inet 192.168.0.26
```

### 1. Utilisateurs

durant la configuration de notre rocky on a donner les droit administrateur a notre utilisateur afin qu'il ai les droits root

### 2. Serveur SSH

#### A. Connexion par clé

sur le client donc mon MAC je genere ma clef de connection ssh avec la commande 

```
ssh-keygen -t rsa -b 4096
```

une fois notre clé généré on utilise la commande 
```
ssh-copy-id -i ~/.ssh/id_rsa.pub max@192.168.0.26
```

on obtient en retour la confirmation que la clef ssh a été reçu et je peut desormais me connecter en sseh a ma machine distance sans taper de mots de passe.

#### B. SSH Server Hardening

pour securiser tous cela on va éditer le fichier sshd_config avec la commande

```
sudo nano /etc/ssh/sshd_config
```

une fois cela fait on obtient cela en executant la commande 

```
sudo cat /etc/ssh/sshd_config
```

on obtient 

```
[max@localhost ~]$ sudo cat /etc/ssh/sshd_config
#	$OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

# If you want to change the port on a SELinux system, you have to tell
# SELinux about this change.
# semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
#
#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# This system is following system-wide crypto policy. The changes to
# crypto properties (Ciphers, MACs, ...) will not have any effect here.
# They will be overridden by command-line options passed to the server
# on command line.
# Please, check manual pages for update-crypto-policies(8) and sshd_config(5).

# Logging
#SyslogFacility AUTH
#SyslogFacility AUTHPRIV
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
#PermitRootLogin yes
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

#PubkeyAuthentication yes

# The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
# but this is overridden so installations will only check .ssh/authorized_keys
AuthorizedKeysFile	.ssh/authorized_keys

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
#PasswordAuthentication yes
#PermitEmptyPasswords no
#PasswordAuthentication yes

# Change to no to disable s/key passwords
#ChallengeResponseAuthentication yes
#ChallengeResponseAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no
#KerberosUseKuserok yes

# GSSAPI options
#GSSAPIAuthentication yes
#GSSAPICleanupCredentials no
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no
#GSSAPIEnablek5users no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
# WARNING: 'UsePAM no' is not supported in Fedora and may cause several
# problems.
#UsePAM yes

#AllowAgentForwarding yes
#AllowTcpForwarding yes
#GatewayPorts no
#X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost yes
#PermitTTY yes

# It is recommended to use pam_motd in /etc/pam.d/sshd instead of PrintMotd,
# as it is more configurable and versatile than the built-in version.
#PrintMotd no

#PrintLastLog yes
#TCPKeepAlive yes
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#UseDNS no
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# Accept locale-related environment variables
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS

# override default of no subsystems
Subsystem	sftp	/usr/libexec/openssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	PermitTTY no
#	ForceCommand cvs server


# Temporarily enabled to check IPs of possibly attackers
PasswordAuthentication yes
#

IgnoreRhosts yes
MaxAuthTries 3
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr,arcfour256
#MACs hmac-sha2-512-etm@openssh.com
KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
#KexAlgorithms=curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
RekeyLimit 256M
#ServerKeyBits 2048 # Deprecated
ClientAliveCountMax 2

PermitRootLogin no
UseDNS no
UsePrivilegeSeparation SANDBOX

Compression delayed
X11Forwarding no
AllowTcpForwarding no
GatewayPorts no
PermitTunnel no
TCPKeepAlive yes

#RSAAuthentication no # Deprecated
GSSAPIAuthentication no
KerberosAuthentication no
HostbasedAuthentication no
ChallengeResponseAuthentication no
```

## II. Serveur VPN

en suivant  l'excellent guide de Digital Ocean pour mettre en place Wireguard sur une machine Rocky 8.

on installe Wireguard sur le server avec les commandes fourni sur le guide 

```
sudo dnf install elrepo-release epel-release
&
sudo dnf install kmod-wireguard wireguard-tools
```

ensuite on va Créez la clé privée pour WireGuard et modifiez ses autorisations à l'aide des commandes suivantes 

```
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
```
en suite la commande que on execute possede trois partie chacun serparer par "|". La premiere affiche la clé priver, la deuxieme génère la clé publique, et la troisieme partie enregistre la clé publique dans un fichier 

```
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
```

on choisit ensuite une ip pour notre server pour ma part ce sera 192.168.1.125

on va maintenant créé notre configuration reseau en créant un fichier de configuration on va ici le créé avec "vi" mais on peut aussi le créé avec "nano"

on éxécute donc la commande suivante

```
sudo vi /etc/wireguard/wg0.conf
```

on rempli donc notre fichier de configuration de la manière suivante 

```
[Interface]
SaveConfig = true
ListenPort = 51820
PrivateKey = eMCw6aBT8Uakj+wVdxMBmaT60gTC7uq36LmQUFLF6Wk=
```

maintenant que l'ont a créé une configuration réseau on va la paramétré 

on éxécute cette commande de manière a configurer notre serveur pour que l'ont puissent acheminer du trafic internet par le server wireguard 

```
sudo vi /etc/sysctl.conf
```

on ajoute donc dans fichié cette ligne 

```
net.ipv4.ip_forward=1
```

et celle-ci si on utilise de l'ipv6 

```
net.ipv6.conf.all.forwarding=1
```

ce qui n'est pas notre cas 

pour lire le fichier afin de verifier que tout a bien été pris compte on peut éxécuter la commande 

```
sudo sysctl -p
```

ce qui nous return 

```
[max@localhost ~]$ sudo sysctl -p
[sudo] Mot de passe de max : 
net.ipv4.ip_forward = 1
```

maintenant on passe à la configuration du firewall 


nous avons jouter toute sorte de regles au firewall 

```
sudo firewall-cmd --zone=public --add-port=51820/udp --permanent
```

celle-ci donne l'acces au port 51820 de manière permanente au service Wireguard

```
sudo firewall-cmd --zone=internal --add-interface=wg0 --permanent
```

Ensuite celle-ci ajoute l'interface wg0 ce qui permettra au trafic d'atteindre d'autres interfaces sur le serveur wireguard et on joute cela encore et toujours de manière permanente 

```
sudo firewall-cmd --zone=public --add-rich-rule='rule family=ipv4 source address=10.8.0.0/24 masquerade' --permanent
```
celle-ci mets en place le masquage des adresse ip de la famille 192.160..

et ensuite on reload le firewall 

avec la commande 

```
sudo firewall-cmd --reload
```
on redemare la machine pour bien faire prendre en compte la modification 

et ensuite pour checker les regle du firewall on utilise la commande 

```
sudo firewall-cmd --zone=public --list-all
```
ce qui nous return 

```
[max@localhost ~]$ sudo firewall-cmd --zone=public --list-all
[sudo] Mot de passe de max : 
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp2s0
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 51820/udp 22/tcp
  protocols: 
  forward: no
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	rule family="ipv4" source address="192.168.0.0/24" masquerade
```
on va maintenande demarrer le server wireguard 

avec ces commande la 

```
sudo systemctl enable wg-quick@wg0.service
```

```
sudo systemctl start wg-quick@wg0.service
```

et on peut checker l'etat de wireguard avec cette commande

```
sudo systemctl status wg-quick@wg0.service
```

ce qui return ceci 

```
[max@localhost ~]$ sudo systemctl status wg-quick@wg0.service
[sudo] Mot de passe de max : 
● wg-quick@wg0.service - WireGuard via wg-quick(8) for wg0
   Loaded: loaded (/usr/lib/systemd/system/wg-quick@.service; enabled; vendor preset: disabled)
   Active: active (exited) since Sun 2022-11-13 16:24:30 CET; 32min ago
     Docs: man:wg-quick(8)
           man:wg(8)
           https://www.wireguard.com/
           https://www.wireguard.com/quickstart/
           https://git.zx2c4.com/wireguard-tools/about/src/man/wg-quick.8
           https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8
  Process: 1238 ExecStart=/usr/bin/wg-quick up wg0 (code=exited, status=0/SUCCESS)
 Main PID: 1238 (code=exited, status=0/SUCCESS)

nov. 13 16:24:30 localhost.localdomain systemd[1]: Starting WireGuard via wg-quick(8) for wg0...
nov. 13 16:24:30 localhost.localdomain wg-quick[1238]: [#] ip link add wg0 type wireguard
nov. 13 16:24:30 localhost.localdomain wg-quick[1238]: [#] wg setconf wg0 /dev/fd/63
nov. 13 16:24:30 localhost.localdomain wg-quick[1238]: [#] ip link set mtu 1420 up dev wg0
nov. 13 16:24:30 localhost.localdomain systemd[1]: Started WireGuard via wg-quick(8) for wg0.
```

ce qui nous confirme que tout fonctionne bien 

youhouuuuuuuuuu :)

on a presque finiiii 

on va généré les clé du pair wireguard 

avec la commande suivante 

```
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
```

```
sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
```

commande qui fonctionne exactement de la meme manière que tt a l'heure qui genere deux cle une publique et un privé sauf que celle la son pour le pair

on va maintenant créé le fichier de configuration d u pair wireguard 

avec vi

```
sudo vi /etc/wireguard/wg0.conf
```

que l'ont remplie de cette manière 

```
[Interface]
PrivateKey = base64_encoded_peer_private_key_goes_here
Address = 192.168.1.125

[Peer]
PublicKey = u8zDDkR2cjmKDxt7gIq7L8+VdPMngVhWnKchiirVP1U=
AllowedIPs = 192.168.0.0
Endpoint = 203.0.113.1:51820
```

on touche presque au buuuut 

on va maintenant ajouté la clé publique du pair au serveur wireguard

on recupere la clé publique du pair avec cette commande 

```
sudo cat /etc/wireguard/public.key
```

pour ensuite executer la commande suivante 

```
sudo wg set wg0 peer nkIetSa0WXaeog9dPQRRyQ9ahvQ8WiO6HZo279s04S8= allowed-ips 192.168.1.125
```

cela fait on peu checker l'état de tt ce petit monde avec la commande 

```
sudo wg
```

ce qui nous return 

```
[max@localhost ~]$ sudo wg
interface: wg0
  public key: u8zDDkR2cjmKDxt7gIq7L8+VdPMngVhWnKchiirVP1U=
  private key: (hidden)
  listening port: 51820
```

