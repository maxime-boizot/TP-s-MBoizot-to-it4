# TP8 INFRA : Make ur own

ooook la c'est du serieux

on devient (presque) un admin réseau pour des boite de prestige

![çavachier](/TP-s-reseau/infra/tp-8/img/ça-va-chier.gif)

## meow origins: 

### petit aperçu des VLAN et des IPs:

voila un rapide aperçu de l'adressage de chaque machines avec a qui elles appartiennent leurs VLAN leurs réseau IP et leurs IPs. évidemment c'est un aperçu donc c'est regrouper et fait pour être plus "jolie" 

| Équipe/Role            | Poste                 | VLAN  | Réseau IP        | Adresse IP                |
|------------------------|-----------------------|-------|------------------|---------------------------|
| Équipe Dév             | Lead Dev              | 10    | 10.1.10.0/23     | 10.1.10.2 - 10.1.11.8     |
|                        | Dev                   | 10    |                  | 10.1.10.9 - 10.1.10.140   |
| Équipe Admin           | Admin Réseau          | 20    | 10.1.20.0/28     | 10.1.20.2                 |
|                        | Admin Sys             | 20    |                  | 10.1.20.3                 |
|                        | Responsable Sécurité  | 20    |                  | 10.1.20.4                 |
| Direction              | PDG                   | 30    | 10.1.30.0/30     | 10.1.30.2                 |
| Secrétariat/Accueil    | Secrétaire/Agent      | 40    | 10.1.40.0/29     | 10.1.40.2 - 10.1.40.6     |
| Ressources Humaines    | Agent RH              | 50    | 10.1.50.0/28     | 10.1.50.2 - 10.1.50.3     |
| Caméras                | Caméras de sécurité   | 60    | 10.1.60.0/26     | 10.1.60.2 - 10.1.60.12    |
| Télés                  | Télés                 | 70    | 10.1.70.0/26     | 10.1.70.2 - 10.1.70.7     |
| Imprimantes            | Imprimantes           | 80    | 10.1.80.0/28     | 10.1.80.2 - 10.1.80.6     |
| Téléphones IP          | Téléphones IP         | 90    | 10.1.90.0/23     | 10.1.90.2 - 10.1.91.192   |


vous trouverez [ici](/TP-s-reseau/infra/tp-8/meow-origins/adressage.md) un fichier qui contient un tableau plus détailler



## Meow and Beyond: 

same ici voila un aperçu de l'adressage de chaque machines avec a qui elles appartiennent leurs VLAN leurs réseau IP et leurs IPs.


| Équipe/Role            | Poste                 | VLAN  | Réseau IP        | Adresse IP                |
|------------------------|-----------------------|-------|------------------|---------------------------|
| Équipe Dév             | Lead Dev              | 11    | 10.1.11.0/24     | 10.1.11.2 - 10.1.11.3     |
|                        | Dev                   | 11    |                  | 10.1.11.4 - 10.1.11.15    |
| Équipe Admin           | Admin Réseau          | 21    | 10.1.21.0/28     | 10.1.21.2                 |
|                        | Admin Sys             | 21    |                  | 10.1.21.3                 |
| Direction              | Secrétaire/Agent      | 31    | 10.1.31.0/28     | 10.1.31.2 - 10.1.31.3     |
| Imprimantes            | Imprimante Étage 1    | 41    | 10.1.41.0/26     | 10.1.41.2 - 10.1.41.3     |
|                        | Imprimante Étage 2    | 41    |                  | 10.1.41.4 - 10.1.41.5     |
|                        | Imprimante Étage 3    | 41    |                  | 10.1.41.6 - 10.1.41.7     |
|                        | Imprimante Étage 1    | 41    |                  | 10.1.41.8 - 10.1.41.9     |
|                        | Imprimante Étage 2    | 41    |                  | 10.1.41.10 - 10.1.41.11    |
|                        | Imprimante Étage 3    | 41    |                  | 10.1.41.12 - 10.1.41.13   |
| Caméras                | Caméras Étage 1       | 51    | 10.1.51.0/25     | 10.1.50.2 - 10.1.51.3     |
|                        | Caméras Étage 2       | 51    |                  | 10.1.51.4 - 10.1.51.5     |
|                        | Caméras Étage 3       | 51    |                  | 10.1.51.6 - 10.1.51.7     |
|                        | Caméra Entrée         | 51    |                  | 10.1.51.9                 |
| Télés                  | Télés Accueil         | 61    | 10.1.61.0/26     | 10.1.60.2 - 10.1.61.3     |
|                        | Télés Étage 1         | 61    |                  | 10.1.61.4                 |
|                        | Télés Étage 2         | 61    |                  | 10.1.61.5                 |
|                        | Télés Étage 3         | 61    |                  | 10.1.61.6                 |
| Téléphones IP          | Téléphones IP         | 71    | 10.1.71.0/23     | 10.1.71.2 - 10.1.71.19   |

pour l'adressage complet [click ici](/TP-s-reseau/infra/tp-8/meow-and-beyond/adressage.md) un fichier qui contient un tableau plus détailler

