# 🔧 Correctif Script de Déploiement

## ❌ **Problème Identifié**
Le script `deploy.sh` cherchait `index.html` dans `dist/` mais Vite génère les fichiers dans `dist/public/`.

```bash
❌ index.html not found in dist
```

## ✅ **Solutions Appliquées**

### 1. **Correction du Dossier de Build**
```bash
# Avant
BUILD_FOLDER="dist"

# Après  
BUILD_FOLDER="dist/public"
```

### 2. **Configuration Vite pour Chemins Relatifs**
```typescript
// vite.config.ts
export default defineConfig({
  base: process.env.VITE_BASE || "/",  // ✅ Ajouté
  plugins: [react()],
  // ...
});
```

### 3. **Script de Build Corrigé**
```bash
# deploy.sh utilise maintenant:
npm run build:static  # Au lieu de npm run build
```

### 4. **Script de Vérification Ajouté**
```bash
./check-build.sh  # Vérifie le build avant déploiement
```

## 🧪 **Tests Réussis**

### ✅ Build Statique
```bash
npm run build:static
# ✅ Génère dist/public/ avec chemins relatifs
```

### ✅ Vérification
```bash
./check-build.sh
# ✅ index.html trouvé
# ✅ Assets trouvés: JS(1), CSS(1), Images(9)  
# ✅ Chemins relatifs configurés
```

### ✅ Chemins Corrects
```html
<!-- Avant (absolu) -->
<script src="/assets/index-xxx.js"></script>

<!-- Après (relatif) -->
<script src="./assets/index-xxx.js"></script>
```

## 🚀 **Prêt pour Déploiement !**

Sur votre VPS, lancez maintenant :
```bash
git pull origin main
./deploy.sh
```

Le script devrait maintenant fonctionner parfaitement ! ✅

---

## 📋 **Scripts Disponibles**

- `./check-build.sh` → Vérification du build
- `./deploy.sh` → Déploiement FTP  
- `./deploy-vps.sh` → Guide déploiement VPS
- `./check-config.sh` → Vérification configuration

**Votre café est prêt pour le web ! ☕🌐**