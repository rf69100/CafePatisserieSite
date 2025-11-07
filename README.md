
# ☕ Café Pâtisserie

Site web moderne pour une boutique de café et pâtisseries, développé avec React, TypeScript, Vite, Express et MariaDB. Ce projet est conçu pour être facilement déployé sur un VPS ou en hébergement statique.

## 🚀 Installation Rapide

### Prérequis
- Node.js 18+ ou 20+
- MariaDB/MySQL
- npm

### Étapes
1. **Cloner le projet**
    ```bash
    git clone <votre-repo>
    cd CafePatisserieSite
    ```
2. **Installer les dépendances**
    ```bash
    npm install
    ```
3. **Configurer la base de données**
    ```sql
    CREATE DATABASE cafe_patisserie;
    CREATE USER 'cafe_user'@'localhost' IDENTIFIED BY 'mot_de_passe_fort';
    GRANT ALL PRIVILEGES ON cafe_patisserie.* TO 'cafe_user'@'localhost';
    FLUSH PRIVILEGES;
    ```
4. **Configurer l'environnement**
    ```bash
    cp .env.example .env
    # Modifier .env avec vos infos
    ```
5. **Migrations & Seed**
    ```bash
    npm run db:push
    npm run db:seed
    ```
6. **Build & Démarrage**
    ```bash
    npm run build
    npm start
    # ou npm run dev pour développement
    ```

## ️ Scripts Utiles
- `npm run dev` : Démarrage dev
- `npm run build` : Build production
- `npm start` : Serveur production
- `npm run db:push` : Appliquer migrations
- `npm run db:seed` : Données de démo

## 📦 Déploiement

### VPS (Express + MariaDB)
1. Build : `npm run build`
2. Démarrer : `npm start` ou via PM2
3. Configurer Nginx (proxy vers localhost:3000)

### Statique (FTP, Netlify, Vercel)
1. Build : `npm run build:static`
2. Uploader le dossier `dist/public` sur votre hébergement

## 🌐 Fonctionnalités
- Catalogue produits (cafés, pâtisseries)
- Filtres par catégorie
- Formulaire de contact
- Pages : Accueil, Produits, À propos, Contact
- Design responsive & animations
- Backend Express minimal (API produits, contact)

## 🧩 Structure du Projet
```
CafePatisserieSite/
├── client/
│   └── src/
│       ├── components/
│       ├── pages/
│       ├── data/
│       ├── App.tsx
│       └── main.tsx
├── server/
│   ├── routes.ts
│   └── storage.ts
├── shared/
│   └── schema.ts
├── attached_assets/
│   └── generated_images/
├── package.json
├── tailwind.config.ts
├── tsconfig.json
└── README.md
```

## ✨ Technologies
- React 18
- TypeScript
- Vite
- Tailwind CSS
- Express.js
- MariaDB/MySQL
- Shadcn/ui
- Lucide React

## 🔒 Sécurité & Conseils
- Changez tous les mots de passe par défaut
- Utilisez HTTPS (Let's Encrypt)
- Mettez à jour vos dépendances
- Configurez un firewall (ufw)

## 👨‍💻 Auteur
Projet réalisé pour portfolio et démonstration de compétences web.

## 📄 Licence
MIT

---
Ce site est fictif, toutes les données sont de démonstration.
