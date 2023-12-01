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



🌞 **Connectez-vous au serveur**

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

