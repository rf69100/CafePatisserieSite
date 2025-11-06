#!/bin/bash

# Script de vérification de configuration
echo "🔍 Vérification de la configuration pour le déploiement VPS"
echo "============================================================"

# Vérifier Node.js
echo "📦 Version Node.js:"
node --version

# Vérifier npm
echo "📦 Version npm:"
npm --version

# Vérifier les dépendances principales
echo ""
echo "🔍 Vérification des dépendances principales..."

# Vérifier TypeScript
if npm list typescript > /dev/null 2>&1; then
    echo "✅ TypeScript installé"
else
    echo "❌ TypeScript manquant"
fi

# Vérifier mysql2
if npm list mysql2 > /dev/null 2>&1; then
    echo "✅ mysql2 installé"
else
    echo "❌ mysql2 manquant"
fi

# Vérifier drizzle-orm
if npm list drizzle-orm > /dev/null 2>&1; then
    echo "✅ drizzle-orm installé"
else
    echo "❌ drizzle-orm manquant"
fi

# Vérifier que les fichiers principaux existent
echo ""
echo "🔍 Vérification des fichiers de configuration..."

if [ -f "server/db.ts" ]; then
    echo "✅ Configuration base de données (server/db.ts)"
else
    echo "❌ Configuration base de données manquante"
fi

if [ -f "shared/schema.ts" ]; then
    echo "✅ Schéma de base de données (shared/schema.ts)"
else
    echo "❌ Schéma de base de données manquant"
fi

if [ -f "drizzle.config.ts" ]; then
    echo "✅ Configuration Drizzle (drizzle.config.ts)"
else
    echo "❌ Configuration Drizzle manquante"
fi

if [ -f ".env.example" ]; then
    echo "✅ Exemple de configuration (.env.example)"
else
    echo "❌ Exemple de configuration manquant"
fi

# Vérifier la compilation TypeScript
echo ""
echo "🔍 Vérification de la compilation TypeScript..."
if npm run check > /dev/null 2>&1; then
    echo "✅ Compilation TypeScript réussie"
else
    echo "❌ Erreurs de compilation TypeScript"
    echo "Détails:"
    npm run check
fi

echo ""
echo "📋 Prochaines étapes sur votre VPS:"
echo "1. Copiez ce projet sur votre VPS"
echo "2. Configurez MariaDB selon les instructions du README"
echo "3. Créez le fichier .env avec vos vraies données"
echo "4. Exécutez: npm install"
echo "5. Exécutez: npm run db:push"
echo "6. Exécutez: npm run db:seed"
echo "7. Exécutez: npm run build"
echo "8. Exécutez: npm start"
echo ""
echo "🎉 Votre application sera accessible sur http://votre-vps:3000"