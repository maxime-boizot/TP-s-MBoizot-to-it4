#!/bin/bash

sudo dnf update -y
update_status=$?

if [ $update_status -ne 0 ]; then
    echo "Erreur lors de la mise à jour du système."
    exit $update_status
fi

sudo dnf upgrade -y
upgrade_status=$?

if [ $upgrade_status -ne 0 ]; then
    echo "Erreur lors de la mise à niveau du système."
    exit $upgrade_status
fi


sudo dnf install -y mariadb-server
mariadb_install_status=$?

if [ $mariadb_install_status -ne 0 ]; then
    echo "Erreur lors de l'installation de MariaDB."
    exit $mariadb_install_status
fi

sudo systemctl start mariadb
start_status=$?

if [ $start_status -ne 0 ]; then
    echo "Erreur lors du démarrage de MariaDB."
    exit $start_status
fi

sudo systemctl enable mariadb
enable_status=$?

if [ $enable_status -ne 0 ]; then
    echo "Erreur lors de l'activation de MariaDB au démarrage."
    exit $enable_status
fi


init_sql="/home/vagrant/db_init/init.sql"

if [ -f "$init_sql" ]; then

    sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS meo; USE meo; SOURCE $init_sql;"
    mysql_status=$?

    if [ $mysql_status -ne 0 ]; then
        echo "Erreur lors de l'exécution du fichier $init_sql pour créer la base de données."
        exit $mysql_status
    else
        echo "Le fichier $init_sql a été exécuté avec succès pour créer la table 'meo'."
    fi
else
    echo "Le fichier $init_sql n'existe pas."
fi

echo "Tout est bon captain ! Meoooow !"