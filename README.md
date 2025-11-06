# ☕ Café Pâtisserie - Site Web

Site web moderne pour café-pâtisserie développé avec React, TypeScript et Express.

## 🚀 Déploiement sur VPS avec MariaDB

### Prérequis
- Node.js 18+ installé
- MariaDB/MySQL installé et configuré
- Git installé

### 🔧 Configuration de la base de données

1. **Connexion à MariaDB :**
```bash
sudo mysql -u root -p
```

2. **Création de la base de données :**
```sql
CREATE DATABASE cafe_patisserie;
CREATE USER 'cafe_user'@'localhost' IDENTIFIED BY 'votre_mot_de_passe_fort';
GRANT ALL PRIVILEGES ON cafe_patisserie.* TO 'cafe_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 📦 Installation

1. **Cloner le projet :**
```bash
git clone <votre-repo>
cd CafePatisserieSite
```

2. **Installer les dépendances :**
```bash
npm install
```

3. **Configuration des variables d'environnement :**
```bash
cp .env.example .env
nano .env
```

Modifiez le fichier `.env` avec vos vraies informations :
```env
DATABASE_URL="mysql://cafe_user:votre_mot_de_passe_fort@localhost:3306/cafe_patisserie"
NODE_ENV=production
PORT=3000
SESSION_SECRET="votre-clé-secrète-très-longue-et-aléatoire"
```

4. **Migration de la base de données :**
```bash
npm run db:push
```

5. **Initialisation avec des données de démonstration :**
```bash
npm run db:seed
```

6. **Build de l'application :**
```bash
npm run build
```

### 🚀 Démarrage

**Mode développement :**
```bash
npm run dev
```

**Mode production :**
```bash
npm start
```

### 🔄 Déploiement automatique avec PM2

1. **Installation de PM2 :**
```bash
sudo npm install -g pm2
```

2. **Démarrage avec PM2 :**
```bash
pm2 start dist/index.js --name cafe-patisserie
pm2 startup
pm2 save
```

3. **Gestion avec PM2 :**
```bash
pm2 status           # Voir le status
pm2 logs cafe-patisserie  # Voir les logs
pm2 restart cafe-patisserie  # Redémarrer
pm2 stop cafe-patisserie     # Arrêter
```

### 🌐 Configuration Nginx (optionnel)

Créez un fichier de configuration Nginx :
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

### 🔒 Sécurité

- Changez les mots de passe par défaut
- Configurez un firewall (ufw)
- Utilisez HTTPS avec Let's Encrypt
- Gardez votre système à jour

### 📊 Structure de la base de données

- **users** : Gestion des utilisateurs
- **products** : Catalogue des produits (cafés & pâtisseries)

### 🛠️ Scripts disponibles

- `npm run dev` : Démarrage en mode développement
- `npm run build` : Build de production
- `npm start` : Démarrage en production
- `npm run db:generate` : Génère les migrations
- `npm run db:push` : Applique les migrations
- `npm run db:seed` : Initialise avec des données de démonstration

### 🆘 Dépannage

**Erreur de connexion à la base :**
- Vérifiez que MariaDB est démarré : `sudo systemctl status mariadb`
- Vérifiez les credentials dans `.env`
- Testez la connexion : `mysql -u cafe_user -p cafe_patisserie`

**Port déjà utilisé :**
- Changez le PORT dans `.env`
- Ou arrêtez le processus : `sudo lsof -ti:3000 | xargs sudo kill -9`

---

🎉 Votre site de café-pâtisserie est maintenant prêt à servir vos clients en ligne !

## 📋 Table des Matières

- [Aperçu](#aperçu)
- [Fonctionnalités](#fonctionnalités)
- [Technologies Utilisées](#technologies-utilisées)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Structure du Projet](#structure-du-projet)
- [Pages](#pages)
- [Composants](#composants)
- [Design](#design)
- [Licence](#licence)

## 🎯 Aperçu

Café & Délices est un site vitrine statique créé pour présenter une boutique fictive de café et pâtisseries artisanales. Le site offre une expérience utilisateur moderne et intuitive avec un design chaleureux et accueillant.

### Objectifs du Projet

- Démonstration de compétences React avancées
- Design responsive et accessible
- Architecture de composants réutilisables
- Code propre et bien organisé
- Projet portfolio pour candidatures de stage

## ✨ Fonctionnalités

### Pages Principales

- **🏠 Accueil** : Section hero avec image d'ambiance, slogan, et bouton d'appel à l'action
- **☕ Produits** : Catalogue de 8 produits (cafés et pâtisseries) avec filtres par catégorie
- **📖 À Propos** : Histoire de la boutique, valeurs, et mission
- **📧 Contact** : Formulaire de contact avec validation, coordonnées, et horaires d'ouverture

### Fonctionnalités Techniques

- ✅ Navigation responsive avec menu mobile
- ✅ Animations au survol sur les cartes produits
- ✅ Validation de formulaire avec Zod
- ✅ Filtrage de produits par catégorie
- ✅ Design adaptatif (mobile, tablette, desktop)
- ✅ SEO optimisé avec meta tags
- ✅ Images générées par IA de haute qualité

## 🛠 Technologies Utilisées

### Frontend

- **React 18** - Bibliothèque UI
- **TypeScript** - Typage statique
- **Vite** - Build tool rapide
- **Tailwind CSS** - Framework CSS utility-first
- **Wouter** - Routage léger pour React
- **Shadcn/ui** - Composants UI réutilisables
- **Lucide React** - Icônes modernes
- **React Hook Form** - Gestion de formulaires
- **Zod** - Validation de schémas

### Backend (Minimal)

- **Express.js** - Serveur pour servir l'application
- Stockage en mémoire (MemStorage) pour démonstration

### Design

- **Google Fonts** : Playfair Display (serif) + Inter (sans-serif)
- **Palette de couleurs** : Tons chauds et terreux inspirés du café
- **Shadcn UI** : Système de design cohérent

## 📦 Installation

### Prérequis

- Node.js 20.x ou supérieur
- npm ou yarn

### Étapes d'Installation

1. **Cloner le dépôt** (ou télécharger les fichiers)

```bash
git clone <repository-url>
cd cafe-delices
```

2. **Installer les dépendances**

```bash
npm install
```

3. **Démarrer le serveur de développement**

```bash
npm run dev
```

4. **Ouvrir dans le navigateur**

L'application sera accessible à `http://localhost:5000`

## 🚀 Utilisation

### Développement

```bash
npm run dev
```

Démarre le serveur de développement avec rechargement à chaud.

### Build de Production

```bash
npm run build
```

Crée une version optimisée pour la production dans le dossier `dist/`.

### Déploiement

Ce site peut être déployé sur :
- **Netlify** : Glisser-déposer le dossier `dist/`
- **Vercel** : Connexion directe au repository Git
- **GitHub Pages** : Via GitHub Actions

## 📁 Structure du Projet

```
cafe-delices/
├── client/
│   ├── src/
│   │   ├── components/          # Composants réutilisables
│   │   │   ├── Navbar.tsx        # Navigation principale
│   │   │   ├── Footer.tsx        # Pied de page
│   │   │   ├── ProductCard.tsx   # Carte produit
│   │   │   └── ui/               # Composants Shadcn UI
│   │   ├── pages/                # Pages de l'application
│   │   │   ├── Home.tsx          # Page d'accueil
│   │   │   ├── Products.tsx      # Page produits
│   │   │   ├── About.tsx         # Page à propos
│   │   │   └── Contact.tsx       # Page contact
│   │   ├── data/
│   │   │   └── products.ts       # Données produits
│   │   ├── lib/                  # Utilitaires
│   │   ├── App.tsx               # Composant racine
│   │   ├── main.tsx              # Point d'entrée
│   │   └── index.css             # Styles globaux
│   └── index.html                # Template HTML
├── shared/
│   └── schema.ts                 # Schémas TypeScript partagés
├── server/
│   ├── routes.ts                 # Routes API (minimal)
│   └── storage.ts                # Interface de stockage
├── attached_assets/
│   └── generated_images/         # Images générées par IA
├── design_guidelines.md          # Guidelines de design
├── package.json
├── tailwind.config.ts
├── tsconfig.json
└── README.md
```

## 📄 Pages

### 🏠 Accueil (`/`)

- Section hero plein écran avec image d'ambiance
- Titre et description accrocheurs
- Bouton d'appel à l'action vers les produits
- Section "Pourquoi nous choisir ?" avec 3 valeurs clés

### ☕ Produits (`/produits`)

- Grille responsive de 8 produits
- Filtres par catégorie (Tous, Cafés, Pâtisseries)
- Cartes produits avec image, nom, description, et prix
- Animations au survol

### 📖 À Propos (`/a-propos`)

- Histoire de la boutique
- Présentation des valeurs (Qualité, Artisanat, Durabilité, Convivialité)
- Mission de l'entreprise

### 📧 Contact (`/contact`)

- Formulaire de contact validé (nom, email, message)
- Message de confirmation après envoi
- Coordonnées (adresse, téléphone, email)
- Horaires d'ouverture

## 🧩 Composants

### Navbar

- Navigation desktop avec liens actifs
- Menu mobile avec hamburger
- Logo cliquable
- Sticky au scroll

### Footer

- Informations de la boutique
- Liens rapides vers les pages
- Icônes réseaux sociaux (Instagram, Facebook)
- Mentions légales et copyright

### ProductCard

- Image produit optimisée
- Nom et prix
- Description courte
- Animation au survol (scale + shadow)
- Accessibilité avec data-testid

## 🎨 Design

### Système de Couleurs

- **Primary** : Marron chaud (hsl(25, 60%, 48%))
- **Background** : Crème léger (hsl(30, 4%, 98%))
- **Card** : Blanc cassé (hsl(30, 5%, 96%))
- **Text** : Gris foncé pour contraste optimal

### Typographie

- **Headlines** : Playfair Display (serif élégant)
- **Body** : Inter (sans-serif moderne)
- Hiérarchie claire avec tailles responsives

### Espacements

- Padding sections : `py-16` à `py-24`
- Gap entre éléments : `gap-6` à `gap-12`
- Conteneurs : `max-w-6xl` à `max-w-7xl`

### Responsive Breakpoints

- Mobile : < 768px
- Tablet : 768px - 1023px
- Desktop : ≥ 1024px

## 📝 Choix Techniques

### Pourquoi React + Vite ?

- **Vite** : Setup ultra-rapide, HMR instantané
- **React** : Composants réutilisables, large écosystème
- **TypeScript** : Sécurité du typage, meilleure DX

### Pourquoi Tailwind CSS ?

- Développement rapide avec classes utilitaires
- Design system cohérent
- Optimisation automatique (purge CSS)
- Responsive design facile

### Pourquoi Shadcn/ui ?

- Composants accessibles (Radix UI)
- Personnalisables à 100%
- Code source intégré au projet
- Styles cohérents avec Tailwind

## 🎯 Améliorations Futures

- [ ] Ajouter une page Équipe avec profils des baristas
- [ ] Section témoignages clients
- [ ] Système de favoris (localStorage)
- [ ] Galerie photos de la boutique
- [ ] Intégration Google Maps pour la localisation
- [ ] Mode sombre/clair
- [ ] Animations de page transitions
- [ ] Blog ou actualités

## 📸 Screenshots

*Les screenshots seront ajoutés après le déploiement*

## 👨‍💻 Auteur

Projet créé dans le cadre d'un portfolio de développement web pour candidatures de stage.

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.

---

**Note** : Ce site est un projet fictif créé à des fins de démonstration de compétences en développement web. Toutes les informations (adresse, numéro de téléphone, email) sont fictives.
