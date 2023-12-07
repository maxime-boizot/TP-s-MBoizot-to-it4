# TP5 : Exploit, pwn, fix

## Sommaire

- [TP5 : Exploit, pwn, fix](#tp5--exploit-pwn-fix)
  - [Sommaire](#sommaire)
  - [1. Reconnaissance](#1-reconnaissance)
  - [2. Exploit](#2-exploit)
  - [3. Reverse shell](#3-reverse-shell)
  - [4. Bonus : DOS](#4-bonus--dos)
  - [II. Remédiation](#ii-remédiation)

## 1. Reconnaissance

🌞 **Déterminer**

bon pour determiner tous ça archi simple on wireshark

ce qui permet de determiner en lancant le programme plusieur fois etc... 

```bash
ip: 13.33.70.40
port: 13337
```

🌞 **Scanner le réseau**

```bash
sudo nmap -n 13.33.70.40 -p 50000 --open
```

resultat du petit scan nmap 

```bash
Starting Nmap 7.94 ( https://nmap.org ) at 2023-12-01 11:34 CET
Nmap scan report for 10.33.70.40
Host is up (0.15s latency).

PORT      STATE SERVICE
50000/tcp open  ibm-db2
50001/tcp open  unknown
50002/tcp open  iiimsf
50003/tcp open  unknown
50004/tcp open  unknown
50005/tcp open  unknown
MAC Address: E4:B3:18:48:36:68 (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.33 seconds
```

🦈 **tp5_nmap.pcapng**

[🦈](/TP-s-reseau/TP-5/capture_nmap.pcapng)

🌞 **Connectez-vous au serveur**


```python
import socket
import sys
import re
import logging
# On définit la destination de la connexion
host = '10.33.70.40'  # IP du serveur
port = 50005          # Port choisir par le serveur
```

on a editer cette partie du code simple et rapide

et ça nous permet de decouvrir qu'il s'agit d'une 

```bash
sudo python3 client.py
Veuillez saisir une opération arithmétique : 2+2


cat bs_client.log 
2023-11-30 11:26:04 INFO Connexion réussie à 10.33.70.40:13337
2023-11-30 11:26:08 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-11-30 11:26:08 INFO Réponse reçue du serveur 10.33.70.40 : b'4'
2023-11-30 11:31:36 INFO Connexion réussie à 10.33.70.40:13337
2023-11-30 11:31:41 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-11-30 11:31:41 INFO Réponse reçue du serveur 10.33.70.40 : b'4'
2023-11-30 11:37:23 INFO Connexion réussie à 10.33.70.40:13337
2023-11-30 11:37:34 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-11-30 11:45:47 INFO Réponse reçue du serveur 10.33.70.40 : b''
2023-12-01 11:30:52 ERROR Impossible de se connecter au serveur 10.33.70.40 sur le port 5005
2023-12-01 11:31:41 INFO Connexion réussie à 10.33.70.40:50005
2023-12-01 11:31:46 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-12-01 11:46:02 INFO Connexion réussie à 10.33.70.40:50005
2023-12-01 11:46:06 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-12-01 11:46:54 INFO Connexion réussie à 10.33.70.40:50003
2023-12-01 11:46:58 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-12-01 11:46:58 INFO Réponse reçue du serveur 10.33.70.40 : b'4'
2023-12-01 11:47:00 INFO Connexion réussie à 10.33.70.40:50003
2023-12-01 11:47:03 INFO Message envoyé au serveur 10.33.70.40 : 2+2
2023-12-01 11:47:03 INFO Réponse reçue du serveur 10.33.70.40 : b'4'
```

## 2. Exploit

🌞 **Injecter du code serveur**

## 3. Reverse shell

🌞 **Obtenez un reverse shell sur le serveur**

🌞 **Pwn**

## 4. Bonus : DOS

⭐ **BONUS : DOS l'application**

## II. Remédiation

🌞 **Proposer une remédiation dév**

🌞 **Proposer une remédiation système**

