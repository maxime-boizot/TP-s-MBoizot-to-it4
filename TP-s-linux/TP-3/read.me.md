# TP 3 : We do a little scripting

## sommaire:

- [0. Un premier script](#0-un-premier-script)
- [I. Script carte d'identité](#i-script-carte-didentité)
- [II. Script youtube-dl](#ii-script-youtube-dl)
- [III. MAKE IT A SERVICE](#iii-make-it-a-service)

## 0. Un premier script

aujourd'hui on va faire du scripting youhou ouai on va ce faire mal au dent oui

bon aller maintenant qu'on a créé notre petit premier script test on attaque 

## I. Script carte d'identité

bon aller on rentre dans le vif du sujet 

bon on créé un fichié en .sh avec le chemin suivant 

```
/srv/idcard/idcard.sh
```

bon après un bon moment a scripté tt ça voila le fichier avec le script 

[idcard.sh](resources/idcard.sh)

comme prévu ça pique les yeux 

![eyesonfire](picture/eyesonfire.gif)

et voila l'éxécution de ce script 

![execution](picture/execution.gif)

mais non je rigole c'est comme ça

```
[max@tp-4-it4 idcard]$ ./idcard.sh 
 
Machine name : tp-4-it4.
 
OS Rocky Linux release 9.1 (Blue Onyx) and kernel version is 5.14.0-162.6.1.el9_1.0.1.aarch64
 
IP :192.168.64.19
 
RAM : 2.3Gi memory available on 2.7Gi total memory
 
Disk : 758M space left
 
Top 5 processes by RAM usage :
  - /usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
  - /usr/lib/polkit-1/polkitd --no-debug
  - /usr/sbin/NetworkManager --no-daemon
  - /usr/lib/systemd/systemd --switched-root --system --deserialize 31
  - /usr/lib/systemd/systemd --user
 
Listening ports :
     - udp 323 : udp
     - tcp 22 : tcp
 
Here is your random cat : ./srv/idcard/cat.jpg

```

ouai ça fait moins mal au yeux effectivement

![that's good](picture/that'sgood.gif)

## II. Script youtube-dl

bon après encore trois migraine et deux crise d'épilepsie voila le code du yt download

[yt.sh](resources/yt.sh)

et [ici](resources/download.sh) le fichier download.log avec quelque telechargement dedans

et quand on execute le programme on obtien ce retour la 

```
[max@tp-4-it4 yt]$ ./yt.sh https://www.youtube.com/watch?v=pXaSFN9VYbw
Video https://www.youtube.com/watch?v=pXaSFN9VYbw was downloaded.
File path : /srv/yt/downloads/Women meme template/Women meme template.mp4
```

## III. MAKE IT A SERVICE

(a few moment later)

et voila un petit service qui fonction avec le scripte [yt-v2](resources/yt-v2.sh)

[et voila le fichier du service](resources/yt.service)

et en bonus un petit status du services en fonction avec le telechargement en log 

```
[max@tp-4-it4 /]$ systemctl status yt
● yt.service - un petit servie pas très légal mais c'est le prof qui veux qu'on le fabrique
     Loaded: loaded (/etc/systemd/system/yt.service; disabled; vendor preset: disabled)
     Active: active (running) since Tue 2023-01-10 01:00:35 CET; 15min ago
   Main PID: 4279 (yt-v2.sh)
      Tasks: 2 (limit: 7412)
     Memory: 2.9M
        CPU: 5.568s
     CGroup: /system.slice/yt.service
             ├─4279 /bin/bash /srv/yt/yt-v2.sh
             └─4632 sleep 5

Jan 10 01:00:35 tp-4-it4 systemd[1]: Started un petit servie pas très légal mais c'est le prof qui veux qu'on le f>
Jan 10 01:03:38 tp-4-it4 yt-v2.sh[4383]: Video https://www.youtube.com/watch?v=UZvP3WRDuOM was downloaded.
Jan 10 01:03:38 tp-4-it4 yt-v2.sh[4383]: File path : /srv/yt/downloads/Obligatory 10-second Cat video./Obligatory
```

```
et ici voila le journal ctl des status
```Jan 10 01:00:35 tp-4-it4 systemd[1]: Started un petit servie pas très légal mais c'est le prof qui veux qu'on le f>
░░ Subject: A start job for unit yt.service has finished successfully
░░ Defined-By: systemd
░░ Support: https://access.redhat.com/support
░░ 
░░ A start job for unit yt.service has finished successfully.
░░ 
░░ The job identifier is 6017.
Jan 10 01:03:38 tp-4-it4 yt-v2.sh[4383]: Video https://www.youtube.com/watch?v=UZvP3WRDuOM was downloaded.
Jan 10 01:03:38 tp-4-it4 yt-v2.sh[4383]: File path : /srv/yt/downloads/Obligatory 10-second Cat video./Obligatory
```

un tp bien prise de tête mais oklm ça passe 

![explosion](picture/explosion.gif)