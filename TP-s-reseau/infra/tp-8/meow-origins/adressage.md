
# 1. Tableau d'adressage IP

| Machine & Réseau      | 10.1.10.0/23      | 10.1.20.0/28      | 10.1.30.0/30      | 10.1.40.0/29      | 10.1.50.0/28      | 10.1.60.0/26      | 10.1.70.0/26      | 10.1.80.0/28      | 10.1.90.0/23      |
|-----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| Routeur 1             | 10.1.10.1         | 10.1.20.1         | 10.1.30.1         | 10.1.40.1         | 10.1.50.1         | 10.1.60.1         | 10.1.70.1         | 10.1.80.1         | 10.1.90.1         |
| Lead Dev 1            | 10.1.10.2         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 2            | 10.1.10.3         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 3            | 10.1.10.4         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 4            | 10.1.10.5         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 5            | 10.1.10.6         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 6            | 10.1.10.7         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 7            | 10.1.10.8         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 1                 | 10.1.10.9         | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 2                 | 10.1.10.10        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 3                 | 10.1.10.11        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 4                 | 10.1.10.12        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 5                 | 10.1.10.13        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| ...                   | ...               | ...               | ...               | ...               | ...               | ...               | ...               | ...               | ...               |
| Dev 132               | 10.1.11.140       | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Admin Réseau          | X                 | 10.1.20.2         | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Admin Sys             | X                 | 10.1.20.3         | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| Responsable Sécurité  | X                 | 10.1.20.4         | X                 | X                 | X                 | X                 | X                 | X                 | X                 |
| PDG                   | X                 | X                 | 10.1.30.2         | X                 | X                 | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 1    | X                 | X                 | X                 | 10.1.40.2         | X                 | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 2    | X                 | X                 | X                 | 10.1.40.3         | X                 | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 3    | X                 | X                 | X                 | 10.1.40.4         | X                 | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 4    | X                 | X                 | X                 | 10.1.40.5         | X                 | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 5    | X                 | X                 | X                 | 10.1.40.6         | X                 | X                 | X                 | X                 | X                 |
| Agent RH 1            | X                 | X                 | X                 | X                 | 10.1.50.2         | X                 | X                 | X                 | X                 |
| Agent RH 2            | X                 | X                 | X                 | X                 | 10.1.50.3         | X                 | X                 | X                 | X                 |
| Caméra 1 (Étage 1)    | X                 | X                 | X                 | X                 | X                 | 10.1.60.2         | X                 | X                 | X                 |
| Caméra 2 (Étage 1)    | X                 | X                 | X                 | X                 | X                 | 10.1.60.3         | X                 | X                 | X                 |
| Caméra 3 (Étage 2)    | X                 | X                 | X                 | X                 | X                 | 10.1.60.4         | X                 | X                 | X                 |
| Caméra 4 (Étage 2)    | X                 | X                 | X                 | X                 | X                 | 10.1.60.5         | X                 | X                 | X                 |
| Caméra 5 (Étage 3)    | X                 | X                 | X                 | X                 | X                 | 10.1.60.6         | X                 | X                 | X                 |
| Caméra 6 (Étage 3)    | X                 | X                 | X                 | X                 | X                 | 10.1.60.7         | X                 | X                 | X                 |
| Caméra 7 (Entrée)     | X                 | X                 | X                 | X                 | X                 | 10.1.60.8         | X                 | X                 | X                 |
| Caméra 8 (Entrée)     | X                 | X                 | X                 | X                 | X                 | 10.1.60.9         | X                 | X                 | X                 |
| Télé 1 (Accueil)      | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.70.2         | X                 | X                 |
| Télé 2 (Accueil)      | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.70.3         | X                 | X                 |
| Télé 3 (Étage 1)      | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.70.4         | X                 | X                 |
| Télé 4 (Étage 2)      | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.70.5         | X                 | X                 |
| Télé 5 (Étage 3)      | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.70.6         | X                 | X                 |
| Imprimante (Rez-de-chaussée) | X          | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.80.2         | X                 |
| Imprimante (Étage 1)  | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.80.3         | X                 |
| Imprimante (Étage 2)  | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.80.4         | X                 |
| Imprimante (Étage 3)  | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.80.5         | X                 |
| Téléphone IP 1        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.90.2         |
| Téléphone IP 2        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.90.3         |
| Téléphone IP 3        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.90.4         |
| Téléphone IP 4        | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.90.5         |
| ...                   | ...               | ...               | ...               | ...               | ...               | ...               | ...               | ...               | ...               |
| Téléphone IP 191      | X                 | X                 | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.91.192       |



# 2. Tableau d'adressage VLAN


| VLAN | VLAN 10 **dev** | VLAN 20 **Admins** | VLAN 30 **Direction** | VLAN 40 **Secretariat** | VLAN 50 **RH** | VLAN 60 **Cameras** | VLAN 70 **TV** | VLAN 80 **Imprimantes** | VLAN 90 **Tel** |
|------------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|----------|-----------|
|Réseau|10.1.10.0/23|10.1.20.0/28|10.1.30.0/3010.1.30.0/30|10.1.40.0/29|10.1.50.0/28|10.1.60.0/26|10.1.70.0/26|10.1.80.0/28|10.1.90.0/23|

