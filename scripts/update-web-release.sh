#!/bin/bash

# Script de mise à jour du web build pour Vercel (Optimisé WASM)
# Usage: ./update-web-release.sh v2.0.0

set -e

VERSION=${1:-v2.0.0}
VERSION_DIR="releases/web-$VERSION"

echo "Préparation de la release Web $VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Forcer un nouveau build propre
echo "Lancement du build WASM (suppression API obsolètes + boost performance)..."
flutter clean
flutter build web --release --wasm --base-href "/" --tree-shake-icons

# Créer le dossier version
echo "Création du dossier release: $VERSION_DIR"
mkdir -p "$VERSION_DIR"
cp -r build/web/* "$VERSION_DIR/"

# Mettre à jour le symlink pour Vercel
echo "Mise à jour du lien symbolique 'current' → web-$VERSION"
cd releases
rm -f current
ln -sf "web-$VERSION" current
cd ..

# Afficher le résumé
echo ""
echo "Release $VERSION prête !"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Taille du bundle : $(du -sh $VERSION_DIR | cut -f1)"
echo "Rappel : N'oubliez pas de compresser assets/mypfp.jpg"
echo ""
echo "Commandes Git suggérées :"
echo "git add ."
echo "git commit -m \"release: $VERSION (Optimisation WASM & Performance)\""
echo "git push origin update"
