# TP3 SECU : SVP soyez cools

bon spoiler on a été cool maiiis on est passer pour des mec chelou en viteuf

## on va voir si on peut ce brancher a des trucs 

bon déja on a répertorier et cartographier en speed l'infra du bat et ça donne ça

![carte](/TP-3/img/carte-du-bat.jpeg)

Pour débrief très rapidement le plan, on as les emplassement des caméra de sécuriter qui ne sont evidemment pas sur le même réseau que nous, les tv / screen,
les salles des server présente au 1er et second étage, les machines a café (on verra après pk on les a mis)
et on a rajouter les grosse borne wifi 

donc celle la 

![](/TP-3/img/big_access.jpeg)

on va les retrouver généralement dans les salle de cours et dans les grand espace genre que le souk

et il y a aussi les petites borne qu'on retrouve dans les couloir 

donc celle-ci

![](/TP-3/img/little_access.jpeg)

![](/TP-3/img/fabulous.gif)

on a essayer les prise RJ45 jusqu'a ce qu'on trouve ça

pour decrire ceci c'est un switch derierre les machines a café sur lequelle il reste pile une prise RJ45 sur laquelle nous connecter

on l'as fait et on pensais clairement pas trouver ça

<!--resultat scan filaire switch machine a café-->
```
PS C: \Users \Miste> nmap -sn 192.168.1.1/24
Starting Nmap 7.94 (https://nmap.org ) at 2023-10-26 12:22 Paris, Madrid (heure daútú)

scan report for RUT241.1an (192.168.1.1)
Host is up (0.0015s latency).

MAC Address: 90:1E:42:63:CC:D3 (Teltonika)
Nmap scan report for 192.168.1.142
Host is up (0.0010s latency).

MAC Address: 10:1E:DA:4B: BD:0C (Ingenico Terminals SAS)
scan report for 192.168.1.183
Host is up (0.0030s latency).

MAC Address: 10:1E:DA:4B:BD:CB (Ingenico Terminals SAS)
Nmap scan report for 192.168.1.188
Host is up (0.0010s latency).

MAC Address: 10:1E:DA:4B:BB:9C (Ingenico Terminals SAS)
Nmap scan report for 192.168.1.192
Host is up (6.0040s latency).

MAC Address: 00:08:DC:41:63:38 (Wiznet)
Nmap scan report for 192.168.1.218
Host is up (0.0070s latency).

MAC Address: 00:08:DC:3C:09:43 (Wiznet)
map scan report for 192.168.1.234
Host is up (0.0033s latency).

MAC Address: 00:08:DC:41:63:62 (Wiznet)
Nmap scan report for DESKTOP-ODDOLFJ.lan
(192.168.1.223)
```




```
# Nmap 7.93 scan initiated Thu Nov  9 14:40:18 2023 as: nmap -A -p 22,80,443,21,25565,139,445 -v -oN Scan.txt 10.33.64.0/20

Nmap scan report for 10.33.64.29
Host is up (0.025s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.64.61
Host is up (0.015s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.64.67
Host is up (0.0074s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Microsoft IIS httpd 10.0
|_http-title: IIS Windows
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-server-header: Microsoft-IIS/10.0
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Nmap scan report for 10.33.64.69
Host is up (0.0098s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Microsoft IIS httpd 10.0
|_http-title: Site doesn't have a title.
|_http-server-header: Microsoft-IIS/10.0
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Nmap scan report for 10.33.64.80
Host is up (0.18s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.64.103
Host is up (0.0084s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.64.121
Host is up (0.48s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.64.126
Host is up (0.040s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.31
Host is up (0.32s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.48
Host is up (0.098s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.79
Host is up (0.012s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.94
Host is up (0.011s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.95
Host is up (0.027s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.96
Host is up (0.014s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.99
Host is up (0.044s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.100
Host is up (0.070s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.101
Host is up (0.041s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    open   http         Apache httpd 2.4.54 ((Unix) OpenSSL/1.0.2u PHP/8.2.0 mod_wsgi/3.5 Python/2.7.18 mod_fastcgi/mod_fastcgi-SNAP-0910052141 mod_perl/2.0.11 Perl/v5.30.1)
|_http-server-header: Apache/2.4.54 (Unix) OpenSSL/1.0.2u PHP/8.2.0 mod_wsgi/3.5 Python/2.7.18 mod_fastcgi/mod_fastcgi-SNAP-0910052141 mod_perl/2.0.11 Perl/v5.30.1
|_http-title: MAMP
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-favicon: Unknown favicon MD5: 22F07115F8763C615E2712737582579C
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.102
Host is up (0.013s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    open   http         Apache httpd 2.4.56 ((Unix))
| http-methods: 
|_  Supported Methods: POST OPTIONS HEAD GET
|_http-title: Site doesn't have a title (text/html).
|_http-server-header: Apache/2.4.56 (Unix)
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.104
Host is up (0.0091s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Apache httpd 2.4.54 ((Win64) OpenSSL/1.1.1q PHP/8.1.10)
|_http-server-header: Apache/2.4.54 (Win64) OpenSSL/1.1.1q PHP/8.1.10
|_http-title: Laragon
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
139/tcp   filtered netbios-ssn
443/tcp   open     http         Apache httpd 2.4.54 ((Win64) OpenSSL/1.1.1q PHP/8.1.10)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.54 (Win64) OpenSSL/1.1.1q PHP/8.1.10
|_http-title: Laragon
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.65.109
Host is up (0.024s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    closed   ssh
80/tcp    open     http         Apache httpd 2.4.46 ((Fedora))
|_http-server-header: Apache/2.4.46 (Fedora)
| http-methods: 
|   Supported Methods: OPTIONS HEAD GET POST TRACE
|_  Potentially risky methods: TRACE
|_http-title: Test Page for the HTTP Server on Fedora
139/tcp   filtered netbios-ssn
443/tcp   closed   https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.65.110
Host is up (0.0096s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.111
Host is up (0.025s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    open   http         Apache httpd 2.4.57 ((Ubuntu))
|_http-server-header: Apache/2.4.57 (Ubuntu)
| http-methods: 
|_  Supported Methods: HEAD GET POST OPTIONS
|_http-title: Apache2 Ubuntu Default Page: It works
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.113
Host is up (0.013s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Microsoft IIS httpd 10.0
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-title: IIS Windows
|_http-server-header: Microsoft-IIS/10.0
139/tcp   open     netbios-ssn  Microsoft Windows netbios-ssn
443/tcp   filtered https
445/tcp   open     microsoft-ds Windows 10 Home 22631 microsoft-ds (workgroup: WORKGROUP)
| fingerprint-strings: 
|   SMBProgNeg: 
|_    SMBr
25565/tcp filtered minecraft
Service Info: Host: DESKTOP-GDRECVA; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| nbstat: NetBIOS name: DESKTOP-GDRECVA, NetBIOS user: <unknown>, NetBIOS MAC: 087190a249d7 (Intel Corporate)
| Names:
|   DESKTOP-GDRECVA<00>  Flags: <unique><active>
|   WORKGROUP<00>        Flags: <group><active>
|   DESKTOP-GDRECVA<20>  Flags: <unique><active>
|_  WORKGROUP<1e>        Flags: <group><active>
| smb2-time: 
|   date: 2023-11-09T13:45:49
|_  start_date: N/A
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   311: 
|_    Message signing enabled but not required
| smb-os-discovery: 
|   OS: Windows 10 Home 22631 (Windows 10 Home 6.3)
|   OS CPE: cpe:/o:microsoft:windows_10::-
|   Computer name: DESKTOP-GDRECVA
|   NetBIOS computer name: DESKTOP-GDRECVA\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2023-11-09T14:45:51+01:00
|_clock-skew: mean: -19m55s, deviation: 34m29s, median: 0s

Nmap scan report for 10.33.65.114
Host is up (0.012s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.118
Host is up (0.13s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.119
Host is up (0.10s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   closed   https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.65.120
Host is up (0.018s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.126
Host is up (0.12s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.128
Host is up (0.079s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.133
Host is up (0.0074s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    closed   ftp
22/tcp    closed   ssh
80/tcp    closed   http
139/tcp   filtered netbios-ssn
443/tcp   closed   https
445/tcp   filtered microsoft-ds
25565/tcp closed   minecraft

Nmap scan report for 10.33.65.134
Host is up (0.0074s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    open   http         nginx 1.18.0 (Ubuntu)
|_http-title: 502 Bad Gateway
|_http-server-header: nginx/1.18.0 (Ubuntu)
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.65.137
Host is up (0.10s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.138
Host is up (0.040s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.142
Host is up (0.015s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.144
Host is up (0.013s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.145
Host is up (0.0097s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.146
Host is up (0.059s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.148
Host is up (0.023s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.65.170
Host is up (0.017s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.171
Host is up (0.033s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.172
Host is up (0.039s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.173
Host is up (0.051s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.174
Host is up (0.0084s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.179
Host is up (0.052s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.180
Host is up (0.15s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.181
Host is up (0.072s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.184
Host is up (0.050s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.187
Host is up (0.056s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.194
Host is up (0.095s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   closed   microsoft-ds
25565/tcp closed   minecraft

Nmap scan report for 10.33.65.197
Host is up (0.19s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.201
Host is up (0.013s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.203
Host is up (0.018s latency).

PORT      STATE    SERVICE       VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http          Apache httpd 2.4.54 ((Win64) OpenSSL/1.1.1q PHP/8.1.10)
|_http-server-header: Apache/2.4.54 (Win64) OpenSSL/1.1.1q PHP/8.1.10
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-title: Laragon
139/tcp   open     netbios-ssn   Microsoft Windows netbios-ssn
443/tcp   open     http          Apache httpd 2.4.54 ((Win64) OpenSSL/1.1.1q PHP/8.1.10)
|_http-title: Laragon
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.54 (Win64) OpenSSL/1.1.1q PHP/8.1.10
445/tcp   open     microsoft-ds?
| fingerprint-strings: 
|   FourOhFourRequest: 
|     HTTP/1.1 403 Blocked by Bitdefender
|     Content-Type: text/html
|     Pragma: no-cache
|     Cache-Control: no-store, no-cache, must-revalidate, max-age=0
|     Expires: Tue, 01 Jan 1971 02:00:00 GMT
|_    Content-Length: 0
25565/tcp filtered minecraft
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port445-TCP:V=7.93%I=7%D=11/9%Time=654CE269%P=x86_64-pc-linux-gnu%r(Fou
SF:rOhFourRequest,CC,"HTTP/1\.1\x20403\x20Blocked\x20by\x20Bitdefender\r\n
SF:Content-Type:\x20text/html\r\nPragma:\x20no-cache\r\nCache-Control:\x20
SF:no-store,\x20no-cache,\x20must-revalidate,\x20max-age=0\r\nExpires:\x20
SF:Tue,\x2001\x20Jan\x201971\x2002:00:00\x20GMT\r\nContent-Length:\x200\r\
SF:n\r\n");
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2023-11-09T13:45:55
|_  start_date: N/A
| smb2-security-mode: 
|   311: 
|_    Message signing enabled but not required
|_clock-skew: 1s

Nmap scan report for 10.33.65.210
Host is up (0.11s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.212
Host is up (0.042s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.213
Host is up (0.0070s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.216
Host is up (0.068s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.218
Host is up (0.051s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.220
Host is up (0.074s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.222
Host is up (0.044s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.228
Host is up (0.086s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.237
Host is up (0.083s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.239
Host is up (0.0087s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Microsoft IIS httpd 10.0
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-title: Site doesn't have a title.
|_http-server-header: Microsoft-IIS/10.0
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Nmap scan report for 10.33.65.246
Host is up (0.11s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.247
Host is up (0.072s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.252
Host is up (0.084s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   closed   netbios-ssn
443/tcp   filtered https
445/tcp   closed   microsoft-ds
25565/tcp closed   minecraft

Nmap scan report for 10.33.65.253
Host is up (0.23s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.65.254
Host is up (0.011s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.4
Host is up (0.12s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.66.29
Host is up (0.11s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.33
Host is up (0.018s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 819ffa4624a2f8dfdc3f9b863a4557ac (ECDSA)
|_  256 0d86c6628f0a8d8403277197e445595e (ED25519)
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.66.54
Host is up (0.13s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.58
Host is up (0.011s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.64
Host is up (0.033s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.71
Host is up (0.60s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.79
Host is up (0.035s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.89
Host is up (0.040s latency).

PORT      STATE  SERVICE       VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   open   microsoft-ds?
25565/tcp closed minecraft

Host script results:
|_clock-skew: -1m24s
| smb2-security-mode: 
|   302: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2023-11-09T13:44:29
|_  start_date: N/A
| nbstat: NetBIOS name: MACBOOKPRO-7F27, NetBIOS user: <unknown>, NetBIOS MAC: 147dda227f27 (Apple)
| Names:
|   MACBOOKPRO-7F27<00>  Flags: <unique><active>
|   MACBOOKPRO-7F27<20>  Flags: <unique><active>
|_  WORKGROUP<00>        Flags: <group><active>

Nmap scan report for 10.33.66.94
Host is up (0.053s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.98
Host is up (0.038s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.106
Host is up (0.019s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.66.109
Host is up (0.027s latency).

PORT      STATE  SERVICE       VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   open   microsoft-ds?
25565/tcp closed minecraft

Host script results:
| nbstat: NetBIOS name: MACBOOK-BENDO, NetBIOS user: <unknown>, NetBIOS MAC: 5ce91ebe0a2c (Apple)
| Names:
|   MACBOOK-BENDO<00>    Flags: <unique><active>
|   MACBOOK-BENDO<20>    Flags: <unique><active>
|_  WORKGROUP<00>        Flags: <group><active>
| smb2-security-mode: 
|   302: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2023-11-09T13:44:29
|_  start_date: N/A
|_clock-skew: -1m25s

Nmap scan report for 10.33.66.114
Host is up (0.014s latency).

PORT      STATE  SERVICE       VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   open   netbios-ssn   Microsoft Windows netbios-ssn
443/tcp   closed https
445/tcp   open   microsoft-ds?
25565/tcp closed minecraft
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2023-11-09T13:45:56
|_  start_date: N/A
| smb2-security-mode: 
|   311: 
|_    Message signing enabled but not required
|_clock-skew: 1s
| nbstat: NetBIOS name: AYMERIC, NetBIOS user: <unknown>, NetBIOS MAC: 58065de0ca2f (unknown)
| Names:
|   AYMERIC<00>          Flags: <unique><active>
|   WORKGROUP<00>        Flags: <group><active>
|_  AYMERIC<20>          Flags: <unique><active>

Nmap scan report for 10.33.66.115
Host is up (0.23s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.116
Host is up (0.25s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.133
Host is up (0.035s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.157
Host is up (0.041s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.160
Host is up (0.16s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.66.166
Host is up (0.32s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.168
Host is up (0.087s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.66.200
Host is up (0.0071s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Microsoft IIS httpd 10.0
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-title: IIS Windows
|_http-server-header: Microsoft-IIS/10.0
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Nmap scan report for 10.33.66.203
Host is up (0.051s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 9.0p1 Ubuntu 1ubuntu8.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 6513c5684e63cbc98173505874cd7fcb (ECDSA)
|_  256 a92e576a164cfe46fcd3f958f88da877 (ED25519)
80/tcp    open   http         Apache httpd 2.4.55 ((Ubuntu))
|_http-title: Apache2 Ubuntu Default Page: It works
|_http-server-header: Apache/2.4.55 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.66.206
Host is up (0.023s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.66.208
Host is up (0.12s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.66.248
Host is up (0.0100s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    open   http         nginx 1.18.0 (Ubuntu)
|_http-server-header: nginx/1.18.0 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET HEAD
|_http-title: Welcome to nginx!
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.67.3
Host is up (0.060s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 9.0 (protocol 2.0)
| ssh-hostkey: 
|   256 37f975437819a7ff1239a36465804d67 (ECDSA)
|_  256 3d301c6d7b59034b05b6d3d0912602a5 (ED25519)
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.17
Host is up (0.051s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 f60a349176644edb48ff5b79445f4feb (ECDSA)
|_  256 6b30c60490759f72bf4f5ea260dbab6e (ED25519)
80/tcp    open   http         Apache httpd 2.4.52 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-server-header: Apache/2.4.52 (Ubuntu)
|_http-title: Apache2 Ubuntu Default Page: It works
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.67.22
Host is up (0.064s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 743b37c65c9b788d91d85c49c6ca6fc2 (ECDSA)
|_  256 35f279740a2cb7d5406e74361d2867f8 (ED25519)
80/tcp    open   http         Apache httpd 2.4.52 ((Ubuntu))
| http-methods: 
|_  Supported Methods: OPTIONS HEAD GET POST
|_http-title: Apache2 Ubuntu Default Page: It works
|_http-server-header: Apache/2.4.52 (Ubuntu)
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.67.23
Host is up (0.053s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.40
Host is up (0.081s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp closed   minecraft

Nmap scan report for 10.33.67.44
Host is up (0.023s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    open   http         nginx
|_http-title: Did not follow redirect to https://dev.local/
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
139/tcp   closed netbios-ssn
443/tcp   open   ssl/http     nginx
|_http-title: Laravel
|_http-favicon: Unknown favicon MD5: D41D8CD98F00B204E9800998ECF8427E
| ssl-cert: Subject: commonName=*.local/CN=local/organizationName=Encelis/stateOrProvinceName=FR/countryName=FR
| Subject Alternative Name: DNS:*.local, DNS:local
| Issuer: commonName=*.local/CN=local/organizationName=Encelis/stateOrProvinceName=Paris/countryName=FR
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2019-07-17T08:34:18
| Not valid after:  2029-07-14T08:34:18
| MD5:   211a47b22f66286dbf8ab306738daafe
|_SHA-1: b64a4b7b039040594821b0f04852bf0e4368c59d
| http-methods: 
|_  Supported Methods: GET HEAD
| tls-alpn: 
|_  http/1.1
|_ssl-date: TLS randomness does not represent time
| tls-nextprotoneg: 
|_  http/1.1
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.67
Host is up (0.026s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.81
Host is up (0.072s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.90
Host is up (0.037s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.127
Host is up (0.16s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.131
Host is up (0.060s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.133
Host is up (0.0096s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    open     http         Node.js Express framework
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-title: Skull King
|_http-favicon: Unknown favicon MD5: C92B85A5B907C70211F4EC25E29A8C4A
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.67.138
Host is up (0.0069s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 8.2p1 Ubuntu 4ubuntu0.9 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 9382b8013586a3168ebd2cfb547303f9 (RSA)
|   256 0e525bb90dcb640f9d380df8fab881e5 (ECDSA)
|_  256 98045dc1b93e6ea94102b8a078fed4cc (ED25519)
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.67.144
Host is up (0.0073s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.146
Host is up (0.081s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.150
Host is up (0.081s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.67.166
Host is up (0.015s latency).

PORT      STATE  SERVICE       VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   open   netbios-ssn   Microsoft Windows netbios-ssn
443/tcp   closed https
445/tcp   open   microsoft-ds?
25565/tcp closed minecraft
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2023-11-09T13:45:55
|_  start_date: N/A
| nbstat: NetBIOS name: LAPTOP-VPED60LK, NetBIOS user: <unknown>, NetBIOS MAC: 586c257fa616 (Intel Corporate)
| Names:
|   LAPTOP-VPED60LK<20>  Flags: <unique><active>
|   LAPTOP-VPED60LK<00>  Flags: <unique><active>
|_  WORKGROUP<00>        Flags: <group><active>
| smb2-security-mode: 
|   311: 
|_    Message signing enabled but not required

Nmap scan report for 10.33.67.173
Host is up (0.046s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.179
Host is up (0.036s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.184
Host is up (0.060s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.192
Host is up (0.081s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.193
Host is up (0.050s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 899a37b0c29b79fb9886450bfc7dfab3 (ECDSA)
|_  256 f1ca8363d8b051e6630ac1524fc699ee (ED25519)
80/tcp    open   http         Apache httpd 2.4.52 ((Ubuntu))
|_http-server-header: Apache/2.4.52 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-title: Apache2 Ubuntu Default Page: It works
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.67.195
Host is up (0.011s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    closed   ftp
22/tcp    closed   ssh
80/tcp    closed   http
139/tcp   filtered netbios-ssn
443/tcp   closed   https
445/tcp   filtered microsoft-ds
25565/tcp closed   minecraft

Nmap scan report for 10.33.67.205
Host is up (0.043s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.67.212
Host is up (0.043s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.67.224
Host is up (0.038s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.6
Host is up (0.057s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.25
Host is up (0.048s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.75
Host is up (0.33s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.77
Host is up (0.049s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.79
Host is up (0.050s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.80
Host is up (0.048s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.101
Host is up (0.12s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.68.127
Host is up (0.10s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    open   ssh          OpenSSH 9.2p1 Debian 2+deb12u1 (protocol 2.0)
| ssh-hostkey: 
|   256 fee50193b27560521d9d2186e36db35a (ECDSA)
|_  256 e47e0c18001df2ef6fd17087764ab041 (ED25519)
80/tcp    open   http         Apache httpd 2.4.57 ((Debian))
|_http-title: Apache2 Debian Default Page: It works
|_http-server-header: Apache/2.4.57 (Debian)
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Nmap scan report for 10.33.68.154
Host is up (0.0075s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.68.159
Host is up (0.14s latency).

PORT      STATE    SERVICE      VERSION
21/tcp    filtered ftp
22/tcp    filtered ssh
80/tcp    filtered http
139/tcp   filtered netbios-ssn
443/tcp   filtered https
445/tcp   filtered microsoft-ds
25565/tcp filtered minecraft

Nmap scan report for 10.33.68.166
Host is up (0.017s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.174
Host is up (0.027s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.177
Host is up (0.0093s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.180
Host is up (0.042s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.182
Host is up (0.024s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.184
Host is up (0.044s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.186
Host is up (0.056s latency).

PORT      STATE  SERVICE      VERSION
21/tcp    closed ftp
22/tcp    closed ssh
80/tcp    closed http
139/tcp   closed netbios-ssn
443/tcp   closed https
445/tcp   closed microsoft-ds
25565/tcp closed minecraft

Nmap scan report for 10.33.68.187
Host is up (0.035s latency).

PORT      STATE  SERVICE       VERSION
21/tcp  ... (96 Ko restants)
```