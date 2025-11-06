#!/bin/bash

# Script de déploiement pour VPS avec MariaDB
# Ce script vous guide dans la configuration de votre application sur votre VPS

echo "🚀 Script de déploiement VPS Café Pâtisserie"
echo "=============================================="

echo ""
echo "📋 Instructions pour configurer votre VPS :"
echo ""

echo "1. 📊 Configuration de la base de données MariaDB :"
echo "   Connectez-vous à MariaDB et exécutez :"
echo "   CREATE DATABASE cafe_patisserie;"
echo "   CREATE USER 'cafe_user'@'localhost' IDENTIFIED BY 'votre_mot_de_passe';"
echo "   GRANT ALL PRIVILEGES ON cafe_patisserie.* TO 'cafe_user'@'localhost';"
echo "   FLUSH PRIVILEGES;"
echo ""

echo "2. 🔧 Configuration des variables d'environnement :"
echo "   Copiez .env.example vers .env et modifiez les valeurs :"
echo "   cp .env.example .env"
echo "   nano .env"
echo ""

echo "3. 📦 Installation des dépendances :"
echo "   npm install"
echo ""

echo "4. 🗄️ Migration de la base de données :"
echo "   npm run db:push"
echo ""

echo "5. 🌱 Initialisation avec des données de démonstration :"
echo "   npm run db:seed"
echo ""

echo "6. 🏗️ Build de l'application :"
echo "   npm run build"
echo ""

echo "7. 🚀 Démarrage en production :"
echo "   npm start"
echo ""

echo "💡 Pour un déploiement automatique avec PM2 :"
echo "   npm install -g pm2"
echo "   pm2 start dist/index.js --name cafe-patisserie"
echo "   pm2 startup"
echo "   pm2 save"
echo ""

echo "🌐 Votre application sera accessible sur http://votre-vps:3000"