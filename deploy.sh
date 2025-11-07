#!/usr/bin/env bash

set -euo pipefail

THIS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$THIS_DIR"

FTP_USER="ryanfoc"
FTP_PASS="Bpi14580911"
FTP_HOST="${FTP_HOST-ftp.cluster021.hosting.ovh.net}"


# Load environment if present
if [ -f ".deploy.env" ]; then
  set -a
  . <(grep -v '^\s*#' .deploy.env | sed '/^\s*$/d') 2>/dev/null || true
  set +a
fi

PROJECT_LIST=(
  "Portfolio:/var/www/html/websites/react/mon-portfolio::build"
  "Café Pâtisserie:/var/www/html/websites/react/CafePatisserieSite:cafe-patisserie:dist/public"
  # "NBA Dashboard:/var/www/html/websites/react/nba-dashbord:nba_dashboard:dist"
  # "Spotify Album Finder:/var/www/html/websites/react/album_finder_spotify:spotify-finder:dist"
  # "F1 Strategy Simulator:/var/www/html/websites/react/f1-strategy-simulator:f1-simulator:dist"
)

if [[ -z "$FTP_USER" || -z "$FTP_PASS" ]]; then
  echo "� FTP credentials missing. Create .deploy.env or set FTP_USER and FTP_PASS."
  exit 1
fi

echo "☕ Building Café Pâtisserie Website (permanent subdirectory /cafe-patisserie/)..."
export VITE_BASE="/cafe-patisserie/"


deploy_project() {
    local project_name="$1"
    local project_path="$2"
    local remote_folder="$3"
    local build_folder="$4"

    echo "\n=============================="
    echo "🚀 Déploiement du projet : $project_name"
    echo "Chemin local : $project_path"
    echo "Dossier de build : $build_folder"
    echo "Dossier distant : $remote_folder"
    echo "=============================="

    pushd "$project_path" >/dev/null || { echo "❌ Erreur: Impossible d'accéder à $project_path"; return 2; }

    echo "📦 [$project_name] Installation des dépendances..."
    npm ci --silent || npm install --silent

    echo "🔨 [$project_name] Build du projet..."
    if [ -f package.json ]; then
      if grep -q '"build:static"' package.json; then
        npm run build:static --silent
      else
        npm run build --silent
      fi
    fi

    # Copy .htaccess for client-side routing and ensure it's present (only for Vite/SPA)
    if [ -f "client/public/.htaccess" ]; then
      cp client/public/.htaccess "$build_folder/.htaccess"
      echo "✅ [$project_name] .htaccess copied for client-side routing"
    fi

    if [ ! -d "$build_folder" ]; then
      echo "❌ [$project_name] Build folder $build_folder not found"
      ls -la
      popd >/dev/null
      return 1
    fi

    echo "🔎 [$project_name] Vérification des fichiers de build..."
    if [ -f "$build_folder/index.html" ]; then
      echo "✅ [$project_name] index.html found"
      if grep -q "./assets/" $build_folder/index.html; then
        echo "✅ [$project_name] index.html references ./assets/"
      else
        echo "⚠️ [$project_name] index.html does not reference ./assets/ - inspect $build_folder/index.html"
      fi
    else
      echo "❌ [$project_name] index.html not found in $build_folder"
      popd >/dev/null
      return 1
    fi

    # Check for JS assets (only for Vite/SPA)
    jsfile=$(ls $build_folder/assets/*.js 2>/dev/null | head -n1 || true)
    if [ -z "$jsfile" ]; then
      echo "⚠️ [$project_name] No JS asset found in $build_folder/assets (normal for CRA)"
    else
      echo "✅ [$project_name] JS assets found: $(basename $jsfile)"
    fi

    # Check for CSS assets
    cssfile=$(ls $build_folder/assets/*.css 2>/dev/null | head -n1 || true)
    if [ -z "$cssfile" ]; then
      echo "⚠️ [$project_name] No CSS asset found in $build_folder/assets (normal for CRA)"
    else
      echo "✅ [$project_name] CSS assets found: $(basename $cssfile)"
    fi

    echo "📤 [$project_name] Uploading $build_folder to FTP /www/$remote_folder/ ..."
    lftp -c "open -u '$FTP_USER','$FTP_PASS' $FTP_HOST; mkdir -p /www/$remote_folder; cd /www/$remote_folder; mirror -R --delete --verbose $build_folder/ .; quit"

    echo "🧪 [$project_name] Testing public URL..."
    URL="https://www.ryanfonseca.fr/$remote_folder/"
    if curl --silent --head --fail "$URL" >/dev/null 2>&1; then
      echo "✅ [$project_name] Public URL reachable: $URL"
    else
      echo "❌ [$project_name] Public URL not reachable: $URL (this might be normal if the site takes time to propagate)"
    fi

    echo "� [$project_name] Asset check (public)..."
    echo "Main page headers:"
    curl -I -sS "$URL" 2>/dev/null | sed -n '1,10p' || echo "Could not fetch main page headers"

    if [ -n "$jsfile" ]; then
      echo "JS asset headers:"
      curl -I -sS "${URL}assets/$(basename $jsfile)" 2>/dev/null | sed -n '1,10p' || echo "Could not fetch JS asset headers"
    fi

    if [ -n "$cssfile" ]; then
      echo "CSS asset headers:"
      curl -I -sS "${URL}assets/$(basename $cssfile)" 2>/dev/null | sed -n '1,10p' || echo "Could not fetch CSS asset headers"
    fi

    echo ""
    echo "✅ [$project_name] Déploiement terminé !"
    popd >/dev/null
    return 0
}

# Loop over PROJECT_LIST and deploy in order
for ((i=0; i<${#PROJECT_LIST[@]}; i++)); do
  entry="${PROJECT_LIST[$i]}"
  # Skip commented or empty lines
  [[ -z "$entry" || "${entry:0:1}" == "#" ]] && continue
  IFS=':' read -r project_name project_path remote_folder build_folder <<<"$entry"
  echo "🔄 Déploiement du projet $((i+1))/${#PROJECT_LIST[@]} : $project_name"
  deploy_project "$project_name" "$project_path" "$remote_folder" "$build_folder"
done