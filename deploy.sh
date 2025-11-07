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
  # Format: "DisplayName:local_path:remote_folder:build_folder"
  # Only deploy CafePatisserieSite for now
  "Café Pâtisserie:/var/www/html/websites/react/CafePatisserieSite:cafe-patisserie:dist/public"
  # "Portfolio:/var/www/html/websites/react/mon-portfolio::build"
  # "NBA Dashboard:/var/www/html/websites/react/nba-dashbord:nba_dashboard:nba_dashboard"
  # "Spotify Album Finder:/var/www/html/websites/react/album_finder_spotify:spotify-finder:dist"
  # "F1 Strategy Simulator:/var/www/html/websites/react/f1-strategy-simulator:f1-simulator:dist"
)

if [[ -z "$FTP_USER" || -z "$FTP_PASS" ]]; then
  echo "� FTP credentials missing. Create .deploy.env or set FTP_USER and FTP_PASS."
  exit 1
fi

echo "☕ Building Café Pâtisserie Website (permanent subdirectory /cafe-patisserie/)..."
export VITE_BASE="/cafe-patisserie/"

# Install dependencies
echo "📦 Installing dependencies..."
npm ci --silent || npm install --silent

# Build the project
echo "🔨 Building the project..."
npm run build:static --silent


# Copy .htaccess for client-side routing and ensure it's present
if [ -f "client/public/.htaccess" ]; then
  cp client/public/.htaccess "$BUILD_FOLDER/.htaccess"
  echo "✅ .htaccess copied for client-side routing"
fi

if [ ! -f "$BUILD_FOLDER/.htaccess" ]; then
  echo "❌ .htaccess missing in $BUILD_FOLDER. SPA routing will break!"
  exit 1
fi

if [ ! -d "$BUILD_FOLDER" ]; then
  echo "❌ Build folder $BUILD_FOLDER not found"
  exit 1
fi

echo "🔎 Quick verification of build files..."
if [ -f "$BUILD_FOLDER/index.html" ]; then
  echo "✅ index.html found"
  if grep -q "./assets/" $BUILD_FOLDER/index.html; then
    echo "✅ index.html references ./assets/"
  else
    echo "⚠️ index.html does not reference ./assets/ - inspect $BUILD_FOLDER/index.html"
  fi
else
  echo "❌ index.html not found in $BUILD_FOLDER"
  exit 1
fi

# Check for JS assets
jsfile=$(ls $BUILD_FOLDER/assets/*.js 2>/dev/null | head -n1 || true)
if [ -z "$jsfile" ]; then
  echo "❌ No JS asset found in $BUILD_FOLDER/assets"
  exit 1
else
  echo "✅ JS assets found: $(basename $jsfile)"
fi

# Check for CSS assets
cssfile=$(ls $BUILD_FOLDER/assets/*.css 2>/dev/null | head -n1 || true)
if [ -z "$cssfile" ]; then
  echo "⚠️ No CSS asset found in $BUILD_FOLDER/assets"
else
  echo "✅ CSS assets found: $(basename $cssfile)"
fi

echo "📤 Uploading $BUILD_FOLDER to FTP /www/$REMOTE_FOLDER/ ..."
lftp -c "open -u '$FTP_USER','$FTP_PASS' $FTP_HOST; mkdir -p /www/$REMOTE_FOLDER; cd /www/$REMOTE_FOLDER; mirror -R --delete --verbose $BUILD_FOLDER/ .; quit"

echo "🧪 Testing public URL..."
URL="https://www.ryanfonseca.fr/$REMOTE_FOLDER/"
if curl --silent --head --fail "$URL" >/dev/null 2>&1; then
  echo "✅ Public URL reachable: $URL"
else
  echo "❌ Public URL not reachable: $URL (this might be normal if the site takes time to propagate)"
fi

echo "� Asset check (public)..."
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
echo "✅ Café Pâtisserie deployment completed!"
echo "🌐 Your website should be available at: $URL"
echo "☕ Enjoy your beautiful café website!"