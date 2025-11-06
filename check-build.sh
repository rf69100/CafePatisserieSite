#!/bin/bash

# Test rapide du build avant déploiement

echo "🔍 Vérification du build..."

# Check build folder
if [ ! -d "dist/public" ]; then
  echo "❌ Dossier dist/public manquant. Lancez: npm run build:static"
  exit 1
fi

# Check index.html
if [ -f "dist/public/index.html" ]; then
  echo "✅ index.html trouvé"
else
  echo "❌ index.html manquant dans dist/public"
  exit 1
fi

# Check assets
if [ -d "dist/public/assets" ]; then
  jscount=$(ls dist/public/assets/*.js 2>/dev/null | wc -l)
  csscount=$(ls dist/public/assets/*.css 2>/dev/null | wc -l)
  imgcount=$(ls dist/public/assets/*.png 2>/dev/null | wc -l)
  
  echo "✅ Assets trouvés:"
  echo "   - JS files: $jscount"
  echo "   - CSS files: $csscount"
  echo "   - Image files: $imgcount"
else
  echo "❌ Dossier assets manquant"
  exit 1
fi

# Check relative paths
if grep -q '\./assets/' dist/public/index.html; then
  echo "✅ Chemins relatifs correctement configurés"
else
  echo "⚠️ Vérifiez les chemins dans index.html"
fi

echo ""
echo "✅ Build prêt pour le déploiement !"
echo "🚀 Lancez: ./deploy.sh"