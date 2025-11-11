git_pull_project() {
  local project_path="$1"
  echo "🔄 [GIT] Mise à jour du projet dans $project_path ..."
  if [ -d "$project_path/.git" ]; then
    pushd "$project_path" >/dev/null
    git pull --rebase --autostash || git pull
    popd >/dev/null
    echo "✅ [GIT] Projet mis à jour."
  else
    echo "⚠️ [GIT] Pas de repo git dans $project_path, pull ignoré."
  fi
}
#!/usr/bin/env bash

set -euo pipefail

THIS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$THIS_DIR"

FTP_USER="${FTP_USER-ryanfoc}"
FTP_PASS="${FTP_PASS-Bpi14580911}"
FTP_HOST="${FTP_HOST-ryanfoc.cluster021.hosting.ovh.net}"



# Chargement des variables d'environnement si le fichier existe
if [ -f ".deploy.env" ]; then
  set -a
  . <(grep -v '^\s*#' .deploy.env | sed '/^\s*$/d') 2>/dev/null || true
  set +a
fi


# Fonction : Met à jour le projet local avec git pull et vérifie s'il y a des changements à déployer
git_pull_and_check_changes() {
  local project_path="$1"
  echo "🔄 [GIT] Mise à jour du projet dans $project_path ..."
  if [ -d "$project_path/.git" ]; then
    pushd "$project_path" >/dev/null
    git fetch origin
    local branch_name
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    local ahead
    local behind
    ahead=$(git rev-list --count HEAD ^origin/$branch_name)
    behind=$(git rev-list --count origin/$branch_name ^HEAD)
    git pull --rebase --autostash || git pull
    popd >/dev/null
    echo "✅ [GIT] Projet mis à jour dans $project_path."
    if [ "$ahead" -gt 0 ] || [ "$behind" -gt 0 ]; then
      echo "🟢 [GIT] Changements détectés pour $project_path (ahead: $ahead, behind: $behind). Déploiement nécessaire."
      return 0
    else
      echo "🟡 [GIT] Aucun changement à déployer pour $project_path."
      return 1
    fi
  else
    echo "⚠️ [GIT] Pas de repo git dans $project_path, pull ignoré."
    return 0
  fi
}

PROJECT_LIST=(
  "Portfolio:/var/www/html/websites/react/mon-portfolio::build"
  "NBA Dashboard:/var/www/html/websites/react/nba-dashbord:nba_dashboard:build"
  "Spotify Album Finder:/var/www/html/websites/react/album_finder_spotify:spotify-finder:dist"
  "F1 Strategy Simulator:/var/www/html/websites/react/f1-strategy-simulator:f1-simulator:dist"
  "Café Pâtisserie:/var/www/html/websites/react/CafePatisserieSite:cafe-patisserie:dist/public"
)

# Option to force deployment of all projects.
# Can be set via environment variable FORCE_DEPLOY=1 or by passing --force / -f as first argument.
## By default we force deployment of all projects to avoid skipped deploys.
## Set FORCE_DEPLOY=0 in the environment or pass --no-force to disable.
FORCE_DEPLOY="${FORCE_DEPLOY-1}"
if [[ "${1-}" == "--force" || "${1-}" == "-f" ]]; then
  FORCE_DEPLOY=1
fi
if [[ "${1-}" == "--no-force" ]]; then
  FORCE_DEPLOY=0
fi

if [[ -z "$FTP_USER" || -z "$FTP_PASS" ]]; then
  echo "⚠️ FTP credentials missing. Create .deploy.env or set FTP_USER and FTP_PASS."
  exit 1
fi

echo "☕ Building Café Pâtisserie Website (permanent subdirectory /cafe-patisserie/)..."
export VITE_BASE="/cafe-patisserie/"



# Fonction : Déploie le projet (build, vérification, upload FTP)
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
    build_success=1
    if [ -f package.json ]; then
      if grep -q '"build:static"' package.json; then
        npm run build:static --silent || build_success=0
      else
        npm run build --silent || build_success=0
      fi
    fi

    if [ $build_success -eq 0 ]; then
      echo "❌ [$project_name] Échec du build. Déploiement annulé."
      popd >/dev/null
      return 1
    fi

    # Copie .htaccess pour le routage client (Vite/SPA uniquement)
    if [ -f "client/public/.htaccess" ]; then
      cp client/public/.htaccess "$build_folder/.htaccess"
      echo "✅ [$project_name] .htaccess copié pour le routage client"
    fi

    if [ ! -d "$build_folder" ]; then
      echo "❌ [$project_name] Dossier de build $build_folder introuvable après build. Vérifie la configuration du build (vite.config.js ou package.json)."
      ls -la
      popd >/dev/null
      return 1
    fi

    echo "🔎 [$project_name] Vérification des fichiers de build..."
    if [ -f "$build_folder/index.html" ]; then
      echo "✅ [$project_name] index.html trouvé"
      if grep -q "./assets/" "$build_folder/index.html"; then
        echo "✅ [$project_name] index.html référence ./assets/"
      else
        echo "⚠️ [$project_name] index.html ne référence pas ./assets/ - inspecte $build_folder/index.html"
      fi
    else
      echo "❌ [$project_name] index.html introuvable dans $build_folder après build. Vérifie la configuration du build."
      popd >/dev/null
      return 1
    fi

    # Vérification JS assets (Vite/SPA)
    jsfile=""
    cssfile=""
    if [ -d "$build_folder/assets" ]; then
      jsfile=$(ls "$build_folder"/assets/*.js 2>/dev/null | head -n1 || true)
      if [ -z "$jsfile" ]; then
        echo "⚠️ [$project_name] Aucun JS asset dans $build_folder/assets (normal pour CRA)"
      else
        echo "✅ [$project_name] JS asset trouvé : $(basename $jsfile)"
      fi

      cssfile=$(ls "$build_folder"/assets/*.css 2>/dev/null | head -n1 || true)
      if [ -z "$cssfile" ]; then
        echo "⚠️ [$project_name] Aucun CSS asset dans $build_folder/assets (normal pour CRA)"
      else
        echo "✅ [$project_name] CSS asset trouvé : $(basename $cssfile)"
      fi
    else
      echo "⚠️ [$project_name] Dossier assets absent dans $build_folder (normal pour certains projets)"
    fi

    echo "📤 [$project_name] Upload FTP de $build_folder vers /www/$remote_folder/ ..."
    # Use lftp with conservative network settings to avoid hanging on servers that
    # don't respond to FEAT or have flaky connections. Wrap with `timeout` so the
    # whole script doesn't block indefinitely.
    LFTP_CMDS="set net:timeout 20; set net:max-retries 2; set net:reconnect-interval-base 5; set ftp:use-feat false; set ftp:passive-mode true; open -u '$FTP_USER','$FTP_PASS' $FTP_HOST; mkdir -p /www/$remote_folder; cd /www/$remote_folder; mirror -R --delete --verbose \"$build_folder/\" .; quit"

    # First try with a global timeout (180s). If it times out or fails, retry in debug
    # mode once to obtain more information.
    if ! timeout 180s lftp -c "$LFTP_CMDS"; then
      echo "⚠️ [$project_name] Upload FTP échoué ou timeout. Tentative en mode debug..."
      # Debug run (no timeout) to get verbose lftp output in logs; if it fails keep going.
      lftp -d -c "$LFTP_CMDS" || echo "❌ [$project_name] Upload FTP définitivement échoué."
    fi

    echo "🧪 [$project_name] Test de l'URL publique..."
    URL="https://www.ryanfonseca.fr/$remote_folder/"
    if curl --silent --head --fail "$URL" >/dev/null 2>&1; then
      echo "✅ [$project_name] URL publique accessible : $URL"
    else
      echo "❌ [$project_name] URL publique inaccessible : $URL (propagation possible)"
    fi

    echo "� [$project_name] Vérification des assets (public)..."
    echo "Headers de la page principale :"
    curl -I -sS "$URL" 2>/dev/null | sed -n '1,10p' || echo "Impossible de récupérer les headers"

    if [ -n "$jsfile" ]; then
      echo "Headers JS asset :"
      curl -I -sS "${URL}assets/$(basename $jsfile)" 2>/dev/null | sed -n '1,10p' || echo "Impossible de récupérer les headers JS"
    fi

    if [ -n "$cssfile" ]; then
      echo "Headers CSS asset :"
      curl -I -sS "${URL}assets/$(basename $cssfile)" 2>/dev/null | sed -n '1,10p' || echo "Impossible de récupérer les headers CSS"
    fi

    echo ""
    echo "✅ [$project_name] Déploiement terminé !"
    popd >/dev/null
    return 0
}

# Loop over PROJECT_LIST and deploy in order

# Tableau pour stocker les résultats de test d'URL
if [[ "${1-}" == "-h" || "${1-}" == "--help" ]]; then
  cat <<'USAGE'
Usage: ./deploy.sh [options]

Options:
  -f, --force     Force deployment of all projects (ignores git change detection)
  -h, --help      Show this help message

You can also set FORCE_DEPLOY=1 in the environment to force deployments.
USAGE
  exit 0
fi
declare -A DEPLOY_RESULTS



for ((i=0; i<${#PROJECT_LIST[@]}; i++)); do
  entry="${PROJECT_LIST[$i]}"
  [[ -z "$entry" || "${entry:0:1}" == "#" ]] && continue
  IFS=':' read -r project_name project_path remote_folder build_folder <<<"$entry"
  echo "🔄 Déploiement du projet $((i+1))/${#PROJECT_LIST[@]} : $project_name"

  # Vérifie si le repo a des modifications locales ou distantes
  branch_name=""
  ahead=0
  behind=0
  if [ -d "$project_path/.git" ]; then
    pushd "$project_path" >/dev/null
    git fetch origin
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    ahead=$(git rev-list --count HEAD ^origin/$branch_name)
    behind=$(git rev-list --count origin/$branch_name ^HEAD)
    popd >/dev/null
  fi

  if [ "$FORCE_DEPLOY" -eq 1 ] || [ "$ahead" -gt 0 ] || [ "$behind" -gt 0 ]; then
    if [ "$FORCE_DEPLOY" -eq 1 ]; then
      echo "� Forçage du déploiement pour $project_name (FORCE_DEPLOY=1)"
    else
      echo "�🟢 Modifications détectées pour $project_name, déploiement en cours."
    fi
    git_pull_project "$project_path"
    deploy_project "$project_name" "$project_path" "$remote_folder" "$build_folder"
  else
    echo "⏭️  Aucun changement détecté pour $project_name, déploiement ignoré."
  fi

  # Test de l'URL publique après déploiement ou non
  URL="https://www.ryanfonseca.fr/$remote_folder/"
  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
  if [ "$http_code" = "200" ]; then
    DEPLOY_RESULTS["$project_name"]="✅ Accessible ($URL)"
  else
    DEPLOY_RESULTS["$project_name"]="❌ Erreur $http_code ($URL)"
  fi
done

# Résumé final
echo "\n=============================="
echo "🧪 Récapitulatif accessibilité des projets :"
for project in "${!DEPLOY_RESULTS[@]}"; do
  echo "- $project : ${DEPLOY_RESULTS[$project]}"
done
echo "==============================\n"