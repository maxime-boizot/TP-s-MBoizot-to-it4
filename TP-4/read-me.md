# TP4 : TCP, UDP et services réseau

## I. First steps

on va determiner le type de paquets en fonction de l'application qui tourne actuellement.

on va pouvoir voir ces paquets on va utiliser la commande 

```
lsof -nP  -i 4
```
qui est une commande spécifique a Mac OS

je suis actuellement entrain de telecharger un jeux sur steam 

```
steam_osx 35210 maximeboizot   56u  IPv4 0xc2b8de3a2d332df5      0t0  TCP 192.168.1.93:59334->92.122.50.36:80 (ESTABLISHED)
```

on obtient grâce a cette ligne on obtien 

l'ip: 92.122.50.36

le port: 35210

et le stype de paquet recu son des paquet utiliser par steam son des paquets TCP

ensuite j'ai lancer deezer une application de streaming musical et utilise des paquets de type TCP 
```
Deezer    34876 maximeboizot   24u  IPv4 0xc2b8de3a2d33235d      0t0  TCP 192.168.1.93:59306->78.40.123.97:443
```
ip: 78.40.123.97:443

port: 34876

j'ai aussi lancer le logiciel qui me permet de regler mon clavier externe et ma souris logitech il le type de paquet est UDP

```
logioptio 25147 maximeboizot   23u  IPv4 0xc2b8de3ef5df828d      0t0  UDP *:59870
```

le port est 25147 mais il n'y a pas d'ip comme sur les ligne de commande

et en dernier discord 

```
Discord   35627 maximeboizot   23u  IPv4 0xc2b8de3ef5dfbfcd      0t0  UDP 192.168.1.93:49406->162.159.136.232:443
```

ip: 162.159.136.232:443

port: 35627

et le type de paquet est de l'UDP

