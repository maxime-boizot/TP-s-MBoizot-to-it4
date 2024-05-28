# 1. Tableau d'adressage IP


| Machine & Réseau      | 10.1.11.0/24      | 10.1.21.0/28      | 10.1.31.0/28      | 10.1.41.0/26      | 10.1.51.0/25      | 10.1.61.0/26      | 10.1.71.0/23      |
|-----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| Routeur 1             | 10.1.11.1         | 10.1.21.1         | 10.1.31.1         | 10.1.41.1         | 10.1.51.1         | 10.1.61.1         | 10.1.71.1         |
| Lead Dev 1            | 10.1.11.2         | X                 | X                 | X                 | X                 | X                 | X                 |
| Lead Dev 2            | 10.1.11.3         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 1                 | 10.1.11.4         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 2                 | 10.1.11.5         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 3                 | 10.1.11.6         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 4                 | 10.1.11.7         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 5                 | 10.1.11.8         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 6                 | 10.1.11.9         | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 7                 | 10.1.11.10        | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 8                 | 10.1.11.11        | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 9                 | 10.1.11.12        | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 10                | 10.1.11.13        | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 11                | 10.1.11.14        | X                 | X                 | X                 | X                 | X                 | X                 |
| Dev 12                | 10.1.11.15        | X                 | X                 | X                 | X                 | X                 | X                 |
| Admin Réseau          | X                 | 10.1.21.2         | X                 | X                 | X                 | X                 | X                 |
| Admin Sys             | X                 | 10.1.21.3         | X                 | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 1    | X                 | X                 | 10.1.31.2         | X                 | X                 | X                 | X                 |
| Secrétaire/Agent 2    | X                 | X                 | 10.1.31.3         | X                 | X                 | X                 | X                 |
| Imprimante (Étage 1)  | X                 | X                 | X                 | 10.1.41.2         | X                 | X                 | X                 |
| Imprimante (Étage 2)  | X                 | X                 | X                 | 10.1.41.3         | X                 | X                 | X                 |
| Imprimante (Étage 3)  | X                 | X                 | X                 | 10.1.41.4         | X                 | X                 | X                 |
| Imprimante (Étage 1)  | X                 | X                 | X                 | 10.1.41.5         | X                 | X                 | X                 |
| Imprimante (Étage 2)  | X                 | X                 | X                 | 10.1.41.6         | X                 | X                 | X                 |
| Imprimante (Étage 3)  | X                 | X                 | X                 | 10.1.41.7         | X                 | X                 | X                 |
| Caméra 1 (Étage 1)    | X                 | X                 | X                 | X                 | 10.1.51.2         | X                 | X                 |
| Caméra 2 (Étage 1)    | X                 | X                 | X                 | X                 | 10.1.51.3         | X                 | X                 |
| Caméra 3 (Étage 2)    | X                 | X                 | X                 | X                 | 10.1.51.4         | X                 | X                 |
| Caméra 4 (Étage 2)    | X                 | X                 | X                 | X                 | 10.1.51.5         | X                 | X                 |
| Caméra 5 (Étage 3)    | X                 | X                 | X                 | X                 | 10.1.51.6         | X                 | X                 |
| Caméra 6 (Étage 3)    | X                 | X                 | X                 | X                 | 10.1.51.7         | X                 | X                 |
| Caméra 7 (Entrée)     | X                 | X                 | X                 | X                 | 10.1.51.8         | X                 | X                 |
| Caméra 8 (Entrée)     | X                 | X                 | X                 | X                 | 10.1.51.9         | X                 | X                 |
| Télé 1 (Accueil)      | X                 | X                 | X                 | X                 | X                 | 10.1.61.2         | X                 |
| Télé 2 (Accueil)      | X                 | X                 | X                 | X                 | X                 | 10.1.61.3         | X                 |
| Télé 3 (Étage 1)      | X                 | X                 | X                 | X                 | X                 | 10.1.61.4         | X                 |
| Télé 4 (Étage 2)      | X                 | X                 | X                 | X                 | X                 | 10.1.61.5         | X                 |
| Télé 5 (Étage 3)      | X                 | X                 | X                 | X                 | X                 | 10.1.61.6         | X                 |
| Téléphone IP 1        | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.71.2         |
| Téléphone IP 2        | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.71.3         |
| Téléphone IP 3        | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.71.4         |
| Téléphone IP 4        | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.71.5         |
| Téléphone IP 5        | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.71.6         |
| ...                   | ...               | ...               | ...               | ...               | ...               | ...               | ...               |
| Téléphone IP 18      | X                 | X                 | X                 | X                 | X                 | X                 | 10.1.71.19       |


# 2. Tableau d'adressage VLAN


| VLAN | VLAN 11 **dev** | VLAN 21 **Admins** | VLAN 31 **Direction** | VLAN 41 **Imprimantes** | VLAN 51 **Caméras** | VLAN 61 **TV** | VLAN 71 **Tel** |
|------|------------------|--------------------|----------------------|-------------------------|---------------------|-----------------|------------------|
| Réseau | 10.1.11.0/24 | 10.1.21.0/28 | 10.1.31.0/28 | 10.1.41.0/26 | 10.1.51.0/25 | 10.1.61.0/26 | 10.1.71.0/23 |

