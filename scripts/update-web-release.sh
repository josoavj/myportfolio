#!/bin/bash

# Script de mise à jour du web build pour Netlify
# Usage: ./update-web-release.sh v1.4.0

set -e

VERSION=${1:-v1.3.0}
VERSION_DIR="releases/web-$VERSION"

echo "🚀 Mise à jour web release pour version: $VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Vérifier que build/web existe
if [ ! -d "build/web" ]; then
    echo "❌ Erreur: build/web n'existe pas"
    echo "   Exécutez d'abord: flutter build web --release"
    exit 1
fi

# Créer le dossier version
echo "📁 Création du dossier: $VERSION_DIR"
mkdir -p "$VERSION_DIR"
cp -r build/web/* "$VERSION_DIR/"

# Mettre à jour le symlink
echo "🔗 Mise à jour du symlink current → web-$VERSION"
cd releases
ln -sf "web-$VERSION" current
cd ..

# Afficher le résumé
echo ""
echo "✅ Succès! Prochaines étapes:"
echo "   1. git add releases/"
echo "   2. git commit -m \"release: v$VERSION - web build\""
echo "   3. git push origin update"
echo "   4. Allez sur Netlify et cliquez 'Trigger deploy'"
echo ""
echo "📊 Statistiques:"
du -sh "$VERSION_DIR"
echo ""
ls -lh releases/current
