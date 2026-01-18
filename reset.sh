#!/bin/bash
echo "🔴 Réinitialisation de la base de données..."
docker-compose down
sudo rm -rf database/data/*
docker-compose up -d
echo "🟢 Base de données réinitialisée avec le jeu d'essai initial."
