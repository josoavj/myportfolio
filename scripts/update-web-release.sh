#!/bin/bash

# Script de mise à jour du web build pour Vercel (Optimisé WASM)
# Usage: ./update-web-release.sh 2.0.0

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

VERSION=${1:-2.0.0}
# Retirer le 'v' initial si présent pour normaliser (ex: v2.0.0 -> 2.0.0)
VERSION=${VERSION#v}
VERSION_DIR="releases/web-v$VERSION"

echo "Préparation de la release Web v$VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Forcer un nouveau build propre
echo "Lancement du build WASM (suppression API obsolètes + boost performance)..."
flutter clean
flutter build web --release --wasm --base-href "/" --tree-shake-icons

# Restaure les glyphes Font Awesome retirés par le tree-shaking
echo "Restauration des glyphes Font Awesome..."
/home/shadowcraft/.venv/bin/python "$SCRIPT_DIR/restore_fa_glyphs.py" "$PROJECT_ROOT/build/web"

# Créer le dossier version
echo "Création du dossier release: $VERSION_DIR"
mkdir -p "$VERSION_DIR"
cp -r build/web/* "$VERSION_DIR/"

# Mettre à jour le symlink pour Vercel
echo "Mise à jour du lien symbolique 'current' → web-v$VERSION"
cd "$PROJECT_ROOT/releases"
rm -f current
ln -sf "web-v$VERSION" current
cd "$PROJECT_ROOT"

# Afficher le résumé
echo ""
echo "Release v$VERSION prête !"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Taille du bundle : $(du -sh $VERSION_DIR | cut -f1)"
echo ""
