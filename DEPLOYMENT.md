# 🚀 Guide de Déploiement - Café Pâtisserie

Ce guide vous explique comment déployer votre site Café Pâtisserie selon différentes méthodes.

## 📋 Types de Déploiement

### 🌐 Option 1 : Déploiement Statique (FTP)
**Idéal pour :** Sites vitrines, hébergements mutualisés, GitHub Pages
**Avantages :** Simple, rapide, peu coûteux
**Inconvénients :** Pas de base de données, pas d'API backend

### 🖥️ Option 2 : Déploiement VPS Complet
**Idéal pour :** Applications complètes avec base de données
**Avantages :** Fonctionnalités complètes, évolutif
**Inconvénients :** Plus complexe, nécessite un VPS

---

## 🌐 Déploiement Statique (FTP)

### Prérequis
- Accès FTP à votre hébergement
- `lftp` installé sur votre machine

### Installation de lftp
```bash
# Ubuntu/Debian
sudo apt-get install lftp

# macOS
brew install lftp

# Windows (via WSL)
sudo apt-get install lftp
```

### Configuration

1. **Créer le fichier de configuration :**
```bash
cp .deploy.env.example .deploy.env
nano .deploy.env
```

2. **Modifier avec vos credentials :**
```env
FTP_USER="votre_username_ftp"
FTP_PASS="votre_mot_de_passe_ftp"
FTP_HOST="ftp.votre-hebergeur.com"
REMOTE_FOLDER="cafe-patisserie"
```

### Déploiement
```bash
# Déploiement automatique
npm run deploy:ftp

# Ou manuellement
./deploy.sh
```

Le script va :
1. ✅ Installer les dépendances
2. ✅ Builder le site en statique
3. ✅ Vérifier les assets
4. ✅ Uploader via FTP
5. ✅ Tester l'URL publique

---

## 🖥️ Déploiement VPS Complet

### Prérequis
- VPS avec Node.js 18+
- MariaDB/MySQL installé
- Accès SSH au VPS

### Guide pas à pas

1. **Transférer le projet sur le VPS :**
```bash
# Depuis votre machine locale
scp -r CafePatisserieSite/ user@votre-vps:/var/www/
```

2. **Se connecter au VPS :**
```bash
ssh user@votre-vps
cd /var/www/CafePatisserieSite
```

3. **Exécuter le script de déploiement VPS :**
```bash
npm run deploy:vps
# Ou directement : ./deploy-vps.sh
```

4. **Suivre les instructions affichées :**
   - Configuration MariaDB
   - Variables d'environnement
   - Installation et build
   - Démarrage

### Configuration MariaDB
```sql
CREATE DATABASE cafe_patisserie;
CREATE USER 'cafe_user'@'localhost' IDENTIFIED BY 'mot_de_passe_fort';
GRANT ALL PRIVILEGES ON cafe_patisserie.* TO 'cafe_user'@'localhost';
FLUSH PRIVILEGES;
```

### Variables d'environnement (.env)
```env
DATABASE_URL="mysql://cafe_user:mot_de_passe_fort@localhost:3306/cafe_patisserie"
NODE_ENV=production
PORT=3000
SESSION_SECRET="votre-clé-secrète-très-longue-et-aléatoire"
```

### Démarrage avec PM2
```bash
# Installation PM2
sudo npm install -g pm2

# Démarrage
pm2 start dist/index.js --name cafe-patisserie

# Auto-démarrage
pm2 startup
pm2 save

# Gestion
pm2 status
pm2 logs cafe-patisserie
pm2 restart cafe-patisserie
```

---

## 🔧 Scripts de Maintenance

### Vérification de Configuration
```bash
npm run check:config
```

### Build et Tests
```bash
# Vérification TypeScript
npm run check

# Build complet (VPS)
npm run build

# Build statique (FTP)
npm run build:static
```

### Base de Données
```bash
# Génération des migrations
npm run db:generate

# Application des migrations
npm run db:push

# Insertion de données de test
npm run db:seed
```

---

## 🌐 Configuration Nginx (VPS)

### Fichier de configuration
```nginx
server {
    listen 80;
    server_name votre-domaine.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### SSL avec Let's Encrypt
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d votre-domaine.com
```

---

## 🆘 Dépannage

### Erreurs Courantes

**Build qui échoue :**
```bash
# Nettoyage et réinstallation
rm -rf node_modules dist
npm install
npm run check
```

**Erreur FTP :**
```bash
# Tester la connexion
lftp -u 'username','password' ftp.hebergeur.com
```

**Erreur de base de données :**
```bash
# Vérifier le service
sudo systemctl status mariadb

# Tester la connexion
mysql -u cafe_user -p cafe_patisserie
```

**Port occupé :**
```bash
# Trouver et tuer le processus
sudo lsof -ti:3000 | xargs sudo kill -9
```

### Logs et Monitoring

**PM2 :**
```bash
pm2 logs cafe-patisserie --lines 100
pm2 monit
```

**Nginx :**
```bash
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```

---

## 📊 Exemples d'Hébergeurs

### Hébergement Statique
- **Netlify** : Glisser-déposer le dossier `dist/public`
- **Vercel** : Connexion Git automatique
- **GitHub Pages** : Via GitHub Actions
- **OVH** : Upload FTP avec le script fourni

### VPS/Serveurs
- **DigitalOcean** : Droplets avec Node.js
- **OVH VPS** : Serveurs privés virtuels
- **Hetzner** : VPS économiques
- **AWS EC2** : Cloud AWS

---

## ✅ Checklist de Déploiement

### Avant le déploiement
- [ ] Tests locaux réussis
- [ ] Build sans erreurs
- [ ] Configuration des credentials
- [ ] Sauvegarde des données importantes

### Déploiement Statique
- [ ] Script `deploy.sh` configuré
- [ ] Credentials FTP vérifiés
- [ ] Build statique testé
- [ ] Upload réussi
- [ ] URL publique accessible

### Déploiement VPS
- [ ] VPS configuré et accessible
- [ ] MariaDB installé et configuré
- [ ] Variables d'environnement définies
- [ ] Migrations appliquées
- [ ] PM2 configuré
- [ ] Nginx configuré (optionnel)
- [ ] SSL activé (optionnel)

---

## 🎉 Succès !

Votre site Café Pâtisserie est maintenant en ligne !

**Statique :** https://votre-domaine.com/cafe-patisserie/
**VPS :** https://votre-domaine.com/

Profitez de votre magnifique site de café ! ☕